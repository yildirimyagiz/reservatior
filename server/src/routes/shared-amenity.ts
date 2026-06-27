import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { sharedAmenityService } from "../services/sharedamenity";
import { 
  SharedAmenityPlainInputCreate, 
  SharedAmenityPlainInputUpdate 
} from "../../generated/prismabox/SharedAmenity";

export const sharedAmenityRoutes = new Elysia({ prefix: "/shared-amenities" })
  .use(authMiddleware)

  /**
   * GET /shared-amenity
   * Retrieves all SharedAmenity with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return sharedAmenityService.getAll({
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
   * POST /shared-amenity
   * Creates a new SharedAmenity.
   */
  .post("/", async ({ body, set }) => {
    const data = await sharedAmenityService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SharedAmenityPlainInputCreate
  })

  /**
   * GET /shared-amenity/:id
   * Retrieves a single SharedAmenity by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await sharedAmenityService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SharedAmenity not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /shared-amenity/:id
   * Updates an existing SharedAmenity.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await sharedAmenityService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SharedAmenity not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SharedAmenityPlainInputUpdate
  })

  /**
   * DELETE /shared-amenity/:id
   * Deletes a SharedAmenity.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await sharedAmenityService.delete(params.id);
      return { success: true, message: "SharedAmenity deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SharedAmenity not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
