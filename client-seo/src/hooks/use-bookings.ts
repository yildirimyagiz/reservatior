import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { bookingsApi, BookingStatus, SecurityRiskLevel, OwnershipVerificationStatus } from "@/lib/api/bookings";
import { useAppState } from "./use-app-state";
import { useToast } from "./use-toast";

// Query Keys
export const bookingKeys = {
  all: ["bookings"] as const,
  lists: () => [...bookingKeys.all, "list"] as const,
  list: (filters: Record<string, any>) => [...bookingKeys.lists(), filters] as const,
  details: () => [...bookingKeys.all, "detail"] as const,
  detail: (id: string) => [...bookingKeys.details(), id] as const,
  securityStatus: (id: string) => [...bookingKeys.detail(id), "security-status"] as const,
  analytics: (filters: Record<string, any>) => [...bookingKeys.all, "analytics", filters] as const,
};

// Base Booking Hooks
export const useBookings = (filters?: {
  orgId?: string;
  listingId?: string;
  contactId?: string;
  status?: string;
  ownershipVerified?: boolean;
  verificationStatus?: string;
  startDate?: string;
  endDate?: string;
  page?: number;
  limit?: number;
}) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: bookingKeys.list(filters || {}),
    queryFn: () => bookingsApi.getBookings(filters),
  });

  // Handle errors
  if (query.error) {
    setError("bookings", (query.error as any)?.message || "Failed to fetch bookings");
    toast({
      title: "Error",
      description: "Failed to fetch bookings",
      variant: "destructive",
    });
  }

  return query;
};

export const useBooking = (id: string) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: bookingKeys.detail(id),
    queryFn: () => bookingsApi.getBookingById(id),
    enabled: !!id,
  });

  // Handle errors
  if (query.error) {
    setError(`booking-${id}`, (query.error as any)?.message || "Failed to fetch booking");
    toast({
      title: "Error",
      description: "Failed to fetch booking details",
      variant: "destructive",
    });
  }

  return query;
};

export const useBookingSecurityStatus = (id: string) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: bookingKeys.securityStatus(id),
    queryFn: () => bookingsApi.getSecurityStatus(id),
    enabled: !!id,
  });

  // Handle errors
  if (query.error) {
    setError(`booking-security-${id}`, (query.error as any)?.message || "Failed to fetch security status");
    toast({
      title: "Error",
      description: "Failed to fetch security status",
      variant: "destructive",
    });
  }

  return query;
};

export const useBookingAnalytics = (filters?: {
  orgId?: string;
  propertyId?: string;
  dateFrom?: string;
  dateTo?: string;
}) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const query = useQuery({
    queryKey: bookingKeys.analytics(filters || {}),
    queryFn: () => bookingsApi.getBookingAnalytics(filters),
  });

  // Handle errors
  if (query.error) {
    setError("booking-analytics", (query.error as any)?.message || "Failed to fetch analytics");
    toast({
      title: "Error",
      description: "Failed to fetch booking analytics",
      variant: "destructive",
    });
  }

  return query;
};

// Mutation Hooks
export const useCreateBooking = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: bookingsApi.createBooking,
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: bookingKeys.lists() });
      
      toast({
        title: "Success",
        description: "Booking created successfully",
      });

      return data;
    },
    onError: (error: any) => {
      setError("create-booking", error.message || "Failed to create booking");
      toast({
        title: "Error",
        description: "Failed to create booking",
        variant: "destructive",
      });
    },
  });
};

export const useUpdateBooking = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: ({ id, data }: { id: string; data: any }) =>
      bookingsApi.updateBooking(id, data),
    onSuccess: (data, variables) => {
      queryClient.invalidateQueries({ queryKey: bookingKeys.detail(variables.id) });
      queryClient.invalidateQueries({ queryKey: bookingKeys.lists() });
      
      toast({
        title: "Success",
        description: "Booking updated successfully",
      });

      return data;
    },
    onError: (error: any) => {
      setError("update-booking", error.message || "Failed to update booking");
      toast({
        title: "Error",
        description: "Failed to update booking",
        variant: "destructive",
      });
    },
  });
};

export const useDeleteBooking = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: bookingsApi.deleteBooking,
    onSuccess: (_, id) => {
      queryClient.invalidateQueries({ queryKey: bookingKeys.lists() });
      queryClient.removeQueries({ queryKey: bookingKeys.detail(id) });
      
      toast({
        title: "Success",
        description: "Booking deleted successfully",
      });
    },
    onError: (error: any) => {
      setError("delete-booking", error.message || "Failed to delete booking");
      toast({
        title: "Error",
        description: "Failed to delete booking",
        variant: "destructive",
      });
    },
  });
};

export const useVerifyOwnership = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: ({ id, data }: { id: string; data: any }) => bookingsApi.verifyOwnership(id, data),
    onSuccess: (data, variables) => {
      queryClient.invalidateQueries({ queryKey: bookingKeys.detail(variables.id) });
      queryClient.invalidateQueries({ queryKey: bookingKeys.lists() });
      
      toast({
        title: "Success",
        description: "Ownership verification submitted",
      });

      return data;
    },
    onError: (error: any) => {
      setError("verify-ownership", error.message || "Failed to verify ownership");
      toast({
        title: "Error",
        description: "Failed to verify ownership",
        variant: "destructive",
      });
    },
  });
};

