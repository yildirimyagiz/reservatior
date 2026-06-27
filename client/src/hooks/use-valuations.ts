import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { valuationsApi, ValuationType, ValuationStatus } from "@/lib/api/valuations";
import { useAppState } from "./use-app-state";
import { useToast } from "./use-toast";

// Query Keys
export const valuationKeys = {
  all: ["valuations"] as const,
  lists: () => [...valuationKeys.all, "list"] as const,
  list: (filters: Record<string, any>) => [...valuationKeys.lists(), filters] as const,
  details: () => [...valuationKeys.all, "detail"] as const,
  detail: (id: string) => [...valuationKeys.details(), id] as const,
  analytics: (id: string) => [...valuationKeys.detail(id), "analytics"] as const,
  reports: (id: string) => [...valuationKeys.detail(id), "reports"] as const,
  stats: (filters: Record<string, any>) => [...valuationKeys.all, "stats", filters] as const,
};

// Base Valuation Hooks
export const useValuations = (filters?: {
  page?: number;
  limit?: number;
  propertyId?: string;
  agentId?: string;
  status?: ValuationStatus;
  valuationType?: ValuationType;
}) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: valuationKeys.list(filters || {}),
    queryFn: () => valuationsApi.getValuations(filters),
  });

  // Handle errors
  if (query.error) {
    setError("valuations", (query.error as any)?.message || "Failed to fetch valuations");
    toast({
      title: "Error",
      description: "Failed to fetch valuations",
      variant: "destructive",
    });
  }

  return query;
};

export const useValuation = (id: string) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: valuationKeys.detail(id),
    queryFn: () => valuationsApi.getValuationById(id),
    enabled: !!id,
  });

  // Handle errors
  if (query.error) {
    setError(`valuation-${id}`, (query.error as any)?.message || "Failed to fetch valuation");
    toast({
      title: "Error",
      description: "Failed to fetch valuation details",
      variant: "destructive",
    });
  }

  return query;
};

export const useValuationAnalytics = (id: string) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: valuationKeys.analytics(id),
    queryFn: () => valuationsApi.getValuationAnalytics(id),
    enabled: !!id,
  });

  // Handle errors
  if (query.error) {
    setError(`valuation-analytics-${id}`, (query.error as any)?.message || "Failed to fetch analytics");
    toast({
      title: "Error",
      description: "Failed to fetch valuation analytics",
      variant: "destructive",
    });
  }

  return query;
};

export const useValuationReports = (id: string) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: valuationKeys.reports(id),
    queryFn: () => valuationsApi.getValuationReports(id),
    enabled: !!id,
  });

  // Handle errors
  if (query.error) {
    setError(`valuation-reports-${id}`, (query.error as any)?.message || "Failed to fetch reports");
    toast({
      title: "Error",
      description: "Failed to fetch valuation reports",
      variant: "destructive",
    });
  }

  return query;
};

export const useValuationStats = (filters?: {
  orgId?: string;
  propertyId?: string;
  dateFrom?: string;
  dateTo?: string;
}) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: valuationKeys.stats(filters || {}),
    queryFn: () => valuationsApi.getValuationStats(filters),
  });

  // Handle errors
  if (query.error) {
    setError("valuation-stats", (query.error as any)?.message || "Failed to fetch valuation stats");
    toast({
      title: "Error",
      description: "Failed to fetch valuation statistics",
      variant: "destructive",
    });
  }

  return query;
};

// Mutation Hooks
export const useCreateValuation = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: valuationsApi.createValuation,
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: valuationKeys.lists() });
      queryClient.invalidateQueries({ queryKey: valuationKeys.stats({}) });
      
      toast({
        title: "Success",
        description: "Valuation request submitted successfully",
      });

      return data;
    },
    onError: (error: any) => {
      setError("create-valuation", error.message || "Failed to create valuation");
      toast({
        title: "Error",
        description: "Failed to submit valuation request",
        variant: "destructive",
      });
    },
  });
};

export const useUpdateValuation = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: ({ id, data }: { id: string; data: any }) =>
      valuationsApi.updateValuation(id, data),
    onSuccess: (data, variables) => {
      queryClient.invalidateQueries({ queryKey: valuationKeys.detail(variables.id) });
      queryClient.invalidateQueries({ queryKey: valuationKeys.lists() });
      
      toast({
        title: "Success",
        description: "Valuation updated successfully",
      });

      return data;
    },
    onError: (error: any) => {
      setError("update-valuation", error.message || "Failed to update valuation");
      toast({
        title: "Error",
        description: "Failed to update valuation",
        variant: "destructive",
      });
    },
  });
};

export const useDeleteValuation = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: valuationsApi.deleteValuation,
    onSuccess: (_, id) => {
      queryClient.invalidateQueries({ queryKey: valuationKeys.lists() });
      queryClient.removeQueries({ queryKey: valuationKeys.detail(id) });
      
      toast({
        title: "Success",
        description: "Valuation deleted successfully",
      });
    },
    onError: (error: any) => {
      setError("delete-valuation", error.message || "Failed to delete valuation");
      toast({
        title: "Error",
        description: "Failed to delete valuation",
        variant: "destructive",
      });
    },
  });
};

