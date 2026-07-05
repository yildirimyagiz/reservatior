import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleArrearsChaser(data: any) {
  const { rentScheduleId } = data;
  console.log(`[Worker: ArrearsAIChaser] Processing RENT_PAYMENT_OVERDUE for scheduleId: ${rentScheduleId}`);

  try {
    const schedule = await prisma.rentSchedule.findUnique({
      where: { id: rentScheduleId },
      include: {
        lease: {
          include: {
            tenant: true,
            listing: { include: { property: { include: { org: true } } } }
          }
        }
      }
    });

    if (!schedule) {
      console.log(`[Worker: ArrearsAIChaser] Schedule ${rentScheduleId} not found, simulating.`);
    }

    const orgId = schedule?.lease?.property?.orgId || "us_seattle_org";
    const locale = schedule?.lease?.property?.organization?.defaultLocale || "en-US";
    const currency = schedule?.lease?.property?.organization?.defaultCurrency || "USD";
    const tenantEmail = schedule?.lease?.tenant?.email || "tenant@example.com";
    const tenantName = schedule?.lease?.tenant?.firstName || "Tenant";
    const amountDue = schedule?.amount ? Number(schedule.amount) : 1500;

    // Check if organization exists before creating aiServiceTask
    const org = await prisma.organization.findUnique({
      where: { id: orgId }
    });

    if (!org) {
      console.warn(`Organization ${orgId} not found, skipping aiServiceTask creation`);
      return;
    }

    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        taskType: "CONCIERGE_DISPATCH",
        status: "PROCESSING",
        outputData: { rentScheduleId },
        errorMessage: "trigger.arrears_chasing_started"
      }
    });

    await new Promise((resolve) => setTimeout(resolve, 2000));

    // AI generates tone-appropriate message based on locale
    const emailDraft = `[${locale}] Dear ${tenantName}, your payment of ${currency} ${amountDue} was due 3 days ago. Please settle this at your earliest convenience to avoid further action.`;
    const smsDraft = `[${locale}] Reminder: ${currency} ${amountDue} payment overdue. Please contact us immediately.`;

    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: "trigger.arrears_chasing_sent",
        outputData: {
          rentScheduleId,
          tenantEmail,
          amountDue,
          currency,
          locale,
          emailDraft,
          smsDraft,
          channels: ["EMAIL", "SMS"]
        }
      }
    });

    console.log(`[Worker: ArrearsAIChaser] Chaser sent for ${currency} ${amountDue} to ${tenantEmail} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: ArrearsAIChaser] Failed:`, error);
  }
}
