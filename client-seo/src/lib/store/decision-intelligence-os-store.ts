import { create } from 'zustand';
import { Decision, DecisionType, DecisionAction } from '../api/decision-intelligence-os';

interface DecisionIntelligenceOSState {
  decisions: Decision[];
  loading: boolean;
  error: string | null;
  makeTenantTrustDecision: (tenantId: string, propertyId: string) => Promise<void>;
  makePropertyRiskDecision: (propertyId: string) => Promise<void>;
  makePriceRecommendation: (propertyId: string) => Promise<void>;
  makeMaintenancePriorityDecision: (propertyId: string) => Promise<void>;
  makeInvestmentOpportunityDecision: (propertyId: string) => Promise<void>;
  makePaymentMethodDecision: (tenantId: string) => Promise<void>;
  makeDepositRecommendation: (tenantId: string, propertyId: string) => Promise<void>;
  executeDecision: (decision: Omit<Decision, 'id' | 'createdAt'>) => Promise<void>;
}

export const useDecisionIntelligenceOSStore = create<DecisionIntelligenceOSState>((set) => ({
  decisions: [],
  loading: false,
  error: null,

  makeTenantTrustDecision: async (tenantId: string, propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const decision = await decisionIntelligenceOSApi.makeTenantTrustDecision(tenantId, propertyId);
      set(state => ({ decisions: [...state.decisions, decision], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  makePropertyRiskDecision: async (propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const decision = await decisionIntelligenceOSApi.makePropertyRiskDecision(propertyId);
      set(state => ({ decisions: [...state.decisions, decision], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  makePriceRecommendation: async (propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const decision = await decisionIntelligenceOSApi.makePriceRecommendation(propertyId);
      set(state => ({ decisions: [...state.decisions, decision], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  makeMaintenancePriorityDecision: async (propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const decision = await decisionIntelligenceOSApi.makeMaintenancePriorityDecision(propertyId);
      set(state => ({ decisions: [...state.decisions, decision], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  makeInvestmentOpportunityDecision: async (propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const decision = await decisionIntelligenceOSApi.makeInvestmentOpportunityDecision(propertyId);
      set(state => ({ decisions: [...state.decisions, decision], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  makePaymentMethodDecision: async (tenantId: string) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const decision = await decisionIntelligenceOSApi.makePaymentMethodDecision(tenantId);
      set(state => ({ decisions: [...state.decisions, decision], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  makeDepositRecommendation: async (tenantId: string, propertyId: string) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const decision = await decisionIntelligenceOSApi.makeDepositRecommendation(tenantId, propertyId);
      set(state => ({ decisions: [...state.decisions, decision], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  executeDecision: async (decision) => {
    set({ loading: true, error: null });
    try {
      const { decisionIntelligenceOSApi } = await import('../api/decision-intelligence-os');
      const executed = await decisionIntelligenceOSApi.executeDecision(decision);
      set(state => ({ decisions: [...state.decisions, executed], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
