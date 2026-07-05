import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { RegionalConfig, fetchRegions } from '../regions';

export type Region = RegionalConfig;

export interface RegionsState {
  regions: Region[];
  selectedRegion: Region | null;
  detectedRegion: string | null; // IP/CDN'den algılanan ülke kodu
  isLoading: boolean;
  error: string | null;

  // Actions
  loadRegions: () => Promise<void>;
  setSelectedRegion: (regionCode: string) => void;
  autoDetectRegion: () => Promise<void>;
}

export const useRegionsStore = create<RegionsState>()(
  persist(
    (set, get) => ({
      regions: [],
      selectedRegion: null,
      detectedRegion: null,
      isLoading: false,
      error: null,

      loadRegions: async () => {
        try {
          set({ isLoading: true, error: null });
          const regions = await fetchRegions();

          set((state) => {
            // Eğer önceden seçili bir bölge varsa onu koru, yoksa ilkini seç
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

      /**
       * CDN headers (Cloudflare, Vercel, CloudFront) ve Accept-Language üzerinden
       * kullanıcının ülkesini otomatik algılar ve bölge seçimini günceller.
       * localStorage'a kaydedilir — sonraki sayfa yüklemelerinde korunur.
       */
      autoDetectRegion: async () => {
        // Zaten bir seçim varsa tekrar algılama yapma
        if (get().detectedRegion) return;

        try {
          const res = await fetch('/api/country-context', { cache: 'no-store' });
          if (!res.ok) return;

          const data = await res.json() as {
            region: string;
            currency: string;
            locale: string;
            isRTL: boolean;
            detectionMethod: string;
          };

          set({ detectedRegion: data.region });

          // Bölgeler yüklendiyse otomatik seç
          const { regions, selectedRegion } = get();
          if (!selectedRegion && regions.length > 0) {
            const match = regions.find(r => r.countryCode === data.region);
            if (match) set({ selectedRegion: match });
          }

          // RTL dilleri için document yönünü ayarla
          if (typeof document !== 'undefined') {
            if (data.isRTL) {
              document.documentElement.setAttribute('dir', 'rtl');
            }
          }

          console.log(`🌍 [RegionsStore] Auto-detected region: ${data.region} (${data.detectionMethod})`);
        } catch (err) {
          console.warn('[RegionsStore] Auto-detection failed:', err);
        }
      },

      setSelectedRegion: (countryCode: string) => {
        const { regions } = get();
        const region = regions.find(r => r.countryCode === countryCode);
        if (region) {
          set({ selectedRegion: region });
          // Sayfa yenileme kaldırıldı - API client otomatik olarak yeni region header'ı kullanır
        }
      }
    }),
    {
      name: 'regions-store',
      // Sadece selectedRegion ve detectedRegion'ı kalıcı tut
      partialize: (state) => ({
        selectedRegion: state.selectedRegion,
        detectedRegion: state.detectedRegion,
      }),
    }
  )
);
