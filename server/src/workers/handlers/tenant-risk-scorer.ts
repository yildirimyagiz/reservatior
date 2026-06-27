import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleTenantRiskScoring(data: any) {
  const { applicationId } = data;
  console.log(`[Worker: TenantRiskScorer] Processing TENANT_APPLICATION_SUBMITTED for ID: ${applicationId}`);

  try {
    const application = await prisma.tenantApplication.findUnique({
      where: { id: applicationId },
      include: { organization: true }
    });

    if (!application) {
      console.log(`[Worker: TenantRiskScorer] Mock application ${applicationId} not found, simulating anyway and returning early.`);
      return;
    }

    // Determine target orgId.
    const orgId = application?.organizationId || "us_seattle_org";
    const locale = application?.organization?.defaultLocale || "en-US";

    // Create an AI task indicating background check / risk scoring has begun
    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        taskType: "FINANCIAL_EXTRACTION", 
        status: "PROCESSING",
        outputData: { applicationId },
        errorMessage: "trigger.tenant_analysis_started"
      }
    });

    // Simulate AI latency
    await new Promise((resolve) => setTimeout(resolve, 3000));

    // Mock risk assessment
    const income = application?.annualIncome ? Number(application.annualIncome) : 60000;
    const creditScore = application?.creditScore ? Number(application.creditScore) : 650;
    
    let decision = "REVIEW";
    let message = "trigger.tenant_review";

    if (creditScore >= 700 && income >= 80000) {
      decision = "APPROVE";
      message = "trigger.tenant_approved";
    } else if (creditScore < 600) {
      decision = "REJECT";
      message = "trigger.tenant_rejected";
    }

    // Complete the task
    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: message,
        outputData: { decision, creditScore, income, riskScore: 85 }
      }
    });

    console.log(`[Worker: TenantRiskScorer] Finished processing with decision: ${decision}`);
  } catch (error) {
    console.error(`[Worker: TenantRiskScorer] Failed:`, error);
  }
}
