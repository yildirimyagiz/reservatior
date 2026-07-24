import { apiClient } from "./client";
import type {
  PropertyROIInput,
  PropertyROIOutput,
  InvestmentReport,
  InvestorProfile,
  LeadCaptureData,
} from "@/types/investment-intelligence";

export const investmentIntelligenceApi = {
  calculateROI: async (input: PropertyROIInput): Promise<PropertyROIOutput> => {
    return apiClient.post("/investment-intelligence/calculate", input);
  },

  generateReport: async (data: {
    input: PropertyROIInput;
    output: PropertyROIOutput;
    email?: string;
  }): Promise<InvestmentReport> => {
    return apiClient.post("/investment-intelligence/reports", data);
  },

  getReport: async (id: string): Promise<InvestmentReport> => {
    return apiClient.get(`/investment-intelligence/reports/${id}`);
  },

  exportReportPdf: async (id: string): Promise<Blob> => {
    const baseUrl = typeof window !== "undefined" ? "/api/v1" : `${process.env.BACKEND_INTERNAL_URL || "https://reservatior.com"}/api/v1`;
    const response = await fetch(
      `${baseUrl}/investment-intelligence/reports/${id}/pdf`,
      {
        headers: {
          Authorization: `Bearer ${typeof window !== "undefined" ? localStorage.getItem("auth_token") : ""}`,
        },
      }
    );
    return response.blob();
  },

  captureLead: async (data: LeadCaptureData): Promise<{ id: string; score: string }> => {
    return apiClient.post("/investment-intelligence/leads", data);
  },

  createInvestorProfile: async (data: Partial<InvestorProfile>): Promise<InvestorProfile> => {
    return apiClient.post("/investment-intelligence/profiles", data);
  },

  updateInvestorProfile: async (id: string, data: Partial<InvestorProfile>): Promise<InvestorProfile> => {
    return apiClient.patch(`/investment-intelligence/profiles/${id}`, data);
  },

  getInvestorProfile: async (id: string): Promise<InvestorProfile> => {
    return apiClient.get(`/investment-intelligence/profiles/${id}`);
  },

  getAnalytics: async (params?: {
    startDate?: string;
    endDate?: string;
    city?: string;
  }) => {
    return apiClient.get("/investment-intelligence/analytics", { params });
  },

  trackEvent: async (event: {
    type: string;
    payload: Record<string, any>;
  }): Promise<void> => {
    apiClient.post("/investment-intelligence/events", event).catch(() => {});
  },
};
