import axios, { AxiosInstance } from 'axios';
import * as crypto from 'crypto';

export interface HotelbedsSearchParams {
  destination: string;
  checkIn: string;
  checkOut: string;
  guests: number;
  rooms?: number;
  nationality?: string;
}

export interface HotelbedsHotel {
  code: number;
  name: string;
  description?: string;
  address?: string;
  city?: string;
  country?: string;
  latitude?: number;
  longitude?: number;
  rating?: number;
  categoryCode?: string;
  images?: { path: string }[];
  facilities?: { facilityCode: number; facilityName: string }[];
}

export interface HotelbedsRoom {
  code: string;
  name: string;
  occupantCount?: number;
  maxGuests?: number;
  bedType?: string;
  images?: { path: string }[];
}

export interface HotelbedsRate {
  rateCode: string;
  rateName?: string;
  net: number;
  gross?: number;
  boardCode?: string;
  boardName?: string;
  cancellationPolicy?: string;
  isRefundable?: boolean;
  rooms?: number;
  adults?: number;
  children?: number;
}

export interface HotelbedsBookingRequest {
  hotelCode: number;
  checkIn: string;
  checkOut: string;
  rooms: {
    rateCode: string;
    guests: { type: 'ADULT' | 'CHILD'; age?: number; name?: string; surname?: string }[];
  }[];
  holder: { name: string; surname: string };
  payment?: { paymentType: 'AT_WEB' | 'AT_HOTEL'; vcc?: string; cvv?: string };
}

export class HotelbedsService {
  private api: AxiosInstance;
  private apiKey: string;
  private secret: string;

  constructor() {
    this.apiKey = process.env.HOTELBEDS_API_KEY || '';
    this.secret = process.env.HOTELBEDS_SECRET || '';
    const baseURL = process.env.HOTELBEDS_API_URL || 'https://api.test.hotelbeds.com/hotel-api/1.0';

    this.api = axios.create({ baseURL, timeout: 15000 });
    this.api.interceptors.request.use((config) => {
      const timestamp = Math.floor(Date.now() / 1000).toString();
      const signature = crypto
        .createHash('sha256')
        .update(`${this.apiKey}${this.secret}${timestamp}`)
        .digest('hex');

      config.headers['X-Signature'] = signature;
      config.headers['Api-Key'] = this.apiKey;
      config.headers['Accept'] = 'application/json';
      config.headers['Content-Type'] = 'application/json';
      return config;
    });
  }

  get isConfigured(): boolean {
    return !!(this.apiKey && this.secret);
  }

  async searchHotels(params: HotelbedsSearchParams) {
    if (!this.isConfigured) return this.getMockResults(params);

    const destCode = this.resolveDestinationCode(params.destination);
    if (!destCode) {
      console.warn(`[HOTELBEDS] Unknown destination: ${params.destination}, falling back to mock`);
      return this.getMockResults(params);
    }

    try {
      const payload = {
        stay: { checkIn: params.checkIn, checkOut: params.checkOut },
        occupancies: [{ rooms: params.rooms || 1, adults: params.guests, children: 0 }],
        destination: { code: destCode },
        filter: { maxHotels: 20, minRate: 1 },
      };

      console.log(`[HOTELBEDS] Calling real API with destination code: ${destCode}`);
      const response = await this.api.post('/hotels', payload);
      const normalized = this.normalizeSearchResponse(response.data);
      if (normalized.length === 0) {
        console.warn('[HOTELBEDS] API returned 0 results, falling back to mock');
        return this.getMockResults(params);
      }
      return normalized;
    } catch (error: any) {
      const detail = error.response?.data || error.message;
      console.warn('[HOTELBEDS] API call failed, falling back to mock:', JSON.stringify(detail).slice(0, 500));
      return this.getMockResults(params);
    }
  }

  async checkRate(rateKey: string) {
    if (!this.isConfigured) {
      return { net: 100, gross: 112, currency: 'USD', rateKey };
    }

    try {
      const response = await this.api.post('/checkrates', { rateKeys: [{ rateKey }] });
      return response.data;
    } catch (error: any) {
      console.error('[HOTELBEDS] checkRate failed:', error.message);
      throw error;
    }
  }

  async createBooking(request: HotelbedsBookingRequest) {
    if (!this.isConfigured) {
      return {
        bookingId: `HB-DEMO-${Math.random().toString(36).slice(2, 8).toUpperCase()}`,
        status: 'CONFIRMED',
        providerReference: `HB-REF-${Date.now()}`,
      };
    }

    try {
      const response = await this.api.post('/bookings', request);
      return response.data;
    } catch (error: any) {
      console.error('[HOTELBEDS] Booking failed:', error.message);
      throw error;
    }
  }

