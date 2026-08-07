import { prisma } from "../lib/prisma";

export class EscrowPayoutService {
  
  /**
   * Schedules an escrow release date for a commission or payment.
   * Default wait time is 21 days for security.
   */
  async scheduleEscrowRelease(commissionId: string, gateway: string, daysToWait = 21) {
    try {
      const releaseDate = new Date();
      releaseDate.setDate(releaseDate.getDate() + daysToWait);
      
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
   *
   * FAIL-CLOSED (audit §3.3 / §6.A.1): the ledger is never flipped to
   * RELEASED unless a real PSP transfer actually executed. The Stripe/PayTR
   * transfer calls are not wired, so due commissions stay PENDING instead of
   * recording money as paid that never left any account.
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
          // 1. Process payout via Stripe Connect or PayTR SubMerchant API.
          // Real transfers are NOT wired, so this fails closed and the
          // commission remains PENDING (no phantom RELEASED status).
          const transfer = await this.transferToBeneficiary(commission);
          if (!transfer.success) {
            console.error(`[Escrow] Payout NOT released for commission ${commission.id}: ${transfer.error}`);
            results.push({ id: commission.id, success: false, error: transfer.error });
            continue;
          }

          // 2. Mark as RELEASED only after the transfer actually succeeded
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

      const processed = results.filter((r) => r.success).length;
      return { success: true, processed, details: results };
    } catch (error: any) {
      console.error("[Escrow] Error processing payouts:", error.message);
      return { success: false, error: error.message };
    }
  }

  /**
   * Executes a real PSP transfer to the beneficiary.
   *
   * Currently returns failure: no Stripe Connect / PayTR transfer call is wired.
   * When a real integration is added, implement the transfer here and only return
   * success after the PSP confirms the funds moved.
   */
  private async transferToBeneficiary(commission: any): Promise<{ success: boolean; error?: string }> {
    if (commission.gateway === "STRIPE") {
      console.log(`[Escrow] Stripe payout for commission ${commission.id} requested — no wired transfer exists.`);
    } else if (commission.gateway === "PAYTR") {
      console.log(`[Escrow] PayTR payout for commission ${commission.id} requested — no wired transfer exists.`);
    } else {
      console.log(`[Escrow] Generic payout for commission ${commission.id} requested — no wired transfer exists.`);
    }

    return {
      success: false,
      error: `Payout for commission ${commission.id} was NOT executed: no real PSP transfer is wired (audit §6.A.1).`
    };
  }
}

export const escrowPayoutService = new EscrowPayoutService();
