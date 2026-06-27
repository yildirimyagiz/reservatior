import { apiClient } from "./client";

export interface FinancialReport {
  id: string;
  title: string;
  type: string;
  period: string;
  revenue: string;
  expenses: string;
  profit: string;
  growth: string;
  createdAt: string;
}

export interface RevenueBreakdown {
  source: string;
  amount: string;
  percentage: number;
  growth: string;
}

export interface ExpenseAnalysis {
  category: string;
  amount: string;
  percentage: number;
  change: string;
}

export interface MonthlyPerformance {
  month: string;
  revenue: string;
  expenses: string;
  profit: string;
  growth: string;
}

export interface TopProperty {
  property: string;
  revenue: string;
  roi: string;
}

export const financialReportsApi = {
  // Reports
  getReports: () => apiClient.get("/financial/reports"),
  getReportById: (id: string) => apiClient.get(`/financial/reports/${id}`),
  createReport: (data: Partial<FinancialReport>) => apiClient.post("/financial/reports", data),
  updateReport: (id: string, data: Partial<FinancialReport>) => apiClient.patch(`/financial/reports/${id}`, data),
  deleteReport: (id: string) => apiClient.delete(`/financial/reports/${id}`, { data: { tags: [] } }),
  
  // Analytics
  getRevenueBreakdown: () => apiClient.get("/financial/reports/revenue-breakdown"),
  getExpenseAnalysis: () => apiClient.get("/financial/reports/expense-analysis"),
  getMonthlyPerformance: () => apiClient.get("/financial/reports/monthly-performance"),
  
  // Properties
  getTopProperties: () => apiClient.get("/financial/reports/top-properties"),
  
  // Payment Methods
  getPaymentMethods: () => apiClient.get("/financial/reports/payment-methods"),
  
  // Upcoming Reports
  getUpcomingReports: () => apiClient.get("/financial/reports/upcoming"),
  
  // Export
  exportReport: (id: string, format: "pdf" | "excel" | "csv") => 
    apiClient.get(`/financial/reports/${id}/export?format=${format}`),
};
