import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { discountService } from "../services/discount";
import { 
  DiscountPlainInputCreate, 
  DiscountPlainInputUpdate 
} from "../../generated/prismabox/Discount";

export const discountRoutes = new Elysia({ prefix: "/discounts" })
  .use(authMiddleware)

  /**
   * GET /discount
   * Retrieves all Discount with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return discountService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await discountService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: DiscountPlainInputCreate
  })

  /**
   * GET /discount/:id
   * Retrieves a single Discount by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await discountService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await discountService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await discountService.delete(params.id);
      return { success: true, message: "Discount deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Discount not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
