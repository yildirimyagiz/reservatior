import { apiClient } from "./client";

export interface IncludedService {
  id: string;
  propertyId: string;
  name: string;
  description?: string;
  value?: number;
  isRecurring: boolean;
  frequency: string;
  icon?: string;
  logo?: string;
  createdAt: string;
  updatedAt: string;
  facilityId?: string;
  property?: {
    id: string;
    name: string;
  };
}

export const includedServiceApi = {
  getServices: (params?: { propertyId?: string; orgId?: string; page?: number; limit?: number }) => 
    apiClient.get<{ data: IncludedService[]; pagination: any }>("/included-services", params),
    
  getService: (id: string) => 
    apiClient.get<{ data: IncludedService }>("/included-services/" + id),
    
  createService: (data: Partial<IncludedService> & { propertyId: string; name: string }) => 
    apiClient.post<{ data: IncludedService }>("/included-services", data),
    
  updateService: (id: string, data: Partial<IncludedService>) => 
    apiClient.patch<{ data: IncludedService }>("/included-services/" + id, data),
    
  deleteService: (id: string) => 
    apiClient.delete("/included-services/" + id, { data: { tags: [] } } as any),
};
