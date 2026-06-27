import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { RegionalConfig, fetchRegions } from '../regions';

export type Region = RegionalConfig;

export interface RegionsState {
  regions: Region[];
  selectedRegion: Region | null;
  isLoading: boolean;
  error: string | null;
  
  // Actions
  loadRegions: () => Promise<void>;
  setSelectedRegion: (regionCode: string) => void;
}

export const useRegionsStore = create<RegionsState>()(
  persist(
    (set, get) => ({
      regions: [],
      selectedRegion: null,
      isLoading: false,
      error: null,

      loadRegions: async () => {
        try {
          set({ isLoading: true, error: null });
          const regions = await fetchRegions();
          
          set((state) => {
            // Auto-select first region if none selected
            const selected = state.selectedRegion 
              ? regions.find(r => r.countryCode === state.selectedRegion?.countryCode) || regions[0]
              : regions[0];
              
            return { 
              regions, 
              selectedRegion: selected || null,
              isLoading: false 
            };
          });
        } catch (error: any) {
          set({ isLoading: false, error: error.message || 'Failed to load regions' });
        }
      },

      setSelectedRegion: (countryCode: string) => {
        const { regions } = get();
        const region = regions.find(r => r.countryCode === countryCode);
        if (region) {
          set({ selectedRegion: region });
          // Optionally trigger a page reload so API client picks up the new header for all queries immediately
          window.location.reload();
        }
      }
    }),
    {
      name: 'regions-store', // matching what client.ts expects
    }
  )
);
