import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface SignatureRequest {
  id: string;
  documentId: string;
  title: string;
  description?: string;
  status: "draft" | "sent" | "signed" | "declined" | "expired";
  expiresAt?: Date;
  signedAt?: Date;
  signers: Array<{
    id: string;
    email: string;
    name: string;
    status: "pending" | "signed" | "declined";
    signedAt?: Date;
    ipAddress?: string;
  }>;
  settings: {
    allowDelegation: boolean;
    requirePassword: boolean;
    orderRequired: boolean;
  };
  createdBy: string;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface SignatureRequestsState {
  requests: SignatureRequest[];
  loading: boolean;
  error: string | null;
  selectedRequest: SignatureRequest | null;
  filters: {
    search: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRequests: (requests: SignatureRequest[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRequest: (request: SignatureRequest | null) => void;
  setFilters: (filters: Partial<SignatureRequestsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<SignatureRequestsState["pagination"]>
  ) => void;
  addRequest: (request: SignatureRequest) => void;
  updateRequest: (id: string, request: Partial<SignatureRequest>) => void;
  removeRequest: (id: string) => void;
  clearFilters: () => void;
}

export const useSignatureRequestsStore = create<SignatureRequestsState>()(
  devtools(
    (set) => ({
      requests: [],
      loading: false,
      error: null,
      selectedRequest: null,
      filters: {
        search: "",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRequests: (requests) => set({ requests }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRequest: (selectedRequest) => set({ selectedRequest }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRequest: (request) =>
        set((state) => ({ requests: [...state.requests, request] })),
      updateRequest: (id, updatedRequest) =>
        set((state) => ({
          requests: state.requests.map((r) =>
            r.id === id ? { ...r, ...updatedRequest } : r
          ),
        })),
      removeRequest: (id) =>
        set((state) => ({
          requests: state.requests.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "signature-requests-store" }
  )
);
