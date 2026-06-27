import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mapDataService } from "../services/mapdata";
import { 
  MapDataPlainInputCreate, 
  MapDataPlainInputUpdate 
} from "../../generated/prismabox/MapData";

export const mapDataRoutes = new Elysia({ prefix: "/map-datas" })
  .use(authMiddleware)

  /**
   * GET /map-data
   * Retrieves all MapData with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mapDataService.getAll({
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
   * POST /map-data
   * Creates a new MapData.
   */
  .post("/", async ({ body, set }) => {
    const data = await mapDataService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MapDataPlainInputCreate
  })

  /**
   * GET /map-data/:id
   * Retrieves a single MapData by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mapDataService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MapData not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /map-data/:id
   * Updates an existing MapData.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mapDataService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MapData not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MapDataPlainInputUpdate
  })

  /**
   * DELETE /map-data/:id
   * Deletes a MapData.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await mapDataService.delete(params.id);
      return { success: true, message: "MapData deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MapData not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
