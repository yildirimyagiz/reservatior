import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyAmenityService } from "../services/propertyamenity";
import { 
  PropertyAmenityPlainInputCreate, 
  PropertyAmenityPlainInputUpdate 
} from "../../generated/prismabox/PropertyAmenity";
import { regionMiddleware } from "../middleware/region";

export const propertyAmenityRoutes = new Elysia({ prefix: "/property-amenity" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-amenity
   * Retrieves all PropertyAmenity with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return propertyAmenityService.withDB(db as any).getAll({
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
   * POST /property-amenity
   * Creates a new PropertyAmenity.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyAmenityService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyAmenityPlainInputCreate
  })

  /**
   * GET /property-amenity/:id
   * Retrieves a single PropertyAmenity by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyAmenityService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyAmenity not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-amenity/:id
   * Updates an existing PropertyAmenity.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyAmenityService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyAmenity not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyAmenityPlainInputUpdate
  })

  /**
   * DELETE /property-amenity/:id
   * Deletes a PropertyAmenity.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyAmenityService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyAmenity deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyAmenity not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
