import { prismaManager } from "../../lib/prisma";

export class ReviewSentimentTracker {
  public static async executeFrequentReviewScan() {
    console.log("[ReviewSentimentTracker] Scanning for new unanalyzed reviews...");
    const db = prismaManager.getClient();

    try {
      // Find GuestReviews that haven't been analyzed yet
      // In a real system, you might add `isAnalyzed` to GuestReview or check AISentimentAnalysis
      // We'll simulate finding recent reviews
      const recentReviews = await db.guestReview.findMany({
        where: {
          isPublic: true,
          // We can mock the 'unanalyzed' state by taking the latest ones
          // Normally we'd do a left join or flag check
        },
        orderBy: { id: 'desc' }, // Just grab latest
        take: 10
      });

      for (const review of recentReviews) {
        // Skip if already analyzed (mock check)
        const existingAnalysis = await db.aISentimentAnalysis.findFirst({
          where: { referenceId: review.id }
        });

        if (existingAnalysis) continue;

        const text = review.comment || "";
        
        // Mock NLP sentiment calculation based on rating and some keywords
        let score = (review.rating / 5) * 100;
        let isFlagged = false;
        let categories = ["General"];

        if (text.toLowerCase().includes("terrible") || text.toLowerCase().includes("berbat") || text.toLowerCase().includes("pis")) {
          score -= 30;
          categories.push("Cleanliness Issue");
        }
        if (text.toLowerCase().includes("scam") || text.toLowerCase().includes("dolandırıcı")) {
          score -= 50;
          isFlagged = true;
          categories.push("Severe Trust Issue");
        }

        // Clamp score between 0-100
        score = Math.max(0, Math.min(100, score));
        const sentimentEnum = score > 70 ? "POSITIVE" : (score > 40 ? "NEUTRAL" : "NEGATIVE");

        // Save Analysis
        const analysis = await db.aISentimentAnalysis.create({
          data: {
            orgId: "SYSTEM",
            textAnalyzed: text,
            sentimentScore: score,
            sentiment: sentimentEnum,
            keyPhrases: categories,
            confidence: 0.88,
            referenceType: "GuestReview",
            referenceId: review.id
          }
        });

        // Host Penalty Action
        if (score < 30 || isFlagged) {
          console.log(`[ReviewSentimentTracker] ALERT: Critical negative review detected (Score: ${score}) for Property ${review.propertyId}`);
          
          // Suspend the property listing automatically
          await db.property.update({
            where: { id: review.propertyId },
            data: { status: "SUSPENDED" }
          });

          // Log Audit
          await db.auditLog.create({
            data: {
              action: "AUTO_PROPERTY_SUSPENSION",
              entityType: "Property",
              entityId: review.propertyId,
              newValues: { reason: "Abusive/Severe Negative Review", sentimentScore: score, reviewId: review.id },
              orgId: "SYSTEM"
            }
          });

          // Notify property owner / org
          // Finding the property to get owner
          const prop = await db.property.findUnique({ where: { id: review.propertyId } });
          if (prop?.organizationId) {
            await db.notification.create({
              data: {
                title: "🛑 Listing Suspended (Quality Control)",
                body: `Your property ${prop.name} was suspended due to a severe negative review triggering our AI safety thresholds. Please contact support.`,
                status: "QUEUED",
                userId: "SYSTEM",
                orgId: prop.organizationId
              }
            });
          }
        }
      }

      console.log("[ReviewSentimentTracker] Scan complete.");
    } catch (error) {
      console.error("[ReviewSentimentTracker] Error during scan:", error);
    }
  }
}
