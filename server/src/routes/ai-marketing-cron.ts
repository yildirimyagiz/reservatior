import { Elysia } from "elysia";
import { cron } from "@elysiajs/cron";
import { AIEmailDrip } from "../services/marketing/ai-email-drip";
import { AIValuationEngine } from "../services/ai/ai-valuation-engine";
import { prisma } from "../lib/prisma";

export const aiMarketingCronRoutes = new Elysia({ name: "AIMarketingCron" })
  .use(
    cron({
      name: 'weekly-email-drip-campaign',
      // Runs every Monday at 09:00 AM
      pattern: '0 9 * * 1',
      async run() {
        console.log("[Cron] Triggering Weekly AI Email Drip...");
        await AIEmailDrip.runWeeklyDrip();
      }
    })
  )
  .use(
    cron({
      name: 'hourly-property-valuation',
      // Runs every hour
      pattern: '0 * * * *',
      async run() {
        console.log("[Cron] Triggering AI Property Valuations...");
        
        // Find un-evaluated properties (where no valuation exists)
        const pendingProperties = await prisma.property.findMany({
          where: { valuations: { none: {} } },
          take: 10 // Batch to avoid rate limits
        });

        for (const property of pendingProperties) {
          try {
            await AIValuationEngine.evaluateProperty(property.id);
          } catch (error) {
            console.error(`[Cron] Valuation failed for property ${property.id}`);
          }
        }
      }
    })
  );
