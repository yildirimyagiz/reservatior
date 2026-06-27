import { apiClient } from "./client";

export interface Tag {
  id: string;
  orgId: string;
  name: string;
  color?: string;
  description?: string;
  createdAt: string;
  updatedAt: string;
  listings?: any[];
}

export interface TagCreate {
  orgId: string;
  name: string;
  color?: string;
  description?: string;
}

export interface TagUpdate {
  name?: string;
  color?: string;
  description?: string;
}

export const tagsApi = {
  getAll: async (params?: {
    orgId?: string;
    search?: string;
  }) => {
    return await apiClient.get("/api/v1/tag", { params });
    
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/v1/tag/${id}`);
    
  },

  create: async (data: TagCreate) => {
    return await apiClient.post("/api/v1/tag", data);
    
  },

  update: async (id: string, data: TagUpdate) => {
    return await apiClient.patch(`/api/v1/tag/${id}`, data);
    
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/v1/tag/${id}`, {
      data: { tags: [] },
    });
    
  },

  // Get tags for organization
  getOrgTags: async (orgId: string) => {
    return await apiClient.get("/api/v1/tag", {
      params: { orgId },
    });
    
  },
};
