/**
 * NWMLS (Northwest MLS) Provider
 * 
 * Seattle / Washington bölgesi için MLS entegrasyonu.
 * NWMLS'in açık JSON API'si üzerinden tek tıkla ilan çekme.
 * 
 * API Endpoint: https://listingsearch.nwmls.com/api/listings/{mlsNumber}
 * Photo Endpoint: https://listingsearch.nwmls.com/api/photo/{photoId}?imageSize=Large
 * 
 * Scraping gerektirmez — doğrudan JSON döner.
 */

import { prisma } from "../lib/prisma";
import { aiMarketingOrchestrator } from "./ai-marketing-orchestrator";
import { ListingStatus, PropertyType, MLSProviderKey } from "@prisma/client";

const NWMLS_API_BASE = "https://listingsearch.nwmls.com/api";

// ─── NWMLS API Response Types ─────────────────────────────────

interface NWMLSAgent {
  memberKeyNumericEncrypted: string | null;
  phoneNumber: string | null;
  photoURL: string | null;
  name: string | null;
  email: string | null;
  website: string | null;
}

interface NWMLSOffice {
  officeNumber: number;
  name: string | null;
  phoneNumber: string | null;
  address: string | null;
}

interface NWMLSLink {
  href: string;
  rel: string;
  method: string;
}

interface NWMLSVirtualTour {
  key: string;
  value: string;
}

interface NWMLSListing {
  listingId: string;
  listPrice: number;
  soldPrice: number | null;
  bedrooms: number;
  bathrooms: number;
  squareFeet: number;
  pricePerSqft: number;
  cdom: number;
  mlsStatus: string;
  latitude: number;
  longitude: number;
  address: string;
  city: string;
  state: string;
  zip: string;
  countyOrParish: string | null;
  propertyType: string;
  propertyTypeDescription: string | null;
  propertySubType: string | null;
  yearBuilt: number | null;
  styleCode: string | null;
  lotSizeAcres: number | null;
  lotSizeSquareFeet: number | null;
  description: string | null;
  interiorFeatures: string | null;
  heating: string | null;
  cooling: string | null;
  sewer: string | null;
  parkingTotal: number | null;
  parkingCoveredTotal: number | null;
  parkingFeatures: string | null;
  fireplacesTotal: number | null;
  fireplaceFeatures: string | null;
  taxAnnualAmount: number | null;
  hoaDues: number | null;
  hoaFrequency: string | null;
  squareFootageFinished: number | null;
  squareFootageUnfinished: number | null;
  sellingBrokerageCompensation: string | null;
  commissionType: string | null;
  waterfront: string | null;
  waterfrontYN: string | null;
  view: string | null;
  highSchoolDistrict: string | null;
  listAgent: NWMLSAgent | null;
  coListAgent: NWMLSAgent | null;
  listAgentOffice: NWMLSOffice | null;
  listAgentOfficeLogoUrl: string | null;
  links: NWMLSLink[];
  virtualTours: NWMLSVirtualTour[] | null;
  amenities: string | null;
  siteFeatures: string | null;
}

// ─── NWMLS Provider Service ───────────────────────────────────

export class NWMLSProvider {

  /**
   * NWMLS API'den tek bir ilan çeker (MLS numarası ile)
   */
  async fetchListing(mlsNumber: string): Promise<NWMLSListing> {
    const url = `${NWMLS_API_BASE}/listings/${mlsNumber}`;
    console.log(`[NWMLS] Fetching listing: ${url}`);

    const response = await fetch(url, {
      headers: {
        "Accept": "application/json",
        "User-Agent": "Reservatior/1.0"
      }
    });

    if (!response.ok) {
      throw new Error(`NWMLS API error: ${response.status} ${response.statusText}`);
    }

    const data = await response.json() as NWMLSListing;

    if (!data.listingId) {
      throw new Error(`NWMLS: Invalid listing data for MLS #${mlsNumber}`);
    }

    console.log(`[NWMLS] ✅ Fetched: MLS #${data.listingId} — ${data.address}, ${data.city} — $${data.listPrice.toLocaleString()}`);
    return data;
  }

