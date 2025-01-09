export type ErrorSeverity = 'low' | 'medium' | 'high' | 'critical';
export type ErrorCode = 
  | 'INVALID_TRADE'
  | 'NO_CONTRACTORS'
  | 'INVALID_SERVICE'
  | 'INVALID_REGION'
  | 'INVALID_AREA'
  | 'INVALID_NEIGHBORHOOD'
  | 'VALIDATION_ERROR'
  | 'API_ERROR'
  | 'NETWORK_ERROR'
  | 'UNKNOWN_ERROR';

export interface ErrorMetadata {
  code: ErrorCode;
  severity: ErrorSeverity;
  timestamp: string;
  component?: string;
  function?: string;
  params?: Record<string, unknown>;
  userId?: string;
  sessionId?: string;
  url?: string;
  errorId: string;
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

export interface BaseErrorOptions {
  code: ErrorCode;
  message: string;
  severity?: ErrorSeverity;
  params?: Record<string, unknown>;
  cause?: Error;
}
