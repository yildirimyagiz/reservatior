import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mapLayerService } from "../services/maplayer";
import { 
  MapLayerPlainInputCreate, 
  MapLayerPlainInputUpdate 
} from "../../generated/prismabox/MapLayer";

export const mapLayerRoutes = new Elysia({ prefix: "/map-layers" })
  .use(authMiddleware)

  /**
   * GET /map-layer
   * Retrieves all MapLayer with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mapLayerService.getAll({
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
   * POST /map-layer
   * Creates a new MapLayer.
   */
  .post("/", async ({ body, set }) => {
    const data = await mapLayerService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MapLayerPlainInputCreate
  })

  /**
   * GET /map-layer/:id
   * Retrieves a single MapLayer by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mapLayerService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MapLayer not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /map-layer/:id
   * Updates an existing MapLayer.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mapLayerService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MapLayer not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MapLayerPlainInputUpdate
  })

  /**
   * DELETE /map-layer/:id
   * Deletes a MapLayer.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await mapLayerService.delete(params.id);
      return { success: true, message: "MapLayer deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MapLayer not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
