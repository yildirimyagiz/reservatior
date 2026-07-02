import { apiClient } from "./client";

export interface UserPreference {
  id: string;
  userId: string;
  key?: string;
  value?: any;
  category?: string;
  updatedAt: string;
  createdAt: string;
}

export const userPreferencesApi = {
  getAll: (params?: { userId?: string; page?: number; limit?: number }) =>
    apiClient.get("/user-preference", params),
  getById: (id: string) => apiClient.get(`/user-preference/${id}`),
  getByUser: (userId: string) => apiClient.get(`/user-preference/user/${userId}`),
  upsert: (userId: string, key: string, value: any) =>
    apiClient.put(`/user-preference/user/${userId}/${key}`, { value }),
  update: (id: string, data: Partial<UserPreference>) =>
    apiClient.patch(`/user-preference/${id}`, data),
  delete: (id: string) => apiClient.delete(`/user-preference/${id}`),
  getByKey: (userId: string, key: string) =>
    apiClient.get(`/user-preference/user/${userId}/key/${key}`),
  bulkUpdate: (userId: string, preferences: Record<string, any>) =>
    apiClient.put(`/user-preference/user/${userId}/bulk`, { preferences }),
};
