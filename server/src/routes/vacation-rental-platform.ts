import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { vacationRentalPlatformService } from "../services/vacationrentalplatform";
import { 
  VacationRentalPlatformPlainInputCreate, 
  VacationRentalPlatformPlainInputUpdate 
} from "../../generated/prismabox/VacationRentalPlatform";

export const vacationRentalPlatformRoutes = new Elysia({ prefix: "/vacation-rental-platforms" })
  .use(authMiddleware)

  /**
   * GET /vacation-rental-platform
   * Retrieves all VacationRentalPlatform with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return vacationRentalPlatformService.getAll({
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
   * POST /vacation-rental-platform
   * Creates a new VacationRentalPlatform.
   */
  .post("/", async ({ body, set }) => {
    const data = await vacationRentalPlatformService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: VacationRentalPlatformPlainInputCreate
  })

  /**
   * GET /vacation-rental-platform/:id
   * Retrieves a single VacationRentalPlatform by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await vacationRentalPlatformService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "VacationRentalPlatform not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /vacation-rental-platform/:id
   * Updates an existing VacationRentalPlatform.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await vacationRentalPlatformService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "VacationRentalPlatform not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: VacationRentalPlatformPlainInputUpdate
  })

  /**
   * DELETE /vacation-rental-platform/:id
   * Deletes a VacationRentalPlatform.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await vacationRentalPlatformService.delete(params.id);
      return { success: true, message: "VacationRentalPlatform deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "VacationRentalPlatform not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
