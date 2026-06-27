import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { referralService } from "../services/referral";
import { 
  ReferralPlainInputCreate, 
  ReferralPlainInputUpdate 
} from "../../generated/prismabox/Referral";

export const referralRoutes = new Elysia({ prefix: "/referrals" })
  .use(authMiddleware)

  /**
   * GET /referral
   * Retrieves all Referral with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return referralService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await referralService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReferralPlainInputCreate
  })

  /**
   * GET /referral/:id
   * Retrieves a single Referral by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await referralService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await referralService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await referralService.delete(params.id);
      return { success: true, message: "Referral deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Referral not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
