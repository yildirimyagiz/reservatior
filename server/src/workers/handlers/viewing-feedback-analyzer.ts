import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleViewingFeedbackAnalysis(data: any) {
  const { viewingId, feedbackText } = data;
  console.log(`[Worker: ViewingFeedbackAnalyzer] Processing VIEWING_COMPLETED for viewingId: ${viewingId}`);

  try {
    const viewing = await prisma.propertyViewing.findUnique({
      where: { id: viewingId },
      include: {
        property: { include: { org: true } }
      }
    });

    if (!viewing && !feedbackText) {
      console.log(`[Worker: ViewingFeedbackAnalyzer] Viewing ${viewingId} not found, simulating.`);
    }

    const orgId = viewing?.property?.orgId || "us_seattle_org";
    const propertyId = viewing?.propertyId || "mock-property";
    const locale = viewing?.property?.org?.defaultLocale || "en-US";
    const textToAnalyze = feedbackText || viewing?.feedbackNotes || "The kitchen is too small and the price is a bit high.";

    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        property: viewing?.propertyId ? { connect: { id: propertyId } } : undefined,
        taskType: "SENTIMENT_ANALYSIS",
        status: "PROCESSING",
        outputData: { viewingId },
        errorMessage: "trigger.feedback_analysis_started"
      } as any
    });

    await new Promise((resolve) => setTimeout(resolve, 2000));

    // Simulate NLP analysis
    const sentiment = "NEGATIVE";
    const insights = [
      { topic: "KITCHEN", concern: "Too small", impact: "HIGH" },
      { topic: "PRICE", concern: "Above market perception", impact: "MEDIUM" }
    ];
    const recommendation = "Consider highlighting the recently renovated bathroom to offset kitchen concerns, or review pricing strategy.";

    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: "trigger.feedback_analysis_completed",
        outputData: {
          viewingId,
          textAnalyzed: textToAnalyze,
          sentiment,
          insights,
          recommendation,
          locale
        }
      }
    });

    // Write to activity log
    await prisma.userActivityLog.create({
      data: {
        userId: orgId,
        orgId,
        action: "VIEWING_FEEDBACK_ANALYZED",
        entityType: "PROPERTY",
        entityId: propertyId,
        metadata: { viewingId, sentiment, insightsCount: insights.length, locale }
      }
    });

    console.log(`[Worker: ViewingFeedbackAnalyzer] Analysis complete. Sentiment: ${sentiment} | locale: ${locale}`);
  } catch (error) {
    console.error(`[Worker: ViewingFeedbackAnalyzer] Failed:`, error);
  }
}
