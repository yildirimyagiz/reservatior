import { apiClient } from "./client";

export const systemApi = {
  // Health Checks
  getHealthChecks: (params?: { orgId?: string; serviceName?: string; status?: string }) =>
    apiClient.get("/system/health", params),
  createHealthCheck: (data: any) => apiClient.post("/system/health", data),

  // System Logs
  getLogs: (params?: { orgId?: string; level?: string; service?: string; fromDate?: string; toDate?: string; page?: number; limit?: number }) =>
    apiClient.get("/system/logs", params),

  // System Config
  getConfig: () => apiClient.get("/system/config"),
  updateConfig: (data: any) => apiClient.patch("/system/config", data),

  // System Stats
  getStats: () => apiClient.get("/system/stats"),

  // Maintenance Mode
  getMaintenanceMode: () => apiClient.get("/system/maintenance-mode"),
  setMaintenanceMode: (enabled: boolean, message?: string) =>
    apiClient.patch("/system/maintenance-mode", { enabled, message }),

  // Feature Flags
  getFeatureFlags: (params?: { orgId?: string }) =>
    apiClient.get("/system/feature-flags", params),
  updateFeatureFlag: (key: string, enabled: boolean, orgId?: string) =>
    apiClient.patch(`/system/feature-flags/${key}`, { enabled, orgId }),
};
