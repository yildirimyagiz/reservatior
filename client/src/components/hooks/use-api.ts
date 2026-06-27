import { useState, useEffect, useCallback } from 'react';

interface UseApiOptions<T> {
  immediate?: boolean;
  onSuccess?: (data: T) => void;
  onError?: (error: Error) => void;
}

interface UseApiReturn<T> {
  data: T | null;
  loading: boolean;
  error: Error | null;
  execute: () => Promise<void>;
  reset: () => void;
}

export function useApi<T>(
  apiCall: () => Promise<T>,
  options: UseApiOptions<T> = {}
): UseApiReturn<T> {
  const { immediate = true, onSuccess, onError } = options;
  
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  const execute = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);
      
      const result = await apiCall();
      setData(result);
      onSuccess?.(result);
    } catch (err) {
      const error = err instanceof Error ? err : new Error('An error occurred');
      setError(error);
      onError?.(error);
    } finally {
      setLoading(false);
    }
  }, [apiCall, onSuccess, onError]);

  const reset = useCallback(() => {
    setData(null);
    setError(null);
    setLoading(false);
  }, []);

  useEffect(() => {
    if (immediate) {
      execute();
    }
  }, [execute, immediate]);

  return { data, loading, error, execute, reset };
}

// Hook for paginated API calls
export function usePaginatedApi<T>(
  apiCall: (page: number, limit: number) => Promise<{ data: T[]; total: number; page: number; limit: number }>,
  options: UseApiOptions<{ data: T[]; total: number; page: number; limit: number }> = {}
) {
  const [page, setPage] = useState(1);
  const [limit] = useState(10);
  
  const { data, loading, error, execute, reset } = useApi(
    () => apiCall(page, limit),
    options
  );

  const nextPage = useCallback(() => {
    if (data && page < Math.ceil(data.total / data.limit)) {
      setPage(prev => prev + 1);
    }
  }, [data, page]);

  const prevPage = useCallback(() => {
    if (page > 1) {
      setPage(prev => prev - 1);
    }
  }, [page]);

  const goToPage = useCallback((targetPage: number) => {
    setPage(targetPage);
  }, []);

  return {
    data: data?.data || [],
    total: data?.total || 0,
    currentPage: data?.page || 1,
    totalPages: data ? Math.ceil(data.total / data.limit) : 0,
    loading,
    error,
    execute,
    reset,
    nextPage,
    prevPage,
    goToPage,
    hasNextPage: data ? page < Math.ceil(data.total / data.limit) : false,
    hasPrevPage: page > 1
  };
}
