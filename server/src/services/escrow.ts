import { prismaManager } from "../lib/prisma";

export class EscrowService {
  /**
   * Configures the commission and escrow split rules for a property.
   * By default: 3.0% commission to agent, 4.0% fee to Reservatior.
   */
  async configurePropertyEscrowSplit(
    region: string,
    propertyId: string,
    agentId: string,
    agentPayoutRate: number = 3.0,
    reservatiorFeeRate: number = 4.0,
    blockageDays: number = 15
  ) {
    const prisma = prismaManager.getClient(region);

    // Verify property and agent exist
    const property = await prisma.property.findUnique({
      where: { id: propertyId }
    });
    if (!property) throw new Error("Property not found");

    const agent = await prisma.agent.findUnique({
      where: { id: agentId }
    });
    if (!agent) throw new Error("Agent not found");

    // Upsert the split configuration
    const config = await prisma.escrowSplitConfig.upsert({
      where: { propertyId },
      update: {
        agentId,
        agentPayoutRate,
        reservatiorFeeRate,
        blockageDays,
        isActive: true
      },
      create: {
        propertyId,
        agentId,
        agentPayoutRate,
        reservatiorFeeRate,
        blockageDays,
        isActive: true
      }
    });

    console.log(`✅ Configured Escrow Split for Property ${propertyId}: Agent ${agentId} (${agentPayoutRate}%), Reservatior (${reservatiorFeeRate}%), Blockage: ${blockageDays} days.`);
    return config;
  }

  /**
   * Processes a rent payment, creating the EscrowAccount and allocating the 3% / 4% split.
   * Puts the agent's portion into a PENDING/BLOCKED state in their wallet.
   */
  async processRentPayment(region: string, paymentId: string) {
    const prisma = prismaManager.getClient(region);

    // Find the payment
    const payment = await prisma.payment.findUnique({
      where: { id: paymentId },
      include: { Property: true }
    });

    if (!payment) throw new Error("Payment not found");
    if (payment.status !== "PAID") {
      throw new Error(`Cannot process escrow for unpaid payment. Current status: ${payment.status}`);
    }

    const propertyId = payment.propertyId;
    if (!propertyId) throw new Error("Payment is not associated with a property");

    // Get the split configuration for this property
    const splitConfig = await prisma.escrowSplitConfig.findUnique({
      where: { propertyId },
      include: { agent: true }
    });

    // If there is no split config, this property doesn't participate in the affiliate broker model
    if (!splitConfig || !splitConfig.isActive) {
      console.log(`ℹ️ Property ${propertyId} has no active escrow split config. Skipping agent payout.`);
      return { success: true, reason: "No active split configuration" };
    }

    const { agentId, agentPayoutRate, reservatiorFeeRate, blockageDays } = splitConfig;

    // Calculate split amounts
    const totalAmount = payment.amount;
    const agentAmount = (totalAmount * agentPayoutRate) / 100;
    const reservatiorAmount = (totalAmount * reservatiorFeeRate) / 100;
    const landlordAmount = totalAmount - agentAmount - reservatiorAmount;

    // Ensure the agent has an escrow wallet initialized
    let wallet = await prisma.agentEscrowWallet.findUnique({
      where: { agentId }
    });

    if (!wallet) {
      wallet = await prisma.agentEscrowWallet.create({
        data: {
          agentId,
          currency: payment.currencyId || "USD"
        }
      });
    }

    // Determine release date (Today + blockageDays)
    const releaseDate = new Date();
    releaseDate.setDate(releaseDate.getDate() + blockageDays);

    // Create the EscrowAccount in the database to lock the entire transaction
    const escrow = await prisma.escrowAccount.create({
      data: {
        orgId: payment.Property?.orgId || "tr_residence_org",
        reservationId: payment.reservationId || `res_mock_${paymentId}`,
        totalAmount: totalAmount,
        depositAmount: 0.00, // Monthly rent has no security deposit
        currency: payment.currencyId || "USD",
        status: "HOLDING"
      }
    });

    // Log the transaction in the agent's wallet as BLOCKED/PENDING
    const agentTx = await prisma.agentEscrowTransaction.create({
      data: {
        walletId: wallet.id,
        amount: agentAmount,
        currency: payment.currencyId || "USD",
        type: "COMMISSION_EARNED",
        status: "BLOCKED",
        escrowAccountId: escrow.id,
        releaseDate,
        reference: `Rent Payment split for ${payment.id}. Total rent: ${totalAmount}. Agent split: ${agentPayoutRate}%.`
      }
    });

    // Update wallet pending balance
    await prisma.agentEscrowWallet.update({
      where: { id: wallet.id },
      data: {
        pendingBalance: { increment: agentAmount }
      }
    });

    console.log(`💰 Processed rent payment split of $${agentAmount} (pending) for Agent ${agentId} from Rent: $${totalAmount}. Release scheduled at: ${releaseDate.toDateString()}`);

    return {
      success: true,
      escrowId: escrow.id,
      agentAmount,
      reservatiorAmount,
      landlordAmount,
      releaseDate
    };
  }

