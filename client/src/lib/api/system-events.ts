import { apiClient } from "./client";

export const systemEventsApi = {
  list: (params?: any) => apiClient.get("/system/events", params),
  getById: (id: string) => apiClient.get(`/system/events/${id}`),
};
