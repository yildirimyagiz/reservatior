import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { escrowDisputeService } from "../services/escrowdispute";
import { 
  EscrowDisputePlainInputCreate, 
  EscrowDisputePlainInputUpdate 
} from "../../generated/prismabox/EscrowDispute";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const escrowDisputeRoutes = new Elysia({ prefix: "/escrow-dispute" })
  .use(authMiddleware)

  /**
   * GET /escrow-dispute
   * Retrieves all EscrowDispute with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return escrowDisputeService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /escrow-dispute
   * Creates a new EscrowDispute.
   */
  .post("/", async ({ body, set }) => {
    const data = await escrowDisputeService.create(body);
    
    // Trigger ML feedback loop: Dispute opened -> penalize tenant risk score
    MLBridgeService.sendFeedback("tenant-screening", "DISPUTE_OPENED", -5.0, { 
      disputeId: data.id, 
      escrowAccountId: data.escrowAccountId,
      orgId: data.orgId
    }).catch(console.error);

    set.status = 201;
    return { data };
  }, {
    body: EscrowDisputePlainInputCreate
  })

  /**
   * GET /escrow-dispute/:id
   * Retrieves a single EscrowDispute by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await escrowDisputeService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "EscrowDispute not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /escrow-dispute/:id
   * Updates an existing EscrowDispute.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await escrowDisputeService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowDispute not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EscrowDisputePlainInputUpdate
  })

  /**
   * DELETE /escrow-dispute/:id
   * Deletes a EscrowDispute.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await escrowDisputeService.delete(params.id);
      return { success: true, message: "EscrowDispute deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowDispute not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