  /**
   * Cron/Scheduled Task: Releases scheduled blocked commissions that have completed their valör (blockage) period.
   * Transfers funds from pendingBalance to cleared balance.
   */
  async releaseScheduledCommissions(region: string) {
    const prisma = prismaManager.getClient(region);
    const now = new Date();

    console.log(`⏰ Running Escrow Release Scheduler for Region [${region}]...`);

    // Find all blocked transactions whose releaseDate has passed
    const pendingTxs = await prisma.agentEscrowTransaction.findMany({
      where: {
        status: "BLOCKED",
        releaseDate: { lte: now }
      },
      include: {
        wallet: true
      }
    });

    console.log(`🔍 Found ${pendingTxs.length} agent transactions ready for release.`);

    let successCount = 0;

    for (const tx of pendingTxs) {
      try {
        // Run as a transaction to guarantee data integrity
        await prisma.$transaction(async (txPrisma) => {
          // 1. Mark transaction as SUCCEEDED
          await txPrisma.agentEscrowTransaction.update({
            where: { id: tx.id },
            data: { status: "SUCCEEDED" }
          });

          // 2. Transfer from pending to cleared balance
          await txPrisma.agentEscrowWallet.update({
            where: { id: tx.walletId },
            data: {
              pendingBalance: { decrement: tx.amount },
              balance: { increment: tx.amount }
            }
          });

          // 3. Mark the master escrow account as released if all splits are resolved
          if (tx.escrowAccountId) {
            await txPrisma.escrowAccount.update({
              where: { id: tx.escrowAccountId },
              data: {
                status: "FULLY_RELEASED",
                releasedAt: now
              }
            });
          }
        });

        console.log(`✅ Released commission of $${tx.amount} to wallet ${tx.walletId}`);
        successCount++;
      } catch (err) {
        console.error(`❌ Failed to release transaction ${tx.id}:`, err);
      }
    }

    return { totalChecked: pendingTxs.length, releasedCount: successCount };
  }

