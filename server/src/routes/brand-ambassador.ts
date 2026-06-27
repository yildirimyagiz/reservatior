import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { brandAmbassadorService } from "../services/brandambassador";
import { 
  BrandAmbassadorPlainInputCreate, 
  BrandAmbassadorPlainInputUpdate 
} from "../../generated/prismabox/BrandAmbassador";

export const brandAmbassadorRoutes = new Elysia({ prefix: "/brand-ambassadors" })
  .use(authMiddleware)

  /**
   * GET /brand-ambassador
   * Retrieves all BrandAmbassador with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return brandAmbassadorService.getAll({
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
   * POST /brand-ambassador
   * Creates a new BrandAmbassador.
   */
  .post("/", async ({ body, set }) => {
    const data = await brandAmbassadorService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: BrandAmbassadorPlainInputCreate
  })

  /**
   * GET /brand-ambassador/:id
   * Retrieves a single BrandAmbassador by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await brandAmbassadorService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "BrandAmbassador not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /brand-ambassador/:id
   * Updates an existing BrandAmbassador.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await brandAmbassadorService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "BrandAmbassador not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: BrandAmbassadorPlainInputUpdate
  })

  /**
   * DELETE /brand-ambassador/:id
   * Deletes a BrandAmbassador.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await brandAmbassadorService.delete(params.id);
      return { success: true, message: "BrandAmbassador deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "BrandAmbassador not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
