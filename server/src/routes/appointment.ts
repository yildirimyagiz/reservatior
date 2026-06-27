import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { appointmentService } from "../services/appointment";
import { 
  AppointmentPlainInputCreate, 
  AppointmentPlainInputUpdate 
} from "../../generated/prismabox/Appointment";

export const appointmentRoutes = new Elysia({ prefix: "/appointments" })
  .use(authMiddleware)

  /**
   * GET /appointment
   * Retrieves all Appointment with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return appointmentService.getAll({
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
   * POST /appointment
   * Creates a new Appointment.
   */
  .post("/", async ({ body, set }) => {
    const data = await appointmentService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AppointmentPlainInputCreate
  })

  /**
   * GET /appointment/:id
   * Retrieves a single Appointment by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await appointmentService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Appointment not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /appointment/:id
   * Updates an existing Appointment.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await appointmentService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Appointment not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AppointmentPlainInputUpdate
  })

  /**
   * DELETE /appointment/:id
   * Deletes a Appointment.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await appointmentService.delete(params.id);
      return { success: true, message: "Appointment deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Appointment not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
