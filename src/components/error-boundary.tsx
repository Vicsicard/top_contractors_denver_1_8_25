'use client';

import { Component, ErrorInfo, ReactNode } from 'react';
import { isLocationError, isTradeError, getLocationErrorMessage, getTradeErrorMessage } from '@/lib/error-utils';
import { errorMonitor } from '@/lib/error-monitoring';

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
  onError?: (error: Error, errorInfo: ErrorInfo) => void;
  resetKeys?: Array<unknown>;
}

interface State {
  hasError: boolean;
  error: Error | null;
  errorInfo: ErrorInfo | null;
}

export class ErrorBoundary extends Component<Props, State> {
  public state: State = {
    hasError: false,
    error: null,
    errorInfo: null
  };

  public static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error, errorInfo: null };
  }

  public componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    this.setState({ errorInfo });
    
    errorMonitor.captureError(error, {
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
    if (this.state.hasError && this.props.resetKeys) {
      // Check if any reset keys have changed
      if (this.props.resetKeys.some((key, index) => key !== prevProps.resetKeys?.[index])) {
        this.reset();
      }
    }
  }

  private reset = () => {
    this.setState({
      hasError: false,
      error: null,
      errorInfo: null
    });
  };

  private getErrorMessage(): string {
    const { error } = this.state;
    if (!error) return 'An unexpected error occurred.';

    if (isLocationError(error)) {
      return getLocationErrorMessage(error);
    }

    if (isTradeError(error)) {
      return getTradeErrorMessage(error);
    }

    return error.message || 'An unexpected error occurred.';
  }

  private reload = () => {
    window.location.reload();
  };

  private goBack = () => {
    window.history.back();
  };

  private renderError() {
    if (this.props.fallback) {
      return this.props.fallback;
    }

    return (
      <div className="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
        <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
          <div className="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
            <div className="text-center">
              <h2 className="mt-2 text-3xl font-bold text-gray-900">
                Oops! Something went wrong
              </h2>
              <p className="mt-4 text-lg text-gray-600">
                {this.getErrorMessage()}
              </p>
              <div className="mt-6 flex justify-center space-x-4">
                <button
                  onClick={this.goBack}
                  className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700"
                >
                  Go Back
                </button>
                <button
                  onClick={this.reset}
                  className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-blue-700 bg-blue-100 hover:bg-blue-200"
                >
                  Try Again
                </button>
              </div>
              {process.env.NODE_ENV === 'development' && (
                <div className="mt-6 text-left">
                  <details className="text-sm text-gray-500">
                    <summary className="cursor-pointer hover:text-gray-700">
                      Technical Details
                    </summary>
                    <div className="mt-2">
                      <h3 className="font-semibold">Error</h3>
                      <pre className="mt-1 whitespace-pre-wrap bg-gray-50 p-4 rounded-md overflow-auto">
                        {this.state.error?.stack}
                      </pre>
                      {this.state.errorInfo && (
                        <>
                          <h3 className="font-semibold mt-4">Component Stack</h3>
                          <pre className="mt-1 whitespace-pre-wrap bg-gray-50 p-4 rounded-md overflow-auto">
                            {this.state.errorInfo.componentStack}
                          </pre>
                        </>
                      )}
                    </div>
                  </details>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    );
  }

  public render() {
    if (this.state.hasError) {
      return this.renderError();
    }

    return this.props.children;
  }
}
