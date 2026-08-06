import { create } from 'zustand';
import { ComplianceRule, ComplianceCheck } from '../api/compliance-os';

interface ComplianceOSState {
  rules: ComplianceRule[];
  checks: ComplianceCheck[];
  loading: boolean;
  error: string | null;
  fetchRules: (country: string) => Promise<void>;
  createRule: (data: Omit<ComplianceRule, 'id' | 'createdAt' | 'updatedAt'>) => Promise<void>;
  updateRule: (id: string, data: Partial<ComplianceRule>) => Promise<void>;
  deleteRule: (id: string) => Promise<void>;
  checkCompliance: (entityId: string, entityType: string) => Promise<void>;
}

export const useComplianceOSStore = create<ComplianceOSState>((set, get) => ({
  rules: [],
  checks: [],
  loading: false,
  error: null,

  fetchRules: async (country: string) => {
    set({ loading: true, error: null });
    try {
      const { complianceOSApi } = await import('../api/compliance-os');
      const rules = await complianceOSApi.getActiveRules(country);
      set({ rules, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  createRule: async (data) => {
    set({ loading: true, error: null });
    try {
      const { complianceOSApi } = await import('../api/compliance-os');
      const rule = await complianceOSApi.createRule(data);
      set(state => ({ rules: [...state.rules, rule], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  updateRule: async (id, data) => {
    set({ loading: true, error: null });
    try {
      const { complianceOSApi } = await import('../api/compliance-os');
      const rule = await complianceOSApi.updateRule(id, data);
      set(state => ({
        rules: state.rules.map(r => r.id === id ? rule : r),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  deleteRule: async (id) => {
    set({ loading: true, error: null });
    try {
      const { complianceOSApi } = await import('../api/compliance-os');
      await complianceOSApi.deleteRule(id);
      set(state => ({
        rules: state.rules.filter(r => r.id !== id),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  checkCompliance: async (entityId, entityType) => {
    set({ loading: true, error: null });
    try {
      const { complianceOSApi } = await import('../api/compliance-os');
      const checks = await complianceOSApi.checkCompliance(entityId, entityType);
      set({ checks, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
