import { apiClient } from "./client";

export const guestsApi = {
  getFollowUps: (params?: any) => apiClient.get("/guests/follow-ups", params),
  getFollowUpAnalytics: () => apiClient.get("/guests/analytics"),
  getGuests: (params?: any) => apiClient.get("/guests", params),
};
