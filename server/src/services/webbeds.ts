import axios, { AxiosInstance } from 'axios';

export interface WebbedsSearchParams {
  destination: string;
  checkIn: string;
  checkOut: string;
  guests: number;
  rooms?: number;
  nationality?: string;
  currency?: string;
}

export interface WebbedsHotel {
  hotelId: string;
  hotelName: string;
  description?: string;
  address?: string;
  city?: string;
  country?: string;
  latitude?: number;
  longitude?: number;
  rating?: number;
  category?: string;
  images?: string[];
  facilities?: string[];
}

export interface WebbedsRoom {
  roomId: string;
  roomName: string;
  maxGuests?: number;
  bedType?: string;
  images?: string[];
}

export interface WebbedsRate {
  rateId: string;
  rateName?: string;
  netPrice: number;
  grossPrice?: number;
  boardCode?: string;
  boardName?: string;
  cancellationPolicy?: string;
  isRefundable?: boolean;
  currency?: string;
  allotment?: number;
}

export interface WebbedsBookingRequest {
  hotelId: string;
  checkIn: string;
  checkOut: string;
  rooms: {
    rateId: string;
    guests: { type: 'ADULT' | 'CHILD'; age?: number; firstName?: string; lastName?: string }[];
  }[];
  holder: { firstName: string; lastName: string; email?: string };
  payment?: { method: 'VCC' | 'BANK_TRANSFER' | 'INVOICE'; vcc?: string };
}

export class WebbedsService {
  private api: AxiosInstance;
  private apiKey: string;
  private apiSecret: string;

  constructor() {
    this.apiKey = process.env.WEBBEDS_API_KEY || '';
    this.apiSecret = process.env.WEBBEDS_API_SECRET || '';
    const baseURL = process.env.WEBBEDS_API_URL || 'https://api.webbeds.com/v3';

    this.api = axios.create({ baseURL, timeout: 15000 });
    this.api.interceptors.request.use((config) => {
      config.headers['X-API-Key'] = this.apiKey;
      config.headers['X-API-Secret'] = this.apiSecret;
      config.headers['Accept'] = 'application/json';
      config.headers['Content-Type'] = 'application/json';
      return config;
    });
  }

  get isConfigured(): boolean {
    return !!(this.apiKey && this.apiSecret);
  }

  async searchHotels(params: WebbedsSearchParams) {
    if (!this.isConfigured) return this.getMockResults(params);

    try {
      const payload = {
        destination: params.destination,
        checkIn: params.checkIn,
        checkOut: params.checkOut,
        occupancy: [{ rooms: params.rooms || 1, adults: params.guests, children: 0 }],
        currency: params.currency || 'USD',
        nationality: params.nationality || 'TR',
      };

      const response = await this.api.post('/hotel/search', payload);
      return this.normalizeSearchResponse(response.data);
    } catch (error: any) {
      console.warn('[WEBBEDS] API call failed, falling back to mock:', error.message);
      return this.getMockResults(params);
    }
  }

  async checkPrice(rateId: string, checkIn: string, checkOut: string) {
    if (!this.isConfigured) {
      return { netPrice: 100, grossPrice: 112, currency: 'USD', rateId };
    }

    try {
      const response = await this.api.post('/hotel/price', { rateId, checkIn, checkOut });
      return response.data;
    } catch (error: any) {
      console.error('[WEBBEDS] checkPrice failed:', error.message);
      throw error;
    }
  }

  async createBooking(request: WebbedsBookingRequest) {
    if (!this.isConfigured) {
      return {
        bookingId: `WB-DEMO-${Math.random().toString(36).slice(2, 8).toUpperCase()}`,
        status: 'CONFIRMED',
        providerReference: `WB-REF-${Date.now()}`,
      };
    }

    try {
      const response = await this.api.post('/hotel/book', request);
      return response.data;
    } catch (error: any) {
      console.error('[WEBBEDS] Booking failed:', error.message);
      throw error;
    }
  }

  async getBookingDetails(bookingId: string) {
    try {
      const response = await this.api.get(`/hotel/booking/${bookingId}`);
      return response.data;
    } catch (error: any) {
      console.error('[WEBBEDS] getBookingDetails failed:', error.message);
      throw error;
    }
  }

  async cancelBooking(bookingId: string) {
    try {
      const response = await this.api.delete(`/hotel/booking/${bookingId}`);
      return response.data;
    } catch (error: any) {
      console.error('[WEBBEDS] cancelBooking failed:', error.message);
      throw error;
    }
  }

