import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleComplianceRenewal(data: any) {
  const { complianceId } = data;
  console.log(`[Worker: ComplianceRenewalAgent] Processing COMPLIANCE_EXPIRY_APPROACHING for complianceId: ${complianceId}`);

  try {
    const compliance = await prisma.propertyCompliance.findUnique({
      where: { id: complianceId },
      include: {
        property: { include: { org: true } }
      }
    });

    if (!compliance) {
      console.log(`[Worker: ComplianceRenewalAgent] Compliance ${complianceId} not found, simulating.`);
    }

    const orgId = compliance?.property?.orgId || "us_seattle_org";
    const locale = compliance?.property?.org?.defaultLocale || "en-US";
    const currency = compliance?.property?.org?.defaultCurrency || "USD";
    const propertyId = compliance?.propertyId || "mock-property";

    // Log compliance renewal started
    await prisma.userActivityLog.create({
      data: {
        userId: compliance?.property?.orgId || "system",
        orgId,
        action: "COMPLIANCE_RENEWAL_STARTED",
        entityType: "PROPERTY",
        entityId: propertyId,
        metadata: {
          complianceId,
          complianceType: compliance?.type || "GAS_SAFETY",
          locale
        }
      }
    });

    await new Promise((resolve) => setTimeout(resolve, 2000));

    // Simulate finding inspector + booking
    const inspectorBooked = true;
    const appointmentDate = new Date(Date.now() + 14 * 24 * 60 * 60 * 1000).toISOString(); // 14 days from now

    await prisma.userActivityLog.create({
      data: {
        userId: compliance?.property?.orgId || "system",
        orgId,
        action: "COMPLIANCE_INSPECTOR_BOOKED",
        entityType: "PROPERTY",
        entityId: propertyId,
        metadata: {
          complianceId,
          inspectorBooked,
          appointmentDate,
          inspectorName: "SafeCheck Ltd.",
          locale
        }
      }
    });

    console.log(`[Worker: ComplianceRenewalAgent] Inspector booked for compliance ${complianceId}. Appointment: ${appointmentDate} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: ComplianceRenewalAgent] Failed:`, error);
  }
}