  async getBookingDetails(bookingId: string) {
    try {
      const response = await this.api.get(`/bookings/${bookingId}`);
      return response.data;
    } catch (error: any) {
      console.error('[HOTELBEDS] getBookingDetails failed:', error.message);
      throw error;
    }
  }

  async cancelBooking(bookingId: string) {
    try {
      const response = await this.api.delete(`/bookings/${bookingId}`);
      return response.data;
    } catch (error: any) {
      console.error('[HOTELBEDS] cancelBooking failed:', error.message);
      throw error;
    }
  }

  async getCancellationPolicy(bookingId: string) {
    try {
      const response = await this.api.get(`/bookings/${bookingId}/cancellations`);
      return response.data;
    } catch (error: any) {
      console.error('[HOTELBEDS] getCancellationPolicy failed:', error.message);
      throw error;
    }
  }

  private normalizeSearchResponse(data: any) {
    const hotels = data?.hotels?.hotels ?? [];
    return hotels.map((h: any) => ({
      code: h.code,
      name: h.name?.content || h.name,
      description: h.description?.content,
      address: h.address?.content,
      city: h.city?.content,
      country: h.country?.content,
      latitude: h.latitude,
      longitude: h.longitude,
      rating: h.categoryCode ? parseFloat(h.categoryCode) / 10 : undefined,
      images: (h.images ?? []).map((img: any) => img.path),
      facilities: (h.facilities ?? []).map((f: any) => f.facilityName),
      rooms: (h.rooms ?? []).map((r: any) => ({
        code: r.code,
        name: r.name,
        rates: (r.rates ?? []).map((rate: any) => ({
          rateKey: rate.rateKey,
          rateName: rate.rateName,
          net: rate.net,
          boardCode: rate.boardCode,
          boardName: rate.boardName,
          isRefundable: rate.isRefundable,
        })),
      })),
    }));
  }

  private async getMockResults(params: HotelbedsSearchParams) {
    await new Promise((r) => setTimeout(r, 800));
    const region = this.matchDestination(params.destination);
    if (!region) return [];

    const hotels = MOCK_HOTELBEDS_HOTELS[region] ?? [];
    return hotels;
  }

  private resolveDestinationCode(destination: string): string | null {
    const d = destination.toLowerCase().trim();
    const codes: Record<string, string> = {
      antalya: 'ANT', istanbul: 'IST', bodrum: 'BJV', izmir: 'ADB', ankara: 'ESB',
      adana: 'ADA', trabzon: 'TZX', dalaman: 'DLM', mugla: 'DLM', marmaris: 'DLM',
      fethiye: 'DLM', kayseri: 'ASR', nevsehir: 'NAV', gaziantep: 'GZT',
      dubai: 'DXB', abu_dhabi: 'AUH', london: 'LON', paris: 'PAR',
      'new york': 'NYC', los_angeles: 'LAX', miami: 'MIA', rome: 'ROM',
      milan: 'MIL', berlin: 'BER', madrid: 'MAD', barcelona: 'BCN',
      amsterdam: 'AMS', zurich: 'ZRH', geneva: 'GVA', vienna: 'VIE',
      prague: 'PRG', budapest: 'BUD', warsaw: 'WAW', athens: 'ATH',
      beirut: 'BEY', cairo: 'CAI', sharm: 'SSH', hurghada: 'HRG',
      tunis: 'TUN', casablanca: 'CMN', marrakech: 'RAK',
    };
    for (const [key, code] of Object.entries(codes)) {
      if (d.includes(key)) return code;
    }
    return null;
  }

  private matchDestination(destination: string): string | null {
    const d = destination.toLowerCase().trim();
    if (['antalya', 'belek', 'kemer', 'alanya', 'side', 'lara', 'kundu'].some((k) => d.includes(k))) return 'antalya';
    if (['istanbul', 'taksim', 'sultanahmet', 'kadıköy', 'beşiktaş', 'beyoğlu'].some((k) => d.includes(k))) return 'istanbul';
    if (['bodrum'].some((k) => d.includes(k))) return 'bodrum';
    if (['türkiye', 'turkey', 'fethiye', 'muğla', 'çeşme', 'izmir', 'marmaris'].some((k) => d.includes(k))) return 'turkey';
    if (['dubai', 'dubayy'].some((k) => d.includes(k))) return 'dubai';
    if (['london', 'londra'].some((k) => d.includes(k))) return 'london';
    if (['paris', 'paris'].some((k) => d.includes(k))) return 'paris';
    if (['new york', 'nyc', 'manhattan'].some((k) => d.includes(k))) return 'newyork';
    return null;
  }
}

