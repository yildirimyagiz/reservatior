import { cron } from "@elysiajs/cron";
import Elysia from "elysia";
import { EventDispatcher } from "../core/events/event-dispatcher";
import { runReputationDecayCron } from "./reputation-decay-cron";
import { escrowService } from "../services/escrow";
import { disputeResolver } from "../core/dispute/resolver";
import { distributionEngine } from "../services/distribution/distribution-engine";
import { demandGenerator } from "../services/demand/demand-generator";

export const cronScheduler = new Elysia({ name: "cron-scheduler" })
  // 1. LEASE_EXPIRY_APPROACHING (Runs daily at 02:00 AM)
  // For demo, we run it every 5 minutes in dev, or standard cron in prod
  .use(
    cron({
      name: "lease-renewal-check",
      pattern: process.env.NODE_ENV === "production" ? "0 2 * * *" : "*/5 * * * *",
      run() {
        console.log("[Cron] Running LEASE_EXPIRY_APPROACHING check...");
        // In a real scenario, you'd query prisma for leases expiring in exactly 60 days
        // and emit an event for each. We mock one emission for the worker.
        EventDispatcher.emit("LEASE_EXPIRY_APPROACHING", { leaseId: "mock-lease-id" });
      }
    })
  )

  // 2. RENT_PAYMENT_OVERDUE (Runs daily at 08:00 AM)
  .use(
    cron({
      name: "rent-arrears-check",
      pattern: process.env.NODE_ENV === "production" ? "0 8 * * *" : "*/6 * * * *",
      run() {
        console.log("[Cron] Running RENT_PAYMENT_OVERDUE check...");
        EventDispatcher.emit("RENT_PAYMENT_OVERDUE", { rentScheduleId: "mock-rent-schedule-id" });
      }
    })
  )

  // 3. QUARTERLY_TAX_REVIEW (Runs on the 1st of Jan, Apr, Jul, Oct)
  .use(
    cron({
      name: "quarterly-tax-review",
      pattern: process.env.NODE_ENV === "production" ? "0 0 1 1,4,7,10 *" : "*/10 * * * *",
      run() {
        console.log("[Cron] Running QUARTERLY_TAX_REVIEW...");
        const currentMonth = new Date().getMonth();
        const quarter = Math.floor(currentMonth / 3) + 1;
        EventDispatcher.emit("QUARTERLY_TAX_REVIEW", { orgId: "us_seattle_org", quarter, year: new Date().getFullYear() });
      }
    })
  )

  // 4. COMPLIANCE_EXPIRY_APPROACHING (Runs daily at 03:00 AM)
  .use(
    cron({
      name: "compliance-expiry-check",
      pattern: process.env.NODE_ENV === "production" ? "0 3 * * *" : "*/7 * * * *",
      run() {
        console.log("[Cron] Running COMPLIANCE_EXPIRY_APPROACHING check...");
        EventDispatcher.emit("COMPLIANCE_EXPIRY_APPROACHING", { complianceId: "mock-compliance-id" });
      }
    })
  )

  // 5. DOCUMENT_EXPIRED (Runs daily at 03:30 AM)
  .use(
    cron({
      name: "document-expiry-check",
      pattern: process.env.NODE_ENV === "production" ? "30 3 * * *" : "*/8 * * * *",
      run() {
        console.log("[Cron] Running DOCUMENT_EXPIRED check...");
        EventDispatcher.emit("DOCUMENT_EXPIRED", { orgId: "us_seattle_org", entityType: "LICENSE", entityId: "mock-license-id" });
      }
    })
  )

  // 6. REPUTATION DECAY (Runs daily at 04:00 AM)
  .use(
    cron({
      name: "reputation-decay",
      pattern: process.env.NODE_ENV === "production" ? "0 4 * * *" : "*/15 * * * *",
      async run() {
        console.log("[Cron] Running REPUTATION_DECAY check...");
        await runReputationDecayCron().catch(console.error);
      }
    })
  )

  // 7. ESCROW RELEASE SCHEDULER (Runs daily at 05:00 AM)
  .use(
    cron({
      name: "escrow-release-scheduler",
      pattern: process.env.NODE_ENV === "production" ? "0 5 * * *" : "*/10 * * * *",
      async run() {
        console.log("[Cron] Running ESCROW_RELEASE_SCHEDULER...");
        const regions = ["US", "TR", "UK", "DE", "FR", "AE", "SA"];
        for (const region of regions) {
          await escrowService.releaseScheduledCommissions(region).catch(console.error);
        }
      }
    })
  )

  // 8. DISPUTE DEADLINE CHECK (Runs daily at 06:00 AM)
  .use(
    cron({
      name: "dispute-deadline-check",
      pattern: process.env.NODE_ENV === "production" ? "0 6 * * *" : "*/12 * * * *",
      async run() {
        console.log("[Cron] Running DISPUTE_DEADLINE_CHECK...");
        const regions = ["US", "TR", "UK", "DE", "FR", "AE", "SA"];
        for (const region of regions) {
          const result = await disputeResolver.withRegion(region).checkDeadlines(region).catch(() => ({ escalated: 0 }));
          if (result.escalated > 0) {
            console.log(`[Cron] Escalated ${result.escalated} overdue disputes in ${region}`);
          }
        }
      }
    })
  )

  // 9. LISTING DISTRIBUTION REFRESH (Runs daily at 07:00 AM)
  .use(
    cron({
      name: "listing-distribution-refresh",
      pattern: process.env.NODE_ENV === "production" ? "0 7 * * *" : "*/20 * * * *",
      async run() {
        console.log("[Cron] Running LISTING_DISTRIBUTION_REFRESH...");
        const regions = ["US", "TR", "UK"];
        for (const region of regions) {
          await distributionEngine.distributeAllActiveListings(region).catch(console.error);
        }
      }
    })
  )

  // 10. DEMAND GENERATION (Runs daily at 09:00 AM)
  .use(
    cron({
      name: "demand-generation",
      pattern: process.env.NODE_ENV === "production" ? "0 9 * * *" : "*/25 * * * *",
      async run() {
        console.log("[Cron] Running DEMAND_GENERATION...");
        const regions = ["US", "TR", "UK", "DE", "FR"];
        for (const region of regions) {
          const recommendations = await demandGenerator.generateDemandForRegion(region, 20).catch(() => []);
          if (recommendations.length > 0) {
            console.log(`[Cron] Generated ${recommendations.length} demand recommendations for ${region}`);
          }
        }
      }
    })
  );

console.log("[CronScheduler] Registered 10 background cron jobs (5 new).");
