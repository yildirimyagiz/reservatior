import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { locationService } from "../services/location";
import { 
  LocationPlainInputCreate, 
  LocationPlainInputUpdate 
} from "../../generated/prismabox/Location";

export const locationRoutes = new Elysia({ prefix: "/locations" })
  .use(authMiddleware)

  /**
   * GET /location
   * Retrieves all Location with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return locationService.getAll({
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
   * POST /location
   * Creates a new Location.
   */
  .post("/", async ({ body, set }) => {
    const data = await locationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LocationPlainInputCreate
  })

  /**
   * GET /location/:id
   * Retrieves a single Location by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await locationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Location not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /location/:id
   * Updates an existing Location.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await locationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Location not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LocationPlainInputUpdate
  })

  /**
   * DELETE /location/:id
   * Deletes a Location.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await locationService.delete(params.id);
      return { success: true, message: "Location deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Location not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
