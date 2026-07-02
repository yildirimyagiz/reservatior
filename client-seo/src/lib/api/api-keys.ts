import { apiClient } from "./client";

export interface ApiKey {
  id: string;
  userId: string;
  name: string;
  key: string;
  permissions: string[];
  expiresAt?: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
  user?: {
    id: string;
    name: string;
    email: string;
  };
}

export interface ApiKeyCreate {
  userId: string;
  name: string;
  permissions: string[];
  expiresAt?: string;
  isActive: boolean;
}

export interface ApiKeyUpdate {
  name?: string;
  permissions?: string[];
  expiresAt?: string;
  isActive?: boolean;
}

export const apiKeysApi = {
  getAll: async (params?: {
    userId?: string;
    isActive?: boolean;
  }): Promise<ApiKey[]> => {
    const response = await apiClient.get<ApiKey[]>("/api/v1/api-key", { params });
    return response;
  },

  getById: async (id: string): Promise<ApiKey> => {
    const response = await apiClient.get<ApiKey>(`/api/v1/api-key/${id}`);
    return response;
  },

  create: async (data: ApiKeyCreate): Promise<ApiKey> => {
    const response = await apiClient.post<ApiKey>("/api/v1/api-key", data);
    return response;
  },

  update: async (id: string, data: ApiKeyUpdate): Promise<ApiKey> => {
    const response = await apiClient.patch<ApiKey>(`/api/v1/api-key/${id}`, data);
    return response;
  },

  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/api/v1/api-key/${id}`, {
      data: { tags: [] },
    });
  },

  // Get API keys for user
  getUserApiKeys: async (userId: string): Promise<ApiKey[]> => {
    const response = await apiClient.get<ApiKey[]>("/api/v1/api-key", {
      params: { userId },
    });
    return response;
  },

  // Regenerate API key
  regenerateKey: async (id: string): Promise<ApiKey> => {
    const response = await apiClient.post<ApiKey>(`/api/v1/api-key/${id}/regenerate`);
    return response;
  },

  // Deactivate API key
  deactivateKey: async (id: string): Promise<ApiKey> => {
    const response = await apiClient.patch<ApiKey>(`/api/v1/api-key/${id}`, {
      isActive: false,
    });
    return response;
  },

  // Activate API key
  activateKey: async (id: string): Promise<ApiKey> => {
    const response = await apiClient.patch<ApiKey>(`/api/v1/api-key/${id}`, {
      isActive: true,
    });
    return response;
  },
};
