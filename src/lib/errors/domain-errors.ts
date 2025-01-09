import { BaseError } from './base-error';
import type { BaseErrorOptions, ErrorSeverity } from '@/types/errors';

export class LocationError extends BaseError {
  constructor(options: Omit<BaseErrorOptions, 'code'> & {
    code: 'INVALID_REGION' | 'INVALID_AREA' | 'INVALID_NEIGHBORHOOD';
  }) {
    super(options);
  }

  protected getDefaultSeverity(): ErrorSeverity {
    return 'low';
  }

  static invalidRegion(region: string, cause?: Error) {
    return new LocationError({
      code: 'INVALID_REGION',
      message: `Region not found: ${region}`,
      params: { region },
      cause
    });
  }

  static invalidArea(area: string, region: string, cause?: Error) {
    return new LocationError({
      code: 'INVALID_AREA',
      message: `Area not found: ${area} in region ${region}`,
      params: { area, region },
      cause
    });
  }

  static invalidNeighborhood(neighborhood: string, area: string, region: string, cause?: Error) {
    return new LocationError({
      code: 'INVALID_NEIGHBORHOOD',
      message: `Neighborhood not found: ${neighborhood} in ${area}, ${region}`,
      params: { neighborhood, area, region },
      cause
    });
  }
}

export class TradeError extends BaseError {
  constructor(options: Omit<BaseErrorOptions, 'code'> & {
    code: 'INVALID_TRADE' | 'NO_CONTRACTORS' | 'INVALID_SERVICE';
  }) {
    super(options);
  }

  protected getDefaultSeverity(): ErrorSeverity {
    return 'medium';
  }

  static invalidTrade(trade: string, cause?: Error) {
    return new TradeError({
      code: 'INVALID_TRADE',
      message: `Trade category not found: ${trade}`,
      params: { trade },
      cause
    });
  }

  static noContractors(trade: string, location: string, cause?: Error) {
    return new TradeError({
      code: 'NO_CONTRACTORS',
      message: `No contractors found for ${trade} in ${location}`,
      params: { trade, location },
      cause
    });
  }

  static invalidService(service: string, trade: string, cause?: Error) {
    return new TradeError({
      code: 'INVALID_SERVICE',
      message: `Service "${service}" is not available for ${trade}`,
      params: { service, trade },
      cause
    });
  }
}

export class ValidationError extends BaseError {
  constructor(options: Omit<BaseErrorOptions, 'code'> & {
    code: 'VALIDATION_ERROR';
    field: string;
    value: unknown;
  }) {
    super({
      ...options,
      params: {
        ...options.params,
        field: options.field,
        value: options.value
      }
    });
  }

  protected getDefaultSeverity(): ErrorSeverity {
    return 'low';
  }

  static invalidField(field: string, value: unknown, message: string, cause?: Error) {
    return new ValidationError({
      code: 'VALIDATION_ERROR',
      message,
      field,
      value,
      cause
    });
  }
}

export class ApiError extends BaseError {
  constructor(options: Omit<BaseErrorOptions, 'code'> & {
    code: 'API_ERROR';
    status?: number;
  }) {
    super({
      ...options,
      params: {
        ...options.params,
        status: options.status
      }
    });
  }

  protected getDefaultSeverity(): ErrorSeverity {
    return 'high';
  }

  static fromResponse(response: Response, message?: string, cause?: Error) {
    return new ApiError({
      code: 'API_ERROR',
      message: message || `API request failed with status ${response.status}`,
      status: response.status,
      cause
    });
  }
}

// Type guards
export function isLocationError(error: unknown): error is LocationError {
  return error instanceof LocationError;
}

export function isTradeError(error: unknown): error is TradeError {
  return error instanceof TradeError;
}

export function isValidationError(error: unknown): error is ValidationError {
  return error instanceof ValidationError;
}

export function isApiError(error: unknown): error is ApiError {
  return error instanceof ApiError;
}
