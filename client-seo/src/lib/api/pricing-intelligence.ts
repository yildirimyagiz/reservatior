const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000/api';

async function apiFetch<T>(path: string, options?: RequestInit): Promise<T> {
  const url = `${API_BASE_URL}${path}`;
  const res = await fetch(url, {
    headers: {
      'Content-Type': 'application/json',
      ...options?.headers,
    },
    ...options,
  });
  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new Error(body.message || `API request failed: ${res.status}`);
  }
  return res.json();
}

export const pricingIntelligenceApi = {
  generatePrediction: async (params: {
    propertyId: string;
    countryCode: string;
    currency: string;
    marketSegment?: string;
  }): Promise<any> => {
    return apiFetch('/pricing-intelligence/predict', {
      method: 'POST',
      body: JSON.stringify(params),
    });
  },

  simulateScenarios: async (propertyId: string, scenarios: any[]): Promise<any> => {
    return apiFetch('/pricing-intelligence/simulate', {
      method: 'POST',
      body: JSON.stringify({ propertyId, scenarios }),
    });
  },

  updateLearningModel: async (
    propertyId: string,
    actualPrice: number,
    previousPrediction: any,
  ): Promise<any> => {
    return apiFetch('/pricing-intelligence/learn', {
      method: 'POST',
      body: JSON.stringify({ propertyId, actualPrice, previousPrediction }),
    });
  },

  getHistoricalPredictions: async (propertyId: string): Promise<any[]> => {
    return apiFetch(`/pricing-intelligence/history/${propertyId}`);
  },
};

export const commissionRuleEngineApi = {
  evaluate: async (params: {
    transactionAmount: number;
    currency: string;
    countryCode: string;
    agentType: string;
    [key: string]: any;
  }): Promise<any> => {
    return apiFetch('/commission-rule-engine/evaluate', {
      method: 'POST',
      body: JSON.stringify(params),
    });
  },

  getCountryRules: async (countryCode: string): Promise<any> => {
    return apiFetch(`/commission-rule-engine/rules/${countryCode}`);
  },

  upsertRule: async (rule: any): Promise<any> => {
    return apiFetch('/commission-rule-engine/rules', {
      method: 'POST',
      body: JSON.stringify(rule),
    });
  },

  getAnalytics: async (): Promise<any> => {
    return apiFetch('/commission-rule-engine/analytics');
  },
};
