import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface ClientRelationship {
  id: string;
  clientId: string;
  agentId: string;
  type: string;
  status: "active" | "inactive" | "terminated";
  startDate: Date;
  endDate?: Date;
  exclusive: boolean;
  commissionRate?: number;
  commissionStructure?: string;
  notes?: string;
  documents: string[];
  properties: Array<{
    propertyId: string;
    role: string; // buyer, seller, renter, landlord
    status: string;
  }>;
  organizationId: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface ClientRelationshipsState {
  relationships: ClientRelationship[];
  loading: boolean;
  error: string | null;
  selectedRelationship: ClientRelationship | null;
  filters: {
    search: string;
    clientId: string;
    agentId: string;
    type: string;
    status: string;
    dateRange: [Date | null, Date | null];
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setRelationships: (relationships: ClientRelationship[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedRelationship: (relationship: ClientRelationship | null) => void;
  setFilters: (filters: Partial<ClientRelationshipsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<ClientRelationshipsState["pagination"]>
  ) => void;
  addRelationship: (relationship: ClientRelationship) => void;
  updateRelationship: (
    id: string,
    relationship: Partial<ClientRelationship>
  ) => void;
  removeRelationship: (id: string) => void;
  clearFilters: () => void;
}

export const useClientRelationshipsStore = create<ClientRelationshipsState>()(
  devtools(
    (set) => ({
      relationships: [],
      loading: false,
      error: null,
      selectedRelationship: null,
      filters: {
        search: "",
        clientId: "all",
        agentId: "all",
        type: "all",
        status: "all",
        dateRange: [null, null],
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setRelationships: (relationships) => set({ relationships }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedRelationship: (selectedRelationship) =>
        set({ selectedRelationship }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addRelationship: (relationship) =>
        set((state) => ({
          relationships: [...state.relationships, relationship],
        })),
      updateRelationship: (id, updatedRelationship) =>
        set((state) => ({
          relationships: state.relationships.map((r) =>
            r.id === id ? { ...r, ...updatedRelationship } : r
          ),
        })),
      removeRelationship: (id) =>
        set((state) => ({
          relationships: state.relationships.filter((r) => r.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            clientId: "all",
            agentId: "all",
            type: "all",
            status: "all",
            dateRange: [null, null],
          },
        }),
    }),
    { name: "client-relationships-store" }
  )
);
