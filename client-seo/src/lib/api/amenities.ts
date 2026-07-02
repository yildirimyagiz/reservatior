import { apiClient } from "./client";

export type AmenityCategory = "ROOM" | "OUTDOOR" | "SAFETY" | "KITCHEN" | "BATHROOM" | "TECHNOLOGY" | "PETS" | "ACCESSIBILITY" | "GENERAL";

export interface Amenity {
  id: string;
  orgId: string;
  name: string;
  category: AmenityCategory;
  icon?: string;
  createdAt: string;
  updatedAt: string;
}

export interface PropertyAmenity {
  id: string;
  propertyId: string;
  amenityId: string;
  orgId: string;
  createdAt: string;
  updatedAt: string;
  amenity?: Amenity;
}

export const amenitiesApi = {
  getAll: () => apiClient.get<Amenity[]>("/amenities"),
  getPropertyAmenities: (propertyId: string) => apiClient.get<PropertyAmenity[]>(`/properties/${propertyId}/amenities`),
  linkAmenity: (propertyId: string, amenityId: string) => apiClient.post(`/properties/${propertyId}/amenities`, { amenityId }),
  unlinkAmenity: (propertyId: string, amenityId: string) => apiClient.delete(`/properties/${propertyId}/amenities/${amenityId}`)
};
