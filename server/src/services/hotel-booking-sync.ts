/**
 * Hotel-Booking Sync Service
 *
 * Takes existing booking/property selections and checks Hotelbeds/WebBeds
 * for matching hotel room options with comparative pricing.
 * Also cross-sells apartments from the local inventory.
 */

import { HotelPriceComparisonEngine } from './hotel-price-comparison';
import { propertyCrossSellService } from './property-cross-sell';

export interface BookingSyncInput {
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

export interface AlternativeOption {
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
  priceComparison: {
    difference: number;
    differencePercent: number;
    isCheaper: boolean;
  };
  bookingUrl: string;
}

export class HotelBookingSyncService {
  /**
   * For a given booking/property selection, find hotel alternatives
   * from Hotelbeds/WebBeds AND apartment alternatives from the local inventory.
   */
  static async findAlternatives(input: BookingSyncInput): Promise<{
    current: { name: string; price: number; currency: string };
    alternatives: AlternativeOption[];
    bestOffer: AlternativeOption | null;
  }> {
    console.log(`[BOOKING-SYNC] Finding alternatives for ${input.destination}`);

    const [offers, apartments] = await Promise.all([
      HotelPriceComparisonEngine.search({
        destination: input.destination,
        checkIn: input.checkIn,
        checkOut: input.checkOut,
        guests: input.guests,
        rooms: input.rooms ?? 1,
        currency: input.currency ?? 'USD',
      }),
      propertyCrossSellService.findPropertiesByCity({
        destination: input.destination,
        excludePropertyName: input.propertyName,
        maxResults: 5,
      }),
    ]);

    const currentPrice = input.currentPrice ?? 0;
    const alternatives: AlternativeOption[] = [
      // Hotel alternatives
      ...offers.map((hotel) => ({
        type: 'HOTEL',
        isOwnInventory: false,
        name: hotel.name,
        description: hotel.description,
        address: hotel.address,
        city: hotel.city,
        country: hotel.country,
        lat: hotel.lat,
        lng: hotel.lng,
        rating: hotel.rating,
        starRating: hotel.starRating,
        photos: hotel.photos,
        amenities: hotel.amenities,
        roomName: hotel.bestRate.roomName,
        boardName: hotel.bestRate.boardName,
        netPrice: hotel.bestRate.netPrice,
        grossPrice: hotel.bestRate.grossPrice,
        provider: hotel.bestRate.provider,
        currency: hotel.currency,
        isRefundable: hotel.bestRate.isRefundable,
        priceComparison: {
          difference: currentPrice > 0 ? hotel.bestRate.grossPrice - currentPrice : 0,
          differencePercent: currentPrice > 0
            ? Math.round(((hotel.bestRate.grossPrice - currentPrice) / currentPrice) * 100)
            : 0,
          isCheaper: currentPrice > 0 && hotel.bestRate.grossPrice < currentPrice,
        },
        bookingUrl: `/b2b-hotels/book?provider=${hotel.bestRate.provider}&hotelId=${hotel.id}&rateKey=${hotel.bestRate.rateKey}`,
      })),
      // Apartment alternatives from local inventory
      ...apartments.map((apt) => ({
        type: apt.type,
        isOwnInventory: true,
        name: apt.name,
        description: apt.description,
        address: apt.address,
        city: apt.city,
        country: apt.country,
        lat: apt.lat,
        lng: apt.lng,
        rating: apt.rating,
        starRating: apt.starRating,
        photos: apt.photos,
        amenities: apt.amenities,
        roomName: `${apt.bedrooms} Bedroom ${apt.areaSqm > 0 ? `· ${apt.areaSqm}m²` : ''}`.trim(),
        boardName: 'Self Catering',
        netPrice: apt.listingPrice,
        grossPrice: apt.listingPrice,
        provider: `${apt.region.toUpperCase()} · ${apt.listingType}`,
        currency: apt.currency,
        isRefundable: true,
        priceComparison: {
          difference: currentPrice > 0 ? apt.listingPrice - currentPrice : 0,
          differencePercent: currentPrice > 0
            ? Math.round(((apt.listingPrice - currentPrice) / currentPrice) * 100)
            : 0,
          isCheaper: currentPrice > 0 && apt.listingPrice < currentPrice,
        },
        bookingUrl: apt.propertyUrl,
      })),
    ];

    alternatives.sort((a, b) => a.grossPrice - b.grossPrice);

    const bestOffer = alternatives.length > 0 ? alternatives[0] : null;

    return {
      current: {
        name: input.propertyName ?? 'Mevcut Konaklama',
        price: currentPrice,
        currency: input.currency ?? 'USD',
      },
      alternatives,
      bestOffer,
    };
  }

  /**
   * Quick comparison: returns true if there are hotel options
   * cheaper than the current booking price.
   */
  static async hasCheaperOptions(input: BookingSyncInput): Promise<{
    hasCheaper: boolean;
    cheapestPrice: number | null;
    savings: number | null;
  }> {
    const result = await this.findAlternatives(input);

    if (!result.bestOffer || !input.currentPrice) {
      return { hasCheaper: false, cheapestPrice: null, savings: null };
    }

    const cheapestPrice = result.bestOffer.grossPrice;
    const savings = input.currentPrice - cheapestPrice;

    return {
      hasCheaper: savings > 0,
      cheapestPrice,
      savings: savings > 0 ? savings : null,
    };
  }
}