  async getCancellationPolicy(bookingId: string) {
    try {
      const response = await this.api.get(`/hotel/booking/${bookingId}/cancellation`);
      return response.data;
    } catch (error: any) {
      console.error('[WEBBEDS] getCancellationPolicy failed:', error.message);
      throw error;
    }
  }

  private normalizeSearchResponse(data: any) {
    const hotels = data?.hotels ?? [];
    return hotels.map((h: any) => ({
      hotelId: h.hotelId || h.id,
      hotelName: h.hotelName || h.name,
      description: h.description,
      address: h.address,
      city: h.city,
      country: h.country,
      latitude: h.latitude,
      longitude: h.longitude,
      rating: h.rating || h.starRating,
      images: (h.images ?? []).map((i: any) => (typeof i === 'string' ? i : i.url || i.path)),
      facilities: (h.facilities ?? []).map((f: any) => (typeof f === 'string' ? f : f.name)),
      rooms: (h.rooms ?? []).map((r: any) => ({
        roomId: r.roomId || r.id,
        roomName: r.roomName || r.name,
        maxGuests: r.maxGuests || r.maxOccupancy,
        rates: (r.rates ?? []).map((rate: any) => ({
          rateId: rate.rateId || rate.id,
          rateName: rate.rateName || rate.name,
          netPrice: rate.netPrice || rate.net,
          grossPrice: rate.grossPrice || rate.gross,
          boardCode: rate.boardCode || rate.board,
          boardName: rate.boardName || rate.boardName,
          isRefundable: rate.isRefundable ?? rate.refundable,
          currency: rate.currency || 'USD',
          cancellationPolicy: rate.cancellationPolicy,
        })),
      })),
    }));
  }

