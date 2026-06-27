import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { vacationRentalService } from "../services/vacationrental";
import { 
  VacationRentalPlainInputCreate, 
  VacationRentalPlainInputUpdate 
} from "../../generated/prismabox/VacationRental";

export const vacationRentalRoutes = new Elysia({ prefix: "/vacation-rentals" })
  .use(authMiddleware)

  /**
   * GET /vacation-rental
   * Retrieves all VacationRental with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return vacationRentalService.getAll({
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
   * POST /vacation-rental
   * Creates a new VacationRental.
   */
  .post("/", async ({ body, set }) => {
    const data = await vacationRentalService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VacationRentalPlainInputCreate
  })

  /**
   * GET /vacation-rental/:id
   * Retrieves a single VacationRental by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await vacationRentalService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VacationRental not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /vacation-rental/:id
   * Updates an existing VacationRental.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await vacationRentalService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VacationRental not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VacationRentalPlainInputUpdate
  })

  /**
   * DELETE /vacation-rental/:id
   * Deletes a VacationRental.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await vacationRentalService.delete(params.id);
      return { success: true, message: "VacationRental deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VacationRental not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
