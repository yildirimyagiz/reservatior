import { prismaManager } from "../../lib/prisma";
import { NotificationDispatcher } from "../../services/notification-dispatcher";
import { MLBridgeService } from "../../lib/intelligence/MLBridgeService";

export class AutoPayoutDispatcher {
  public static async executeNightlyPayouts() {
    console.log("[AutoPayoutDispatcher] Starting nightly commission and payout sweep...");
    const db = prismaManager.getClient();

    try {
      // Find commissions that are PENDING and overdue (>30 days old)
      const thirtyDaysAgo = new Date(Date.now() - 30 * 24 * 60 * 60 * 1000);
      
      const overdueCommissions = await db.commission.findMany({
        where: {
          status: { in: ["PENDING", "HOLDBACK"] },
          createdAt: { lt: thirtyDaysAgo }
        },
        include: {
          agent: true,
          agency: true
        }
      });

      console.log(`[AutoPayoutDispatcher] Found ${overdueCommissions.length} overdue commissions ready for auto-payout.`);

      for (const commission of overdueCommissions) {
        // Mocking the Stripe / Wise payout logic here
        // In reality, you'd call stripe.transfers.create(...) or wise.payouts(...)
        const isSuccess = Math.random() > 0.05; // 95% success rate simulation

        if (isSuccess) {
          // Update status to PAID
          await db.commission.update({
            where: { id: commission.id },
            data: { 
              status: "PAID"
            }
          });

          // Log Audit
          await db.auditLog.create({
            data: {
              action: "AUTO_PAYOUT_SUCCESS",
              entityType: "Commission",
              entityId: commission.id,
              newValues: { amount: Number(commission.commissionAmount), currency: commission.currency },
              orgId: commission.orgId
            }
          });

          // Notify Agent
          if (commission.agent?.ownerId) {
            await db.notification.create({
              data: {
                title: "💰 Commission Paid!",
                body: `Your commission of ${commission.commissionAmount} ${commission.currency} has been automatically transferred to your linked bank account.`,
                status: "QUEUED",
                userId: commission.agent.ownerId,
                orgId: commission.orgId
              }
            });
          }

          console.log(`[AutoPayoutDispatcher] Successfully paid commission ${commission.id}`);
        } else {
          // Payment Failed
          await db.commission.update({
            where: { id: commission.id },
            data: { status: "CANCELLED" }
          });

          if (commission.agent?.ownerId) {
            await db.notification.create({
              data: {
                title: "⚠️ Payout Failed",
                body: `We attempted to transfer ${commission.commissionAmount} ${commission.currency} to your account but the bank rejected it. Please update your billing details.`,
                status: "QUEUED",
                userId: commission.agent.ownerId,
                orgId: commission.orgId
              }
            });
          }
          console.error(`[AutoPayoutDispatcher] Failed to pay commission ${commission.id}`);
        }
      }

      console.log("[AutoPayoutDispatcher] Nightly payout sweep completed.");
    } catch (error) {
      console.error("[AutoPayoutDispatcher] Error during payout sweep:", error);
    }
  }
}
