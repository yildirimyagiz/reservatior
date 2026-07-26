"use client";

import { useCallback, useState } from 'react';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api/client';
import { useSpatialAnalysisStore } from '@/lib/store/spatial-analysis-store';
import type { SpatialAnalysisResult, PropertyHealthReport } from '@/types/spatial-analysis';

export function useSpatialAnalysis() {
  const { setAnalyses, setLoading, setError, setHealthReports } = useSpatialAnalysisStore();
  const queryClient = useQueryClient();
  const [analysisProgress, setAnalysisProgress] = useState<Record<string, number>>({});

  const analyzeProperty = useMutation({
    mutationFn: async (data: { propertyId: string; assets: string[] }) => {
      setLoading(true);
      const result = await apiClient.post<{ data: SpatialAnalysisResult }>('/spatial-analysis', data);
      return result.data;
    },
    onSuccess: (result) => {
      setLoading(false);
      queryClient.invalidateQueries({ queryKey: ['spatial-analyses'] });
      return result;
    },
    onError: (err: any) => {
      setLoading(false);
      setError(err.message);
    },
  });

  const generateHealthReport = useMutation({
    mutationFn: async (data: { propertyId: string; assets: string[] }) => {
      setLoading(true);
      const result = await apiClient.post<{ data: PropertyHealthReport }>('/property-health-report', data);
      return result.data;
    },
    onSuccess: (result) => {
      setLoading(false);
      queryClient.invalidateQueries({ queryKey: ['health-reports'] });
      return result;
    },
    onError: (err: any) => {
      setLoading(false);
      setError(err.message);
    },
  });

  const simulateAnalysis = useCallback(async (propertyId: string) => {
    setAnalysisProgress((prev) => ({ ...prev, [propertyId]: 0 }));
    const steps = [10, 25, 40, 55, 70, 85, 95, 100];
    for (const pct of steps) {
      await new Promise((r) => setTimeout(r, 400));
      setAnalysisProgress((prev) => ({ ...prev, [propertyId]: pct }));
    }
    setAnalysisProgress((prev) => {
      const next = { ...prev };
      delete next[propertyId];
      return next;
    });
  }, []);

  return {
    analyzeProperty,
    generateHealthReport,
    simulateAnalysis,
    analysisProgress,
  };
}
