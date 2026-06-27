import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { bookingSecurityScreeningService } from "../services/bookingsecurityscreening";
import { 
  BookingSecurityScreeningPlainInputCreate, 
  BookingSecurityScreeningPlainInputUpdate 
} from "../../generated/prismabox/BookingSecurityScreening";
import { regionMiddleware } from "../middleware/region";

export const bookingSecurityScreeningRoutes = new Elysia({ prefix: "/booking-security-screening" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /booking-security-screening
   * Retrieves all BookingSecurityScreening with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return bookingSecurityScreeningService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await bookingSecurityScreeningService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: BookingSecurityScreeningPlainInputCreate
  })

  /**
   * GET /booking-security-screening/:id
   * Retrieves a single BookingSecurityScreening by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await bookingSecurityScreeningService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await bookingSecurityScreeningService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await bookingSecurityScreeningService.withDB(db as any).delete(params.id);
      return { success: true, message: "BookingSecurityScreening deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "BookingSecurityScreening not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
