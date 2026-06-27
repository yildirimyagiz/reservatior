import { cron } from "@elysiajs/cron";
import Elysia from "elysia";
import { EventDispatcher } from "../core/events/event-dispatcher";

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
  );

console.log("[CronScheduler] Registered background cron jobs.");
