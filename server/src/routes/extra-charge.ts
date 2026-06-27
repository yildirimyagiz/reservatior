import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { extraChargeService } from "../services/extracharge";
import { 
  ExtraChargePlainInputCreate, 
  ExtraChargePlainInputUpdate 
} from "../../generated/prismabox/ExtraCharge";
import { regionMiddleware } from "../middleware/region";

export const extraChargeRoutes = new Elysia({ prefix: "/extra-charge" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /extra-charge
   * Retrieves all ExtraCharge with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return extraChargeService.withDB(db as any).getAll({
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
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await extraChargeService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ExtraChargePlainInputCreate
  })

  /**
   * GET /extra-charge/:id
   * Retrieves a single ExtraCharge by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await extraChargeService.withDB(db as any).getById(params.id);
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
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await extraChargeService.withDB(db as any).update(params.id, body);
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
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await extraChargeService.withDB(db as any).delete(params.id);
      return { success: true, message: "ExtraCharge deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ExtraCharge not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
