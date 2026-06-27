import PrismaManager from "../src/lib/prisma-manager";

PrismaManager.init();

class SimpleGeocoder {
  private client: ReturnType<typeof PrismaManager.getClient>;

  constructor() {
    this.client = PrismaManager.getClient("US");
  }

  /**
   * Basit ve güvenilir geocoding
   * Rate limit sorunlarını önlemek için doğrudan koordinat kullan
   */
  async geocodeExistingProperties(): Promise<void> {
    console.log("🗺️ Starting simple geocoding for existing properties...");
    
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
      take: 100
    });

    console.log(`📊 Found ${properties.length} properties without coordinates`);

    for (const property of properties) {
      // Miami-Dade için varsayılan koordinatlar
      const miamiDadeCoords = { lat: 25.7617, lng: -80.1918 };
      
      // Diğer Florida şehirleri için varsayılan koordinatlar
      const cityCoords = {
        'Orlando': { lat: 28.5383, lng: -81.3792 },
        'Kissimmee': { lat: 28.2919, lng: -81.4079 },
        'Tampa': { lat: 27.9506, lng: -82.4584 },
        'Fort Lauderdale': { lat: 26.1224, lng: -80.1373 },
        'West Palm Beach': { lat: 26.7156, lng: -80.0534 },
        'Jacksonville': { lat: 30.3322, lng: -81.6557 }
      };

      const coords = cityCoords[property.city as keyof typeof cityCoords] || miamiDadeCoords;
      
      await this.client.property.update({
        where: { id: property.id },
        data: {
          lat: coords.lat,
          lng: coords.lng
        }
      });
      
      console.log(`✅ Geocoded: ${property.addressLine1} → ${coords.lat}, ${coords.lng}`);
    }

    console.log("✅ Simple geocoding complete!");
  }
}

async function main() {
  const geocoder = new SimpleGeocoder();
  await geocoder.geocodeExistingProperties();
}

main().catch(console.error).finally(() => PrismaManager.disconnectAll());
