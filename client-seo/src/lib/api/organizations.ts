import { apiClient } from "./client";

export interface Organization {
  id: string;
  name: string;
  type: string;
  status: "active" | "inactive" | "suspended";
  subscription: string;
  userCount: number;
  propertyCount: number;
  createdAt: string;
  updatedAt: string;
}

export interface OrganizationSettings {
  id: string;
  organizationId: string;
  timezone: string;
  currency: string;
  dateFormat: string;
  language: string;
}

export const organizationsApi = {
  // Organizations
  getOrganizations: () => apiClient.get("/api/v1/organization"),
  getOrganizationById: (id: string) => apiClient.get(`/api/v1/organization/${id}`),
  createOrganization: (data: Partial<Organization>) => apiClient.post("/api/v1/organization", data),
  updateOrganization: (id: string, data: Partial<Organization>) => apiClient.patch(`/api/v1/organization/${id}`, data),
  deleteOrganization: (id: string) => apiClient.delete(`/api/v1/organization/${id}`, { data: { tags: [] } }),
  
  // Settings
  getOrganizationSettings: (id: string) => apiClient.get(`/api/v1/organization/${id}/settings`),
  updateOrganizationSettings: (id: string, data: Partial<OrganizationSettings>) => 
    apiClient.patch(`/api/v1/organization/${id}/settings`, data),
  
  // Users
  getOrganizationUsers: (id: string) => apiClient.get(`/api/v1/organization/${id}/users`),
  addUserToOrganization: (id: string, userId: string) => 
    apiClient.post(`/api/v1/organization/${id}/users`, { userId }),
  removeUserFromOrganization: (id: string, userId: string) => 
    apiClient.delete(`/api/v1/organization/${id}/users/${userId}`, { data: { tags: [] } }),
  
  // Properties
  getOrganizationProperties: (id: string) => apiClient.get(`/api/v1/organization/${id}/properties`),
  
  // Statistics
  getOrganizationStats: (id: string) => apiClient.get(`/api/v1/organization/${id}/stats`),
};
