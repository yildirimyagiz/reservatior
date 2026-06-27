import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleDocumentExpiry(data: any) {
  const { orgId, entityType, entityId } = data;
  console.log(`[Worker: DocumentExpiryRevoker] Processing DOCUMENT_EXPIRED for ${entityType}: ${entityId}`);

  try {
    const org = await prisma.organization.findUnique({ where: { id: orgId } });
    const locale = org?.defaultLocale || "en-US";

    // Find all active listings belonging to this org
    const affectedProperties = await prisma.property.findMany({
      where: {
        orgId,
        status: "AVAILABLE"
      },
      select: { id: true, title: true }
    });

    if (affectedProperties.length === 0) {
      console.log(`[Worker: DocumentExpiryRevoker] No active listings to suspend for org: ${orgId}`);
      return;
    }

    // Suspend all active listings
    await prisma.property.updateMany({
      where: {
        id: { in: affectedProperties.map((p) => p.id) },
        orgId
      },
      data: { status: "SUSPENDED" }
    });

    // Log to activity log
    await prisma.activityLog.create({
      data: {
        organization: { connect: { id: orgId } },
        action: "LISTINGS_SUSPENDED_DOCUMENT_EXPIRY",
        description: "trigger.document_expired_listings_suspended",
        entityType: entityType || "ORGANIZATION",
        entityId: entityId || orgId,
        metadata: {
          suspendedCount: affectedProperties.length,
          suspendedPropertyIds: affectedProperties.map((p) => p.id),
          reason: `${entityType} document expired. All active listings suspended automatically.`,
          locale
        }
      }
    });

    // Log audit trail
    await prisma.auditLog.create({
      data: {
        orgId,
        action: "LISTINGS_AUTO_SUSPENDED",
        entityType: "PROPERTY",
        entityId: orgId,
        newValues: {
          suspendedCount: affectedProperties.length,
          reason: "DOCUMENT_EXPIRED",
          triggeredAt: new Date().toISOString()
        }
      }
    });

    console.log(`[Worker: DocumentExpiryRevoker] Suspended ${affectedProperties.length} listings for org: ${orgId} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: DocumentExpiryRevoker] Failed:`, error);
  }
}
