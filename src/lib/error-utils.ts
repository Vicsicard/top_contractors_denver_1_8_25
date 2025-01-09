import { errorMonitor } from './error-monitoring';

export class LocationError extends Error {
  constructor(
    message: string,
    public readonly code: 'INVALID_REGION' | 'INVALID_AREA' | 'INVALID_NEIGHBORHOOD',
    public readonly params: Record<string, string>
  ) {
    super(message);
    this.name = 'LocationError';
    Error.captureStackTrace(this, LocationError);
  }

  public toJSON() {
    return {
      name: this.name,
      message: this.message,
      code: this.code,
      params: this.params,
      stack: this.stack
    };
  }
}

export class TradeError extends Error {
  constructor(
    message: string,
    public readonly code: 'INVALID_TRADE' | 'NO_CONTRACTORS' | 'INVALID_SERVICE',
    public readonly params: Record<string, string>
  ) {
    super(message);
    this.name = 'TradeError';
    Error.captureStackTrace(this, TradeError);
  }

  public toJSON() {
    return {
      name: this.name,
      message: this.message,
      code: this.code,
      params: this.params,
      stack: this.stack
    };
  }
}

export class ValidationError extends Error {
  constructor(
    message: string,
    public readonly field: string,
    public readonly value: unknown
  ) {
    super(message);
    this.name = 'ValidationError';
    Error.captureStackTrace(this, ValidationError);
  }

  public toJSON() {
    return {
      name: this.name,
      message: this.message,
      field: this.field,
      value: this.value,
      stack: this.stack
    };
  }
}

export function logError(
  error: Error,
  context?: Record<string, unknown>,
  tags: string[] = []
): void {
  errorMonitor.captureError(error, {
    ...context,
    tags: [...tags, error.name.toLowerCase()]
  });
}

export function getLocationErrorMessage(error: LocationError): string {
  switch (error.code) {
    case 'INVALID_REGION':
      return `The region "${error.params.region}" was not found in our directory. Please select a valid Denver region.`;
    case 'INVALID_AREA':
      return `The area "${error.params.area}" was not found in ${error.params.region}. Please select a valid area.`;
    case 'INVALID_NEIGHBORHOOD':
      return `The neighborhood "${error.params.neighborhood}" was not found in ${error.params.area}, ${error.params.region}. Please select a valid neighborhood.`;
    default:
      return 'An error occurred while processing your location request.';
  }
}

export function getTradeErrorMessage(error: TradeError): string {
  switch (error.code) {
    case 'INVALID_TRADE':
      return `The trade category "${error.params.trade}" was not found. Please select a valid trade category.`;
    case 'NO_CONTRACTORS':
      return `No contractors found for ${error.params.trade} in ${error.params.location}. Please try a different location or trade category.`;
    case 'INVALID_SERVICE':
      return `The service "${error.params.service}" is not available for ${error.params.trade}. Please select a valid service.`;
    default:
      return 'An error occurred while processing your trade request.';
  }
}

export function isLocationError(error: unknown): error is LocationError {
  return error instanceof LocationError;
}

export function isTradeError(error: unknown): error is TradeError {
  return error instanceof TradeError;
}

export function isValidationError(error: unknown): error is ValidationError {
  return error instanceof ValidationError;
}

// Development helper to track performance issues
export function trackPerformance<T>(
  operation: () => T,
  context: {
    name: string;
    threshold?: number;
    tags?: string[];
  }
): T {
  if (process.env.NODE_ENV !== 'development') {
    return operation();
  }

  const start = performance.now();
  try {
    return operation();
  } finally {
    const duration = performance.now() - start;
    const threshold = context.threshold || 100; // Default 100ms threshold
    
    if (duration > threshold) {
      errorMonitor.captureMessage(
        `Performance warning: ${context.name} took ${duration.toFixed(2)}ms`,
        'medium',
        {
          tags: [...(context.tags || []), 'performance'],
          params: { duration, threshold, operation: context.name }
        }
      );
    }
  }
}