export const useProcessValuation = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: valuationsApi.processValuation,
    onSuccess: (data, id) => {
      queryClient.invalidateQueries({ queryKey: valuationKeys.detail(id as string) });
      queryClient.invalidateQueries({ queryKey: valuationKeys.lists() });
      
      toast({
        title: "Success",
        description: "Valuation processing started",
      });

      return data;
    },
    onError: (error: any) => {
      setError("process-valuation", error.message || "Failed to process valuation");
      toast({
        title: "Error",
        description: "Failed to start valuation processing",
        variant: "destructive",
      });
    },
  });
};

export const useCreateValuationReport = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: ({ id, data }: { id: string; data: any }) =>
      valuationsApi.createValuationReport(id, data),
    onSuccess: (data, variables) => {
      queryClient.invalidateQueries({ queryKey: valuationKeys.reports(variables.id) });
      
      toast({
        title: "Success",
        description: "Valuation report generated successfully",
      });

      return data;
    },
    onError: (error: any) => {
      setError("create-valuation-report", error.message || "Failed to create report");
      toast({
        title: "Error",
        description: "Failed to generate valuation report",
        variant: "destructive",
      });
    },
  });
};

export const useBulkUpdateValuations = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: ({ ids, data }: { ids: string[]; data: any }) =>
      valuationsApi.bulkUpdateValuations(ids, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: valuationKeys.lists() });
      
      toast({
        title: "Success",
        description: "Valuations updated successfully",
      });
    },
    onError: (error: any) => {
      setError("bulk-update-valuations", error.message || "Failed to update valuations");
      toast({
        title: "Error",
        description: "Failed to update valuations",
        variant: "destructive",
      });
    },
  });
};

// Search Hook
export const useSearchValuations = (query: string, filters?: {
  propertyId?: string;
  status?: ValuationStatus;
  valuationType?: ValuationType;
  dateFrom?: string;
  dateTo?: string;
}) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const queryResult = useQuery({
    queryKey: ["valuations", "search", query, filters],
    queryFn: () => valuationsApi.searchValuations(query, filters),
    enabled: !!query,
  });

  // Handle errors
  if (queryResult.error) {
    setError("search-valuations", (queryResult.error as any)?.message || "Failed to search valuations");
    toast({
      title: "Error",
      description: "Failed to search valuations",
      variant: "destructive",
    });
  }

  return queryResult;
};

// Export Hook
export const useExportValuations = () => {
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: valuationsApi.exportValuations,
    onSuccess: (response: any) => {
      // Create download link
      const blob = response.data || response;
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = `valuations-export-${new Date().toISOString().split('T')[0]}.xlsx`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
      
      toast({
        title: "Success",
        description: "Valuations exported successfully",
      });
    },
    onError: (error: any) => {
      setError("export-valuations", error.message || "Failed to export valuations");
      toast({
        title: "Error",
        description: "Failed to export valuations",
        variant: "destructive",
      });
    },
  });
};

// Combined Hook for Valuation Management
export const useValuationManagement = (valuationId?: string) => {
  const valuationQuery = useValuation(valuationId!);
  const analyticsQuery = useValuationAnalytics(valuationId!);
  const reportsQuery = useValuationReports(valuationId!);
  const createMutation = useCreateValuation();
  const updateMutation = useUpdateValuation();
  const deleteMutation = useDeleteValuation();
  const processMutation = useProcessValuation();
  const createReportMutation = useCreateValuationReport();

  return {
    // Data
    valuation: valuationQuery.data,
    analytics: analyticsQuery.data,
    reports: reportsQuery.data,
    
    // Loading states
    isLoading: valuationQuery.isLoading || analyticsQuery.isLoading || reportsQuery.isLoading,
    isCreating: createMutation.isPending,
    isUpdating: updateMutation.isPending,
    isDeleting: deleteMutation.isPending,
    isProcessing: processMutation.isPending,
    isCreatingReport: createReportMutation.isPending,
    
    // Error states
    valuationError: valuationQuery.error,
    analyticsError: analyticsQuery.error,
    reportsError: reportsQuery.error,
    createError: createMutation.error,
    updateError: updateMutation.error,
    deleteError: deleteMutation.error,
    processError: processMutation.error,
    createReportError: createReportMutation.error,
    
    // Actions
    createValuation: createMutation.mutate,
    updateValuation: updateMutation.mutate,
    deleteValuation: deleteMutation.mutate,
    processValuation: processMutation.mutate,
    createReport: createReportMutation.mutate,
    
    // Refetch
    refetch: () => {
      valuationQuery.refetch();
      analyticsQuery.refetch();
      reportsQuery.refetch();
    },
  };
};
