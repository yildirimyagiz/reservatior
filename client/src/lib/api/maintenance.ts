import { apiClient } from "./client";

export interface MaintenanceWorkOrder {
  id: string;
  propertyId: string;
  reportedBy: string;
  title: string;
  description: string;
  priority: string;
  category: string;
  status?: string;
  reportedAt: string;
  tenantId?: string;
  dueDate?: string;
  estimatedCost?: number;
  organizationId?: string;
  createdAt: string;
}

export interface MaintenanceBlock {
  id: string;
  orgId: string;
  propertyId: string;
  type: string;
  startDate: string;
  endDate: string;
  reason?: string;
  listingId?: string;
  deletedAt?: string;
}

export const maintenanceApi = {
  // Work Orders
  getWorkOrders: (params?: { orgId?: string; propertyId?: string; status?: string; priority?: string }) =>
    apiClient.get("/maintenance/work-orders", params),
  getWorkOrderById: (id: string) => apiClient.get(`/maintenance/work-orders/${id}`),
  createWorkOrder: (data: Partial<MaintenanceWorkOrder>) => apiClient.post("/maintenance/work-orders", data),
  updateWorkOrder: (id: string, data: Partial<MaintenanceWorkOrder>) => apiClient.patch(`/maintenance/work-orders/${id}`, data),

  // Blocks
  getBlocks: (params?: { orgId?: string; propertyId?: string; listingId?: string }) =>
    apiClient.get("/maintenance/blocks", params),
  createBlock: (data: Partial<MaintenanceBlock>) => apiClient.post("/maintenance/blocks", data),
  deleteBlock: (id: string) => apiClient.delete(`/maintenance/blocks/${id}`),
};
