import { apiClient } from "./client";

export interface Template {
  id: string;
  orgId: string;
  name: string;
  content: string;
  type: string;
  category?: string;
  variables?: string[];
  createdAt: string;
  updatedAt: string;
}

export interface TemplateCreate {
  orgId: string;
  name: string;
  content: string;
  type: string;
  category?: string;
  variables?: string[];
}

export interface TemplateUpdate {
  name?: string;
  content?: string;
  type?: string;
  category?: string;
  variables?: string[];
}

export const templatesApi = {
  getAll: async (params?: {
    orgId?: string;
    type?: string;
    category?: string;
  }) => {
    return await apiClient.get("/api/v1/communication-template", { params });
    
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/v1/communication-template/${id}`);
    
  },

  create: async (data: TemplateCreate) => {
    return await apiClient.post("/api/v1/communication-template", data);
    
  },

  update: async (id: string, data: TemplateUpdate) => {
    return await apiClient.patch(`/api/v1/communication-template/${id}`, data);
    
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/v1/communication-template/${id}`, {
      data: { tags: [] },
    });
    
  },

  // Get templates for organization
  getOrgTemplates: async (orgId: string) => {
    return await apiClient.get("/api/v1/communication-template", {
      params: { orgId },
    });
    
  },

  // Get templates by type
  getTemplatesByType: async (type: string, orgId?: string) => {
    const params: any = { type };
    if (orgId) params.orgId = orgId;
    return await apiClient.get("/api/v1/communication-template", { params });
    
  },
};
