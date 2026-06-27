import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleEmergencyMaintenance(data: any) {
  const { ticketId, urgency } = data;
  console.log(`[Worker: VendorDispatcher] Processing EMERGENCY ticket: ${ticketId} with urgency: ${urgency}`);

  if (urgency !== "CRITICAL") return;

  try {
    const ticket = await prisma.maintenanceWorkOrder.findUnique({
      where: { id: ticketId },
      include: { organization: true }
    });

    if (!ticket) {
      console.log(`[Worker: VendorDispatcher] Mock ticket ${ticketId} not found, simulating success anyway.`);
    }

    // Read locale & currency from org
    const orgId = ticket?.orgId || "us_seattle_org";
    const org = ticket?.organization;
    const locale = org?.defaultLocale || "en-US";
    const currency = org?.defaultCurrency || "USD";

    // Log activity: searching for vendor
    await prisma.userActivityLog.create({
      data: {
        userId: orgId,
        orgId,
        action: "VENDOR_SEARCH_STARTED",
        entityType: "MAINTENANCE_WORK_ORDER",
        entityId: ticketId || "mock-ticket",
        metadata: { urgency, locale, currency }
      }
    });

    // Simulate search latency
    await new Promise((resolve) => setTimeout(resolve, 2500));

    // Log activity: vendor found and dispatched
    await prisma.userActivityLog.create({
      data: {
        userId: orgId,
        orgId,
        action: "VENDOR_DISPATCHED",
        entityType: "MAINTENANCE_WORK_ORDER",
        entityId: ticketId || "mock-ticket",
        metadata: { urgency, vendor: "Emergency Plumbing Co.", estimatedArrival: "20-30 min", locale, currency }
      }
    });

    console.log(`[Worker: VendorDispatcher] Dispatch finished for ticket: ${ticketId} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: VendorDispatcher] Failed processing:`, error);
  }
}
