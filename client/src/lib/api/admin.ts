import { apiClient } from "./client";

export interface AdminRole {
  id: string;
  name: string;
  description: string;
  permissions: string[];
  userCount: number;
  createdAt: string;
}

export interface AdminReport {
  id: string;
  name: string;
  type: string;
  status: string;
  createdAt: string;
  downloads: number;
}

export interface AdminPlan {
  id: string;
  name: string;
  price: string;
  features: string[];
  userLimit: number;
  isActive: boolean;
}

export interface AdminExport {
  id: string;
  name: string;
  type: string;
  status: string;
  createdAt: string;
  downloadUrl?: string;
}

export interface SecurityEvent {
  id: string;
  type: string;
  severity: "low" | "medium" | "high" | "critical";
  description: string;
  userId?: string;
  ipAddress: string;
  timestamp: string;
  resolved: boolean;
}

export const adminApi = {
  // Roles
  getRoles: () => apiClient.get("/admin/roles"),
  getRoleById: (id: string) => apiClient.get(`/admin/roles/${id}`),
  createRole: (data: Partial<AdminRole>) => apiClient.post("/admin/roles", data),
  updateRole: (id: string, data: Partial<AdminRole>) => apiClient.patch(`/admin/roles/${id}`, data),
  deleteRole: (id: string) => apiClient.delete(`/admin/roles/${id}`, { data: { tags: [] } }),
  
  // Reports
  getReports: () => apiClient.get("/admin/reports"),
  getReportById: (id: string) => apiClient.get(`/admin/reports/${id}`),
  createReport: (data: Partial<AdminReport>) => apiClient.post("/admin/reports", data),
  deleteReport: (id: string) => apiClient.delete(`/admin/reports/${id}`, { data: { tags: [] } }),
  
  // Plans
  getPlans: () => apiClient.get("/admin/plans"),
  getPlanById: (id: string) => apiClient.get(`/admin/plans/${id}`),
  createPlan: (data: Partial<AdminPlan>) => apiClient.post("/admin/plans", data),
  updatePlan: (id: string, data: Partial<AdminPlan>) => apiClient.patch(`/admin/plans/${id}`, data),
  deletePlan: (id: string) => apiClient.delete(`/admin/plans/${id}`, { data: { tags: [] } }),
  
  // Exports
  getExports: () => apiClient.get("/admin/exports"),
  createExport: (data: Partial<AdminExport>) => apiClient.post("/admin/exports", data),
  downloadExport: (id: string) => apiClient.get(`/admin/exports/${id}/download`),
  
  // Security Events
  getSecurityEvents: (params?: any) => apiClient.get("/admin/security-events", params),
  getSecurityEventById: (id: string, params?: any) => apiClient.get(`/admin/security-events/${id}`, params),
  resolveSecurityEvent: (id: string) => apiClient.post(`/admin/security-events/${id}/resolve`),
  unresolveSecurityEvent: (id: string) => apiClient.post(`/admin/security-events/${id}/unresolve`),
  deleteSecurityEvent: (id: string) => apiClient.delete(`/admin/security-events/${id}`),
  
  // Organizations
  getOrganizations: (params?: any) => apiClient.get("/organization", params),
  getOrganizationById: (id: string, params?: any) => apiClient.get(`/organization/${id}`, params),
  createOrganization: (data: any) => apiClient.post("/organization", data),
  updateOrganization: (id: string, data: any) => apiClient.patch(`/organization/${id}`, data),
  deleteOrganization: (id: string) => apiClient.delete(`/organization/${id}`),

  // Users
  getUsers: (params?: any) => apiClient.get("/admin/users", params),
  getUserStats: () => apiClient.get("/admin/users/stats"),
  createUser: (data: any) => apiClient.post("/admin/users", data),
  updateUser: (id: string, data: any) => apiClient.patch(`/admin/users/${id}`, data),
  deleteUser: (id: string) => apiClient.delete(`/admin/users/${id}`),
  resetUserPassword: (id: string) => apiClient.post(`/admin/users/${id}/reset-password`),
  
  // System Metrics
  getSystemMetrics: (params?: any) => apiClient.get("/admin/system-metrics", params),
  getMetricHistory: (id: string, params?: any) => apiClient.get(`/admin/system-metrics/${id}/history`, params),
  refreshMetrics: () => apiClient.post("/admin/system-metrics/refresh"),
  exportMetrics: (params?: any) => apiClient.get("/admin/system-metrics/export", params),
};
