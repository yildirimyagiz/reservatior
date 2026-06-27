import { apiClient } from "./index";

export interface PropertyInventory {
  id: string;
  orgId: string;
  propertyId: string;
  leaseId?: string;
  inventoryType: string;
  inventoryDate: string;
  conductedBy: string;
  presentAtCheck: string[];
  rooms?: any;
  overallCondition: string;
  damages?: any;
  cleaningRequired: boolean;
  tenantSignature?: string;
  landlordSignature?: string;
  agentSignature?: string;
  reportUrl?: string;
  photos?: any;
  createdAt: string;
  updatedAt: string;
}

export const inventoryApi = {
  getInventories: (params?: any) => apiClient.get("/property-inventory", params),
  getInventory: (id: string) => apiClient.get(`/property-inventory/${id}`),
  createInventory: (data: any) => apiClient.post("/property-inventory", data),
  updateInventory: (id: string, data: any) => apiClient.patch(`/property-inventory/${id}`, data),
  deleteInventory: (id: string) => apiClient.delete(`/property-inventory/${id}`),
};
