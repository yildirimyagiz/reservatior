import { apiClient } from "./client";

export const reportsEnhancedApi = {
  // Revenue Reports
  getRevenueReport: (params?: { orgId?: string; startDate?: string; endDate?: string; groupBy?: string }) =>
    apiClient.get("/reports-enhanced/revenue", params),

  // Occupancy Reports
  getOccupancyReport: (params?: { orgId?: string; startDate?: string; endDate?: string; propertyId?: string }) =>
    apiClient.get("/reports-enhanced/occupancy", params),

  // Agent Performance Reports
  getAgentPerformanceReport: (params?: { orgId?: string; agentId?: string; startDate?: string; endDate?: string }) =>
    apiClient.get("/reports-enhanced/agent-performance", params),

  // Financial Summary
  getFinancialSummary: (params?: { orgId?: string; startDate?: string; endDate?: string }) =>
    apiClient.get("/reports-enhanced/financial-summary", params),

  // Leads Report
  getLeadsReport: (params?: { orgId?: string; startDate?: string; endDate?: string; source?: string }) =>
    apiClient.get("/reports-enhanced/leads", params),

  // Custom Report
  generateReport: (data: { type: string; params: any; format?: string }) =>
    apiClient.post("/reports-enhanced/generate", data),

  // Export
  exportReport: (type: string, params?: any, format?: "pdf" | "csv" | "excel") =>
    apiClient.get(`/reports-enhanced/export/${type}`, { ...params, format }),
};
