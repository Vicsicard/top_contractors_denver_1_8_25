import React, { ErrorInfo } from 'react';
import Link from 'next/link';

interface ErrorFallbackProps {
  error: Error;
  errorInfo: ErrorInfo | null;
  message: string;
  onReset?: () => void;
}

export function ErrorFallback({ error, errorInfo, message, onReset }: ErrorFallbackProps) {
  const goBack = () => {
    if (typeof window !== 'undefined') {
      window.history.back();
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <div className="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <div className="text-center">
            <h2 className="mt-2 text-3xl font-bold text-gray-900">
              Oops! Something went wrong
            </h2>
            <p className="mt-4 text-lg text-gray-600">
              {message}
            </p>
            <div className="mt-6 flex justify-center space-x-4">
              <button
                onClick={goBack}
                className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700"
              >
                Go Back
              </button>
              {onReset && (
                <button
                  onClick={onReset}
                  className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-blue-700 bg-blue-100 hover:bg-blue-200"
                >
                  Try Again
                </button>
              )}
              <Link
                href="/"
                className="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md text-gray-700 bg-gray-100 hover:bg-gray-200"
              >
                Go Home
              </Link>
            </div>
            {process.env.NODE_ENV === 'development' && (
              <div className="mt-6 text-left">
                <details className="text-sm text-gray-500">
                  <summary className="cursor-pointer hover:text-gray-700">
                    Technical Details
                  </summary>
                  <div className="mt-2">
                    <h3 className="font-semibold">Error</h3>
                    <pre className="mt-1 whitespace-pre-wrap bg-gray-50 p-4 rounded-md overflow-auto text-sm">
                      {error.stack}
                    </pre>
                    {errorInfo && (
                      <>
                        <h3 className="font-semibold mt-4">Component Stack</h3>
                        <pre className="mt-1 whitespace-pre-wrap bg-gray-50 p-4 rounded-md overflow-auto text-sm">
                          {errorInfo.componentStack}
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
