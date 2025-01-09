'use client';

import React, { Component, ErrorInfo, ReactNode } from 'react';
import { ErrorFallback } from './error-fallback';
import { errorService } from '@/lib/services/error-service';
import { isLocationError, isTradeError, isValidationError, isApiError } from '@/lib/errors/domain-errors';

interface Props {
  children: ReactNode;
  fallback?: ReactNode | ((error: Error) => ReactNode);
  onError?: (error: Error, errorInfo: ErrorInfo) => void;
  resetKeys?: Array<unknown>;
}

interface State {
  error: Error | null;
  errorInfo: ErrorInfo | null;
}

export class ErrorBoundary extends Component<Props, State> {
  public state: State = {
    error: null,
    errorInfo: null
  };

  public static getDerivedStateFromError(error: Error): State {
    return { error, errorInfo: null };
  }

  public componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    this.setState({ errorInfo });
    
    errorService.captureError(error, {
      component: 'ErrorBoundary',
      params: {
        componentStack: errorInfo.componentStack,
        props: this.props
      }
    });

    if (this.props.onError) {
      this.props.onError(error, errorInfo);
    }
  }

  public componentDidUpdate(prevProps: Props) {
    if (this.state.error && this.props.resetKeys) {
      // Check if any reset keys have changed
      if (this.props.resetKeys.some((key, index) => key !== prevProps.resetKeys?.[index])) {
        this.reset();
      }
    }
  }

  private reset = () => {
    this.setState({
      error: null,
      errorInfo: null
    });
  };

  private getErrorMessage(error: Error): string {
    if (isLocationError(error)) {
      return error.message;
    }

    if (isTradeError(error)) {
      return error.message;
    }

    if (isValidationError(error)) {
      return error.message;
    }

    if (isApiError(error)) {
      return `An error occurred while communicating with the server. ${error.message}`;
    }

    return error.message || 'An unexpected error occurred.';
  }

  private renderFallback() {
    const { error } = this.state;
    if (!error) return null;

    if (this.props.fallback) {
      if (typeof this.props.fallback === 'function') {
        return this.props.fallback(error);
      }
      return this.props.fallback;
    }

    return (
      <ErrorFallback
        error={error}
        errorInfo={this.state.errorInfo}
        message={this.getErrorMessage(error)}
        onReset={this.reset}
      />
    );
  }

  public render() {
    if (this.state.error) {
      return this.renderFallback();
    }

    return this.props.children;
  }
}
