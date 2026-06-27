import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { investorPropertyService } from "../services/investorproperty";
import { 
  InvestorPropertyPlainInputCreate, 
  InvestorPropertyPlainInputUpdate 
} from "../../generated/prismabox/InvestorProperty";

export const investorPropertyRoutes = new Elysia({ prefix: "/investor-properties" })
  .use(authMiddleware)

  /**
   * GET /investor-property
   * Retrieves all InvestorProperty with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return investorPropertyService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /investor-property
   * Creates a new InvestorProperty.
   */
  .post("/", async ({ body, set }) => {
    const data = await investorPropertyService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: InvestorPropertyPlainInputCreate
  })

  /**
   * GET /investor-property/:id
   * Retrieves a single InvestorProperty by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await investorPropertyService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "InvestorProperty not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /investor-property/:id
   * Updates an existing InvestorProperty.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await investorPropertyService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "InvestorProperty not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: InvestorPropertyPlainInputUpdate
  })

  /**
   * DELETE /investor-property/:id
   * Deletes a InvestorProperty.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await investorPropertyService.delete(params.id);
      return { success: true, message: "InvestorProperty deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "InvestorProperty not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
