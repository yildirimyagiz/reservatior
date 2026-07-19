import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { PropertyScan, AgentOffer, AgentDashboardSummary } from "@/lib/api/agent-mobile";

export interface AgentMobileState {
  scannedProperties: PropertyScan[];
  dashboardSummary: AgentDashboardSummary | null;
  agentOffers: AgentOffer[];
  loading: boolean;
  error: string | null;
  selectedProperty: PropertyScan | null;
  selectedOffer: AgentOffer | null;
  filters: {
    address: string;
    city: string;
    minBedrooms: number | null;
    maxPrice: number | null;
    offerStatus: string;
  };
  setScannedProperties: (properties: PropertyScan[]) => void;
  setDashboardSummary: (summary: AgentDashboardSummary | null) => void;
  setAgentOffers: (offers: AgentOffer[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedProperty: (property: PropertyScan | null) => void;
  setSelectedOffer: (offer: AgentOffer | null) => void;
  setFilters: (filters: Partial<AgentMobileState["filters"]>) => void;
  addOffer: (offer: AgentOffer) => void;
  updateOffer: (id: string, offer: Partial<AgentOffer>) => void;
  removeOffer: (id: string) => void;
  clearFilters: () => void;
}

export const useAgentMobileStore = create<AgentMobileState>()(
  devtools(
    (set) => ({
      scannedProperties: [],
      dashboardSummary: null,
      agentOffers: [],
      loading: false,
      error: null,
      selectedProperty: null,
      selectedOffer: null,
      filters: {
        address: "",
        city: "",
        minBedrooms: null,
        maxPrice: null,
        offerStatus: "all",
      },
      setScannedProperties: (scannedProperties) => set({ scannedProperties }),
      setDashboardSummary: (dashboardSummary) => set({ dashboardSummary }),
      setAgentOffers: (agentOffers) => set({ agentOffers }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedProperty: (selectedProperty) => set({ selectedProperty }),
      setSelectedOffer: (selectedOffer) => set({ selectedOffer }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      addOffer: (offer) =>
        set((state) => ({ agentOffers: [...state.agentOffers, offer] })),
      updateOffer: (id, updatedOffer) =>
        set((state) => ({
          agentOffers: state.agentOffers.map((o) =>
            o.id === id ? { ...o, ...updatedOffer } : o
          ),
        })),
      removeOffer: (id) =>
        set((state) => ({
          agentOffers: state.agentOffers.filter((o) => o.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            address: "",
            city: "",
            minBedrooms: null,
            maxPrice: null,
            offerStatus: "all",
          },
        }),
    }),
    { name: "agent-mobile-store" }
  )
);
