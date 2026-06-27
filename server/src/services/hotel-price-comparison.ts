/**
 * Smart Hotel Price Comparison Engine
 *
 * Searches Hotelbeds and WebBeds in parallel, deduplicates hotels,
 * finds the cheapest rate for each, and returns sorted results.
 */

import { hotelbedsService } from './hotelbeds';
import { webbedsService } from './webbeds';
import { hotelMappingService } from './hotel-mapping';
import { hotelCache } from './hotel-cache';
import type { PrismaClient } from '@prisma/client';

export interface SearchParams {
  destination: string;
  checkIn: string;
  checkOut: string;
  guests: number;
  rooms?: number;
  currency?: string;
  nationality?: string;
}

export interface HotelOffer {
  id: string;
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
  currency: string;
  bestRate: BestRate;
  otherRates: BestRate[];
  providers: string[];
}

export interface BestRate {
  roomType: string;
  roomName: string;
  boardCode: string;
  boardName: string;
  netPrice: number;
  grossPrice: number;
  provider: string;
  rateKey: string;
  isRefundable: boolean;
  maxGuests: number;
}

interface NormalizedHotel {
  id: string;
  name: string;
  description: string;
  address: string;
  city: string;
  country: string;
  lat: number;
  lng: number;
  rating: number;
  images: string[];
  facilities: string[];
  provider: string;
  rooms: NormalizedRoom[];
}

interface NormalizedRoom {
  id: string;
  name: string;
  maxGuests: number;
  rates: NormalizedRate[];
}

interface NormalizedRate {
  rateKey: string;
  name: string;
  netPrice: number;
  grossPrice: number;
  boardCode: string;
  boardName: string;
  isRefundable: boolean;
  currency: string;
}

const DEFAULT_MARKUP = 0.12;

function calculateGross(netPrice: number, markupPct: number = DEFAULT_MARKUP): number {
  const dynamicMarkup = markupPct + Math.random() * 0.03;
  return Number((netPrice * (1 + dynamicMarkup)).toFixed(2));
}

function normalizeHotelbedsResults(results: any[]): NormalizedHotel[] {
  return results.map((h: any) => ({
    id: String(h.code).startsWith('HB-') ? String(h.code) : `HB-${h.code}`,
    name: h.name,
    description: h.description || '',
    address: h.address || '',
    city: h.city || '',
    country: h.country || '',
    lat: h.latitude || 0,
    lng: h.longitude || 0,
    rating: h.rating || 0,
    images: h.images || [],
    facilities: h.facilities || [],
    provider: 'HOTELBEDS',
    rooms: (h.rooms ?? []).map((r: any) => ({
      id: `HB-${h.code}-${r.code}`,
      name: r.name,
      maxGuests: r.maxGuests || 2,
      rates: (r.rates ?? []).map((rate: any) => ({
        rateKey: rate.rateKey || `${r.code}-${rate.net}`,
        name: rate.rateName || 'Standard Rate',
        netPrice: rate.net,
        grossPrice: rate.gross || calculateGross(rate.net),
        boardCode: rate.boardCode || 'RO',
        boardName: rate.boardName || 'Room Only',
        isRefundable: rate.isRefundable ?? false,
        currency: 'USD',
      })),
    })),
  }));
}

function normalizeWebbedsResults(results: any[]): NormalizedHotel[] {
  return results.map((h: any) => ({
    id: h.hotelId.startsWith('WB-') ? h.hotelId : `WB-${h.hotelId}`,
    name: h.hotelName,
    description: h.description || '',
    address: h.address || '',
    city: h.city || '',
    country: h.country || '',
    lat: h.latitude || 0,
    lng: h.longitude || 0,
    rating: h.rating || 0,
    images: h.images || [],
    facilities: h.facilities || [],
    provider: 'WEBBEDS',
    rooms: (h.rooms ?? []).map((r: any) => ({
      id: r.roomId,
      name: r.roomName,
      maxGuests: r.maxGuests || 2,
      rates: (r.rates ?? []).map((rate: any) => ({
        rateKey: rate.rateId,
        name: rate.rateName || 'Standard Rate',
        netPrice: rate.netPrice,
        grossPrice: rate.grossPrice || calculateGross(rate.netPrice),
        boardCode: rate.boardCode || 'RO',
        boardName: rate.boardName || 'Room Only',
        isRefundable: rate.isRefundable ?? false,
        currency: rate.currency || 'USD',
      })),
    })),
  }));
}

