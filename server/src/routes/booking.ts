import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { bookingService } from "../services/booking";
import { 
  BookingPlainInputCreate, 
  BookingPlainInputUpdate 
} from "../../generated/prismabox/Booking";
import { regionMiddleware } from "../middleware/region";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const bookingRoutes = new Elysia({ prefix: "/booking" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /booking
   * Retrieves all Booking with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return bookingService.withDB(db as any).getAll({
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
   * POST /booking
   * Creates a new Booking.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await bookingService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: BookingPlainInputCreate
  })

  /**
   * GET /booking/:id
   * Retrieves a single Booking by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await bookingService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Booking not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /booking/:id
   * Updates an existing Booking.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const oldData = await bookingService.withDB(db as any).getById(params.id);
      const data = await bookingService.withDB(db as any).update(params.id, body);
      
      // Trigger ML feedback loop if status changed
      if (oldData && oldData.status !== (body as any).status) {
        if ((body as any).status === 'CONFIRMED') {
          MLBridgeService.sendFeedback("pricing-bandit", "BOOKING_CONFIRMED", 1.0, { 
            bookingId: data.id, 
            propertyId: data.propertyId,
            orgId: data.orgId 
          }).catch(console.error);
        } else if ((body as any).status === 'CANCELLED') {
          MLBridgeService.sendFeedback("pricing-bandit", "BOOKING_CANCELLED", -1.0, { 
            bookingId: data.id, 
            propertyId: data.propertyId,
            orgId: data.orgId 
          }).catch(console.error);
        }
      }
      
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Booking not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: BookingPlainInputUpdate
  })

  /**
   * DELETE /booking/:id
   * Deletes a Booking.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await bookingService.withDB(db as any).delete(params.id);
      return { success: true, message: "Booking deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Booking not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
