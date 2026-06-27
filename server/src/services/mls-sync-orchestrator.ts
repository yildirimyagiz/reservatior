import { prisma } from "../lib/prisma";
import { neuralImporterService } from "./neural-importer";
import { aiMarketingOrchestrator } from "./ai-marketing-orchestrator";
import { MLSProviderKey, SyncStatus } from "@prisma/client";

export class MLSSyncOrchestrator {
  /**
   * Orchestrates a sync job for a specific MLS connection
   */
  async triggerSync(connectionId: string, orgId: string) {
    const connection = await prisma.mLSConnection.findUnique({
      where: { id: connectionId }
    });

    if (!connection) throw new Error("MLS Connection not found");

    // Create sync job record
    const job = await prisma.mLSSyncJob.create({
      data: {
        orgId,
        connectionId,
        status: "RUNNING",
        startedAt: new Date(),
      }
    });

    try {
      console.log(`[MLS-SYNC] Starting sync for ${connection.provider} (${connection.name})`);
      
      let results;
      switch (connection.provider as string) {
        case "ZILLOW":
        case "REDFIN":
        case "IDEALISTA":
        case "RIGHTMOVE":
          // Use Neural Importer (Puppeteer/Scraper based) for sites without easy API
          results = await this.syncViaScraper(connection);
          break;
        case "BRIDGE_API":
        case "SPARK_API":
        case "GENERIC_RETS":
          // Use real API clients (Simulated for now)
          results = await this.syncViaAPI(connection);
          break;
        default:
          results = await this.syncViaScraper(connection);
      }

      // Update job with stats
      await prisma.mLSSyncJob.update({
        where: { id: job.id },
        data: {
          status: "SUCCESS",
          finishedAt: new Date(),
          stats: {
            totalProcessed: results.processed,
            newlyAdded: results.added,
            updated: results.updated,
            errors: results.errors
          }
        }
      });

      // Update connection status
      await prisma.mLSConnection.update({
        where: { id: connectionId },
        data: {
          status: "IDLE",
          lastSyncAt: new Date()
        }
      });

      return { success: true, jobId: job.id, stats: results };

    } catch (error) {
      console.error(`[MLS-SYNC] Sync failed for ${connection.id}:`, error);
      
      await prisma.mLSSyncJob.update({
        where: { id: job.id },
        data: {
          status: "FAILED",
          finishedAt: new Date(),
          error: error instanceof Error ? error.message : String(error)
        }
      });

      await prisma.mLSConnection.update({
        where: { id: connectionId },
        data: {
          status: "FAILED",
          lastError: error instanceof Error ? error.message : String(error)
        }
      });

      throw error;
    }
  }

  private async syncViaScraper(connection: any) {
    if (!connection.baseUrl) throw new Error("Base URL required for scraping sync");
    
    // In a real scenario, we'd iterate through pages
    // For demo, we just import the main URL
    const importResult = await neuralImporterService.importFromUrl(connection.baseUrl);
    
    if (!importResult.success) {
      return { processed: 1, added: 0, updated: 0, errors: 1 };
    }

    // Create external listing record
    await prisma.mLSExternalListing.upsert({
      where: {
        connectionId_externalId: {
          connectionId: connection.id,
          externalId: importResult.data.source.url || Date.now().toString()
        }
      },
      create: {
        orgId: connection.orgId,
        connectionId: connection.id,
        externalId: importResult.data.source.url || Date.now().toString(),
        externalUrl: importResult.data.source.url,
        raw: importResult.data as any,
        status: "ACTIVE",
        lastSeenAt: new Date()
      },
      update: {
        raw: importResult.data as any,
        lastSeenAt: new Date()
      }
    });

    return { processed: 1, added: 1, updated: 0, errors: 0 };
  }

  private async syncViaAPI(connection: any) {
    // Placeholder for actual RETS/Web API logic
    // We'll simulate finding 5 listings
    const mockListings = [
      { id: "mls_101", title: "Luxury Penthouse", price: 1250000, zip: "BH90210" },
      { id: "mls_102", title: "Modern Studio", price: 450000, zip: "NYC10001" },
      { id: "mls_103", title: "Seaside Villa", price: 2100000, zip: "MIA33101" }
    ];

    for (const listing of mockListings) {
      await prisma.mLSExternalListing.upsert({
        where: {
          connectionId_externalId: {
            connectionId: connection.id,
            externalId: listing.id
          }
        },
        create: {
          orgId: connection.orgId,
          connectionId: connection.id,
          externalId: listing.id,
          raw: listing as any,
          status: "ACTIVE",
          lastSeenAt: new Date()
        },
        update: {
          raw: listing as any,
          lastSeenAt: new Date()
        }
      });
    }

    return { processed: mockListings.length, added: mockListings.length, updated: 0, errors: 0 };
  }

  /**
   * Converts an external MLS listing into a full platform Property and Listing
   */
  async convertToLocalListing(externalListingId: string, orgId: string, userId: string) {
    const external = await prisma.mLSExternalListing.findUnique({
      where: { id: externalListingId }
    });

    if (!external) throw new Error("External listing not found");

    const raw = external.raw as any;
    
    // 1. Create Property
    const property = await prisma.property.create({
      data: {
        orgId,
        name: raw.title || `MLS Property ${external.externalId}`,
        notes: raw.description || raw.title,
        listingPrice: raw.price?.amount || raw.price || 0,
        addressLine1: raw.location?.address || "MLS Imported Address",
        city: raw.location?.city || "Unknown",
        addressLine2: "",
        country: raw.location?.country || "US",
        region: "USA_WEST",
        currency: "USD",
        bedrooms: raw.property?.bedrooms || 0,
        bathrooms: raw.property?.bathrooms || 0,
        areaSqm: raw.property?.area?.value || 0,
        listingStatus: "AVAILABLE",
        type: "APARTMENT", // Default or map from raw
        listingType: "SALE"
      }
    });

    // 2. Create Listing linked to Property
    const listing = await prisma.listing.create({
      data: {
        orgId,
        propertyId: property.id,
        title: property.name,
        description: property.notes,
        price: property.listingPrice,
        status: "DRAFT",
        type: "SALE"
      }
    });

    // 3. Create MLS Enhancement record for tracking
    await prisma.mlsListingEnhancement.create({
      data: {
        orgId,
        listingId: listing.id,
        mlsNumber: external.externalId,
        mlsStatus: external.status,
        mlsPhotos: (raw.media?.images as any) || [],
        lastMlsUpdate: external.updatedAt
      }
    });

    // 4. Update the external listing with the mapped ID
    await prisma.mLSExternalListing.update({
      where: { id: externalListingId },
      data: { mappedListingId: listing.id }
    });

    // 5. Trigger Neural Suite (AI Staging & Video)
    try {
      await aiMarketingOrchestrator.triggerStaging(property.id, orgId);
      await aiMarketingOrchestrator.triggerVideo(property.id, orgId);
    } catch (e) {
      console.warn("[MLS-CONVERT] AI Trigger failed:", e);
    }

    return { 
      success: true, 
      propertyId: property.id, 
      listingId: listing.id,
      message: "Successfully migrated MLS listing to Reservatior Platform" 
    };
  }
}

export const mLSSyncOrchestrator = new MLSSyncOrchestrator();
