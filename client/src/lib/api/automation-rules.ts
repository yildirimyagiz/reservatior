import { apiClient } from "./client";

export const automationExecutionsApi = {
  list: (params?: any) => apiClient.get("/system/automation-executions", params),
  get: (id: string) => apiClient.get(`/system/automation-executions/${id}`),
};
