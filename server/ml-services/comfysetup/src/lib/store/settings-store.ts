import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { Preset, PromptConfig, SellerAPIConfig } from '@/types';
import { generateId } from '@/lib/utils';

interface SettingsState {
    // Presets
    presets: Preset[];

    // Seller APIs
    sellerAPIs: SellerAPIConfig[];

    // Preferences
    defaultComputeMode: 'cpu' | 'gpu';

    // Preset actions
    savePreset: (name: string, config: PromptConfig) => string;
    deletePreset: (id: string) => void;
    getPresetById: (id: string) => Preset | undefined;

    // Seller API actions
    addSellerAPI: (config: Omit<SellerAPIConfig, 'id'>) => string;
    updateSellerAPI: (id: string, updates: Partial<SellerAPIConfig>) => void;
    removeSellerAPI: (id: string) => void;
    toggleSellerAPI: (id: string) => void;

    // Preference actions
    setDefaultComputeMode: (mode: 'cpu' | 'gpu') => void;
}

export const useSettingsStore = create<SettingsState>()(
    persist(
        (set, get) => ({
            presets: [],
            sellerAPIs: [],
            defaultComputeMode: 'gpu',

            // Preset actions
            savePreset: (name, config) => {
                const id = generateId();
                const preset: Preset = {
                    id,
                    name,
                    config,
                    createdAt: Date.now(),
                };
                set((state) => ({
                    presets: [...state.presets, preset],
                }));
                return id;
            },

            deletePreset: (id) =>
                set((state) => ({
                    presets: state.presets.filter((p) => p.id !== id),
                })),

            getPresetById: (id) =>
                get().presets.find((p) => p.id === id),

            // Seller API actions
            addSellerAPI: (config) => {
                const id = generateId();
                const apiConfig: SellerAPIConfig = {
                    ...config,
                    id,
                };
                set((state) => ({
                    sellerAPIs: [...state.sellerAPIs, apiConfig],
                }));
                return id;
            },

            updateSellerAPI: (id, updates) =>
                set((state) => ({
                    sellerAPIs: state.sellerAPIs.map((api) =>
                        api.id === id ? { ...api, ...updates } : api
                    ),
                })),

            removeSellerAPI: (id) =>
                set((state) => ({
                    sellerAPIs: state.sellerAPIs.filter((api) => api.id !== id),
                })),

            toggleSellerAPI: (id) =>
                set((state) => ({
                    sellerAPIs: state.sellerAPIs.map((api) =>
                        api.id === id ? { ...api, enabled: !api.enabled } : api
                    ),
                })),

            // Preference actions
            setDefaultComputeMode: (defaultComputeMode) =>
                set({ defaultComputeMode }),
        }),
        {
            name: 'staging-settings',
        }
    )
);
