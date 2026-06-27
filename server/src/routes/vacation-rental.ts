import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { vacationRentalService } from "../services/vacationrental";
import { 
  VacationRentalPlainInputCreate, 
  VacationRentalPlainInputUpdate 
} from "../../generated/prismabox/VacationRental";
import { regionMiddleware } from "../middleware/region";

export const vacationRentalRoutes = new Elysia({ prefix: "/vacation-rentals" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /vacation-rental
   * Retrieves all VacationRental with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return vacationRentalService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await vacationRentalService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: VacationRentalPlainInputCreate
  })

  /**
   * GET /vacation-rental/:id
   * Retrieves a single VacationRental by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await vacationRentalService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await vacationRentalService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await vacationRentalService.withDB(db as any).delete(params.id);
      return { success: true, message: "VacationRental deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VacationRental not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
