import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleSecurityAlertEscalation(data: any) {
  const { incidentId } = data;
  console.log(`[Worker: SecurityAlertEscalator] Processing SECURITY_INCIDENT_CREATED for incidentId: ${incidentId}`);

  try {
    const incident = await prisma.securityIncident.findUnique({
      where: { id: incidentId },
      include: {
        property: { include: { org: true } }
      }
    });

    if (!incident) {
      console.log(`[Worker: SecurityAlertEscalator] Incident ${incidentId} not found, simulating.`);
    }

    const orgId = incident?.property?.orgId || "us_seattle_org";
    const locale = incident?.property?.org?.defaultLocale || "en-US";
    const riskLevel = incident?.severity || "HIGH";
    const propertyId = incident?.propertyId || "mock-property";

    // Only escalate HIGH risk
    if (riskLevel !== "HIGH" && riskLevel !== "CRITICAL") {
      console.log(`[Worker: SecurityAlertEscalator] Incident ${incidentId} is ${riskLevel} — no escalation needed.`);
      return;
    }

    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        property: incident?.propertyId ? { connect: { id: propertyId } } : undefined,
        taskType: "CONCIERGE_DISPATCH",
        status: "PROCESSING",
        outputData: { incidentId, riskLevel },
        errorMessage: "trigger.security_escalation_started"
      } as any
    });

    await new Promise((resolve) => setTimeout(resolve, 1500));

    // Simulate notifying owner + security firm
    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: "trigger.security_escalation_notified",
        outputData: {
          incidentId,
          riskLevel,
          locale,
          notified: ["PROPERTY_OWNER", "SECURITY_FIRM"],
          channels: ["SMS", "VOICE_CALL"],
          securityFirmDispatched: true,
          dispatchedAt: new Date().toISOString()
        }
      }
    });

    await prisma.userActivityLog.create({
      data: {
        userId: orgId,
        orgId,
        action: "SECURITY_ESCALATED",
        entityType: "SECURITY_INCIDENT",
        entityId: incidentId || "mock-incident",
        metadata: { riskLevel, locale, channels: ["SMS", "VOICE_CALL"] }
      }
    });

    console.log(`[Worker: SecurityAlertEscalator] Escalation complete for incident: ${incidentId} | risk: ${riskLevel} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: SecurityAlertEscalator] Failed:`, error);
  }
}
