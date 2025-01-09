import type { ErrorMetadata, ErrorReport, ErrorSeverity } from '@/types/errors';
import { BaseError } from '../errors/base-error';
import { isLocationError, isTradeError, isValidationError, isApiError } from '../errors/domain-errors';

interface ErrorServiceConfig {
  bufferSize?: number;
  flushInterval?: number;
  shouldLogToConsole?: boolean;
  errorEndpoint?: string;
}

class ErrorService {
  private static instance: ErrorService;
  private errorBuffer: ErrorReport[] = [];
  private readonly bufferSize: number;
  private readonly flushInterval: number;
  private readonly shouldLogToConsole: boolean;
  private readonly errorEndpoint?: string;
  private flushTimeoutId?: NodeJS.Timeout;

  private constructor(config: ErrorServiceConfig = {}) {
    this.bufferSize = config.bufferSize || 10;
    this.flushInterval = config.flushInterval || 5000;
    this.shouldLogToConsole = config.shouldLogToConsole ?? process.env.NODE_ENV === 'development';
    this.errorEndpoint = config.errorEndpoint;

    if (typeof window !== 'undefined') {
      this.startFlushInterval();
      this.setupUnhandledErrorListeners();
    }
  }

  public static getInstance(config?: ErrorServiceConfig): ErrorService {
    if (!ErrorService.instance) {
      ErrorService.instance = new ErrorService(config);
    }
    return ErrorService.instance;
  }

  private startFlushInterval(): void {
    if (this.flushTimeoutId) {
      clearInterval(this.flushTimeoutId);
    }
    this.flushTimeoutId = setInterval(() => this.flushErrors(), this.flushInterval);
  }

  private setupUnhandledErrorListeners(): void {
    window.addEventListener('error', (event) => {
      this.captureError(event.error || new Error(event.message), {
        severity: 'critical',
        tags: ['unhandled', 'window.onerror']
      });
    });

    window.addEventListener('unhandledrejection', (event) => {
      const error = event.reason instanceof Error ? event.reason : new Error(String(event.reason));
      this.captureError(error, {
        severity: 'critical',
        tags: ['unhandled', 'promise-rejection']
      });
    });
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

    interface NavigatorWithConnection extends Navigator {
      connection?: {
        effectiveType: string;
      };
    }

    interface NavigatorWithMemory extends Navigator {
      deviceMemory?: number;
    }

    return {
      viewport: {
        width: window.innerWidth,
        height: window.innerHeight
      },
      devicePixelRatio: window.devicePixelRatio,
      os: this.getOperatingSystem(),
      device: this.getDeviceType(),
      language: window.navigator.language,
      platform: window.navigator.platform,
      memory: (window.navigator as NavigatorWithMemory).deviceMemory,
      connection: (navigator as NavigatorWithConnection).connection?.effectiveType
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

  private generateErrorId(): string {
    return `${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
  }

  private async flushErrors(): Promise<void> {
    if (this.errorBuffer.length === 0) return;

    const errors = [...this.errorBuffer];
    this.errorBuffer = [];

    try {
      if (this.shouldLogToConsole) {
        console.group('🚨 Error Reports');
        errors.forEach(error => {
          console.log('Error Report:', {
            ...error,
            timestamp: new Date(error.timestamp).toLocaleString()
          });
        });
        console.groupEnd();
      }

      if (this.errorEndpoint && process.env.NODE_ENV === 'production') {
        try {
          const response = await fetch(this.errorEndpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(errors)
          });

          if (!response.ok) {
            throw new Error(`Failed to send errors: ${response.statusText}`);
          }
        } catch (error) {
          console.error('Failed to send errors to server:', error);
          // Re-add errors to buffer
          this.errorBuffer = [...errors, ...this.errorBuffer].slice(0, this.bufferSize);
        }
      }
    } catch (error) {
      console.error('Failed to process errors:', error);
      // Re-add errors to buffer
      this.errorBuffer = [...errors, ...this.errorBuffer].slice(0, this.bufferSize);
    }
  }

  public getSeverity(error: Error): ErrorSeverity {
    if (error instanceof BaseError) {
      return error.severity;
    }

    if (isLocationError(error)) return 'low';
    if (isTradeError(error)) return 'medium';
    if (isValidationError(error)) return 'low';
    if (isApiError(error)) return 'high';
    if (error instanceof TypeError || error instanceof ReferenceError) return 'high';
    
    return 'critical';
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
      code: (error as BaseError).code || 'UNKNOWN_ERROR',
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
    severity: ErrorSeverity = 'low',
    metadata: Partial<ErrorMetadata> = {}
  ): void {
    const error = new Error(message);
    this.captureError(error, { ...metadata, severity });
  }
}

export const errorService = ErrorService.getInstance({
  bufferSize: 10,
  flushInterval: 5000,
  shouldLogToConsole: process.env.NODE_ENV === 'development',
  errorEndpoint: process.env.NEXT_PUBLIC_ERROR_ENDPOINT
});
