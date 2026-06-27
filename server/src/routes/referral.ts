import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { referralService } from "../services/referral";
import { 
  ReferralPlainInputCreate, 
  ReferralPlainInputUpdate 
} from "../../generated/prismabox/Referral";
import { regionMiddleware } from "../middleware/region";

export const referralRoutes = new Elysia({ prefix: "/referrals" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /referral
   * Retrieves all Referral with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return referralService.withDB(db as any).getAll({
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
   * POST /referral
   * Creates a new Referral.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await referralService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReferralPlainInputCreate
  })

  /**
   * GET /referral/:id
   * Retrieves a single Referral by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await referralService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Referral not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /referral/:id
   * Updates an existing Referral.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await referralService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Referral not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ReferralPlainInputUpdate
  })

  /**
   * DELETE /referral/:id
   * Deletes a Referral.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await referralService.withDB(db as any).delete(params.id);
      return { success: true, message: "Referral deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Referral not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
