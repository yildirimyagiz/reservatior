import { create } from 'zustand';
import { Developer, APIKey, Integration, IntegrationStatus, APIAccessLevel } from '../api/ecosystem-os';

interface EcosystemOSState {
  developers: Developer[];
  apiKeys: APIKey[];
  integrations: Integration[];
  loading: boolean;
  error: string | null;
  registerDeveloper: (data: { userId: string; organizationName: string; email: string }) => Promise<void>;
  createAPIKey: (data: { developerId: string; name: string; accessLevel: APIAccessLevel; scopes: string[]; rateLimit: number }) => Promise<void>;
  revokeAPIKey: (keyId: string) => Promise<void>;
  createIntegration: (data: { developerId: string; name: string; description: string; category: string; pricingModel: string }) => Promise<void>;
  submitIntegrationForReview: (integrationId: string) => Promise<void>;
  approveIntegration: (integrationId: string) => Promise<void>;
  getIntegrationMarketplace: (category?: string) => Promise<void>;
}

export const useEcosystemOSStore = create<EcosystemOSState>((set) => ({
  developers: [],
  apiKeys: [],
  integrations: [],
  loading: false,
  error: null,

  registerDeveloper: async (data) => {
    set({ loading: true, error: null });
    try {
      const { ecosystemOSApi } = await import('../api/ecosystem-os');
      const developer = await ecosystemOSApi.registerDeveloper(data);
      set(state => ({ developers: [...state.developers, developer], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  createAPIKey: async (data) => {
    set({ loading: true, error: null });
    try {
      const { ecosystemOSApi } = await import('../api/ecosystem-os');
      const apiKey = await ecosystemOSApi.createAPIKey(data);
      set(state => ({ apiKeys: [...state.apiKeys, apiKey], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  revokeAPIKey: async (keyId: string) => {
    set({ loading: true, error: null });
    try {
      const { ecosystemOSApi } = await import('../api/ecosystem-os');
      await ecosystemOSApi.revokeAPIKey(keyId);
      set(state => ({
        apiKeys: state.apiKeys.filter(k => k.id !== keyId),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  createIntegration: async (data) => {
    set({ loading: true, error: null });
    try {
      const { ecosystemOSApi } = await import('../api/ecosystem-os');
      const integration = await ecosystemOSApi.createIntegration(data);
      set(state => ({ integrations: [...state.integrations, integration], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  submitIntegrationForReview: async (integrationId: string) => {
    set({ loading: true, error: null });
    try {
      const { ecosystemOSApi } = await import('../api/ecosystem-os');
      const integration = await ecosystemOSApi.submitIntegrationForReview(integrationId);
      set(state => ({
        integrations: state.integrations.map(i => i.id === integrationId ? integration : i),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  approveIntegration: async (integrationId: string) => {
    set({ loading: true, error: null });
    try {
      const { ecosystemOSApi } = await import('../api/ecosystem-os');
      const integration = await ecosystemOSApi.approveIntegration(integrationId);
      set(state => ({
        integrations: state.integrations.map(i => i.id === integrationId ? integration : i),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getIntegrationMarketplace: async (category?: string) => {
    set({ loading: true, error: null });
    try {
      const { ecosystemOSApi } = await import('../api/ecosystem-os');
      const integrations = await ecosystemOSApi.getIntegrationMarketplace(category);
      set({ integrations, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
