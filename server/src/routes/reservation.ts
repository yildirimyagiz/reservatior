import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { reservationService } from "../services/reservation";
import { 
  ReservationPlainInputCreate, 
  ReservationPlainInputUpdate 
} from "../../generated/prismabox/Reservation";
import { regionMiddleware } from "../middleware/region";

export const reservationRoutes = new Elysia({ prefix: "/reservation" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /reservation
   * Retrieves all Reservation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return reservationService.withDB(db as any).getAll({
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
   * POST /reservation
   * Creates a new Reservation.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await reservationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReservationPlainInputCreate
  })

  /**
   * GET /reservation/:id
   * Retrieves a single Reservation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await reservationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Reservation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /reservation/:id
   * Updates an existing Reservation.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await reservationService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Reservation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ReservationPlainInputUpdate
  })

  /**
   * DELETE /reservation/:id
   * Deletes a Reservation.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await reservationService.withDB(db as any).delete(params.id);
      return { success: true, message: "Reservation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Reservation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
