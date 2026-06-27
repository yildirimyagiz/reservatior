import { apiClient } from "./client";

export interface ListingChannel {
  id: string;
  orgId: string;
  listingId: string;
  channel: string;
  status: string;
  externalId?: string;
  syncedAt?: string;
  createdAt: string;
}

export const listingChannelsApi = {
  getAll: (params?: { orgId?: string; listingId?: string; channelType?: string; isActive?: boolean; page?: number; limit?: number }) =>
    apiClient.get("/listing-channels", params),
  getById: (id: string) => apiClient.get(`/listing-channels/${id}`),
  create: (data: Partial<ListingChannel>) => apiClient.post("/listing-channels", data),
  update: (id: string, data: Partial<ListingChannel>) => apiClient.patch(`/listing-channels/${id}`, data),
  delete: (id: string) => apiClient.delete(`/listing-channels/${id}`),
  getByListing: (listingId: string, params?: any) =>
    apiClient.get(`/listing-channels/listing/${listingId}`, params),
  sync: (id: string) => apiClient.post(`/listing-channels/${id}/sync`),
  activate: (id: string) => apiClient.patch(`/listing-channels/${id}/activate`),
  deactivate: (id: string) => apiClient.patch(`/listing-channels/${id}/deactivate`),
};
