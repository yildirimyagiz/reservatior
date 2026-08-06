import { prisma } from "../lib/prisma";

export class ReferralCommissionService {
  /**
   * Processes the referral override commission for a given commission payout.
   * If the user who earned the commission was referred by someone, 
   * a percentage (e.g. 5%) of that commission is awarded to the referring user.
   */
  async processReferralOverride(commissionId: string, overridePercentage = 0.05) {
    try {
      // 1. Fetch the original commission
      const commission = await prisma.commission.findUnique({
        where: { id: commissionId }
      });

      if (!commission || (!commission.beneficiaryUserId && !commission.agentId)) {
        return { success: false, message: "Commission has no beneficiary user or agent." };
      }

      let userId = commission.beneficiaryUserId;

      if (!userId && commission.agentId) {
        const agent = await prisma.agent.findUnique({
          where: { id: commission.agentId }
        });
        userId = agent?.ownerId || null;
      }

      if (!userId) {
        return { success: false, message: "Could not determine user for commission." };
      }

      const user = await prisma.user.findUnique({
        where: { id: userId }
      });

      const referredByUserId = user?.referredByUserId;
      if (!referredByUserId) {
        return { success: false, message: "User was not referred by anyone." };
      }

      // 2. Check if an override commission was already created for this commission
      // Assuming we can identify it by checking if a referral commission exists for this transaction
      const existingReferral = await prisma.commission.findFirst({
        where: {
          transactionId: commission.transactionId,
          beneficiaryUserId: referredByUserId,
          type: "REFERRAL"
        }
      });

      if (existingReferral) {
        return { success: false, message: "Referral commission already processed." };
      }

      // 3. Calculate override amount
      const originalAmount = Number(commission.commissionAmount);
      const referralAmount = originalAmount * overridePercentage;

      // 4. Create the new Commission for the referrer
      const referralCommission = await prisma.commission.create({
        data: {
          orgId: commission.orgId,
          beneficiaryUserId: referredByUserId,
          type: "REFERRAL",
          amountBase: originalAmount,
          commissionRate: overridePercentage * 100,
          platformFee: 0,
          partnerFee: 0,
          taxAmount: 0,
          commissionAmount: referralAmount,
          currency: commission.currency,
          status: "PENDING",
          collectionType: commission.collectionType,
          transactionId: commission.transactionId,
          listingId: commission.listingId,
          leaseId: commission.leaseId,
          bookingId: commission.bookingId,
          reservationId: commission.reservationId,
        }
      });

      // 5. Update Referral stats for the referrer
      const referralCode = await prisma.referral.findFirst({
        where: { userId: referredByUserId }
      });

      if (referralCode) {
        await prisma.referral.update({
          where: { id: referralCode.id },
          data: {
            totalEarnings: { increment: referralAmount },
            successfulReferrals: { increment: 1 }
          }
        });
      }

      return { success: true, data: referralCommission };
    } catch (error: any) {
      console.error("[ReferralCommissionService] Error:", error.message);
      return { success: false, error: error.message };
    }
  }
}

export const referralCommissionService = new ReferralCommissionService();
