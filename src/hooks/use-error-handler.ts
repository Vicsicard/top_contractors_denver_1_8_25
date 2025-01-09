'use client';

import { useCallback, useState } from 'react';
import { errorService } from '@/lib/services/error-service';
import { isLocationError, isTradeError, isValidationError, isApiError } from '@/lib/errors/domain-errors';
import type { ErrorSeverity } from '@/types/errors';

interface ErrorState {
  hasError: boolean;
  message: string | null;
  details: unknown;
  severity?: ErrorSeverity;
}

interface ErrorHandlerOptions {
  component?: string;
  tags?: string[];
  onError?: (error: Error) => void;
  defaultSeverity?: ErrorSeverity;
}

export function useErrorHandler(options: ErrorHandlerOptions = {}) {
  const [errorState, setErrorState] = useState<ErrorState>({
    hasError: false,
    message: null,
    details: null,
    severity: undefined
  });

  const clearError = useCallback(() => {
    setErrorState({
      hasError: false,
      message: null,
      details: null,
      severity: undefined
    });
  }, []);

  const handleError = useCallback((error: unknown) => {
    if (!(error instanceof Error)) {
      error = new Error(String(error));
    }

    let message = 'An unexpected error occurred.';
    let severity = options.defaultSeverity || 'medium';

    if (isLocationError(error)) {
      message = error.message;
      severity = error.severity;
    } else if (isTradeError(error)) {
      message = error.message;
      severity = error.severity;
    } else if (isValidationError(error)) {
      message = error.message;
      severity = error.severity;
    } else if (isApiError(error)) {
      message = error.message;
      severity = error.severity;
    } else if (error instanceof Error) {
      message = error.message;
    }

    errorService.captureError(error as Error, {
      component: options.component,
      tags: options.tags,
      severity
    });

    setErrorState({
      hasError: true,
      message,
      details: error,
      severity
    });

    options.onError?.(error as Error);
  }, [options]);

  const wrapAsync = useCallback(async <T,>(
    asyncFn: () => Promise<T>,
    context?: {
      action: string;
      tags?: string[];
      severity?: ErrorSeverity;
    }
  ): Promise<T | undefined> => {
    try {
      const result = await asyncFn();
      clearError();
      return result;
    } catch (error) {
      handleError(error);
      if (context) {
        errorService.captureError(error as Error, {
          component: options.component,
          tags: [...(options.tags || []), ...(context.tags || [])],
          params: { action: context.action },
          severity: context.severity
        });
      }
    }
  }, [handleError, clearError, options.component, options.tags]);

  const withErrorHandling = useCallback(<T extends (...args: Parameters<T>) => ReturnType<T>>(
    fn: T,
    context?: {
      action: string;
      tags?: string[];
      severity?: ErrorSeverity;
    }
  ): ((...args: Parameters<T>) => ReturnType<T>) => {
    return (...args: Parameters<T>): ReturnType<T> => {
      try {
        const result = fn(...args);
        if (result instanceof Promise) {
          return wrapAsync(() => result, context) as ReturnType<T>;
        }
        clearError();
        return result;
      } catch (error) {
        handleError(error);
        if (context) {
          errorService.captureError(error as Error, {
            component: options.component,
            tags: [...(options.tags || []), ...(context.tags || [])],
            params: { action: context.action },
            severity: context.severity
          });
        }
        throw error;
      }
    };
  }, [handleError, clearError, wrapAsync, options.component, options.tags]);

  return {
    error: errorState,
    handleError,
    clearError,
    wrapAsync,
    withErrorHandling
  };
}
