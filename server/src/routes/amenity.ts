import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { amenityService } from "../services/amenity";
import { 
  AmenityPlainInputCreate, 
  AmenityPlainInputUpdate 
} from "../../generated/prismabox/Amenity";
import { regionMiddleware } from "../middleware/region";

export const amenityRoutes = new Elysia({ prefix: "/amenities" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /amenity
   * Retrieves all Amenity with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return amenityService.withDB(db as any).getAll({
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
   * POST /amenity
   * Creates a new Amenity.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await amenityService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AmenityPlainInputCreate
  })

  /**
   * GET /amenity/:id
   * Retrieves a single Amenity by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await amenityService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Amenity not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /amenity/:id
   * Updates an existing Amenity.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await amenityService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Amenity not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AmenityPlainInputUpdate
  })

  /**
   * DELETE /amenity/:id
   * Deletes a Amenity.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await amenityService.withDB(db as any).delete(params.id);
      return { success: true, message: "Amenity deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Amenity not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
