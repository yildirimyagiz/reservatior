import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleSmartContractGeneration(data: any) {
  const { applicationId } = data;
  console.log(`[Worker: SmartContractGenerator] Processing TENANT_APPLICATION_APPROVED for applicationId: ${applicationId}`);

  try {
    const application = await prisma.tenantApplication.findUnique({
      where: { id: applicationId },
      include: {
        property: { include: { org: true } },
        organization: true
      }
    });

    if (!application) {
      console.log(`[Worker: SmartContractGenerator] Application ${applicationId} not found, simulating.`);
    }

    const orgId = application?.organizationId || "us_seattle_org";
    const locale = application?.organization?.defaultLocale || "en-US";
    const currency = application?.organization?.defaultCurrency || "USD";

    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        property: application?.propertyId ? { connect: { id: application.propertyId } } : undefined,
        taskType: "DOCUMENT_PROCESSING",
        status: "PROCESSING",
        outputData: { applicationId },
        errorMessage: "trigger.contract_generation_started"
      } as any
    });

    await new Promise((resolve) => setTimeout(resolve, 3000));

    // Simulate contract generation + e-signature dispatch
    const contractRef = `CONTRACT-${Date.now()}`;

    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: "trigger.contract_sent_for_signature",
        outputData: {
          applicationId,
          contractRef,
          locale,
          currency,
          signatureRequestSent: true,
          signatureProvider: "DocuSign",
          generatedAt: new Date().toISOString()
        }
      }
    });

    // Also log to activity log
    await prisma.userActivityLog.create({
      data: {
        userId: orgId,
        orgId,
        action: "CONTRACT_GENERATED",
        entityType: "TENANT_APPLICATION",
        entityId: applicationId || "mock-application",
        metadata: { contractRef, locale }
      }
    });

    console.log(`[Worker: SmartContractGenerator] Contract ${contractRef} generated and sent for e-signature | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: SmartContractGenerator] Failed:`, error);
  }
}
