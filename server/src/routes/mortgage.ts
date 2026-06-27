import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mortgageService } from "../services/mortgage";
import { 
  MortgagePlainInputCreate, 
  MortgagePlainInputUpdate 
} from "../../generated/prismabox/Mortgage";

export const mortgageRoutes = new Elysia({ prefix: "/mortgages" })
  .use(authMiddleware)

  /**
   * GET /mortgage
   * Retrieves all Mortgage with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mortgageService.getAll({
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
   * POST /mortgage
   * Creates a new Mortgage.
   */
  .post("/", async ({ body, set }) => {
    const data = await mortgageService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MortgagePlainInputCreate
  })

  /**
   * GET /mortgage/:id
   * Retrieves a single Mortgage by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mortgageService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Mortgage not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mortgage/:id
   * Updates an existing Mortgage.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mortgageService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Mortgage not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MortgagePlainInputUpdate
  })

  /**
   * DELETE /mortgage/:id
   * Deletes a Mortgage.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await mortgageService.delete(params.id);
      return { success: true, message: "Mortgage deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Mortgage not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
