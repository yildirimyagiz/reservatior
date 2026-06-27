import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { userValuationPreferenceService } from "../services/uservaluationpreference";
import { 
  UserValuationPreferencePlainInputCreate, 
  UserValuationPreferencePlainInputUpdate 
} from "../../generated/prismabox/UserValuationPreference";

export const userValuationPreferenceRoutes = new Elysia({ prefix: "/user-valuation-preference" })
  .use(authMiddleware)

  /**
   * GET /user-valuation-preference
   * Retrieves all UserValuationPreference with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return userValuationPreferenceService.getAll({
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
   * POST /user-valuation-preference
   * Creates a new UserValuationPreference.
   */
  .post("/", async ({ body, set }) => {
    const data = await userValuationPreferenceService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: UserValuationPreferencePlainInputCreate
  })

  /**
   * GET /user-valuation-preference/:id
   * Retrieves a single UserValuationPreference by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await userValuationPreferenceService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "UserValuationPreference not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /user-valuation-preference/:id
   * Updates an existing UserValuationPreference.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await userValuationPreferenceService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "UserValuationPreference not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: UserValuationPreferencePlainInputUpdate
  })

  /**
   * DELETE /user-valuation-preference/:id
   * Deletes a UserValuationPreference.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await userValuationPreferenceService.delete(params.id);
      return { success: true, message: "UserValuationPreference deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "UserValuationPreference not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
