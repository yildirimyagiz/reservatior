import { apiClient } from "./client";

export interface User {
  id: string;
  orgId?: string;
  email: string;
  firstName?: string;
  lastName?: string;
  name?: string;
  phone?: string;
  avatar?: string;
  role?: string;
  status?: string;
  lastLoginAt?: string;
  emailVerified?: boolean;
  phoneVerified?: boolean;
  twoFactorEnabled?: boolean;
  locale?: string;
  timezone?: string;
  preferences?: {
    language: string;
    timezone: string;
    notifications: {
      email: boolean;
      sms: boolean;
      push: boolean;
    };
  };
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
}

export const usersApi = {
  getAll: async (params?: any): Promise<User[]> => {
    const response = await apiClient.get<any>("/api/v1/user", params);
    // Handle both { data: User[] } and User[] directly
    return Array.isArray(response.data) ? response.data : (response.data as any)?.data || [];
  },

  // Create user
  create: async (data: Partial<User>): Promise<User> => {
    const { data: created } = await apiClient.post<any>("/api/v1/user", data);
    return created;
  },

  // Get user by ID
  getById: async (id: string): Promise<User> => {
    const { data } = await apiClient.get<any>(`/api/v1/user/${id}`);
    return data;
  },

  // Update user
  update: async (id: string, data: Partial<User>): Promise<User> => {
    const { data: updated } = await apiClient.patch<any>(`/api/v1/user/${id}`, data);
    return updated;
  },

  // Delete user
  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/api/v1/user/${id}`);
  },

  // Get user preferences
  getPreferences: async (id: string): Promise<any> => {
    const { data } = await apiClient.get<any>(`/api/v1/user/${id}/preferences`);
    return data;
  },

  // Update user preferences
  updatePreferences: async (id: string, preferences: any): Promise<any> => {
    const { data } = await apiClient.put<any>(`/api/v1/user/${id}/preferences`, preferences);
    return data;
  },

  // Upload avatar image
  uploadAvatar: async (file: File): Promise<{ url: string; fileName: string }> => {
    const formData = new FormData();
    formData.append("file", file);
    const response = await apiClient.post<{ data: { url: string; fileName: string } }>("/auth/avatar", formData);
    return response.data;
  }
};
