import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { virtualTourService } from "../services/virtualtour";
import { 
  VirtualTourPlainInputCreate, 
  VirtualTourPlainInputUpdate 
} from "../../generated/prismabox/VirtualTour";
import { regionMiddleware } from "../middleware/region";

export const virtualTourRoutes = new Elysia({ prefix: "/virtual-tours" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /virtual-tour
   * Retrieves all VirtualTour with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return virtualTourService.withDB(db as any).getAll({
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
   * POST /virtual-tour
   * Creates a new VirtualTour.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await virtualTourService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VirtualTourPlainInputCreate
  })

  /**
   * GET /virtual-tour/:id
   * Retrieves a single VirtualTour by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await virtualTourService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VirtualTour not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /virtual-tour/:id
   * Updates an existing VirtualTour.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await virtualTourService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VirtualTour not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VirtualTourPlainInputUpdate
  })

  /**
   * DELETE /virtual-tour/:id
   * Deletes a VirtualTour.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await virtualTourService.withDB(db as any).delete(params.id);
      return { success: true, message: "VirtualTour deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VirtualTour not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
