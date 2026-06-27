/**
 * Yandex Maps Integration Service
 * Provides geocoding and map functionality for Turkey/Russia regions
 */

export interface YandexGeocodeResult {
  lat: number;
  lon: number;
  address: string;
  formattedAddress: string;
}

export interface YandexSearchParams {
  text: string;
  lang?: string;
  apiKey?: string;
}

export class YandexMapsService {
  private apiKey: string;
  private geocoderApiKey: string;
  private javascriptApiKey: string;

  constructor() {
    this.apiKey = process.env.YANDEX_MAPS_API_KEY || '';
    this.geocoderApiKey = process.env.YANDEX_GEOCODER_API_KEY || '';
    this.javascriptApiKey = process.env.YANDEX_JAVASCRIPT_API_KEY || '';

    if (!this.apiKey) {
      console.warn('⚠️ Yandex Maps API key not configured');
    }
  }

  /**
   * Geocode an address to coordinates
   */
  async geocode(address: string, lang: string = 'tr_TR'): Promise<YandexGeocodeResult | null> {
    try {
      const url = `https://geocode-maps.yandex.ru/1.x/?apikey=${this.geocoderApiKey}&geocode=${encodeURIComponent(address)}&lang=${lang}&format=json`;
      
      const response = await fetch(url);
      const data = await response.json();

      if (data.response?.GeoObjectCollection?.featureMember?.length > 0) {
        const geoObject = data.response.GeoObjectCollection.featureMember[0].GeoObject;
        const pos = geoObject.Point.pos.split(' ');
        
        return {
          lat: parseFloat(pos[1]),
          lon: parseFloat(pos[0]),
          address: geoObject.name,
          formattedAddress: geoObject.description || geoObject.name,
        };
      }

      return null;
    } catch (error) {
      console.error('Yandex geocoding error:', error);
      return null;
    }
  }

  /**
   * Reverse geocode coordinates to address
   */
  async reverseGeocode(lat: number, lon: number, lang: string = 'tr_TR'): Promise<string | null> {
    try {
      const url = `https://geocode-maps.yandex.ru/1.x/?apikey=${this.geocoderApiKey}&geocode=${lon},${lat}&lang=${lang}&format=json`;
      
      const response = await fetch(url);
      const data = await response.json();

      if (data.response?.GeoObjectCollection?.featureMember?.length > 0) {
        const geoObject = data.response.GeoObjectCollection.featureMember[0].GeoObject;
        return geoObject.description || geoObject.name;
      }

      return null;
    } catch (error) {
      console.error('Yandex reverse geocoding error:', error);
      return null;
    }
  }

  /**
   * Search for places
   */
  async search(params: YandexSearchParams): Promise<any[]> {
    try {
      const { text, lang = 'tr_TR', apiKey } = params;
      const key = apiKey || this.apiKey;
      
      const url = `https://search-maps.yandex.ru/v1/?apikey=${key}&text=${encodeURIComponent(text)}&lang=${lang}&results=10`;
      
      const response = await fetch(url);
      const data = await response.json();

      return data.features || [];
    } catch (error) {
      console.error('Yandex search error:', error);
      return [];
    }
  }

  /**
   * Get static map image URL
   */
  getStaticMapUrl(params: {
    center: string; // "lon,lat"
    zoom?: number;
    size?: string; // "width,height"
    lang?: string;
  }): string {
    const { center, zoom = 12, size = '600,400', lang = 'tr_TR' } = params;
    return `https://static-maps.yandex.ru/1.x/?ll=${center}&z=${zoom}&l=map&size=${size}&lang=${lang}&apikey=${this.apiKey}`;
  }

  /**
   * Get JavaScript API configuration for frontend
   */
  getJavaScriptConfig() {
    return {
      apiKey: this.javascriptApiKey,
      lang: 'tr_TR',
      coordorder: 'longlat', // or 'latlong'
      load: 'package.full', // or 'package.standard'
    };
  }

  /**
   * Validate API keys are configured
   */
  isConfigured(): boolean {
    return !!(this.apiKey && this.geocoderApiKey && this.javascriptApiKey);
  }
}

// Export singleton instance
export const yandexMapsService = new YandexMapsService();
