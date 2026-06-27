import { apiClient } from "./client";

export type OfferStatus = "PENDING" | "ACCEPTED" | "REJECTED" | "COUNTERED" | "EXPIRED" | "WITHDRAWN";

export interface Offer {
  id: string;
  offerType: string;
  status: OfferStatus;
  basePrice: number;
  discountRate?: number;
  finalPrice: number;
  guestId?: string;
  startDate: string;
  endDate: string;
  propertyId: string;
  createdAt: string;
}

export interface PropertyOffer {
  id: string;
  orgId: string;
  propertyId: string;
  contactId: string;
  offerPrice: number;
  currency: string;
  status: string;
  validUntil?: string;
  createdAt: string;
}

export const offersApi = {
  // Booking/Reservation Offers
  getOffers: () => apiClient.get<Offer[]>("/offers"),
  createOffer: (data: Partial<Offer>) => apiClient.post("/offers", data),
  
  // Property Sales/Listing Offers
  getPropertyOffers: () => apiClient.get<PropertyOffer[]>("/property-offers"),
  createPropertyOffer: (data: Partial<PropertyOffer>) => apiClient.post("/property-offers", data),
  updatePropertyOffer: (id: string, data: Partial<PropertyOffer>) => apiClient.put(`/property-offers/${id}`, data)
};
