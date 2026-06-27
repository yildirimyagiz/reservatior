import { useCallback } from 'react';
import { useToast } from '@/hooks/use-toast';

export interface ErrorInfo {
  componentStack?: string;
  errorBoundary?: boolean;
  apiCall?: boolean;
  context?: string;
}

export interface AppError extends Error {
  code?: string;
  statusCode?: number;
  details?: any;
  context?: string;
}

export const useErrorHandler = () => {
  const { toast } = useToast();

  const handleError = useCallback((error: AppError, errorInfo?: ErrorInfo) => {
    console.error('Error caught by global handler:', error, errorInfo);

    // Determine error type and message
    let userMessage = 'Something went wrong. Please try again.';
    let variant: 'default' | 'destructive' = 'destructive';

    // Network errors
    if (error.name === 'TypeError' && error.message.includes('fetch')) {
      userMessage = 'Network error. Please check your connection.';
    }

    // API errors with status codes
    if (error.statusCode) {
      switch (error.statusCode) {
        case 401:
          userMessage = 'You need to login to access this resource.';
          break;
        case 403:
          userMessage = 'You don\'t have permission to perform this action.';
          break;
        case 404:
          userMessage = 'The requested resource was not found.';
          break;
        case 429:
          userMessage = 'Too many requests. Please try again later.';
          break;
        case 500:
          userMessage = 'Server error. Please try again later.';
          break;
        default:
          userMessage = error.message || 'An unexpected error occurred.';
      }
    }

    // Validation errors
    if (error.code === 'VALIDATION_ERROR') {
      userMessage = 'Please check your input and try again.';
      variant = 'default';
    }

    // Authentication errors
    if (error.code === 'AUTH_ERROR') {
      userMessage = 'Authentication failed. Please login again.';
    }

    // Show toast notification
    toast({
      title: 'Error',
      description: userMessage,
      variant,
    });

    // Log to external service in production
    const isDevelopment = true; // Simple flag for development mode
    if (!isDevelopment) {
      // TODO: Send to logging service
      console.log('Would send error to logging service:', {
        message: error.message,
        stack: error.stack,
        code: error.code,
        statusCode: error.statusCode,
        context: errorInfo?.context,
        componentStack: errorInfo?.componentStack,
        timestamp: new Date().toISOString(),
      });
    }

    // Return error info for further handling
    return {
      handled: true,
      message: userMessage,
      error,
      errorInfo,
    };
  }, [toast]);

  const handleAsyncError = useCallback(async (
    asyncFn: () => Promise<any>,
    errorInfo?: ErrorInfo
  ): Promise<{ success: boolean; data?: any; error?: AppError }> => {
    try {
      const data = await asyncFn();
      return { success: true, data };
    } catch (error) {
      const appError = error as AppError;
      handleError(appError, { ...errorInfo, apiCall: true });
      return { success: false, error: appError };
    }
  }, [handleError]);

  const createError = useCallback((
    message: string,
    code?: string,
    statusCode?: number,
    details?: any
  ): AppError => {
    const error = new Error(message) as AppError;
    error.code = code;
    error.statusCode = statusCode;
    error.details = details;
    return error;
  }, []);

  return {
    handleError,
    handleAsyncError,
    createError,
  };
};

// Error types for better type safety
export const ErrorTypes = {
  NETWORK: 'NETWORK_ERROR',
  VALIDATION: 'VALIDATION_ERROR',
  AUTH: 'AUTH_ERROR',
  PERMISSION: 'PERMISSION_ERROR',
  NOT_FOUND: 'NOT_FOUND_ERROR',
  SERVER: 'SERVER_ERROR',
  TIMEOUT: 'TIMEOUT_ERROR',
} as const;

// Helper function to create specific error types
export const createError = (
  message: string,
  type: keyof typeof ErrorTypes,
  statusCode?: number,
  details?: any
): AppError => {
  const error = new Error(message) as AppError;
  error.code = ErrorTypes[type];
  error.statusCode = statusCode;
  error.details = details;
  return error;
};
