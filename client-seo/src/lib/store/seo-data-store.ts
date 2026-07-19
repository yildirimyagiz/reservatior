import { create } from "zustand";
import { devtools } from "zustand/middleware";
import type { PropertySEOData, InvestmentScore, RentalYield } from "../api/seo-data";

export interface SEODataState {
  seoData: PropertySEOData | null;
  investmentScore: InvestmentScore | null;
  rentalYield: RentalYield | null;
  loading: boolean;
  error: string | null;
  setSEOData: (data: PropertySEOData | null) => void;
  setInvestmentScore: (score: InvestmentScore | null) => void;
  setRentalYield: (yieldData: RentalYield | null) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  clearAll: () => void;
}

export const useSEODataStore = create<SEODataState>()(
  devtools(
    (set) => ({
      seoData: null,
      investmentScore: null,
      rentalYield: null,
      loading: false,
      error: null,
      setSEOData: (seoData) => set({ seoData }),
      setInvestmentScore: (investmentScore) => set({ investmentScore }),
      setRentalYield: (rentalYield) => set({ rentalYield }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      clearAll: () =>
        set({
          seoData: null,
          investmentScore: null,
          rentalYield: null,
          error: null,
        }),
    }),
    { name: "seo-data-store" }
  )
);
