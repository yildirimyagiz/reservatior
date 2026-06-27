import { apiClient } from "./client";

export const guestsApi = {
  getFollowUps: (params?: any) => apiClient.get("/guest/follow-ups", params),
  getFollowUpAnalytics: () => apiClient.get("/guest/analytics"),
  getGuests: (params?: any) => apiClient.get("/guest", params),
};
