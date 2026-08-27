import { apiClient } from "./client";

// Property types based on generated schema
export type PropertyType =
  | "DETACHED_HOUSE"
  | "SEMI_DETACHED_HOUSE"
  | "TERRACED_HOUSE"
  | "FLAT_MAISONETTE"
  | "BUNGALOW"
  | "COTTAGE"
  | "TOWNHOUSE"
  | "APARTMENT"
  | "STUDIO"
  | "PENTHOUSE";

export type PropertyRegion =
  | "USA_NORTHEAST"
  | "USA_SOUTH"
  | "USA_MIDWEST"
  | "USA_WEST"
  | "USA_SOUTHWEST";

export enum ListingType {
  SALE = "SALE",
  RENT = "RENT",
  BOOKING = "BOOKING",
}

export enum ListingStatus {
  DRAFT = "DRAFT",
  VACANT = "VACANT",
  AVAILABLE = "AVAILABLE",
  RESERVED = "RESERVED",
  RENTED = "RENTED",
  BOOKED = "BOOKED",
  WILL_BE_AVAILABLE = "WILL_BE_AVAILABLE",
  MAINTENANCE = "MAINTENANCE",
  SOLD = "SOLD",
  ARCHIVED = "ARCHIVED",
}

export enum PropertyCategory {
  RESIDENTIAL = "RESIDENTIAL",
  COMMERCIAL = "COMMERCIAL",
  INDUSTRIAL = "INDUSTRIAL",
  MIXED_USE = "MIXED_USE",
  AGRICULTURAL = "AGRICULTURAL",
  SPECIAL_PURPOSE = "SPECIAL_PURPOSE",
}

export interface Property {
  id: string;
  orgId: string;
  type: PropertyType;
  name: string;
  region: PropertyRegion;
  currency: string;
  addressLine1: string;
  addressLine2?: string;
  city: string;
  state?: string;
  zip?: string;
  country: string;
  lat?: number;
  lng?: number;
  neighborhoodId?: string;
  bedrooms?: number;
  bathrooms?: number; // Backend is Float
  areaSqm?: number;
  yearBuilt?: number;
  notes?: string;
  locationId?: string;
  stateCode?: string;
  propertyCategory: PropertyCategory;
  listingType: ListingType;
  listingStatus: ListingStatus;
  listingPrice?: number;
  originalPrice?: number;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;

  // Added Fields
  lotSizeAcres?: number;
  lotSizeSqFt?: number;
  parkingSpaces?: number;
  heatingType?: string;
  coolingType?: string;
  schoolDistrict?: string;
  zoningCode?: string;
  propertyTaxRate?: number;
  yearRenovated?: number;
  isDoped?: boolean;
  
  // AI & Advanced Filter Fields
  aiSummary?: string;
  aiOpportunityScore?: number;
  aiWhyScore?: number;
  aiRecommendedStrategy?: string;
  aiOpportunityTier?: string;
  aiAcquisitionUrgency?: string;
  aiRiskLevel?: string;
  legalComplianceStatus?: string;

  // Relations (will be populated by API)
  photos?: PropertyPhoto[];
  documents?: PropertyDocument[];
  amenities?: PropertyAmenity[];
  valuations?: PropertyValuation[];
  offers?: PropertyOffer[];
  viewings?: PropertyViewing[];
}

export interface PropertyPhoto {
  id: string;
  orgId: string;
  propertyId: string;
  url: string;
  caption?: string;
  isPrimary: boolean;
  sortOrder: number;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}

export interface PropertyDocument {
  id: string;
  orgId: string;
  propertyId: string;
  url: string;
  title: string;
  type: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}

export interface PropertyAmenity {
  id: string;
  orgId: string;
  propertyId: string;
  amenityId: string;
  createdAt: Date;
  updatedAt: Date;
  deletedAt?: Date;
}

