import React from 'react';
import { LocationError, TradeError } from './error-utils';

export interface ErrorMetadata {
  timestamp: string;
  component?: string;
  function?: string;
  params?: Record<string, unknown>;
  userId?: string;
  sessionId?: string;
  url?: string;
  errorId: string;
  severity: 'low' | 'medium' | 'high' | 'critical';
  tags: string[];
}

export interface ErrorReport extends ErrorMetadata {
  error: {
    name: string;
    message: string;
    stack?: string;
  };
  context: {
    browser?: string;
    os?: string;
    device?: string;
    viewport?: {
      width: number;
      height: number;
    };
  };
}

class ErrorMonitor {
  private static instance: ErrorMonitor;
  private errorBuffer: ErrorReport[] = [];
  private readonly bufferSize = 10;
  private readonly flushInterval = 5000; // 5 seconds

  private constructor() {
    if (typeof window !== 'undefined') {
      setInterval(() => this.flushErrors(), this.flushInterval);
    }
  }

  public static getInstance(): ErrorMonitor {
    if (!ErrorMonitor.instance) {
      ErrorMonitor.instance = new ErrorMonitor();
    }
    return ErrorMonitor.instance;
  }

  private generateErrorId(): string {
    return `${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
  }

  private getBrowserInfo(): Record<string, string> {
    if (typeof window === 'undefined') return {};
    
    const userAgent = window.navigator.userAgent;
    const browserRegexes = [
      { name: 'Chrome', regex: /Chrome\/([0-9.]+)/ },
      { name: 'Firefox', regex: /Firefox\/([0-9.]+)/ },
      { name: 'Safari', regex: /Version\/([0-9.]+).*Safari/ },
      { name: 'Edge', regex: /Edg\/([0-9.]+)/ }
    ];

    for (const browser of browserRegexes) {
      const match = userAgent.match(browser.regex);
      if (match) {
        return { browser: `${browser.name} ${match[1]}` };
      }
    }

    return { browser: 'Unknown' };
  }

  private getDeviceInfo(): Record<string, unknown> {
    if (typeof window === 'undefined') return {};

    return {
      viewport: JSON.stringify({
        width: window.innerWidth,
        height: window.innerHeight
      }),
      devicePixelRatio: window.devicePixelRatio,
      os: this.getOperatingSystem(),
      device: this.getDeviceType()
    };
  }

  private getOperatingSystem(): string {
    if (typeof window === 'undefined') return 'Unknown';
    
    const userAgent = window.navigator.userAgent;
    if (userAgent.includes('Windows')) return 'Windows';
    if (userAgent.includes('Mac')) return 'MacOS';
    if (userAgent.includes('Linux')) return 'Linux';
    if (userAgent.includes('Android')) return 'Android';
    if (userAgent.includes('iOS')) return 'iOS';
    return 'Unknown';
  }

  private getDeviceType(): string {
    if (typeof window === 'undefined') return 'Unknown';
    
    const userAgent = window.navigator.userAgent;
    if (userAgent.includes('Mobile')) return 'Mobile';
    if (userAgent.includes('Tablet')) return 'Tablet';
    return 'Desktop';
  }

  private async flushErrors(): Promise<void> {
    if (this.errorBuffer.length === 0) return;

    const errors = [...this.errorBuffer];
    this.errorBuffer = [];

    try {
      // In development, log to console
      if (process.env.NODE_ENV === 'development') {
        console.group('🚨 Error Reports');
        errors.forEach(error => {
          console.log('Error Report:', {
            ...error,
            timestamp: new Date(error.timestamp).toLocaleString()
          });
        });
        console.groupEnd();
      }

      // In production, you would send to your error tracking service
      if (process.env.NODE_ENV === 'production') {
        // Example: await sendToErrorTrackingService(errors);
      }
    } catch (error) {
      console.error('Failed to flush errors:', error);
      // Re-add errors to buffer
      this.errorBuffer = [...errors, ...this.errorBuffer].slice(0, this.bufferSize);
    }
  }

  public getSeverity(error: Error): ErrorMetadata['severity'] {
    if (error instanceof LocationError) {
      return 'low'; // Navigation errors are usually low severity
    }
    if (error instanceof TradeError) {
      return 'medium'; // Trade-related errors might affect user experience
    }
    if (error instanceof TypeError || error instanceof ReferenceError) {
      return 'high'; // Programming errors need immediate attention
    }
    return 'critical'; // Unknown errors are treated as critical
  }

  public captureError(
    error: Error,
    metadata: Partial<ErrorMetadata> = {}
  ): void {
    const errorReport: ErrorReport = {
      error: {
        name: error.name,
        message: error.message,
        stack: error.stack
      },
      errorId: this.generateErrorId(),
      severity: metadata.severity || this.getSeverity(error),
      timestamp: new Date().toISOString(),
      tags: metadata.tags || [],
      context: {
        ...this.getBrowserInfo(),
        ...this.getDeviceInfo()
      },
      ...metadata,
      url: typeof window !== 'undefined' ? window.location.href : undefined
    };

    this.errorBuffer.push(errorReport);

    // Flush immediately if buffer is full
    if (this.errorBuffer.length >= this.bufferSize) {
      this.flushErrors();
    }
  }

  public captureMessage(
    message: string,
    severity: ErrorMetadata['severity'] = 'low',
    metadata: Partial<ErrorMetadata> = {}
  ): void {
    const error = new Error(message);
    this.captureError(error, { ...metadata, severity });
  }
}

export const errorMonitor = ErrorMonitor.getInstance();

// Error boundary enhancement
export function withErrorMonitoring<P extends object>(
  Component: React.ComponentType<P>,
  options: {
    componentName: string;
    severity?: ErrorMetadata['severity'];
    tags?: string[];
  }
): React.ComponentType<P> {
  return function WithErrorMonitoring(props: P): React.ReactElement {
    try {
      return React.createElement(Component, props);
    } catch (error) {
      if (error instanceof Error) {
        errorMonitor.captureError(error, {
          component: options.componentName,
          severity: options.severity || 'medium',
          tags: options.tags || [],
          params: props as Record<string, unknown>
        });
      }
      throw error;
    }
  };
}
