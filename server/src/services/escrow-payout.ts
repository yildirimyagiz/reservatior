import { prisma } from "../lib/prisma";
import { addDays, isPast } from "date-fns";

export class EscrowPayoutService {
  
  /**
   * Schedules an escrow release date for a commission or payment.
   * Default wait time is 21 days for security.
   */
  async scheduleEscrowRelease(commissionId: string, gateway: string, daysToWait = 21) {
    try {
      const releaseDate = addDays(new Date(), daysToWait);
      
      const updated = await prisma.commission.update({
        where: { id: commissionId },
        data: {
          gateway,
          escrowReleaseDate: releaseDate,
          payoutStatus: "PENDING"
        }
      });
      
      console.log(`[Escrow] Commission ${commissionId} scheduled for release on ${releaseDate.toISOString()}`);
      return { success: true, data: updated };
    } catch (error: any) {
      console.error("[Escrow] Error scheduling release:", error.message);
      return { success: false, error: error.message };
    }
  }

  /**
   * Cron-job friendly function to find all due payments in escrow 
   * and process them to the beneficiaries.
   */
  async processDuePayouts() {
    try {
      // Find all commissions where escrowReleaseDate is in the past and status is PENDING
      const dueCommissions = await prisma.commission.findMany({
        where: {
          payoutStatus: "PENDING",
          escrowReleaseDate: {
            lte: new Date()
          }
        },
        include: {
          agent: true,
          org: true
        }
      });

      console.log(`[Escrow] Found ${dueCommissions.length} commissions due for payout.`);

      const results = [];

      for (const commission of dueCommissions) {
        try {
          // 1. Process payout via Stripe Connect or PayTR SubMerchant API
          if (commission.gateway === "STRIPE") {
            console.log(`Processing Stripe Payout for commission ${commission.id}...`);
            // await stripeService.transferToConnectedAccount(...)
          } else if (commission.gateway === "PAYTR") {
            console.log(`Processing PayTR Payout for commission ${commission.id}...`);
            // await payTRService.transferToSubMerchant(...)
          } else {
            console.log(`Processing generic payout for commission ${commission.id}...`);
          }

          // 2. Mark as RELEASED
          await prisma.commission.update({
            where: { id: commission.id },
            data: {
              payoutStatus: "RELEASED"
            }
          });

          results.push({ id: commission.id, success: true });
        } catch (err: any) {
          console.error(`[Escrow] Failed to payout commission ${commission.id}:`, err.message);
          results.push({ id: commission.id, success: false, error: err.message });
        }
      }

      return { success: true, processed: results.length, details: results };
    } catch (error: any) {
      console.error("[Escrow] Error processing payouts:", error.message);
      return { success: false, error: error.message };
    }
  }
}

export const escrowPayoutService = new EscrowPayoutService();
