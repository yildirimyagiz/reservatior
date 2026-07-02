import { apiClient } from "./client";

export interface Solicitor {
  id: string;
  orgId: string;
  name: string;
  firmName?: string;
  email?: string;
  phone?: string;
  address?: string;
  specializations?: string[];
  isActive?: boolean;
  createdAt: string;
}

export const solicitorManagementApi = {
  getSolicitors: (params?: { orgId?: string; isActive?: boolean; page?: number; limit?: number }) =>
    apiClient.get("/solicitor-management/solicitors", params),
  getSolicitorById: (id: string) => apiClient.get(`/solicitor-management/solicitors/${id}`),
  createSolicitor: (data: Partial<Solicitor>) => apiClient.post("/solicitor-management/solicitors", data),
  updateSolicitor: (id: string, data: Partial<Solicitor>) => apiClient.patch(`/solicitor-management/solicitors/${id}`, data),
  deleteSolicitor: (id: string) => apiClient.delete(`/solicitor-management/solicitors/${id}`),
  assignToProperty: (solicitorId: string, propertyId: string, role?: string) =>
    apiClient.post(`/solicitor-management/solicitors/${solicitorId}/assign`, { propertyId, role }),
  getAssignments: (params?: { solicitorId?: string; propertyId?: string }) =>
    apiClient.get("/solicitor-management/assignments", params),
};