function normalizeAmenities(hotel: NormalizedHotel): string[] {
  if (hotel.facilities && hotel.facilities.length > 0) return hotel.facilities;
  if (hotel.rooms.length > 0) {
    const room = hotel.rooms[0];
    if ((room as any).amenities) return (room as any).amenities;
  }
  return [];
}

function computeStarRating(raw: number): number {
  if (raw >= 5) return 5;
  if (raw >= 4.5) return 5;
  if (raw >= 4) return 4;
  if (raw >= 3) return 3;
  if (raw >= 2) return 2;
  return 1;
}

function parseLatLng(raw: any): number {
  const n = Number(raw);
  return isNaN(n) ? 0 : n;
}

export class HotelPriceComparisonEngine {
  static async search(params: SearchParams): Promise<HotelOffer[]> {
    const cacheKey = hotelCache.buildKey(params.destination, params.checkIn, params.checkOut, params.guests);
    const cached = hotelCache.get<HotelOffer[]>(cacheKey);
    if (cached) {
      console.log(`[PRICE-COMPARISON] Cache hit for ${params.destination}`);
      return cached;
    }

    const [hbRaw, wbRaw] = await Promise.all([
      hotelbedsService.searchHotels({
        destination: params.destination,
        checkIn: params.checkIn,
        checkOut: params.checkOut,
        guests: params.guests,
        rooms: params.rooms,
        nationality: params.nationality,
      }),
      webbedsService.searchHotels({
        destination: params.destination,
        checkIn: params.checkIn,
        checkOut: params.checkOut,
        guests: params.guests,
        rooms: params.rooms,
        nationality: params.nationality,
      }),
    ]);

    const allHotels: NormalizedHotel[] = [
      ...normalizeHotelbedsResults(hbRaw),
      ...normalizeWebbedsResults(wbRaw),
    ];

    return this.deduplicateAndRank(allHotels, cacheKey);
  }

  private static deduplicateAndRank(hotels: NormalizedHotel[], cacheKey?: string): HotelOffer[] {
    const grouped = new Map<string, NormalizedHotel[]>();

    for (const hotel of hotels) {
      const key = hotelMappingService.resolve(hotel.name, hotel.city);
      if (!grouped.has(key)) {
        grouped.set(key, []);
      }
      grouped.get(key)!.push(hotel);
    }

    const offers: HotelOffer[] = [];

    for (const [, group] of grouped) {
      if (group.length === 0) continue;

      const primary = group[0];
      const providers = group.map((h) => h.provider);

      const allRates: {
        room: NormalizedRoom;
        rate: NormalizedRate;
        provider: string;
      }[] = [];

      for (const h of group) {
        for (const room of h.rooms) {
          for (const rate of room.rates) {
            allRates.push({ room, rate, provider: h.provider });
          }
        }
      }

      allRates.sort((a, b) => a.rate.grossPrice - b.rate.grossPrice);

      const bestRate = allRates[0];
      if (!bestRate) continue;

      const offer: HotelOffer = {
        id: primary.id,
        name: primary.name,
        description: primary.description || '',
        address: primary.address || '',
        city: primary.city || '',
        country: primary.country || '',
        lat: parseLatLng(primary.lat),
        lng: parseLatLng(primary.lng),
        rating: primary.rating,
        starRating: computeStarRating(primary.rating),
        photos: primary.images || [],
        amenities: normalizeAmenities(primary),
        currency: bestRate.rate.currency || 'USD',
        bestRate: {
          roomType: bestRate.room.id,
          roomName: bestRate.room.name,
          boardCode: bestRate.rate.boardCode,
          boardName: bestRate.rate.boardName,
          netPrice: bestRate.rate.netPrice,
          grossPrice: bestRate.rate.grossPrice,
          provider: bestRate.provider,
          rateKey: bestRate.rate.rateKey,
          isRefundable: bestRate.rate.isRefundable,
          maxGuests: bestRate.room.maxGuests,
        },
        otherRates: allRates.slice(1, 10).map((r) => ({
          roomType: r.room.id,
          roomName: r.room.name,
          boardCode: r.rate.boardCode,
          boardName: r.rate.boardName,
          netPrice: r.rate.netPrice,
          grossPrice: r.rate.grossPrice,
          provider: r.provider,
          rateKey: r.rate.rateKey,
          isRefundable: r.rate.isRefundable,
          maxGuests: r.room.maxGuests,
        })),
        providers: [...new Set(providers)],
      };

      offers.push(offer);
    }

    offers.sort((a, b) => a.bestRate.grossPrice - b.bestRate.grossPrice);

    if (cacheKey) {
      hotelCache.set(cacheKey, offers, 180_000);
    }
    return offers;
  }
}
