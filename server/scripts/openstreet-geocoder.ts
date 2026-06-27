import PrismaManager from "../src/lib/prisma-manager";

PrismaManager.init();

interface GeocodeRequest {
  address: string;
  city: string;
  state: string;
  propertyId: string;
}

class OpenStreetGeocoder {
  private client: ReturnType<typeof PrismaManager.getClient>;

  constructor() {
    this.client = PrismaManager.getClient("US");
  }

  /**
   * OpenStreetMap Nominatim API kullanarak ücretsiz geocoding
   * Rate limit: 1000 request/saat (resmi)
   */
  async batchGeocode(requests: GeocodeRequest[]): Promise<void> {
    console.log(`🗺️ Starting OpenStreetMap geocoding for ${requests.length} addresses...`);
    
    const BATCH_SIZE = 50; // Nominatim limiti
    let successCount = 0;

    for (let i = 0; i < requests.length; i += BATCH_SIZE) {
      const batch = requests.slice(i, i + BATCH_SIZE);
      console.log(`\n📍 Processing batch ${Math.floor(i/BATCH_SIZE) + 1}/${Math.ceil(requests.length/BATCH_SIZE)} (${batch.length} addresses)`);
      
      try {
        await this.processBatch(batch);
        successCount += batch.length;
        
        // Rate limiting - 2 saniye bekle
        await new Promise(resolve => setTimeout(resolve, 2000));
        
      } catch (error) {
        console.error(`❌ Batch ${Math.floor(i/BATCH_SIZE) + 1} failed:`, error);
      }
    }

    console.log(`\n✅ OpenStreetMap geocoding complete: ${successCount}/${requests.length} addresses processed`);
  }

  private async processBatch(batch: GeocodeRequest[]): Promise<void> {
    // OpenStreetMap Nominatim API'sini kullan
    const geocodePromises = batch.map(async (request) => {
      const fullAddress = `${request.address}, ${request.city}, ${request.state}`;
      const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(fullAddress)}&limit=1`;
      
      try {
        const response = await fetch(url, {
          headers: {
            'User-Agent': 'RealEstateScraper/1.0'
          }
        });
        const data = await response.json();
        
        if (data && data.length > 0) {
          const location = data[0];
          
          // Property'yi güncelle
          await this.client.property.update({
            where: { id: request.propertyId },
            data: {
              lat: parseFloat(location.lat),
              lng: parseFloat(location.lon)
            }
          });
          
          console.log(`✅ Geocoded: ${request.address} → ${location.lat}, ${location.lon}`);
        } else {
          console.log(`⚠️ Failed to geocode: ${request.address}`);
        }
      } catch (error) {
        console.error(`❌ Error geocoding ${request.address}:`, error);
      }
    });

    await Promise.allSettled(geocodePromises);
  }

  /**
   * Mevcut properties'leri OpenStreetMap ile geocode yap
   */
  async updateExistingProperties() {
    console.log("🔄 Starting OpenStreetMap geocoding for existing properties...");
    
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
  const geocoder = new OpenStreetGeocoder();
  await geocoder.updateExistingProperties();
}

main().catch(console.error).finally(() => PrismaManager.disconnectAll());
