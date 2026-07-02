import { apiClient } from "./client";
import { LeadStatus } from "@/lib/types/leads";

export interface Lead {
  id: string;
  orgId: string;
  contactId?: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  leadSource: string;
  leadStatus: string;
  leadType: string;
  budget?: number;
  propertyType?: string;
  location?: string;
  timeline?: string;
  notes?: string;
  assignedAgentId?: string;
  score?: number;
  tags?: string[];
  customFields?: Record<string, any>;
  followUpDate?: string;
  lastContactDate?: string;
  createdAt: string;
  updatedAt: string;
  // Additional properties for Leads.tsx compatibility
  status: LeadStatus;
  sourceDetail?: string;
  interestedPropertyId?: string;
  assignedToUserId?: string;
}

export interface LeadCreate {
  orgId: string;
  contactId?: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  leadSource: string;
  leadStatus: string;
  leadType: string;
  budget?: number;
  propertyType?: string;
  location?: string;
  timeline?: string;
  notes?: string;
  assignedAgentId?: string;
  tags?: string[];
  customFields?: Record<string, any>;
  followUpDate?: string;
}

export interface LeadUpdate {
  contactId?: string;
  firstName?: string;
  lastName?: string;
  email?: string;
  phone?: string;
  leadSource?: string;
  leadStatus?: string;
  leadType?: string;
  status?: LeadStatus;
  budget?: number;
  propertyType?: string;
  location?: string;
  timeline?: string;
  notes?: string;
  assignedAgentId?: string;
  score?: number;
  tags?: string[];
  customFields?: Record<string, any>;
  followUpDate?: string;
  lastContactDate?: string;
}

export const leadsApi = {
  getAll: async (params?: {
    page?: number;
    limit?: number;
    search?: string;
    orgId?: string;
    leadStatus?: string;
    leadType?: string;
    leadSource?: string;
    assignedAgentId?: string;
  }): Promise<{ data: Lead[] }> => {
    return await apiClient.get("/api/leads", { params });
  },

  getById: async (id: string): Promise<Lead> => {
    return await apiClient.get(`/api/leads/${id}`);
  },

  create: async (data: LeadCreate): Promise<Lead> => {
    return await apiClient.post("/api/leads", data);
  },

  update: async (id: string, data: LeadUpdate): Promise<Lead> => {
    return await apiClient.patch(`/api/leads/${id}`, data);
  },

  delete: async (id: string): Promise<void> => {
    return await apiClient.delete(`/api/leads/${id}`);
  },

  // Get leads for organization
  getOrgLeads: async (orgId: string) => {
    return await apiClient.get("/api/leads", {
      params: { orgId },
    });
  },

  // Search leads
  searchLeads: async (query: string, filters?: any) => {
    return await apiClient.get("/api/leads/search", {
      params: { q: query, ...filters },
    });
  },

  // Get lead analytics
  getLeadAnalytics: async (orgId: string) => {
    return await apiClient.get("/api/leads/analytics", {
      params: { orgId },
    });
  },

  // Update lead score
  updateLeadScore: async (id: string, score: number) => {
    return await apiClient.patch(`/api/leads/${id}/score`, { score });
  },

  // Convert lead to contact
  convertToContact: async (id: string) => {
    return await apiClient.post(`/api/leads/${id}/convert`);
  },

  // Get lead activities
  getLeadActivities: async (id: string) => {
    return await apiClient.get(`/api/leads/${id}/activities`);
  },

  // Add lead activity
  addLeadActivity: async (
    id: string,
    activity: {
      type: string;
      description: string;
      date: string;
    }
  ) => {
    return await apiClient.post(
      `/api/leads/${id}/activities`,
      activity
    );
  },

  // Import leads
  importLeads: async (file: File) => {
    const formData = new FormData();
    formData.append("file", file);

    return await apiClient.post("/api/leads/import", formData, {
      headers: { "Content-Type": "multipart/form-data" },
    });
  },

  // Export leads
  exportLeads: async (format: "csv" | "xlsx" | "json") => {
    return await apiClient.get("/api/leads/export", {
      params: { format },
      responseType: "blob",
    });
  },
};
