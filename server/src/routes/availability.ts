import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { availabilityService } from "../services/availability";
import { 
  AvailabilityPlainInputCreate, 
  AvailabilityPlainInputUpdate 
} from "../../generated/prismabox/Availability";

export const availabilityRoutes = new Elysia({ prefix: "/availabilities" })
  .use(authMiddleware)

  /**
   * GET /availability
   * Retrieves all Availability with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return availabilityService.getAll({
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
   * POST /availability
   * Creates a new Availability.
   */
  .post("/", async ({ body, set }) => {
    const data = await availabilityService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AvailabilityPlainInputCreate
  })

  /**
   * GET /availability/:id
   * Retrieves a single Availability by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await availabilityService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Availability not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /availability/:id
   * Updates an existing Availability.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await availabilityService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Availability not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AvailabilityPlainInputUpdate
  })

  /**
   * DELETE /availability/:id
   * Deletes a Availability.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await availabilityService.delete(params.id);
      return { success: true, message: "Availability deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Availability not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
