import { apiClient } from "./client";

export interface Facility {
  id: string;
  orgId: string;
  propertyId: string;
  name: string;
  feeAmount?: number;
  feeCurrency?: string;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    name: string;
  };
  includedServices?: any[];
}

export const facilityApi = {
  getFacilities: (params?: { propertyId?: string; orgId?: string; page?: number; limit?: number }) => 
    apiClient.get<{ data: Facility[]; total: number }>("/remaining", { ...params, model: "facility" } as any),
    
  getFacility: (id: string) => 
    apiClient.get<{ data: Facility }>("/remaining/" + id, { model: "facility" } as any),
    
  createFacility: (data: Partial<Facility> & { propertyId: string; name: string }) => 
    apiClient.post<{ data: Facility }>("/remaining", { ...data, model: "facility" } as any),
    
  updateFacility: (id: string, data: Partial<Facility>) => 
    apiClient.patch<{ data: Facility }>("/remaining/" + id, { ...data, model: "facility" } as any),
    
  deleteFacility: (id: string) => 
    apiClient.delete("/remaining/" + id, { data: { model: "facility" } } as any),
};
