import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleTaxAnomalyDetection(data: any) {
  const { orgId, quarter, year } = data;
  console.log(`[Worker: TaxAnomalyDetector] Processing QUARTERLY_TAX_REVIEW for org: ${orgId}, Q${quarter} ${year}`);

  try {
    const org = await prisma.organization.findUnique({ where: { id: orgId } });

    const locale = org?.defaultLocale || "en-US";
    const currency = org?.defaultCurrency || "USD";

    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        taskType: "FINANCIAL_EXTRACTION",
        status: "PROCESSING",
        outputData: { orgId, quarter, year },
        errorMessage: "trigger.tax_review_started"
      }
    });

    await new Promise((resolve) => setTimeout(resolve, 3500));

    // Simulate AI scanning payment + expense records for anomalies
    const totalRevenue = 125000;
    const totalExpenses = 48000;
    const potentialDeductions = 12500;
    const anomaliesFound = 2;

    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: anomaliesFound > 0 ? "trigger.tax_anomalies_found" : "trigger.tax_review_clean",
        outputData: {
          orgId,
          quarter,
          year,
          locale,
          currency,
          totalRevenue,
          totalExpenses,
          potentialDeductions,
          anomaliesFound,
          anomalies: [
            { type: "DUPLICATE_EXPENSE", amount: 3200, description: "Possible duplicate maintenance invoice" },
            { type: "UNCLAIMED_DEDUCTION", amount: 9300, description: "Office equipment depreciation unclaimed" }
          ],
          reportGeneratedAt: new Date().toISOString()
        }
      }
    });

    // Write to audit log
    await prisma.auditLog.create({
      data: {
        orgId,
        action: "TAX_ANOMALY_SCAN",
        entityType: "ORGANIZATION",
        entityId: orgId,
        newValues: { quarter, year, anomaliesFound, potentialDeductions, currency }
      }
    });

    console.log(`[Worker: TaxAnomalyDetector] Q${quarter} ${year} scan complete. Anomalies: ${anomaliesFound}, Potential deductions: ${currency} ${potentialDeductions}`);
  } catch (error) {
    console.error(`[Worker: TaxAnomalyDetector] Failed:`, error);
  }
}
