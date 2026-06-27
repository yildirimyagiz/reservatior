import PrismaManager from "../src/lib/prisma";

interface GeocodeRequest {
  address: string;
  city: string;
  state: string;
  propertyId: string;
}

class BulkGeocoder {
  private client: ReturnType<typeof PrismaManager.getClient>;
  private googleMapsApiKey: string;

  constructor() {
    this.client = PrismaManager.getClient("US");
    this.googleMapsApiKey = process.env.GOOGLE_DRIVE_API_KEY || process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || "";
  }

  /**
   * Google Maps API rate limit'ini aşmak için batch geocoding
   * 100 adresi tek seferde işler
   */
  async batchGeocode(requests: GeocodeRequest[]): Promise<void> {
    if (!this.googleMapsApiKey) {
      console.log('❌ Google Maps API key not found');
      return;
    }

    console.log(`🗺️ Starting batch geocoding for ${requests.length} addresses...`);
    
    const BATCH_SIZE = 100; // Google Maps limiti
    let successCount = 0;

    for (let i = 0; i < requests.length; i += BATCH_SIZE) {
      const batch = requests.slice(i, i + BATCH_SIZE);
      console.log(`\n📍 Processing batch ${Math.floor(i/BATCH_SIZE) + 1}/${Math.ceil(requests.length/BATCH_SIZE)} (${batch.length} addresses)`);
      
      try {
        await this.processBatch(batch);
        successCount += batch.length;
        
        // Rate limiting - 1 saniye bekle
        await new Promise(resolve => setTimeout(resolve, 1000));
        
      } catch (error) {
        console.error(`❌ Batch ${Math.floor(i/BATCH_SIZE) + 1} failed:`, error);
      }
    }

    console.log(`\n✅ Batch geocoding complete: ${successCount}/${requests.length} addresses processed`);
  }

  private async processBatch(batch: GeocodeRequest[]): Promise<void> {
    // Google Maps Geocoding API'sini kullan
    const geocodePromises = batch.map(async (request) => {
      const fullAddress = `${request.address}, ${request.city}, ${request.state}`;
      const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(fullAddress)}&key=${this.googleMapsApiKey}`;
        
        try {
          const response = await fetch(url);
          const data = await response.json();
          
          if (data.status === 'OK' && data.results && data.results.length > 0) {
            const location = data.results[0].geometry.location;
            
            // Property'yi güncelle
            await this.client.property.update({
              where: { id: request.propertyId },
              data: {
                lat: location.lat,
                lng: location.lng
              }
            });
            
            console.log(`✅ Geocoded: ${request.address} → ${location.lat}, ${location.lng}`);
          } else {
            console.log(`⚠️ Failed to geocode: ${request.address} (${data.status || 'No results'})`);
          }
        } catch (error) {
          console.error(`❌ Error geocoding ${request.address}:`, error);
        }
    });

    await Promise.allSettled(geocodePromises);
  }

  /**
   * Mevcut properties'leri batch geocode yap
   */
  async updateExistingProperties() {
    console.log("🔄 Starting batch geocoding for existing properties...");
    
    const properties = await this.client.property.findMany({
      where: {
        lat: null, // Koordinatı olmayanları bul
        region: "USA"
      },
      select: {
        id: true,
        addressLine1: true,
        city: true,
        state: true
      },
      take: 1000 // İlk 1000 mülk
    });

    console.log(`📊 Found ${properties.length} properties without coordinates`);

    const requests: GeocodeRequest[] = properties.map((property: { addressLine1: any; city: any; state: any; id: any; }) => ({
      address: property.addressLine1 || '',
      city: property.city || '',
      state: property.state || '',
      propertyId: property.id
    }));

    await this.batchGeocode(requests);
  }
}

async function main() {
  const geocoder = new BulkGeocoder();
  await geocoder.updateExistingProperties();
}

main().catch(console.error).finally(() => PrismaManager.disconnectAll());
