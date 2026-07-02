import { apiClient } from "./client";

export const mlsApi = {
  getConnections: () => apiClient.get<any>("/api/mls/connections"),
  createConnection: (data: any) => apiClient.post<any>("/api/mls/connections", data),
  updateConnection: (id: string, data: any) => apiClient.patch<any>(`/api/mls/connections/${id}`, data),
  deleteConnection: (id: string) => apiClient.delete<any>(`/api/mls/connections/${id}`),
  triggerSync: (id: string, orgId: string) => apiClient.post<any>(`/api/mls/connections/${id}/sync`, { orgId }),
  getSyncJobs: () => apiClient.get<any>("/api/mls/sync-jobs"),
  getExternalListings: () => apiClient.get<any>("/api/mls/external-listings"),
  getDataMappings: () => apiClient.get<any>("/api/mls/data-mappings"),
  convert: (externalListingId: string, orgId: string, userId: string) => 
    apiClient.post<any>("/api/mls/convert", { externalListingId, orgId, userId }),
  superchargeStaging: (propertyId: string, orgId: string, imageUrl: string) => 
    apiClient.post<any>("/api/ai/supercharge/staging", { propertyId, orgId, imageUrl }),
  superchargeReels: (propertyId: string, orgId: string, photos: string[]) => 
    apiClient.post<any>("/api/ai/supercharge/reels", { propertyId, orgId, photos }),
};
