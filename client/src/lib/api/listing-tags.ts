import { apiClient } from "./client";

export interface ListingTag {
  id: string;
  listingId: string;
  tagId: string;
  orgId: string;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string;
  listing?: any;
  tag?: Tag;
}

export interface Tag {
  id: string;
  orgId: string;
  name: string;
  color?: string;
  createdAt: string;
  updatedAt: string;
}

export interface CreateListingTagRequest {
  listingId: string;
  tagId: string;
  orgId: string;
}

export interface UpdateListingTagRequest extends Partial<CreateListingTagRequest> {}

export const listingTagsApi = {
  getAll: (params?: { orgId?: string; listingId?: string; tagId?: string }) =>
    apiClient.get("/listing-tag", params),

  getById: (id: string) => apiClient.get(`/listing-tag/${id}`),

  create: (data: CreateListingTagRequest) => apiClient.post("/listing-tag", data),

  update: (id: string, data: UpdateListingTagRequest) => apiClient.patch(`/listing-tag/${id}`, data),

  delete: (id: string) => apiClient.delete(`/listing-tag/${id}`),

  getByListing: (listingId: string) => apiClient.get("/listing-tag", { listingId }),

  getByOrg: (orgId: string) => apiClient.get("/listing-tag", { orgId }),

  addTagToListing: (listingId: string, tagId: string, orgId: string) =>
    apiClient.post("/listing-tag", { listingId, tagId, orgId }),

  removeTagFromListing: (id: string) => apiClient.delete(`/listing-tag/${id}`),
};
