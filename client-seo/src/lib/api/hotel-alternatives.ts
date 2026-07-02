import { apiClient } from "./client";

export interface HotelAlternativeSearchInput {
  destination: string;
  checkIn: string;
  checkOut: string;
  guests: number;
  rooms?: number;
  propertyName?: string;
  propertyCity?: string;
  currentPrice?: number;
  currency?: string;
}

export interface PriceComparison {
  difference: number;
  differencePercent: number;
  isCheaper: boolean;
}

export interface HotelAlternative {
  type: string;
  isOwnInventory: boolean;
  name: string;
  description: string;
  address: string;
  city: string;
  country: string;
  lat: number;
  lng: number;
  rating: number;
  starRating: number;
  photos: string[];
  amenities: string[];
  roomName: string;
  boardName: string;
  netPrice: number;
  grossPrice: number;
  provider: string;
  currency: string;
  isRefundable: boolean;
  priceComparison: PriceComparison;
  bookingUrl: string;
  /** Apartment-specific */
  bedrooms?: number;
  bathrooms?: number;
  areaSqm?: number;
}

export interface HotelAlternativeResponse {
  current: {
    name: string;
    price: number;
    currency: string;
  };
  alternatives: HotelAlternative[];
  bestOffer: HotelAlternative | null;
}

export interface HasCheaperResponse {
  hasCheaper: boolean;
  cheapestPrice: number | null;
  savings: number | null;
}

export const hotelAlternativesApi = {
  getAlternatives: (data: HotelAlternativeSearchInput) =>
    apiClient.post<{ success: boolean; data: HotelAlternativeResponse }>(
      "/hotel-booking-sync/alternatives",
      data
    ),

  hasCheaper: (data: Partial<HotelAlternativeSearchInput>) =>
    apiClient.post<{ success: boolean; data: HasCheaperResponse }>(
      "/hotel-booking-sync/has-cheaper",
      data
    ),

  searchHotels: (params: {
    destination: string;
    checkIn: string;
    checkOut: string;
    guests?: string;
    rooms?: string;
    currency?: string;
    nationality?: string;
  }) =>
    apiClient.get<{ success: boolean; total: number; data: any[] }>(
      "/b2b-hotels/search",
      params
    ),
};