  private async getMockResults(params: WebbedsSearchParams) {
    await new Promise((r) => setTimeout(r, 600));
    const region = this.matchDestination(params.destination);
    if (!region) return [];

    const hotels = MOCK_WEBBEDS_HOTELS[region] ?? [];
    return hotels;
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

const MOCK_WEBBEDS_HOTELS: Record<string, any[]> = {
  antalya: [
    {
      hotelId: 'WB-ANT-101',
      hotelName: 'Maxx Royal Belek Golf Resort',
      description: 'Ultra luxurious golf resort in Belek.',
      address: 'İskele Mevkii, Belek',
      city: 'Antalya',
      country: 'Turkey',
      latitude: 36.8523,
      longitude: 31.0665,
      rating: 4.9,
      images: ['https://images.unsplash.com/photo-1542314831-c6a4d27ce6a2?w=1200'],
      facilities: ['Pool', 'Golf Course', 'Sea View', 'Spa'],
      rooms: [
        {
          roomId: 'WB-ANT-101-DBL',
          roomName: 'Deluxe Golf View Room',
          maxGuests: 3,
          rates: [
            { rateId: 'WB-ANT-101-DBL-STD', rateName: 'Standard Rate', netPrice: 210, grossPrice: 235, boardCode: 'AI', boardName: 'All Inclusive', isRefundable: false, currency: 'USD' },
            { rateId: 'WB-ANT-101-DBL-FLX', rateName: 'Flexible Rate', netPrice: 250, grossPrice: 280, boardCode: 'AI', boardName: 'All Inclusive', isRefundable: true, currency: 'USD' },
          ],
        },
      ],
    },
    {
      hotelId: 'WB-ANT-102',
      hotelName: 'Kempinski Hotel The Dome Belek',
      description: 'Luxury beachfront resort with private marina.',
      address: 'Türkler Mahallesi, Belek',
      city: 'Antalya',
      country: 'Turkey',
      latitude: 36.848,
      longitude: 31.081,
      rating: 4.7,
      images: ['https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=1200'],
      facilities: ['Pool', 'Spa', 'Marina', 'Fine Dining'],
      rooms: [
        {
          roomId: 'WB-ANT-102-DBL',
          roomName: 'Deluxe Sea View Room',
          maxGuests: 2,
          rates: [
            { rateId: 'WB-ANT-102-DBL-STD', rateName: 'Standard Rate', netPrice: 160, grossPrice: 179, boardCode: 'BB', boardName: 'Bed & Breakfast', isRefundable: true, currency: 'USD' },
          ],
        },
      ],
    },
  ],
  istanbul: [
    {
      hotelId: 'WB-IST-101',
      hotelName: 'The Peninsula Istanbul',
      description: 'Spectacular new luxury property in Galataport.',
      address: 'Karaköy, Beyoğlu',
      city: 'İstanbul',
      country: 'Turkey',
      latitude: 41.0251,
      longitude: 28.9784,
      rating: 4.8,
      images: ['https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=1200'],
      facilities: ['Pool', 'Spa', 'Bosphorus View', 'Fitness', 'Michelin Restaurant'],
      rooms: [
        {
          roomId: 'WB-IST-101-STD',
          roomName: 'Standard Room',
          maxGuests: 2,
          rates: [
            { rateId: 'WB-IST-101-STD-1', rateName: 'Standard Rate', netPrice: 310, grossPrice: 347, boardCode: 'BB', boardName: 'Bed & Breakfast', isRefundable: true, currency: 'USD' },
          ],
        },
        {
          roomId: 'WB-IST-101-SUI',
          roomName: 'Bosphorus Suite',
          maxGuests: 3,
          rates: [
            { rateId: 'WB-IST-101-SUI-1', rateName: 'Premium Rate', netPrice: 680, grossPrice: 762, boardCode: 'HB', boardName: 'Half Board', isRefundable: true, currency: 'USD' },
          ],
        },
      ],
    },
  ],
  bodrum: [
    {
      hotelId: 'WB-BOD-101',
      hotelName: 'Mandarin Oriental Bodrum',
      description: 'Luxury hillside resort overlooking the Aegean.',
      address: 'Kızılburun Mevkii, Bodrum',
      city: 'Bodrum',
      country: 'Turkey',
      latitude: 37.034,
      longitude: 27.432,
      rating: 4.9,
      images: ['https://images.unsplash.com/photo-1566915341058-3f12b8e1b5d2?w=1200'],
      facilities: ['Pool', 'Spa', 'Private Beach', 'Water Sports'],
      rooms: [
        {
          roomId: 'WB-BOD-101-DBL',
          roomName: 'Deluxe Sea View Room',
          maxGuests: 2,
          rates: [
            { rateId: 'WB-BOD-101-DBL-STD', rateName: 'Standard Rate', netPrice: 430, grossPrice: 482, boardCode: 'BB', boardName: 'Bed & Breakfast', isRefundable: true, currency: 'USD' },
          ],
        },
      ],
    },
  ],
  turkey: [
    {
      hotelId: 'WB-TR-101',
      hotelName: 'Rixos Premium Belek',
      description: 'Luxury resort with private beach and exclusive amenities.',
      address: 'İleribaşı Mevkii, Belek',
      city: 'Antalya',
      country: 'Turkey',
      latitude: 36.8524,
      longitude: 31.066,
      rating: 4.8,
      images: ['https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1200'],
      facilities: ['Pool', 'Spa', 'Beachfront', 'All Inclusive'],
      rooms: [
        {
          roomId: 'WB-TR-101-DBL',
          roomName: 'Deluxe Standard Room',
          maxGuests: 2,
          rates: [
            { rateId: 'WB-TR-101-DBL-STD', rateName: 'Standard Rate', netPrice: 130, grossPrice: 145, boardCode: 'AI', boardName: 'All Inclusive', isRefundable: false, currency: 'USD' },
          ],
        },
      ],
    },
  ],
  dubai: [
    {
      hotelId: 'WB-DXB-101',
      hotelName: 'Atlantis The Palm',
      description: 'Iconic resort on the Palm Jumeirah.',
      address: 'Palm Jumeirah, Dubai',
      city: 'Dubai',
      country: 'UAE',
      latitude: 25.1317,
      longitude: 55.1167,
      rating: 4.8,
      images: ['https://images.unsplash.com/photo-1586351012965-861624544334?w=1200'],
      facilities: ['Pool', 'Aquaventure', 'Spa', 'Dolphin Bay'],
      rooms: [
        {
          roomId: 'WB-DXB-101-DBL',
          roomName: 'Deluxe Ocean View Room',
          maxGuests: 2,
          rates: [
            { rateId: 'WB-DXB-101-DBL-STD', rateName: 'Standard Rate', netPrice: 350, grossPrice: 392, boardCode: 'BB', boardName: 'Bed & Breakfast', isRefundable: true, currency: 'USD' },
          ],
        },
      ],
    },
  ],
};

export const webbedsService = new WebbedsService();
