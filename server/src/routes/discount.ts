import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { discountService } from "../services/discount";
import { 
  DiscountPlainInputCreate, 
  DiscountPlainInputUpdate 
} from "../../generated/prismabox/Discount";
import { regionMiddleware } from "../middleware/region";

export const discountRoutes = new Elysia({ prefix: "/discounts" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /discount
   * Retrieves all Discount with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return discountService.withDB(db as any).getAll({
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
   * POST /discount
   * Creates a new Discount.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await discountService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: DiscountPlainInputCreate
  })

  /**
   * GET /discount/:id
   * Retrieves a single Discount by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await discountService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Discount not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /discount/:id
   * Updates an existing Discount.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await discountService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Discount not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: DiscountPlainInputUpdate
  })

  /**
   * DELETE /discount/:id
   * Deletes a Discount.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await discountService.withDB(db as any).delete(params.id);
      return { success: true, message: "Discount deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Discount not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
