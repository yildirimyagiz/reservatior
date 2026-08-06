import { apiClient } from "./client";

export enum DecisionType {
  TENANT_TRUST = "TENANT_TRUST",
  PROPERTY_RISK = "PROPERTY_RISK",
  PRICE_RECOMMENDATION = "PRICE_RECOMMENDATION",
  MAINTENANCE_PRIORITY = "MAINTENANCE_PRIORITY",
  INVESTMENT_OPPORTUNITY = "INVESTMENT_OPPORTUNITY",
  PAYMENT_METHOD = "PAYMENT_METHOD",
  DEPOSIT_RECOMMENDATION = "DEPOSIT_RECOMMENDATION",
}

export enum DecisionAction {
  APPROVE = "APPROVE",
  REJECT = "REJECT",
  MONITOR = "MONITOR",
  SCHEDULE_MAINTENANCE = "SCHEDULE_MAINTENANCE",
  INVEST = "INVEST",
  HOLD = "HOLD",
}

export interface Decision {
  id: string;
  type: DecisionType;
  entityType: string;
  entityId: string;
  recommendedAction: DecisionAction;
  confidence: number;
  reasoning: string;
  factors: Array<{ factor: string; impact: number }>;
  metadata?: Record<string, unknown>;
  createdAt: string;
}

export const decisionIntelligenceOSApi = {
  // Make tenant trust decision
  makeTenantTrustDecision: async (tenantId: string, propertyId: string): Promise<Decision> => {
    const response = await apiClient.get<Decision>(
      `/api/v1/decision-intelligence-os/decision/tenant-trust/${tenantId}/${propertyId}`
    );
    return response;
  },

  // Make property risk decision
  makePropertyRiskDecision: async (propertyId: string): Promise<Decision> => {
    const response = await apiClient.get<Decision>(
      `/api/v1/decision-intelligence-os/decision/property-risk/${propertyId}`
    );
    return response;
  },

  // Make price recommendation
  makePriceRecommendation: async (propertyId: string): Promise<Decision> => {
    const response = await apiClient.get<Decision>(
      `/api/v1/decision-intelligence-os/decision/price-recommendation/${propertyId}`
    );
    return response;
  },

  // Make maintenance priority decision
  makeMaintenancePriorityDecision: async (propertyId: string): Promise<Decision> => {
    const response = await apiClient.get<Decision>(
      `/api/v1/decision-intelligence-os/decision/maintenance-priority/${propertyId}`
    );
    return response;
  },

  // Make investment opportunity decision
  makeInvestmentOpportunityDecision: async (propertyId: string): Promise<Decision> => {
    const response = await apiClient.get<Decision>(
      `/api/v1/decision-intelligence-os/decision/investment-opportunity/${propertyId}`
    );
    return response;
  },

  // Make payment method decision
  makePaymentMethodDecision: async (tenantId: string): Promise<Decision> => {
    const response = await apiClient.get<Decision>(
      `/api/v1/decision-intelligence-os/decision/payment-method/${tenantId}`
    );
    return response;
  },

  // Make deposit recommendation
  makeDepositRecommendation: async (tenantId: string, propertyId: string): Promise<Decision> => {
    const response = await apiClient.get<Decision>(
      `/api/v1/decision-intelligence-os/decision/deposit-recommendation/${tenantId}/${propertyId}`
    );
    return response;
  },

  // Execute decision
  executeDecision: async (decision: Omit<Decision, 'id' | 'createdAt'>): Promise<Decision> => {
    const response = await apiClient.post<Decision>(
      `/api/v1/decision-intelligence-os/execute`,
      decision
    );
    return response;
  },

  // Get decision summary
  getSummary: async (orgId?: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/decision-intelligence-os/summary`, {
      params: { orgId },
    });
    return response;
  },

  // Get dashboard
  getDashboard: async (orgId?: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/decision-intelligence-os/dashboard`, {
      params: { orgId },
    });
    return response;
  },
};
