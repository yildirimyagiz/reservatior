import { rabbitMQService } from "./rabbitmq-service";
import { prismaManager } from "../lib/prisma";
import axios from "axios";

const db = prismaManager.getClient();
const SKIPPER_API_URL = process.env.SKIPPER_API_URL || 'http://localhost:8001';

export async function initMlsConsumer() {
  await rabbitMQService.consumeQueue('mls_sync_queue', async (msg, data) => {
    console.log(`[MLS Consumer] Processing listing from connection: ${data.connectionId}, MLS Number: ${data.mlsNumber}`);
    
    try {
      // 1. Ask Skipper to analyze the MLS Data (Extract tags, estimate valuation, predict days on market)
      let skipperAnalysis = {
        valuation_estimate: data.price,
        suggested_tags: ["Standard"],
        doping_recommended: false,
        fraud_risk: 0.1
      };
      
      try {
        const response = await axios.post(`${SKIPPER_API_URL}/api/ml/analyze-mls`, {
          mls_data: data
        }, { timeout: 10000 });
        if (response.data) skipperAnalysis = response.data;
      } catch (err) {
        console.warn(`[MLS Consumer] Skipper API unavailable or failed, using defaults. Error: ${err}`);
      }

      // 2. Map and Save to Database
      // Find or Create the related Listing
      // Assuming 'data.orgId' and 'data.listingId' are provided in the payload if mapping to existing,
      // or we create a new Listing and MLSExternalListing. For simplicity we assume it's just updating MlsListingEnhancement
      // or creating an external record.
      
      if (!data.orgId || !data.connectionId) return;

      const enhancement = await db.mLSExternalListing.upsert({
        where: {
          connectionId_externalId: {
            connectionId: data.connectionId,
            externalId: data.mlsNumber
          }
        },
        update: {
          status: data.status,
          raw: { ...data, skipper_analysis: skipperAnalysis },
          lastSeenAt: new Date(),
        },
        create: {
          orgId: data.orgId,
          connectionId: data.connectionId,
          externalId: data.mlsNumber,
          status: data.status,
          raw: { ...data, skipper_analysis: skipperAnalysis },
          lastSeenAt: new Date(),
        }
      });

      console.log(`[MLS Consumer] Successfully synced and analyzed MLS Listing: ${enhancement.externalId}`);

    } catch (error) {
      console.error(`[MLS Consumer] Database or processing error for ${data.mlsNumber}:`, error);
      throw error; // This will trigger a NACK and retry if we configure it, currently the service just nacks without requeue
    }
  });
}
