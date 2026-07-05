import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { escrowDisputeService } from "../services/escrowdispute";
import { regionMiddleware } from "../middleware/region";
import { 
  EscrowDisputePlainInputCreate, 
  EscrowDisputePlainInputUpdate 
} from "../../generated/prismabox/EscrowDispute";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const escrowDisputeRoutes = new Elysia({ prefix: "/escrow-dispute" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /escrow-dispute
   * Retrieves all EscrowDispute with pagination and basic filtering.
   */
  .get("/", async ({ db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return escrowDisputeService.withDB(db as any).getAll({
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
   * Creates/Opens a new EscrowDispute.
   */
  .post("/", async ({ body, set, region }) => {
    const data = await escrowDisputeService.openDispute({
      ...body,
      region
    } as any);
    
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
  .get("/:id", async ({ params, set, region }) => {
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
  })

  /**
   * POST /escrow-dispute/:id/evidence
   * Submits new evidence to an active dispute.
   */
  .post("/:id/evidence", async ({ params, body, region }) => {
    const updated = await escrowDisputeService.submitEvidence(params.id, body as any, region);
    return { data: updated };
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Any()
  })

  /**
   * POST /escrow-dispute/:id/review
   * Requests a moderator/AI review for the dispute.
   */
  .post("/:id/review", async ({ params, region }) => {
    const result = await escrowDisputeService.requestModeratorReview(params.id, region);
    return { data: result };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * POST /escrow-dispute/:id/resolve
   * Resolves the dispute using AI analyst.
   */
  .post("/:id/resolve", async ({ params, body, region }) => {
    const { resolvedBy = "AI_ANALYST" } = body as { resolvedBy?: string };
    const result = await escrowDisputeService.resolveDispute(params.id, resolvedBy, region);
    return { data: result };
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      resolvedBy: t.Optional(t.String())
    })
  })

  /**
   * GET /escrow-dispute/:id/timeline
   * Retrieves the dispute timeline including AI analysis and history logs.
   */
  .get("/:id/timeline", async ({ params, region }) => {
    const result = await escrowDisputeService.getDisputeTimeline(params.id, region);
    return { data: result };
  }, {
    params: t.Object({ id: t.String() })
  });
