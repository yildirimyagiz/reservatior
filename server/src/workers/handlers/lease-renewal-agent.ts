import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleLeaseRenewal(data: any) {
  const { leaseId } = data;
  console.log(`[Worker: LeaseRenewalAgent] Processing LEASE_EXPIRY_APPROACHING for leaseId: ${leaseId}`);

  try {
    const lease = await prisma.lease.findUnique({
      where: { id: leaseId },
      include: {
        listing: { include: { property: { include: { org: true } } } },
        tenant: true,
      }
    });

    if (!lease) {
      console.log(`[Worker: LeaseRenewalAgent] Lease ${leaseId} not found, simulating anyway.`);
    }

    const orgId = lease?.listing?.property?.orgId || "us_seattle_org";
    const locale = lease?.listing?.property?.org?.defaultLocale || "en-US";
    const currency = lease?.listing?.property?.org?.defaultCurrency || "USD";

    // Check if organization exists before creating aiServiceTask
    const org = await prisma.organization.findUnique({
      where: { id: orgId }
    });

    if (!org) {
      console.warn(`Organization ${orgId} not found, skipping aiServiceTask creation`);
      return;
    }

    // Log: renewal process started
    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        property: lease?.listing?.propertyId ? { connect: { id: lease.listing.propertyId } } : undefined,
        taskType: "CONCIERGE_DISPATCH",
        status: "PROCESSING",
        outputData: { leaseId },
        errorMessage: "trigger.lease_renewal_started"
      } as any
    });

    // Simulate AI calculating new rent (inflation + market index)
    await new Promise((resolve) => setTimeout(resolve, 2500));

    const currentRent = lease?.rent ? Number(lease.rent) : 2000;
    const inflationRate = 0.08; // 8% inflation assumption
    const proposedRent = Math.round(currentRent * (1 + inflationRate));

    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: "trigger.lease_renewal_offer_sent",
        outputData: {
          leaseId,
          currentRent,
          proposedRent,
          currency,
          locale,
          tenantEmail: lease?.tenant?.email || "tenant@example.com",
          emailDraft: `[${locale}] Dear Tenant, your lease expires in 60 days. We propose a renewal at ${currency} ${proposedRent}/month (${Math.round(inflationRate * 100)}% market adjustment).`
        }
      }
    });

    console.log(`[Worker: LeaseRenewalAgent] Renewal offer generated. ${currency} ${currentRent} → ${proposedRent} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: LeaseRenewalAgent] Failed:`, error);
  }
}
