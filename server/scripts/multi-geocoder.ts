import PrismaManager from "../src/lib/prisma-manager";

PrismaManager.init();

interface GeocodeRequest {
  address: string;
  city: string;
  state: string;
  propertyId: string;
}

interface GeocodeResult {
  lat: number;
  lng: number;
  source: string;
}

class MultiGeocoder {
  private client: ReturnType<typeof PrismaManager.getClient>;
  private apis: {
    openstreet: string;
    here: string;
    mapbox: string;
    bing: string;
  };

  constructor() {
    this.client = PrismaManager.getClient("US");
    this.apis = {
      openstreet: process.env.OPENSTREET_API_KEY || "",
      here: process.env.HERE_API_KEY || "",
      mapbox: process.env.MAPBOX_TOKEN || "",
      bing: process.env.BING_API_KEY || ""
    };
  }

  async geocodeWithOpenStreet(address: string): Promise<GeocodeResult | null> {
    try {
      const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(address)}&limit=1`;
      const response = await fetch(url, {
        headers: { 'User-Agent': 'RealEstateScraper/1.0' }
      });
      const data = await response.json();
      
      if (data && data.length > 0) {
        const location = data[0];
        return {
          lat: parseFloat(location.lat),
          lng: parseFloat(location.lon),
          source: "OpenStreetMap"
        };
      }
      return null;
    } catch (error) {
      console.error(`OpenStreetMap error:`, error);
      return null;
    }
  }

  async geocodeWithHere(address: string): Promise<GeocodeResult | null> {
    if (!this.apis.here) return null;
    
    try {
      const url = `https://geocode.search.hereapi.com/6.2/geocode.json?searchtext=${encodeURIComponent(address)}&apiKey=${this.apis.here}`;
      const response = await fetch(url);
      const data = await response.json();
      
      if (data.Response && data.Response.View && data.Response.View.length > 0) {
        const location = data.Response.View[0].Result[0].Location;
        return {
          lat: parseFloat(location.Latitude),
          lng: parseFloat(location.Longitude),
          source: "HERE Maps"
        };
      }
      return null;
    } catch (error) {
      console.error(`HERE Maps error:`, error);
      return null;
    }
  }

  async geocodeWithMapbox(address: string): Promise<GeocodeResult | null> {
    if (!this.apis.mapbox) return null;
    
    try {
      const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${encodeURIComponent(address)}.json?access_token=${this.apis.mapbox}`;
      const response = await fetch(url);
      const data = await response.json();
      
      if (data.features && data.features.length > 0) {
        const location = data.features[0].center;
        return {
          lat: parseFloat(location[1]),
          lng: parseFloat(location[0]),
          source: "Mapbox"
        };
      }
      return null;
    } catch (error) {
      console.error(`Mapbox error:`, error);
      return null;
    }
  }

  async geocodeWithBing(address: string): Promise<GeocodeResult | null> {
    if (!this.apis.bing) return null;
    
    try {
      const url = `https://dev.virtualearth.net/v1/locations/${encodeURIComponent(address)}.json?key=${this.apis.bing}`;
      const response = await fetch(url);
      const data = await response.json();
      
      if (data.resourceSets && data.resourceSets.length > 0) {
        const location = data.resourceSets[0].resources[0].locations[0].point.coordinates;
        return {
          lat: parseFloat(location[0]),
          lng: parseFloat(location[1]),
          source: "Bing Maps"
        };
      }
      return null;
    } catch (error) {
      console.error(`Bing Maps error:`, error);
      return null;
    }
  }

  async geocodeAddress(request: GeocodeRequest): Promise<GeocodeResult | null> {
    const fullAddress = `${request.address}, ${request.city}, ${request.state}`;
    
    // Önce OpenStreetMap dene (ücretsiz)
    let result = await this.geocodeWithOpenStreet(fullAddress);
    if (result) {
      console.log(`✅ OpenStreetMap: ${request.address} → ${result.lat}, ${result.lng}`);
      return result;
    }

    // Sonra HERE Maps dene
    result = await this.geocodeWithHere(fullAddress);
    if (result) {
      console.log(`✅ HERE Maps: ${request.address} → ${result.lat}, ${result.lng}`);
      return result;
    }

    // Sonra Mapbox dene
    result = await this.geocodeWithMapbox(fullAddress);
    if (result) {
      console.log(`✅ Mapbox: ${request.address} → ${result.lat}, ${result.lng}`);
      return result;
    }

    // Son olarak Bing Maps dene
    result = await this.geocodeWithBing(fullAddress);
    if (result) {
      console.log(`✅ Bing Maps: ${request.address} → ${result.lat}, ${result.lng}`);
      return result;
    }

    console.log(`❌ All geocoding services failed for: ${request.address}`);
    return null;
  }

  async batchGeocode(requests: GeocodeRequest[]): Promise<void> {
    console.log(`🗺️ Starting multi-API geocoding for ${requests.length} addresses...`);
    
    const BATCH_SIZE = 25; // Daha küçük batch - rate limit yönetimi
    let successCount = 0;

    for (let i = 0; i < requests.length; i += BATCH_SIZE) {
      const batch = requests.slice(i, i + BATCH_SIZE);
      console.log(`\n📍 Processing batch ${Math.floor(i/BATCH_SIZE) + 1}/${Math.ceil(requests.length/BATCH_SIZE)} (${batch.length} addresses)`);
      
      try {
        await this.processBatch(batch);
        successCount += batch.length;
        
        // Rate limiting - 3 saniye bekle
        await new Promise(resolve => setTimeout(resolve, 3000));
        
      } catch (error) {
        console.error(`❌ Batch ${Math.floor(i/BATCH_SIZE) + 1} failed:`, error);
      }
    }

    console.log(`\n✅ Multi-API geocoding complete: ${successCount}/${requests.length} addresses processed`);
  }

  private async processBatch(batch: GeocodeRequest[]): Promise<void> {
    const geocodePromises = batch.map(async (request) => {
      const result = await this.geocodeAddress(request);
      
      if (result) {
        // Property'yi güncelle
        await this.client.property.update({
          where: { id: request.propertyId },
          data: {
            lat: result.lat,
            lng: result.lng
          }
        });
        
        console.log(`✅ Geocoded: ${request.address} → ${result.lat}, ${result.lng} (${result.source})`);
      } else {
        console.log(`⚠️ Failed to geocode: ${request.address}`);
      }
    });

    await Promise.allSettled(geocodePromises);
  }

  async updateExistingProperties() {
    console.log("🔄 Starting multi-API geocoding for existing properties...");
    
    const properties = await this.client.property.findMany({
      where: {
        lat: null,
        region: "USA"
      },
      select: {
        id: true,
        addressLine1: true,
        city: true,
        state: true
      },
      take: 500 // İlk 500 mülk
    });

    console.log(`📊 Found ${properties.length} properties without coordinates`);
    console.log(`🔑 Available APIs: OpenStreetMap ✓, HERE Maps ${this.apis.here ? '✓' : '✗'}, Mapbox ${this.apis.mapbox ? '✓' : '✗'}, Bing Maps ${this.apis.bing ? '✓' : '✗'}`);

    const requests: GeocodeRequest[] = properties.map(property => ({
      address: property.addressLine1 || '',
      city: property.city || '',
      state: property.state || '',
      propertyId: property.id
    }));

    await this.batchGeocode(requests);
  }
}

async function main() {
  const geocoder = new MultiGeocoder();
  await geocoder.updateExistingProperties();
}

main().catch(console.error).finally(() => PrismaManager.disconnectAll());
