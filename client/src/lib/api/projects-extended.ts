import { apiClient } from "./client";

export const projectsExtendedApi = {
  // Project Alerts
  getAlerts: (params?: { projectId?: string; alertType?: string; severity?: string; isRead?: boolean; isResolved?: boolean }) =>
    apiClient.get("/projects-ext/alerts", params),
  getAlertById: (id: string) => apiClient.get(`/projects-ext/alerts/${id}`),
  createAlert: (data: any) => apiClient.post("/projects-ext/alerts", data),
  updateAlert: (id: string, data: any) => apiClient.patch(`/projects-ext/alerts/${id}`, data),
  deleteAlert: (id: string) => apiClient.delete(`/projects-ext/alerts/${id}`),
  markAlertRead: (id: string) => apiClient.patch(`/projects-ext/alerts/${id}/read`),
  resolveAlert: (id: string) => apiClient.patch(`/projects-ext/alerts/${id}/resolve`),

  // Project Budgets
  getBudgets: (params?: { projectId?: string; orgId?: string }) =>
    apiClient.get("/projects-ext/budgets", params),
  getBudgetById: (id: string) => apiClient.get(`/projects-ext/budgets/${id}`),
  createBudget: (data: any) => apiClient.post("/projects-ext/budgets", data),
  updateBudget: (id: string, data: any) => apiClient.patch(`/projects-ext/budgets/${id}`, data),

  // Project KPIs
  getKPIs: (params?: { projectId?: string }) =>
    apiClient.get("/projects-ext/kpis", params),
  createKPI: (data: any) => apiClient.post("/projects-ext/kpis", data),
  updateKPI: (id: string, data: any) => apiClient.patch(`/projects-ext/kpis/${id}`, data),
};