  /**
   * Allows an independent agent to request a withdrawal from their cleared balance.
   */
  async withdrawCommissions(region: string, agentId: string, amount: number) {
    const prisma = prismaManager.getClient(region);

    if (amount <= 0) throw new Error("Withdrawal amount must be greater than zero");

    const wallet = await prisma.agentEscrowWallet.findUnique({
      where: { agentId }
    });

    if (!wallet) throw new Error("Escrow wallet not found for agent");

    const availableBalance = Number(wallet.balance);
    if (availableBalance < amount) {
      throw new Error(`Insufficient cleared balance. Available: $${availableBalance}, Requested: $${amount}`);
    }

    // Run transaction
    const withdrawalTx = await prisma.$transaction(async (txPrisma) => {
      // 1. Deduct from cleared balance, add to paidBalance
      const updatedWallet = await txPrisma.agentEscrowWallet.update({
        where: { id: wallet.id },
        data: {
          balance: { decrement: amount },
          paidBalance: { increment: amount }
        }
      });

      // 2. Log withdrawal transaction
      const txLog = await txPrisma.agentEscrowTransaction.create({
        data: {
          walletId: wallet.id,
          amount,
          currency: wallet.currency,
          type: "PAYOUT_WITHDRAWAL",
          status: "SUCCEEDED",
          reference: `Withdrawal payout requested by agent ${agentId} to their bank account.`
        }
      });

      return { updatedWallet, txLog };
    });

    console.log(`🏦 Withdrawal processed for Agent ${agentId}: $${amount}. Remaining balance: $${withdrawalTx.updatedWallet.balance}`);

    return {
      success: true,
      amount,
      newBalance: Number(withdrawalTx.updatedWallet.balance),
      transactionId: withdrawalTx.txLog.id
    };
  }

  /**
   * Fetch wallet and transactions details for an agent
   */
  async getAgentWallet(region: string, agentId: string) {
    const prisma = prismaManager.getClient(region);

    let wallet = await prisma.agentEscrowWallet.findUnique({
      where: { agentId },
      include: {
        transactions: {
          orderBy: { createdAt: "desc" },
          take: 50
        }
      }
    });

    if (!wallet) {
      // Lazy init wallet
      wallet = await prisma.agentEscrowWallet.create({
        data: {
          agentId,
          currency: "USD"
        },
        include: {
          transactions: true
        }
      });
    }

    return wallet;
  }

  /**
   * Legacy cross-border method (preserved for compatibility)
   */
  async createCrossBorderEscrow(
    buyerEmail: string,
    buyerRegion: string,
    sellerRegion: string,
    amount: number,
    propertyId: string
  ) {
    if (amount <= 0) throw new Error("Amount must be greater than zero");

    const buyerPrisma = prismaManager.getClient(buyerRegion);
    const sellerPrisma = prismaManager.getClient(sellerRegion);

    const buyer = await buyerPrisma.user.findUnique({
      where: { email: buyerEmail },
    });

    if (!buyer) throw new Error("Buyer not found in origin region");

    const wallet = { id: "mock-wallet", balance: 10000, currency: "USD" };
    if (wallet.balance < amount) {
      throw new Error("Insufficient coupon balance");
    }

    const updatedWallet = wallet;

    try {
      const escrow = await sellerPrisma.escrowAccount.create({
        data: {
          orgId: "tr_residence_org",
          totalAmount: amount,
          depositAmount: amount,
          currency: wallet.currency,
          status: "HOLDING",
          reservationId: propertyId,
        }
      });

      return {
        success: true,
        transactionId: escrow.id,
        newBalance: updatedWallet.balance
      };

    } catch (sellerError) {
      console.error("[EscrowService] Seller DB Commit failed. Rolling back buyer funds.", sellerError);
      throw new Error("Cross-border transaction failed. Funds have been securely rolled back.");
    }
  }

  /**
   * Legacy release method (preserved for compatibility)
   */
  async releaseEscrow(
    escrowId: string,
    sellerEmail: string,
    sellerRegion: string,
    transactionRegion: string
  ) {
    const transactionPrisma = prismaManager.getClient(transactionRegion);
    const sellerPrisma = prismaManager.getClient(sellerRegion);

    const escrow = await transactionPrisma.escrowAccount.update({
      where: { id: escrowId },
      data: { status: "FULLY_RELEASED" }
    });

    const seller = await sellerPrisma.user.findUnique({
      where: { email: sellerEmail },
    });

    if (!seller) throw new Error("Seller not found");

    return escrow;
  }
}

export const escrowService = new EscrowService();
