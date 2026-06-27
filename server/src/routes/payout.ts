import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { payoutService } from "../services/payout";
import { 
  PayoutPlainInputCreate, 
  PayoutPlainInputUpdate 
} from "../../generated/prismabox/Payout";

export const payoutRoutes = new Elysia({ prefix: "/payout" })
  .use(authMiddleware)

  /**
   * GET /payout
   * Retrieves all Payout with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return payoutService.getAll({
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
   * POST /payout
   * Creates a new Payout.
   */
  .post("/", async ({ body, set }) => {
    const data = await payoutService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PayoutPlainInputCreate
  })

  /**
   * GET /payout/:id
   * Retrieves a single Payout by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await payoutService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Payout not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /payout/:id
   * Updates an existing Payout.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await payoutService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Payout not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PayoutPlainInputUpdate
  })

  /**
   * DELETE /payout/:id
   * Deletes a Payout.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await payoutService.delete(params.id);
      return { success: true, message: "Payout deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Payout not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
