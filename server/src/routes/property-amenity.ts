import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyAmenityService } from "../services/propertyamenity";
import { 
  PropertyAmenityPlainInputCreate, 
  PropertyAmenityPlainInputUpdate 
} from "../../generated/prismabox/PropertyAmenity";

export const propertyAmenityRoutes = new Elysia({ prefix: "/property-amenity" })
  .use(authMiddleware)

  /**
   * GET /property-amenity
   * Retrieves all PropertyAmenity with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return propertyAmenityService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await propertyAmenityService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyAmenityPlainInputCreate
  })

  /**
   * GET /property-amenity/:id
   * Retrieves a single PropertyAmenity by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await propertyAmenityService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await propertyAmenityService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await propertyAmenityService.delete(params.id);
      return { success: true, message: "PropertyAmenity deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyAmenity not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
