import { apiClient } from "./client";

export interface Contact {
  id: string;
  orgId: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  mobile?: string;
  company?: string;
  position?: string;
  contactType: string;
  status: string;
  tags?: string[];
  notes?: string;
  address?: {
    street: string;
    city: string;
    state: string;
    zipCode: string;
    country: string;
  };
  socialProfiles?: {
    linkedin?: string;
    twitter?: string;
    facebook?: string;
    instagram?: string;
  };
  preferences?: {
    communicationMethod: string;
    preferredTime: string;
    timezone: string;
  };
  lastContactDate?: string;
  nextFollowUp?: string;
  createdAt: string;
  updatedAt: string;
}

export interface ContactCreate {
  orgId: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  mobile?: string;
  company?: string;
  position?: string;
  contactType: string;
  status: string;
  tags?: string[];
  notes?: string;
  address?: {
    street: string;
    city: string;
    state: string;
    zipCode: string;
    country: string;
  };
  socialProfiles?: {
    linkedin?: string;
    twitter?: string;
    facebook?: string;
    instagram?: string;
  };
  preferences?: {
    communicationMethod: string;
    preferredTime: string;
    timezone: string;
  };
  nextFollowUp?: string;
}

export interface ContactUpdate {
  firstName?: string;
  lastName?: string;
  email?: string;
  phone?: string;
  mobile?: string;
  company?: string;
  position?: string;
  contactType?: string;
  status?: string;
  tags?: string[];
  notes?: string;
  address?: {
    street: string;
    city: string;
    state: string;
    zipCode: string;
    country: string;
  };
  socialProfiles?: {
    linkedin?: string;
    twitter?: string;
    facebook?: string;
    instagram?: string;
  };
  preferences?: {
    communicationMethod: string;
    preferredTime: string;
    timezone: string;
  };
  lastContactDate?: string;
  nextFollowUp?: string;
}

export const contactsApi = {
  getAll: async (params?: {
    page?: number;
    limit?: number;
    search?: string;
    orgId?: string;
    contactType?: string;
    status?: string;
    tags?: string[];
  }): Promise<Contact[]> => {
    const { data } = await apiClient.get<{ data: Contact[] }>("/contacts", params);
    return data;
  },

  getById: async (id: string): Promise<Contact> => {
    const { data } = await apiClient.get<{ data: Contact }>(`/contacts/${id}`);
    return data;
  },

  create: async (data: ContactCreate): Promise<Contact> => {
    const { data: created } = await apiClient.post<{ data: Contact }>("/contacts", data);
    return created;
  },

  update: async (id: string, data: ContactUpdate): Promise<Contact> => {
    const { data: updated } = await apiClient.patch<{ data: Contact }>(`/contacts/${id}`, data);
    return updated;
  },

  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/contacts/${id}`);
  },

  // Get contacts for organization
  getOrgContacts: async (orgId: string): Promise<Contact[]> => {
    const { data } = await apiClient.get<{ data: Contact[] }>("/contacts", { orgId });
    return data;
  },

  // Search contacts
  searchContacts: async (query: string, filters?: any): Promise<Contact[]> => {
    const response = await apiClient.get<Contact[]>("/api/contacts/search", {
      params: { q: query, ...filters },
    });
    return response;
  },

  // Get contact history
  getContactHistory: async (id: string): Promise<any[]> => {
    const response = await apiClient.get<any[]>(`/api/contacts/${id}/history`);
    return response;
  },

  // Add tags to contact
  addTags: async (id: string, tags: string[]): Promise<Contact> => {
    const response = await apiClient.post<Contact>(`/api/contacts/${id}/tags`, { tags });
    return response;
  },

  // Remove tags from contact
  removeTags: async (id: string): Promise<Contact> => {
    const response = await apiClient.delete<Contact>(`/api/contacts/${id}/tags`, { data: { tags: [] } });
    return response;
  },

  // Update follow-up date
  updateFollowUp: async (id: string, date: string): Promise<Contact> => {
    const response = await apiClient.patch<Contact>(`/api/contacts/${id}/followup`, {
      nextFollowUp: date,
    });
    return response;
  },

  // Get contact analytics
  getContactAnalytics: async (orgId: string): Promise<any> => {
    const response = await apiClient.get<any>("/api/contacts/analytics", {
      params: { orgId },
    });
    return response;
  },

  // Import contacts
  importContacts: async (file: File): Promise<any> => {
    const formData = new FormData();
    formData.append("file", file);

    const response = await apiClient.post<any>("/api/contacts/import", formData, {
      headers: { "Content-Type": "multipart/form-data" },
    });
    return response;
  },

  // Export contacts
  exportContacts: async (format: "csv" | "xlsx" | "json"): Promise<Blob> => {
    const response = await apiClient.get<Blob>("/api/contacts/export", {
      params: { format },
      responseType: "blob",
    });
    return response;
  },
};
