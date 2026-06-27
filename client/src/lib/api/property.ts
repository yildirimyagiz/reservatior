import { apiClient } from "./client";

export interface Property {
  id: string;
  name: string;
  type: string;
  status: string;
  address: string;
  price: string;
  createdAt: string;
  updatedAt: string;
  listings?: Array<{
    id: string;
    price: number;
    pricingRules?: Array<{
      id: string;
      basePrice: number;
      strategy: string;
      isActive: boolean;
      startDate?: string;
      endDate?: string;
      weekdayPrices?: any;
      discountRules?: any;
    }>;
  }>;
}

export interface PropertyAvailability {
  id: string;
  propertyId: string;
  startDate: string;
  endDate: string;
  status: "available" | "occupied" | "maintenance";
  tenant?: string;
}

export const propertyApi = {
  // Properties
  getProperties: (params?: any) => apiClient.get("/api/v1/property?include=listings.pricingRules", params),
  getPropertyById: (id: string) => apiClient.get(`/api/v1/property/${id}?include=listings.pricingRules`),
  createProperty: (data: Partial<Property>) => apiClient.post("/api/v1/property", data),
  updateProperty: (id: string, data: Partial<Property>) => apiClient.patch(`/api/v1/property/${id}`, data),
  deleteProperty: (id: string) => apiClient.delete(`/api/v1/property/${id}`, { data: { tags: [] } }),
  
  // Availability
  getAvailability: (propertyId: string) => apiClient.get(`/api/v1/property/${propertyId}/availability`),
  updateAvailability: (propertyId: string, data: Partial<PropertyAvailability>) => 
    apiClient.patch(`/api/v1/property/${propertyId}/availability`, data),
  
  // Search
  searchProperties: (params: any) => apiClient.get("/api/v1/property/search?include=listings.pricingRules", params),
};