const MOCK_HOTELBEDS_HOTELS: Record<string, any[]> = {
  antalya: [
    {
      code: 1001,
      name: 'Rixos Premium Belek',
      description: 'Luxury resort with private beach and exclusive amenities.',
      address: 'İleribaşı Mevkii, Belek',
      city: 'Antalya',
      country: 'Turkey',
      latitude: 36.8524,
      longitude: 31.066,
      rating: 4.8,
      images: [
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1200',
        'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=1200',
      ],
      facilities: ['Pool', 'Spa', 'Beachfront', 'All Inclusive'],
      rooms: [
        {
          code: 'DBL-STD',
          name: 'Deluxe Standard Room',
          rates: [
            { rateKey: 'HB-1001-DBL-STD-1', rateName: 'Standard Rate', net: 120, boardCode: 'AI', boardName: 'All Inclusive', isRefundable: false },
            { rateKey: 'HB-1001-DBL-STD-2', rateName: 'Flexible Rate', net: 145, boardCode: 'AI', boardName: 'All Inclusive', isRefundable: true },
          ],
        },
        {
          code: 'SUITE',
          name: 'Executive Suite',
          rates: [
            { rateKey: 'HB-1001-SUITE-1', rateName: 'Standard Rate', net: 280, boardCode: 'AI', boardName: 'All Inclusive', isRefundable: true },
          ],
        },
      ],
    },
    {
      code: 1002,
      name: 'Titanic Mardan Palace',
      description: 'Iconic luxury palace resort in Antalya.',
      address: 'Kundu Köyü, Antalya',
      city: 'Antalya',
      country: 'Turkey',
      latitude: 36.855,
      longitude: 30.9,
      rating: 4.9,
      images: ['https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=1200'],
      facilities: ['Pool', 'Spa', 'Restaurant', 'Fitness'],
      rooms: [
        {
          code: 'DBL-STD',
          name: 'Deluxe Standard Room',
          rates: [
            { rateKey: 'HB-1002-DBL-STD-1', rateName: 'Standard Rate', net: 180, boardCode: 'BB', boardName: 'Bed & Breakfast', isRefundable: false },
          ],
        },
      ],
    },
  ],
  istanbul: [
    {
      code: 2001,
      name: 'Çırağan Palace Kempinski',
      description: 'Ottoman palace turned 5-star hotel on the Bosphorus.',
      address: 'Çırağan Cad. No:32, Beşiktaş',
      city: 'İstanbul',
      country: 'Turkey',
      latitude: 41.0459,
      longitude: 29.0183,
      rating: 4.9,
      images: ['https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=1200'],
      facilities: ['Pool', 'Spa', 'Bosphorus View', 'Fine Dining'],
      rooms: [
        {
          code: 'DBL-STD',
          name: 'Deluxe Standard Room',
          rates: [
            { rateKey: 'HB-2001-DBL-STD-1', rateName: 'Standard Rate', net: 250, boardCode: 'BB', boardName: 'Bed & Breakfast', isRefundable: true },
          ],
        },
        {
          code: 'SUITE',
          name: 'Bosphorus Suite',
          rates: [
            { rateKey: 'HB-2001-SUITE-1', rateName: 'Premium Rate', net: 550, boardCode: 'HB', boardName: 'Half Board', isRefundable: true },
          ],
        },
      ],
    },
  ],
  dubai: [
    {
      code: 3001,
      name: 'Burj Al Arab Jumeirah',
      description: 'World-famous sail-shaped luxury hotel.',
      address: 'Jumeirah Beach Road, Dubai',
      city: 'Dubai',
      country: 'UAE',
      latitude: 25.1412,
      longitude: 55.1852,
      rating: 4.9,
      images: ['https://images.unsplash.com/photo-1586351012965-861624544334?w=1200'],
      facilities: ['Pool', 'Spa', 'Private Beach', 'Helipad'],
      rooms: [
        {
          code: 'DBL-DLX',
          name: 'Deluxe Suite',
          rates: [
            { rateKey: 'HB-3001-DBL-DLX-1', rateName: 'Standard Rate', net: 1200, boardCode: 'BB', boardName: 'Bed & Breakfast', isRefundable: false },
          ],
        },
      ],
    },
  ],
  turkey: [
    {
      code: 4001,
      name: 'Maxx Royal Kemer Resort',
      description: 'Ultra-luxury all-inclusive resort in Kemer.',
      address: 'Kemer, Antalya',
      city: 'Kemer',
      country: 'Turkey',
      latitude: 36.605,
      longitude: 30.56,
      rating: 4.7,
      images: ['https://images.unsplash.com/photo-1542314831-c6a4d27ce6a2?w=1200'],
      facilities: ['Pool', 'Spa', 'All Inclusive', 'Water Park'],
      rooms: [
        {
          code: 'DBL-STD',
          name: 'Deluxe Standard Room',
          rates: [
            { rateKey: 'HB-4001-DBL-STD-1', rateName: 'Standard Rate', net: 300, boardCode: 'AI', boardName: 'All Inclusive', isRefundable: false },
          ],
        },
      ],
    },
  ],
};

export const hotelbedsService = new HotelbedsService();
