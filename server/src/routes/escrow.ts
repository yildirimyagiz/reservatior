import { Elysia, t } from "elysia";
import { escrowService } from "../services/escrow";
import { regionMiddleware } from "../middleware/region";

export const escrowRoutes = new Elysia({ prefix: "/escrow" })
  .use(regionMiddleware)
  /**
   * POST /api/v1/escrow/split-config
   * Configures the commission split rule for a property.
   */
  .post(
    "/split-config",
    async ({ orgId, db, body, headers }) => {
      const region = headers["x-region"] || headers["X-Region"] || "US";
      const { propertyId, agentId, agentPayoutRate, reservatiorFeeRate, blockageDays } = body;

      const result = await escrowService.withDB(db as any).configurePropertyEscrowSplit(
        region,
        propertyId,
        agentId,
        agentPayoutRate,
        reservatiorFeeRate,
        blockageDays
      );

      return { success: true, config: result };
    },
    {
      body: t.Object({
        propertyId: t.String(),
        agentId: t.String(),
        agentPayoutRate: t.Optional(t.Number()),
        reservatiorFeeRate: t.Optional(t.Number()),
        blockageDays: t.Optional(t.Number())
      })
    }
  )

  /**
   * POST /api/v1/escrow/process-payment
   * Processes a rent payment, creating the EscrowAccount and allocating splits.
   */
  .post(
    "/process-payment",
    async ({ orgId, db, body, headers }) => {
      const region = headers["x-region"] || headers["X-Region"] || "US";
      const { paymentId } = body;

      const result = await escrowService.withDB(db as any).processRentPayment(region, paymentId);
      return result;
    },
    {
      body: t.Object({
        paymentId: t.String()
      })
    }
  )

  /**
   * POST /api/v1/escrow/release-commissions
   * Triggers the release scheduler to clear blocked commissions.
   */
  .post(
    "/release-commissions",
    async ({ orgId, db, headers }) => {
      const region = headers["x-region"] || headers["X-Region"] || "US";
      const result = await escrowService.withDB(db as any).releaseScheduledCommissions(region);
      return { success: true, ...result };
    }
  )

  /**
   * POST /api/v1/escrow/withdraw
   * Requests a payout withdrawal from cleared agent balance.
   */
  .post(
    "/withdraw",
    async ({ orgId, db, body, headers }) => {
      const region = headers["x-region"] || headers["X-Region"] || "US";
      const { agentId, amount } = body;

      const result = await escrowService.withDB(db as any).withdrawCommissions(region, agentId, amount);
      return result;
    },
    {
      body: t.Object({
        agentId: t.String(),
        amount: t.Number()
      })
    }
  )

  /**
   * GET /api/v1/escrow/wallet/:agentId
   * Retrieves the wallet details and transaction history for an agent.
   */
  .get(
    "/wallet/:agentId",
    async ({ orgId, db, params, headers }) => {
      const region = headers["x-region"] || headers["X-Region"] || "US";
      const { agentId } = params;

      const wallet = await escrowService.withDB(db as any).getAgentWallet(region, agentId);
      return { success: true, wallet };
    },
    {
      params: t.Object({
        agentId: t.String()
      })
    }
  )

  /**
   * POST /api/v1/escrow/cross-border
   * Legacy cross-border endpoint (kept for compatibility)
   */
  .post(
    "/cross-border",
    async ({ orgId, db, body, headers }) => {
      const token = headers.authorization?.split(" ")[1];
      if (!token) throw new Error("Unauthorized");
      const payloadBase64 = token.split(".")[1];
      const decoded = JSON.parse(Buffer.from(payloadBase64, "base64").toString());
      const buyerEmail = decoded.email;

      const { buyerRegion, sellerRegion, amount, propertyId } = body;

      const result = await escrowService.withDB(db as any).createCrossBorderEscrow(
        buyerEmail,
        buyerRegion,
        sellerRegion,
        amount,
        propertyId
      );

      return result;
    },
    {
      body: t.Object({
        buyerRegion: t.String(),
        sellerRegion: t.String(),
        amount: t.Number(),
        propertyId: t.String(),
      }),
    }
  )

  /**
   * POST /api/v1/escrow/release
   * Legacy release endpoint (kept for compatibility)
   */
  .post(
    "/release",
    async ({ orgId, db, body }) => {
      const { escrowId, sellerEmail, sellerRegion, transactionRegion } = body;
      const result = await escrowService.withDB(db as any).releaseEscrow(
        escrowId,
        sellerEmail,
        sellerRegion,
        transactionRegion
      );
      return result;
    },
    {
      body: t.Object({
        escrowId: t.String(),
        sellerEmail: t.String(),
        sellerRegion: t.String(),
        transactionRegion: t.String(),
      }),
    }
  );
