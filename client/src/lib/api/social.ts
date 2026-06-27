import { apiClient } from "./client";

export const favoritesApi = {
  getFavorites: async () => {
    return await apiClient.get("/api/v1/favorite");
    
  },

  toggleFavorite: async (propertyId: string) => {
    return await apiClient.post(`/api/v1/favorite/toggle/${propertyId}`);
    
  },

  isFavorite: async (propertyId: string) => {
    return await apiClient.get(`/api/v1/favorite/check/${propertyId}`);
    
  },
};

export interface Review {
  id: string;
  rating: number;
  comment: string;
  userId: string;
  propertyId?: string;
  agentId?: string;
  createdAt: string;
}

export const reviewsApi = {
  getPropertyReviews: async (propertyId: string) => {
    return await apiClient.get(`/api/v1/review/property/${propertyId}`);
    
  },

  getAgentReviews: async (agentId: string) => {
    return await apiClient.get(`/api/v1/review/agent/${agentId}`);
    
  },

  submitReview: async (data: { 
    rating: number; 
    comment: string; 
    propertyId?: string; 
    agentId?: string 
  }) => {
    return await apiClient.post("/api/v1/review", data);
    
  },
};
