import { create } from "zustand";
import { devtools } from "zustand/middleware";

export interface SecuritySettings {
  id: string;
  organizationId: string;
  passwordPolicy: {
    minLength: number;
    requireUppercase: boolean;
    requireLowercase: boolean;
    requireNumbers: boolean;
    requireSpecialChars: boolean;
    maxAge: number; // days
  };
  sessionPolicy: {
    timeout: number; // minutes
    maxConcurrentSessions: number;
    requireReauth: boolean;
  };
  twoFactorAuth: {
    required: boolean;
    methods: string[];
    gracePeriod: number; // days
  };
  ipWhitelist: {
    enabled: boolean;
    allowedIPs: string[];
  };
  apiRateLimit: {
    enabled: boolean;
    requestsPerMinute: number;
    burstLimit: number;
  };
  dataEncryption: {
    atRest: boolean;
    inTransit: boolean;
    keyRotation: number; // days
  };
  auditLogging: {
    enabled: boolean;
    retention: number; // days
    logLevel: string;
  };
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface SecuritySettingsState {
  settings: SecuritySettings[];
  loading: boolean;
  error: string | null;
  selectedSettings: SecuritySettings | null;
  filters: {
    search: string;
    organizationId: string;
    isActive: string;
  };
  pagination: {
    page: number;
    limit: number;
    total: number;
  };
  setSettings: (settings: SecuritySettings[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  setSelectedSettings: (settings: SecuritySettings | null) => void;
  setFilters: (filters: Partial<SecuritySettingsState["filters"]>) => void;
  setPagination: (
    pagination: Partial<SecuritySettingsState["pagination"]>
  ) => void;
  addSettings: (settings: SecuritySettings) => void;
  updateSettings: (id: string, settings: Partial<SecuritySettings>) => void;
  removeSettings: (id: string) => void;
  clearFilters: () => void;
}

export const useSecuritySettingsStore = create<SecuritySettingsState>()(
  devtools(
    (set) => ({
      settings: [],
      loading: false,
      error: null,
      selectedSettings: null,
      filters: {
        search: "",
        organizationId: "all",
        isActive: "all",
      },
      pagination: {
        page: 1,
        limit: 20,
        total: 0,
      },
      setSettings: (settings) => set({ settings }),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      setSelectedSettings: (selectedSettings) => set({ selectedSettings }),
      setFilters: (filters) =>
        set((state) => ({ filters: { ...state.filters, ...filters } })),
      setPagination: (pagination) =>
        set((state) => ({
          pagination: { ...state.pagination, ...pagination },
        })),
      addSettings: (settings) =>
        set((state) => ({ settings: [...state.settings, settings] })),
      updateSettings: (id, updatedSettings) =>
        set((state) => ({
          settings: state.settings.map((s) =>
            s.id === id ? { ...s, ...updatedSettings } : s
          ),
        })),
      removeSettings: (id) =>
        set((state) => ({
          settings: state.settings.filter((s) => s.id !== id),
        })),
      clearFilters: () =>
        set({
          filters: {
            search: "",
            organizationId: "all",
            isActive: "all",
          },
        }),
    }),
    { name: "security-settings-store" }
  )
);