export interface PropertyValuation {
  id: string;
  orgId: string;
  propertyId: string;
  amount: number;
  currency: string;
  date: Date;
  type: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyOffer {
  id: string;
  orgId: string;
  propertyId: string;
  amount: number;
  currency: string;
  status: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyViewing {
  id: string;
  orgId: string;
  propertyId: string;
  scheduledDate: Date;
  status: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface PropertyCreate {
  orgId: string;
  name: string;
  address: string;
  city: string;
  state: string;
  zipCode: string;
  country: string;
  propertyType: string;
  listingType: string;
  status: string;
  bedrooms: number;
  bathrooms: number;
  squareFootage: number;
  lotSize: number;
  yearBuilt: number;
  description?: string;
  features?: string[];
  amenities?: string[];
  latitude?: number;
  longitude?: number;
  ownerId?: string;
  managerId?: string;
}

export interface PropertyUpdate {
  name?: string;
  address?: string;
  city?: string;
  state?: string;
  zipCode?: string;
  country?: string;
  propertyType?: string;
  listingType?: string;
  status?: string;
  bedrooms?: number;
  bathrooms?: number;
  squareFootage?: number;
  lotSize?: number;
  yearBuilt?: number;
  description?: string;
  features?: string[];
  amenities?: string[];
  valuation?: number;
  rentalPrice?: number;
  salePrice?: number;
  latitude?: number;
  longitude?: number;
  ownerId?: string;
  managerId?: string;
}

export const propertiesApi = {
  getAll: async (params?: {
    page?: number;
    limit?: number;
    sortBy?: string;
    search?: string;
    region?: string;
    propertyType?: string;
    status?: string;
    city?: string;
    state?: string;
  }): Promise<Property[]> => {
    const res: any = await apiClient.get("/api/v1/property", params);
    if (Array.isArray(res)) return res;
    if (Array.isArray(res?.data)) return res.data;
    if (Array.isArray(res?.data?.data)) return res.data.data;
    return [];
  },

  getById: async (id: string): Promise<Property> => {
    const { data } = await apiClient.get<{ data: Property }>(`/api/v1/property/${id}`);
    return data;
  },

  create: async (data: PropertyCreate): Promise<Property> => {
    const { data: created } = await apiClient.post<{ data: Property }>("/api/v1/property", data);
    return created;
  },

  update: async (id: string, data: PropertyUpdate): Promise<Property> => {
    const { data: updated } = await apiClient.patch<{ data: Property }>(`/api/v1/property/${id}`, data);
    return updated;
  },

  delete: async (id: string): Promise<any> => {
    return await apiClient.delete<any>(`/api/v1/property/${id}`);
  },

  // Get properties for organization
  getOrgProperties: async (orgId: string): Promise<Property[]> => {
    const { data } = await apiClient.get<{ data: Property[] }>("/api/v1/property", { orgId });
    return data;
  },

  // Search properties
  searchProperties: async (query: string, filters?: any): Promise<Property[]> => {
    return await apiClient.get<Property[]>("/api/v1/property/search", {
      params: { q: query, ...filters },
    });
    
  },

  // Get property analytics
  getPropertyAnalytics: async (id: string): Promise<any> => {
    return await apiClient.get<any>(`/api/v1/property/${id}/analytics`);
    
  },

  // Upload property photos
  uploadPhotos: async (id: string, files: File[]): Promise<PropertyPhoto[]> => {
    const formData = new FormData();
    files.forEach((file) => formData.append("photos", file));

    return await apiClient.post<PropertyPhoto[]>(
      `/api/v1/property/${id}/photos`,
      formData,
      {
        headers: { "Content-Type": "multipart/form-data" },
      }
    );
    
  },

  // Get property valuation
  getPropertyValuation: async (id: string): Promise<any> => {
    return await apiClient.get<any>(`/api/v1/property/${id}/valuation`);
    
  },

  // AI Staging & Visual Enhancement
  runAIStaging: async (propertyId: string, options?: { style?: string, roomType?: string }): Promise<any> => {
    // In a real app this would proxy to the python ML backend staging endpoint
    return await apiClient.post<any>(`/api/v1/property/${propertyId}/ai-staging`, options);
  },
};
