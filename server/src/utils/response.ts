import type { ApiResponse } from "@reservatiorm/shared-types";

/**
 * Standardized success response format
 */
export function createSuccessResponse<T>(data: T, message?: string): ApiResponse<T> {
  return {
    data,
    success: true,
    message
  };
}

/**
 * Standardized error response format
 */
export function createErrorResponse(error: string, code?: string): ApiResponse<null> {
  return {
    data: null,
    success: false,
    message: error
  };
}

/**
 * Standardized paginated response format
 */
export function createPaginatedResponse<T>(
  data: T[],
  total: number,
  page: number,
  limit: number,
  message?: string
): ApiResponse<{
  data: T[];
  pagination: {
    total: number;
    page: number;
    limit: number;
    totalPages: number;
    hasNext: boolean;
    hasPrev: boolean;
  };
}> {
  const totalPages = Math.ceil(total / limit);
  
  return {
    data: {
      data,
      pagination: {
        total,
        page,
        limit,
        totalPages,
        hasNext: page < totalPages,
        hasPrev: page > 1
      }
    },
    success: true,
    message
  };
}

/**
 * Handles async route errors with standardized responses
 */
export function handleAsyncError(
  error: any,
  set: { status?: number | string; headers?: Record<string, any> }
): ApiResponse<null> {
  console.error('Route error:', error);
  
  // Handle specific error types
  if (error.code === 'P2025') {
    set.status = 404;
    return createErrorResponse('Resource not found', 'NOT_FOUND');
  }
  
  if (error.code === 'P2002') {
    set.status = 409;
    return createErrorResponse('Resource already exists', 'CONFLICT');
  }
  
  if (error.name === 'ValidationError') {
    set.status = 400;
    return createErrorResponse(error.message, 'VALIDATION_ERROR');
  }
  
  // Generic server error
  set.status = 500;
  return createErrorResponse('Internal server error', 'INTERNAL_ERROR');
}