  /**
   * NWMLS fotoğraf URL'lerini çıkarır (links array'inden)
   */
  extractPhotos(listing: NWMLSListing): { large: string[]; original: string[] } {
    const large: string[] = [];
    const original: string[] = [];

    if (listing.links) {
      for (const link of listing.links) {
        if (link.rel.startsWith("get_photo_")) {
          large.push(link.href);
        } else if (link.rel.startsWith("get_original_photo_")) {
          original.push(link.href);
        }
      }
    }

    return { large, original };
  }

  /**
   * NWMLS URL'den MLS numarasını parse eder
   * Desteklenen formatlar:
   *   - https://www.nwmls.com/what-is-the-mls/listing-search/#/listing/2232728
   *   - 2232728 (doğrudan numara)
   */
  parseMLSNumber(input: string): string {
    // Doğrudan numara mı?
    if (/^\d+$/.test(input.trim())) {
      return input.trim();
    }

    // URL'den parse et
    const hashMatch = input.match(/#\/listing\/(\d+)/);
    if (hashMatch) return hashMatch[1];

    const pathMatch = input.match(/listing\/(\d+)/);
    if (pathMatch) return pathMatch[1];

    throw new Error(`Cannot parse MLS number from input: "${input}"`);
  }

  /**
   * NWMLS property type → Reservatior property type mapping
   */
  private mapPropertyType(nwmls: NWMLSListing): PropertyType {
    const subType = (nwmls.propertySubType || "").toLowerCase();
    const propType = (nwmls.propertyType || "").toLowerCase();

    if (subType.includes("condo")) return "CONDO";
    if (subType.includes("townhouse")) return "TOWNHOUSE";
    if (subType.includes("single family")) return "HOUSE";
    if (subType.includes("multi")) return "MULTI_FAMILY";
    if (subType.includes("manufactured") || subType.includes("mobile")) return "MOBILE_HOME";
    if (propType.includes("land") || propType.includes("lot")) return "LAND";
    if (propType.includes("commercial")) return "COMMERCIAL";
    return "HOUSE"; // default for residential
  }

  /**
   * NWMLS listing status → Reservatior listing status mapping
   */
  private mapListingStatus(mlsStatus: string): ListingStatus {
    switch (mlsStatus?.toLowerCase()) {
      case "active": return "AVAILABLE";
      case "pending": return "PENDING";
      case "sold": return "SOLD";
      case "contingent": return "PENDING";
      case "expired": return "EXPIRED";
      case "withdrawn": return "WITHDRAWN";
      default: return "AVAILABLE";
    }
  }

  /**
   * sqft → m² dönüşümü
   */
  private sqftToSqm(sqft: number): number {
    return Math.round(sqft * 0.092903 * 100) / 100;
  }

  /**
   * Tek tıkla ilan import — URL veya MLS# alır, sisteme Property + Listing olarak ekler
   */
  async importListing(input: string, orgId: string, userId: string) {
    // 1. MLS numarasını parse et
    const mlsNumber = this.parseMLSNumber(input);
    console.log(`[NWMLS] 🚀 One-click import starting for MLS #${mlsNumber}`);

    // 2. Mevcut kayıt kontrolü (duplikasyon önleme)
    const existing = await prisma.mlsListingEnhancement.findFirst({
      where: { mlsNumber, orgId }
    });
    if (existing) {
      console.log(`[NWMLS] ⚠️ MLS #${mlsNumber} already imported as listing ${existing.listingId}`);
      return {
        success: false,
        error: "DUPLICATE",
        message: `MLS #${mlsNumber} is already imported`,
        listingId: existing.listingId
      };
    }

    // 3. NWMLS API'den veriyi çek
    const nwmlsData = await this.fetchListing(mlsNumber);
    const photos = this.extractPhotos(nwmlsData);

    // 4. Property oluştur
    const property = await prisma.property.create({
      data: {
        orgId,
        name: `${nwmlsData.address}, ${nwmlsData.city}`,
        notes: nwmlsData.description || "",
        listingPrice: nwmlsData.listPrice,
        addressLine1: nwmlsData.address,
        addressLine2: "",
        city: nwmlsData.city,
        country: "US",
        region: "USA_WEST",
        currency: "USD",
        bedrooms: nwmlsData.bedrooms || 0,
        bathrooms: nwmlsData.bathrooms || 0,
        areaSqm: nwmlsData.squareFeet ? this.sqftToSqm(nwmlsData.squareFeet) : 0,
        listingStatus: this.mapListingStatus(nwmlsData.mlsStatus),
        type: this.mapPropertyType(nwmlsData),
        listingType: "SALE",
        latitude: nwmlsData.latitude || null,
        longitude: nwmlsData.longitude || null,
      }
    });

    console.log(`[NWMLS] ✅ Property created: ${property.id}`);

    // 5. Listing oluştur
    const listing = await prisma.listing.create({
      data: {
        orgId,
        propertyId: property.id,
        title: `${nwmlsData.address}, ${nwmlsData.city}, ${nwmlsData.state} ${nwmlsData.zip}`,
        description: nwmlsData.description || `${nwmlsData.propertySubType || nwmlsData.propertyType} — ${nwmlsData.bedrooms} bd | ${nwmlsData.bathrooms} ba | ${nwmlsData.squareFeet?.toLocaleString()} sqft`,
        price: nwmlsData.listPrice,
        status: "DRAFT",
        type: "SALE"
      }
    });

    console.log(`[NWMLS] ✅ Listing created: ${listing.id}`);

    // 6. MLS Enhancement kaydı — gelecekte güncelleme takibi için
    await prisma.mlsListingEnhancement.create({
      data: {
        orgId,
        listingId: listing.id,
        mlsNumber,
        mlsStatus: nwmlsData.mlsStatus,
        mlsPhotos: photos.large,
        lastMlsUpdate: new Date()
      }
    });

    // 7. MLS External Listing kaydı (ham veri saklama)
    // Önce NWMLS connection var mı kontrol et, yoksa oluştur
    let connection = await prisma.mLSConnection.findFirst({
      where: { provider: "NWMLS", orgId }
    });

    if (!connection) {
      connection = await prisma.mLSConnection.create({
        data: {
          orgId,
          provider: "NWMLS" as any,
          name: "Northwest MLS (Seattle)",
          baseUrl: "https://listingsearch.nwmls.com/api",
          isEnabled: true,
          status: "IDLE"
        }
      });
    }

    await prisma.mLSExternalListing.upsert({
      where: {
        connectionId_externalId: {
          connectionId: connection.id,
          externalId: mlsNumber
        }
      },
      create: {
        orgId,
        connectionId: connection.id,
        externalId: mlsNumber,
        externalUrl: `https://www.nwmls.com/what-is-the-mls/listing-search/#/listing/${mlsNumber}`,
        raw: nwmlsData as any,
        status: "ACTIVE",
        mappedListingId: listing.id,
        lastSeenAt: new Date()
      },
      update: {
        raw: nwmlsData as any,
        mappedListingId: listing.id,
        lastSeenAt: new Date()
      }
    });

    // 8. AI Pipeline'ı tetikle (arka planda — hata olursa import başarısız olmaz)
    try {
      await aiMarketingOrchestrator.triggerStaging(property.id, orgId);
      await aiMarketingOrchestrator.triggerVideo(property.id, orgId);
      console.log(`[NWMLS] 🤖 AI pipeline triggered for property ${property.id}`);
    } catch (e) {
      console.warn("[NWMLS] AI pipeline trigger failed (non-blocking):", e);
    }

    console.log(`[NWMLS] 🎉 Import complete: MLS #${mlsNumber} → Property ${property.id} → Listing ${listing.id}`);

    return {
      success: true,
      mlsNumber,
      propertyId: property.id,
      listingId: listing.id,
      data: {
        address: `${nwmlsData.address}, ${nwmlsData.city}, ${nwmlsData.state} ${nwmlsData.zip}`,
        price: nwmlsData.listPrice,
        bedrooms: nwmlsData.bedrooms,
        bathrooms: nwmlsData.bathrooms,
        squareFeet: nwmlsData.squareFeet,
        yearBuilt: nwmlsData.yearBuilt,
        propertyType: nwmlsData.propertySubType || nwmlsData.propertyType,
        status: nwmlsData.mlsStatus,
        agent: nwmlsData.listAgent?.name || null,
        office: nwmlsData.listAgentOffice?.name || null,
        commission: nwmlsData.sellingBrokerageCompensation
          ? `${nwmlsData.sellingBrokerageCompensation}${nwmlsData.commissionType || "%"}`
          : null,
        photos: photos.large.length,
        virtualTour: nwmlsData.virtualTours?.[0]?.value || null
      }
    };
  }

  /**
   * Bir NWMLS ilanını yeniden senkronize eder (fiyat/durum güncellemesi)
   */
  async resyncListing(mlsNumber: string, orgId: string) {
    const enhancement = await prisma.mlsListingEnhancement.findFirst({
      where: { mlsNumber, orgId },
      include: { listing: true }
    });

    if (!enhancement) {
      throw new Error(`MLS #${mlsNumber} not found in system`);
    }

    const freshData = await this.fetchListing(mlsNumber);
    const photos = this.extractPhotos(freshData);

    // Listing güncelle
    await prisma.listing.update({
      where: { id: enhancement.listingId },
      data: {
        price: freshData.listPrice,
        description: freshData.description || undefined,
      }
    });

    // Property güncelle
    if (enhancement.listing?.propertyId) {
      await prisma.property.update({
        where: { id: enhancement.listing.propertyId },
        data: {
          listingPrice: freshData.listPrice,
          listingStatus: this.mapListingStatus(freshData.mlsStatus),
          notes: freshData.description || undefined,
        }
      });
    }

    // Enhancement güncelle
    await prisma.mlsListingEnhancement.update({
      where: { id: enhancement.id },
      data: {
        mlsStatus: freshData.mlsStatus,
        mlsPhotos: photos.large,
        lastMlsUpdate: new Date()
      }
    });

    console.log(`[NWMLS] 🔄 Resync complete: MLS #${mlsNumber} — $${freshData.listPrice.toLocaleString()} (${freshData.mlsStatus})`);

    return {
      success: true,
      mlsNumber,
      updated: {
        price: freshData.listPrice,
        status: freshData.mlsStatus,
        photos: photos.large.length
      }
    };
  }

  /**
   * NWMLS API önizlemesi — sisteme kaydetmeden ilan bilgisini getirir
   */
  async previewListing(input: string) {
    const mlsNumber = this.parseMLSNumber(input);
    const data = await this.fetchListing(mlsNumber);
    const photos = this.extractPhotos(data);

    return {
      mlsNumber: data.listingId,
      address: `${data.address}, ${data.city}, ${data.state} ${data.zip}`,
      price: data.listPrice,
      priceFormatted: `$${data.listPrice.toLocaleString()}`,
      bedrooms: data.bedrooms,
      bathrooms: data.bathrooms,
      squareFeet: data.squareFeet,
      pricePerSqft: data.pricePerSqft,
      yearBuilt: data.yearBuilt,
      propertyType: data.propertySubType || data.propertyType,
      style: data.styleCode,
      status: data.mlsStatus,
      daysOnMarket: data.cdom,
      lotSizeAcres: data.lotSizeAcres,
      county: data.countyOrParish,
      schoolDistrict: data.highSchoolDistrict,
      description: data.description,
      interiorFeatures: data.interiorFeatures,
      heating: data.heating,
      cooling: data.cooling,
      parking: data.parkingFeatures,
      fireplaces: data.fireplacesTotal,
      taxAnnual: data.taxAnnualAmount,
      hoaDues: data.hoaDues,
      commission: data.sellingBrokerageCompensation
        ? `${data.sellingBrokerageCompensation}${data.commissionType || "%"}`
        : null,
      agent: {
        name: data.listAgent?.name,
        phone: data.listAgent?.phoneNumber,
        email: data.listAgent?.email,
        photo: data.listAgent?.photoURL
      },
      office: {
        name: data.listAgentOffice?.name,
        phone: data.listAgentOffice?.phoneNumber,
        logo: data.listAgentOfficeLogoUrl
      },
      location: {
        latitude: data.latitude,
        longitude: data.longitude
      },
      photos: {
        count: photos.large.length,
        urls: photos.large
      },
      virtualTour: data.virtualTours?.[0]?.value || null,
      nwmlsUrl: `https://www.nwmls.com/what-is-the-mls/listing-search/#/listing/${data.listingId}`
    };
  }
}

export const nwmlsProvider = new NWMLSProvider();
