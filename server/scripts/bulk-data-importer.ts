import { PropertyType, ListingStatus, ListingType, PropertyCategory, OwnershipVerificationStatus, VerificationMethod } from "@prisma/client";
import PrismaManager from "../src/lib/prisma-manager";

PrismaManager.init();

interface BulkPropertyRecord {
  folio: string;
  address: string;
  city: string;
  ownerName: string;
  marketValue: number;
  yearBuilt: number;
  sqft: number;
  lat?: number;
  lng?: number;
}

class BulkDataImporter {
  private client: ReturnType<typeof PrismaManager.getClient>;
  private googleMapsApiKey: string;

  constructor() {
    this.client = PrismaManager.getClient("US");
    this.googleMapsApiKey = process.env.GOOGLE_DRIVE_API_KEY || process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || "";
  }

  async geocodeAddress(address: string): Promise<{ lat: number; lng: number }> {
    if (!this.googleMapsApiKey) {
      return { lat: 25.7617, lng: -80.1918 };
    }

    try {
      const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address + ', Miami, FL')}&key=${this.googleMapsApiKey}`;
      const response = await fetch(url);
      const data = await response.json();

      if (data.status === 'OK' && data.results && data.results.length > 0) {
        const location = data.results[0].geometry.location;
        return { lat: location.lat, lng: location.lng };
      }
      return { lat: 25.7617, lng: -80.1918 };
    } catch (error) {
      return { lat: 25.7617, lng: -80.1918 };
    }
  }

  /**
   * Miami-Dade bulk data simülasyonu
   * Gerçek uygulamada https://bbs.miamidadepa.gov/ üzerinden CSV/Excel indirilecek
   */
  async importBulkData() {
    console.log("📦 Starting bulk data import for Miami-Dade County...");
    
    // Simüle edilmiş bulk data (gerçek uygulamada dosyadan okunacak)
    const bulkData: BulkPropertyRecord[] = [
      {
        folio: "30-1234-001-0001",
        address: "1001 Brickell Ave",
        city: "Miami",
        ownerName: "Brickell Holdings LLC",
        marketValue: 1250000,
        yearBuilt: 2019,
        sqft: 2500
      },
      {
        folio: "30-1234-002-0002",
        address: "500 Brickell Key Dr",
        city: "Miami",
        ownerName: "Key Island Properties LLC",
        marketValue: 2100000,
        yearBuilt: 2021,
        sqft: 3200
      },
      {
        folio: "30-1234-003-0003",
        address: "1200 Brickell Bay Dr",
        city: "Miami",
        ownerName: "Bay View Investments Inc",
        marketValue: 1800000,
        yearBuilt: 2020,
        sqft: 2800
      },
      {
        folio: "30-2234-001-0001",
        address: "1 Ocean Dr",
        city: "Miami Beach",
        ownerName: "Oceanfront Realty Trust",
        marketValue: 3500000,
        yearBuilt: 2018,
        sqft: 4000
      },
      {
        folio: "30-2234-002-0002",
        address: "500 Collins Ave",
        city: "Miami Beach",
        ownerName: "Collins Ave Holdings LLC",
        marketValue: 2800000,
        yearBuilt: 2017,
        sqft: 3500
      }
    ];

    const orgId = "seed-global-org-master";
    let successCount = 0;

    for (const record of bulkData) {
      try {
        console.log(`\n📍 Processing: ${record.address}`);
        
        const coordinates = await this.geocodeAddress(record.address);
        console.log(`🗺️ Geocoded: ${coordinates.lat}, ${coordinates.lng}`);

        const uniqueId = `bulk-${record.folio.replace(/-/g, '')}`;

        await this.client.property.upsert({
          where: { id: uniqueId },
          update: {},
          create: {
            id: uniqueId,
            orgId: orgId,
            name: `${record.city}, FL Premium Property`,
            type: PropertyType.APARTMENT,
            region: "USA",
            currency: "USD",
            addressLine1: record.address,
            city: record.city,
            state: "FL",
            zip: "33131",
            country: "US",
            lat: coordinates.lat,
            lng: coordinates.lng,
            listingPrice: record.marketValue,
            listingType: ListingType.SALE,
            listingStatus: ListingStatus.AVAILABLE,
            propertyCategory: PropertyCategory.RESIDENTIAL
          }
        });

        await this.client.taxRecord.upsert({
          where: { id: `tax-bulk-${uniqueId}` },
          update: {},
          create: {
            id: `tax-bulk-${uniqueId}`,
            propertyId: uniqueId,
            orgId: orgId,
            recordType: "PROPERTY_TAX",
            profileData: {
              assessor: "Miami-Dade Property Appraiser",
              parcelNumber: record.folio,
              lastAssessedValue: record.marketValue,
              ownerOfRecord: record.ownerName,
              taxYear: 2025,
              status: "ACTIVE",
              dataSource: "BULK_IMPORT"
            }
          }
        });

        await this.client.propertyOwnershipVerification.upsert({
          where: { id: `verif-bulk-${uniqueId}` },
          update: {},
          create: {
            id: `verif-bulk-${uniqueId}`,
            propertyId: uniqueId,
            orgId: orgId,
            verificationStatus: OwnershipVerificationStatus.PENDING,
            verificationMethod: VerificationMethod.GOVERNMENT_API,
            parcelNumber: record.folio,
            jurisdiction: "Miami-Dade County",
            aiConfidenceScore: 95.0,
            ownershipHistory: [{ owner: record.ownerName, type: "Bulk Data Import" }]
          }
        });

        console.log(`✅ Imported: ${record.address} (Folio: ${record.folio})`);
        successCount++;

        // Rate limiting
        await new Promise(resolve => setTimeout(resolve, 1000));

      } catch (error) {
        console.error(`❌ Error importing ${record.address}:`, error);
      }
    }

    console.log(`\n🎉 Bulk import complete: ${successCount}/${bulkData.length} properties imported`);
    return successCount;
  }
}

async function main() {
  const importer = new BulkDataImporter();
  await importer.importBulkData();
}

main().catch(console.error).finally(() => PrismaManager.disconnectAll());