export const useCreateSecurityScreening = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: ({ id, data }: { id: string; data: any }) => bookingsApi.createSecurityScreening(id, data),
    onSuccess: (data, variables) => {
      queryClient.invalidateQueries({ queryKey: bookingKeys.detail(variables.id) });
      queryClient.invalidateQueries({ queryKey: bookingKeys.lists() });
      
      toast({
        title: "Success",
        description: "Security screening created",
      });

      return data;
    },
    onError: (error: any) => {
      setError("create-security-screening", error.message || "Failed to create security screening");
      toast({
        title: "Error",
        description: "Failed to create security screening",
        variant: "destructive",
      });
    },
  });
};

export const useUpdateBookingStatus = () => {
  const queryClient = useQueryClient();
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: ({ id, status, notes }: { id: string; status: BookingStatus; notes?: string }) =>
      bookingsApi.updateBookingStatus(id, status, notes),
    onSuccess: (data, variables) => {
      queryClient.invalidateQueries({ queryKey: bookingKeys.detail(variables.id) });
      queryClient.invalidateQueries({ queryKey: bookingKeys.lists() });
      
      toast({
        title: "Success",
        description: "Booking status updated",
      });

      return data;
    },
    onError: (error: any) => {
      setError("update-booking-status", error.message || "Failed to update status");
      toast({
        title: "Error",
        description: "Failed to update booking status",
        variant: "destructive",
      });
    },
  });
};

// Search Hook
export const useSearchBookings = (query: string, filters?: {
  orgId?: string;
  status?: BookingStatus;
  propertyId?: string;
  contactId?: string;
  dateFrom?: string;
  dateTo?: string;
  riskLevel?: SecurityRiskLevel;
  verificationStatus?: OwnershipVerificationStatus;
}) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  const queryResult = useQuery({
    queryKey: ["bookings", "search", query, filters],
    queryFn: () => bookingsApi.searchBookings(query, filters),
    enabled: !!query,
  });

  // Handle errors
  if (queryResult.error) {
    setError("search-bookings", (queryResult.error as any)?.message || "Failed to search bookings");
    toast({
      title: "Error",
      description: "Failed to search bookings",
      variant: "destructive",
    });
  }

  return queryResult;
};

// Export Hook
export const useExportBookings = () => {
  const { setError } = useAppState();
  const { toast } = useToast();

  return useMutation({
    mutationFn: bookingsApi.exportBookings,
    onSuccess: (response: any) => {
      // Create download link
      const blob = response.data || response;
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = `bookings-export-${new Date().toISOString().split('T')[0]}.xlsx`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
      
      toast({
        title: "Success",
        description: "Bookings exported successfully",
      });
    },
    onError: (error: any) => {
      setError("export-bookings", error.message || "Failed to export bookings");
      toast({
        title: "Error",
        description: "Failed to export bookings",
        variant: "destructive",
      });
    },
  });
};

// Combined Hook for Booking Management
export const useBookingManagement = (bookingId?: string) => {
  const bookingQuery = useBooking(bookingId!);
  const securityStatusQuery = useBookingSecurityStatus(bookingId!);
  const createMutation = useCreateBooking();
  const updateMutation = useUpdateBooking();
  const deleteMutation = useDeleteBooking();
  const verifyOwnershipMutation = useVerifyOwnership();
  const createSecurityScreeningMutation = useCreateSecurityScreening();
  const updateStatusMutation = useUpdateBookingStatus();

  return {
    // Data
    booking: bookingQuery.data,
    securityStatus: securityStatusQuery.data,
    
    // Loading states
    isLoading: bookingQuery.isLoading || securityStatusQuery.isLoading,
    isCreating: createMutation.isPending,
    isUpdating: updateMutation.isPending,
    isDeleting: deleteMutation.isPending,
    isVerifyingOwnership: verifyOwnershipMutation.isPending,
    isCreatingSecurityScreening: createSecurityScreeningMutation.isPending,
    isUpdatingStatus: updateStatusMutation.isPending,
    
    // Error states
    bookingError: bookingQuery.error,
    securityStatusError: securityStatusQuery.error,
    createError: createMutation.error,
    updateError: updateMutation.error,
    deleteError: deleteMutation.error,
    verifyOwnershipError: verifyOwnershipMutation.error,
    createSecurityScreeningError: createSecurityScreeningMutation.error,
    updateStatusError: updateStatusMutation.error,
    
    // Actions
    createBooking: createMutation.mutate,
    updateBooking: updateMutation.mutate,
    deleteBooking: deleteMutation.mutate,
    verifyOwnership: verifyOwnershipMutation.mutate,
    createSecurityScreening: createSecurityScreeningMutation.mutate,
    updateBookingStatus: updateStatusMutation.mutate,
    
    // Refetch
    refetch: () => {
      bookingQuery.refetch();
      securityStatusQuery.refetch();
    },
  };
};
