import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleInvoiceOcrVerification(data: any) {
  const { invoiceId } = data;
  console.log(`[Worker: InvoiceOCRVerifier] Processing INVOICE_UPLOADED for invoiceId: ${invoiceId}`);

  try {
    const invoice = await prisma.financialRecord.findUnique({
      where: { id: invoiceId },
      include: { org: true }
    });

    if (!invoice) {
      console.log(`[Worker: InvoiceOCRVerifier] Invoice ${invoiceId} not found, simulating.`);
    }

    const orgId = invoice?.orgId || "us_seattle_org";
    const locale = invoice?.org?.defaultLocale || "en-US";
    const currency = invoice?.org?.defaultCurrency || "USD";

    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        taskType: "FINANCIAL_EXTRACTION",
        status: "PROCESSING",
        outputData: { invoiceId },
        errorMessage: "trigger.invoice_ocr_started"
      }
    });

    await new Promise((resolve) => setTimeout(resolve, 2500));

    // Simulate OCR read + budget comparison
    const invoiceAmount = invoice?.amount ? Number(invoice.amount) : 1800;
    const budgetAmount = 1500; // Simulated VendorTask budget
    const isOverBudget = invoiceAmount > budgetAmount * 1.1; // >10% over = dispute
    const variance = invoiceAmount - budgetAmount;

    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: isOverBudget ? "trigger.invoice_dispute_raised" : "trigger.invoice_verified_ok",
        outputData: {
          invoiceId,
          invoiceAmount,
          budgetAmount,
          variance,
          currency,
          locale,
          status: isOverBudget ? "DISPUTED" : "APPROVED",
          disputeReason: isOverBudget
            ? `Invoice exceeds approved budget by ${currency} ${variance}. Auto-dispute initiated.`
            : null
        }
      }
    });

    console.log(
      `[Worker: InvoiceOCRVerifier] Invoice ${invoiceId} → ${isOverBudget ? "DISPUTED" : "APPROVED"} | variance: ${currency} ${variance} | locale: ${locale}`
    );
  } catch (error) {
    console.error(`[Worker: InvoiceOCRVerifier] Failed:`, error);
  }
}
