import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { bookingSecurityScreeningService } from "../services/bookingsecurityscreening";
import { 
  BookingSecurityScreeningPlainInputCreate, 
  BookingSecurityScreeningPlainInputUpdate 
} from "../../generated/prismabox/BookingSecurityScreening";

export const bookingSecurityScreeningRoutes = new Elysia({ prefix: "/booking-security-screening" })
  .use(authMiddleware)

  /**
   * GET /booking-security-screening
   * Retrieves all BookingSecurityScreening with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return bookingSecurityScreeningService.getAll({
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
   * POST /booking-security-screening
   * Creates a new BookingSecurityScreening.
   */
  .post("/", async ({ body, set }) => {
    const data = await bookingSecurityScreeningService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: BookingSecurityScreeningPlainInputCreate
  })

  /**
   * GET /booking-security-screening/:id
   * Retrieves a single BookingSecurityScreening by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await bookingSecurityScreeningService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "BookingSecurityScreening not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /booking-security-screening/:id
   * Updates an existing BookingSecurityScreening.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await bookingSecurityScreeningService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "BookingSecurityScreening not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: BookingSecurityScreeningPlainInputUpdate
  })

  /**
   * DELETE /booking-security-screening/:id
   * Deletes a BookingSecurityScreening.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await bookingSecurityScreeningService.delete(params.id);
      return { success: true, message: "BookingSecurityScreening deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "BookingSecurityScreening not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
