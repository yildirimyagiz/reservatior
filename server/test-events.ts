import { EventDispatcher } from "./src/core/events/event-dispatcher";
import { startWorkerPool } from "./src/workers/worker-pool";

async function runTest() {
  await startWorkerPool();

  console.log("Emitting test events...");

  // Mock a low offer
  await EventDispatcher.emit("OFFER_CREATED", { offerId: "mock-id-1" });
  
  // Mock an emergency maintenance ticket
  await EventDispatcher.emit("MAINTENANCE_CREATED", { ticketId: "mock-ticket-1", urgency: "CRITICAL" });

  // Mock Tenant Risk Scoring
  await EventDispatcher.emit("TENANT_APPLICATION_SUBMITTED", { applicationId: "mock-tenant-app-1" });

  // Mock Social Media Marketing
  await EventDispatcher.emit("PROPERTY_STATUS_CHANGED", { propertyId: "mock-prop-id-1", status: "AVAILABLE" });

  // Mock Smart Key Provisioning
  await EventDispatcher.emit("VIEWING_SCHEDULED", { viewingId: "mock-viewing-1" });

  console.log("Events emitted. Waiting for workers to process...");
  
  // Give it some time to process
  setTimeout(() => {
    console.log("Done.");
    process.exit(0);
  }, 5000);
}

runTest();
