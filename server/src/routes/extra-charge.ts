import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { extraChargeService } from "../services/extracharge";
import { 
  ExtraChargePlainInputCreate, 
  ExtraChargePlainInputUpdate 
} from "../../generated/prismabox/ExtraCharge";

export const extraChargeRoutes = new Elysia({ prefix: "/extra-charge" })
  .use(authMiddleware)

  /**
   * GET /extra-charge
   * Retrieves all ExtraCharge with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return extraChargeService.getAll({
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
   * POST /extra-charge
   * Creates a new ExtraCharge.
   */
  .post("/", async ({ body, set }) => {
    const data = await extraChargeService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExtraChargePlainInputCreate
  })

  /**
   * GET /extra-charge/:id
   * Retrieves a single ExtraCharge by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await extraChargeService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ExtraCharge not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /extra-charge/:id
   * Updates an existing ExtraCharge.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await extraChargeService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ExtraCharge not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ExtraChargePlainInputUpdate
  })

  /**
   * DELETE /extra-charge/:id
   * Deletes a ExtraCharge.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await extraChargeService.delete(params.id);
      return { success: true, message: "ExtraCharge deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ExtraCharge not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
