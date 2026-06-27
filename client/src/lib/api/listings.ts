import { apiClient } from "./client";

export interface Listing {
  id: string;
  propertyId: string;
  title: string;
  description: string;
  type: string;
  status: "draft" | "active" | "inactive" | "rented" | "sold";
  price: string;
  currency: string;
  bedrooms: number;
  bathrooms: number;
  areaSqm: number;
  address: string;
  city: string;
  state: string;
  zip: string;
  country: string;
  featured: boolean;
  views: number;
  inquiries: number;
  createdAt: string;
  updatedAt: string;
}

export interface ListingStatusHistory {
  id: string;
  listingId: string;
  status: string;
  timestamp: string;
  notes?: string;
  changedBy: string;
}

import { AiServiceTask } from "./ai-extended";

export interface ListingTag {
  id: string;
  listingId: string;
  tagId: string;
}

export const listingsApi = {
  // Listings
  getListings: (params?: { 
    propertyId?: string; 
    status?: string; 
    type?: string; 
    featured?: boolean;
    search?: string;
    page?: number;
    limit?: number;
    mine?: boolean;
  }) => apiClient.get("/api/v1/listing", params),
  getListingById: (id: string) => apiClient.get(`/api/v1/listing/${id}`),
  createListing: (data: Partial<Listing>) => apiClient.post("/api/v1/listing", data),
  updateListing: (id: string, data: Partial<Listing>) => apiClient.patch(`/api/v1/listing/${id}`, data),
  deleteListing: (id: string) => apiClient.delete(`/api/v1/listing/${id}`, { data: { tags: [] } }),
  
  applyDoping: (listingId: string, tagName: string) => apiClient.post("/api/v1/listing-tag/doping", { listingId, tagName }),
  getActiveSubscription: () => apiClient.get("/api/v1/subscription/active"),
  
  // Status Management
  updateListingStatus: (id: string, status: string, notes?: string) => 
    apiClient.patch(`/api/v1/listing/${id}/status`, { status, notes }),
  getListingStatusHistory: (id: string) => apiClient.get(`/api/v1/listing/${id}/status`),
  
  // Property Listings
  getPropertyListings: (propertyId: string) => apiClient.get(`/api/v1/property/${propertyId}/listings`),
  
  // Featured Listings
  getFeaturedListings: () => apiClient.get("/api/v1/listing/featured"),
  setListingAsFeatured: (id: string, featured: boolean) => 
    apiClient.patch(`/api/v1/listing/${id}/featured`, { featured }),
  
  // Search
  searchListings: (query: any) => apiClient.post("/api/v1/listing/search", query),
  
  // Analytics
  getListingAnalytics: (id: string) => apiClient.get(`/api/v1/listing/${id}/analytics`),
  getListingViews: (id: string, params?: { startDate?: string; endDate?: string }) => 
    apiClient.get(`/api/v1/listing/${id}/views`, params),
  getListingInquiries: (id: string) => apiClient.get(`/api/v1/listing/${id}/inquiries`),
  
  // Tags
  getListingTags: (id: string) => apiClient.get(`/api/v1/listing/${id}/tags`),
  addListingTag: (id: string, tagId: string) => 
    apiClient.post(`/api/v1/listing/${id}/tags`, { tagId }),
  removeListingTag: (id: string, tagId: string) => 
    apiClient.delete(`/api/v1/listing/${id}/tags/${tagId}`, { data: { tags: [] } }),
  
  // Photos
  getListingPhotos: (id: string) => apiClient.get(`/api/v1/listing/${id}/photos`),
  uploadListingPhoto: (id: string, file: File) => {
    const formData = new FormData();
    formData.append("photo", file);
    return apiClient.post(`/api/v1/listing/${id}/photos`, formData);
  },
  deleteListingPhoto: (id: string, photoId: string) => 
    apiClient.delete(`/api/v1/listing/${id}/photos/${photoId}`, { data: { tags: [] } }),
  
  // Publishing
  publishListing: (id: string) => apiClient.post(`/api/v1/listing/${id}/publish`),
  unpublishListing: (id: string) => apiClient.post(`/api/v1/listing/${id}/unpublish`),
  
  // Export
  exportListings: (params?: { 
    propertyId?: string; 
    status?: string; 
    format?: "csv" | "excel" | "pdf"
  }) => apiClient.get("/api/v1/listing/export", params),
  
  // Statistics
  getListingStats: (params?: { 
    propertyId?: string; 
    startDate?: string; 
    endDate?: string 
  }) => apiClient.get("/api/v1/listing/stats", params),

  // AI Services
  dispatchAiTask: (id: string, taskType: string, inputData?: any) => 
    apiClient.post<AiServiceTask>(`/api/v1/listing/${id}/ai-task`, { taskType, inputData }),
  getAiTasks: (id: string, params?: { status?: string }) => 
    apiClient.get<AiServiceTask[]>(`/api/v1/listing/${id}/ai-tasks`, params),
  getAiTaskById: (id: string) => 
    apiClient.get<AiServiceTask>(`/api/v1/ai-service-task/${id}`),
};
