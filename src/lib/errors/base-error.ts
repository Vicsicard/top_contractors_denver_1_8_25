import type { BaseErrorOptions, ErrorCode, ErrorSeverity } from '@/types/errors';

export class BaseError extends Error {
  readonly code: ErrorCode;
  readonly severity: ErrorSeverity;
  readonly params: Record<string, unknown>;
  readonly timestamp: string;
  readonly cause?: Error;

  constructor(options: BaseErrorOptions) {
    super(options.message);
    this.name = this.constructor.name;
    this.code = options.code;
    this.severity = options.severity || this.getDefaultSeverity();
    this.params = options.params || {};
    this.timestamp = new Date().toISOString();
    this.cause = options.cause;

    if (Error.captureStackTrace) {
      Error.captureStackTrace(this, this.constructor);
    }
  }

  protected getDefaultSeverity(): ErrorSeverity {
    return 'medium';
  }

  public toJSON(): Record<string, unknown> {
    return {
      name: this.name,
      message: this.message,
      code: this.code,
      timestamp: this.timestamp,
      stack: this.stack,
      cause: this.cause instanceof Error ? {
        name: this.cause.name,
        message: this.cause.message,
        stack: this.cause.stack
      } : this.cause
    };
  }

  public static fromJSON(json: Record<string, unknown>): BaseError {
    return new BaseError({
      message: String(json.message || ''),
      code: (json.code as ErrorCode) || 'UNKNOWN_ERROR',
      severity: (json.severity as ErrorSeverity) || 'medium',
      params: (json.params as Record<string, unknown>) || {},
      cause: json.cause instanceof Error ? json.cause : undefined
    });
  }
}
