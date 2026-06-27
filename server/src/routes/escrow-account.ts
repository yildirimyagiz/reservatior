import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { escrowAccountService } from "../services/escrowaccount";
import { GeminiOpsNotificationCoordinator } from "../services/ai/gemini-ops-coordinator";
import { 
  EscrowAccountPlainInputCreate, 
  EscrowAccountPlainInputUpdate 
} from "../../generated/prismabox/EscrowAccount";

export const escrowAccountRoutes = new Elysia({ prefix: "/escrow-account" })
  .use(authMiddleware)

  /**
   * GET /escrow-account
   * Retrieves all EscrowAccount with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return escrowAccountService.getAll({
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
   * POST /escrow-account
   * Creates a new EscrowAccount.
   */
  .post("/", async ({ body, set, headers }) => {
    const data = await escrowAccountService.create(body);
    
    // Trigger Gemini ops audit for escrow creation
    const region = headers["x-region"] || "US";
    GeminiOpsNotificationCoordinator.trackEscrowChange(data.id, region).catch(err => {
      console.error("❌ Failed to trigger trackEscrowChange in post handler:", err);
    });

    set.status = 201;
    return { data };
  }, {
    body: EscrowAccountPlainInputCreate
  })

  /**
   * GET /escrow-account/:id
   * Retrieves a single EscrowAccount by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await escrowAccountService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "EscrowAccount not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /escrow-account/:id
   * Updates an existing EscrowAccount.
   */
  .patch("/:id", async ({ params, body, set, headers }) => {
    try {
      const data = await escrowAccountService.update(params.id, body);
      
      // Trigger Gemini ops audit for escrow updates
      const region = headers["x-region"] || "US";
      GeminiOpsNotificationCoordinator.trackEscrowChange(params.id, region).catch(err => {
        console.error("❌ Failed to trigger trackEscrowChange in patch handler:", err);
      });

      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowAccount not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EscrowAccountPlainInputUpdate
  })

  /**
   * DELETE /escrow-account/:id
   * Deletes a EscrowAccount.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await escrowAccountService.delete(params.id);
      return { success: true, message: "EscrowAccount deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowAccount not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
