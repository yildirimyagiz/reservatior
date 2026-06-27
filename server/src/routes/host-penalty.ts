import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { hostPenaltyService } from "../services/host-penalty";
import { GeminiOpsNotificationCoordinator } from "../services/ai/gemini-ops-coordinator";

export const hostPenaltyRoutes = new Elysia({ prefix: "/host-penalty" })
  .use(authMiddleware)

  /**
   * GET /host-penalty
   * Retrieves all HostPenalty with pagination and filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return hostPenaltyService.getAll({
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
   * POST /host-penalty
   * Creates a new HostPenalty record.
   */
  .post("/", async ({ body, set, headers }) => {
    const data = await hostPenaltyService.create(body);
    const region = headers["x-region"] || "US";
    GeminiOpsNotificationCoordinator.trackHostPenalty(data.id, region).catch(err => {
      console.error("❌ Failed to trigger trackHostPenalty in post handler:", err);
    });
    set.status = 201;
    return { data };
  })

  /**
   * GET /host-penalty/:id
   * Retrieves a single HostPenalty by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await hostPenaltyService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "HostPenalty not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /host-penalty/:id
   * Updates an existing HostPenalty.
   */
  .patch("/:id", async ({ params, body, set, headers }) => {
    try {
      const data = await hostPenaltyService.update(params.id, body);
      const region = headers["x-region"] || "US";
      GeminiOpsNotificationCoordinator.trackHostPenalty(params.id, region).catch(err => {
        console.error("❌ Failed to trigger trackHostPenalty in patch handler:", err);
      });
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "HostPenalty not found or update failed" };
    }
  })

  /**
   * DELETE /host-penalty/:id
   * Deletes a HostPenalty.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await hostPenaltyService.delete(params.id);
      return { success: true, message: "HostPenalty deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "HostPenalty not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
