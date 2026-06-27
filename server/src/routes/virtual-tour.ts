import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { virtualTourService } from "../services/virtualtour";
import { 
  VirtualTourPlainInputCreate, 
  VirtualTourPlainInputUpdate 
} from "../../generated/prismabox/VirtualTour";

export const virtualTourRoutes = new Elysia({ prefix: "/virtual-tours" })
  .use(authMiddleware)

  /**
   * GET /virtual-tour
   * Retrieves all VirtualTour with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return virtualTourService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await virtualTourService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VirtualTourPlainInputCreate
  })

  /**
   * GET /virtual-tour/:id
   * Retrieves a single VirtualTour by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await virtualTourService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await virtualTourService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await virtualTourService.delete(params.id);
      return { success: true, message: "VirtualTour deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VirtualTour not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
