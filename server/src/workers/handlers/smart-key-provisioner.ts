import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleSmartKeyProvision(data: any) {
  const { viewingId, propertyId } = data;
  console.log(`[Worker: SmartKeyProvisioner] Processing VIEWING_SCHEDULED for viewingId: ${viewingId}`);

  try {
    // Fetch the property to get org locale info
    const property = await prisma.property.findFirst({
      where: propertyId ? { id: propertyId } : undefined,
      include: { org: true }
    });

    const orgId = property?.orgId || "us_seattle_org";
    const locale = property?.org?.defaultLocale || "en-US";
    const resolvedPropertyId = propertyId || property?.id || "mock-property";

    // Log: key generation started
    await prisma.userActivityLog.create({
      data: {
        userId: orgId,
        orgId,
        action: "SMART_KEY_GEN",
        entityType: "PROPERTY",
        entityId: resolvedPropertyId,
        metadata: { viewingId, doorId: "MAIN_DOOR", locale }
      }
    });

    // Simulate IoT communication latency
    await new Promise((resolve) => setTimeout(resolve, 2000));

    // Generate a random 6-digit pin
    const pinCode = Math.floor(100000 + Math.random() * 900000).toString();

    // Log: key provisioned
    await prisma.userActivityLog.create({
      data: {
        userId: orgId,
        orgId,
        action: "SMART_KEY_PROVISIONED",
        entityType: "PROPERTY",
        entityId: resolvedPropertyId,
        metadata: { viewingId, pinCode, validUntil: new Date(Date.now() + 3600000).toISOString(), locale }
      }
    });

    console.log(`[Worker: SmartKeyProvisioner] Provisioning finished. PIN: ${pinCode} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: SmartKeyProvisioner] Failed:`, error);
  }
}
