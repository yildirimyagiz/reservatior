import { apiClient } from "./client";

export const mlsApi = {
  getConnections: () => apiClient.get<any>("/mls/connections"),
  createConnection: (data: any) => apiClient.post<any>("/mls/connections", data),
  updateConnection: (id: string, data: any) => apiClient.patch<any>(`/mls/connections/${id}`, data),
  deleteConnection: (id: string) => apiClient.delete<any>(`/mls/connections/${id}`),
  triggerSync: (id: string, orgId: string) => apiClient.post<any>(`/mls/connections/${id}/sync`, { orgId }),
  getSyncJobs: () => apiClient.get<any>("/mls/sync-jobs"),
  getExternalListings: () => apiClient.get<any>("/mls/external-listings"),
  getDataMappings: () => apiClient.get<any>("/mls/data-mappings"),
  convert: (externalListingId: string, orgId: string, userId: string) => 
    apiClient.post<any>("/mls/convert", { externalListingId, orgId, userId }),
  superchargeStaging: (propertyId: string, orgId: string, imageUrl: string) => 
    apiClient.post<any>("/ai/supercharge/staging", { propertyId, orgId, imageUrl }),
  superchargeReels: (propertyId: string, orgId: string, photos: string[]) => 
    apiClient.post<any>("/ai/supercharge/reels", { propertyId, orgId, photos }),
};
