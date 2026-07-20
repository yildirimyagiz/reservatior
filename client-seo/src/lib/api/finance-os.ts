import { getLocalizationHeaders } from './localization-helper';

export const financeOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/finance-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error("Failed to fetch dashboard stats");
    return res.json();
  },

  /** Calculate all 3 commission models for a sales deal */
  calculateSalesCommission: async (params: {
    propertyId: string;
    agentId: string;
    salePrice: number;
    currency: string;
    baseRateBps: number;
    countryCode: string;
    stateCode?: string;
    tenantMonthlyRent?: number;
  }) => {
    const res = await fetch("/api/v1/fintech/sales-commission/calculate", {
      method: "POST",
      headers: { 
        "Content-Type": "application/json",
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(params),
    });
    if (!res.ok) throw new Error("Failed to calculate commission");
    return res.json();
  },

  /** Create a sales deal agreement with selected commission model */
  createSalesDeal: async (params: {
    propertyId: string;
    agentId: string;
    salePrice: number;
    currency: string;
    countryCode: string;
    commissionModel: "INSTALLMENT_12" | "HYBRID_50_6" | "TRADITIONAL_1M";
    contractLanguages: string[];
    landlord: { fullName: string; nationalIdOrTaxNo: string; address: string; };
    buyer: { fullName: string; nationalIdOrTaxNo: string; address: string; };
    tenantMonthlyRent?: number;
  }) => {
    const res = await fetch("/api/v1/fintech/sales-deal", {
      method: "POST",
      headers: { 
        "Content-Type": "application/json",
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(params),
    });
    if (!res.ok) throw new Error("Failed to create sales deal");
    return res.json();
  },

  /** Compliance check for a country + model */
  checkCompliance: async (countryCode: string, model: string, requestedInstallments: number) => {
    const res = await fetch(
      `/api/v1/fintech/compliance-check?country=${countryCode}&model=${model}&installments=${requestedInstallments}`,
      { headers: getLocalizationHeaders() }
    );
    if (!res.ok) throw new Error("Compliance check failed");
    return res.json();
  },

  // Notification OS integration
  sendFinanceNotification: async (dealId: string, type: string, userId: string) => {
    const res = await fetch(`/api/v1/finance-os/${dealId}/notify`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ type, userId }),
    });
    if (!res.ok) throw new Error('Failed to send finance notification');
    return res.json();
  },

  // Analytics OS integration
  trackFinanceMetric: async (dealId: string, metricType: string, value: number) => {
    const res = await fetch(`/api/v1/finance-os/${dealId}/metrics`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ metricType, value }),
    });
    if (!res.ok) throw new Error('Failed to track finance metric');
    return res.json();
  },

  // Document OS integration
  generateFinanceDocument: async (dealId: string, documentType: string) => {
    const res = await fetch(`/api/v1/finance-os/${dealId}/documents`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ documentType }),
    });
    if (!res.ok) throw new Error('Failed to generate finance document');
    return res.json();
  },

  // Localization OS integration
  getLocalizedPricing: async (basePrice: number, countryCode: string) => {
    const res = await fetch(`/api/v1/finance-os/localized-pricing?basePrice=${basePrice}&countryCode=${countryCode}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to get localized pricing');
    return res.json();
  },
};
