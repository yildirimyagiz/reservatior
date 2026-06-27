import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { userPreferenceService } from "../services/userpreference";
import { prisma } from "../lib/prisma";
import { 
  UserPreferencePlainInputCreate, 
  UserPreferencePlainInputUpdate 
} from "../../generated/prismabox/UserPreference";
import { regionMiddleware } from "../middleware/region";

export const userPreferenceRoutes = new Elysia({ prefix: "/user-preferences" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /user-preference
   * Retrieves all UserPreference with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return userPreferenceService.withDB(db as any).getAll({
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
   * POST /user-preference
   * Creates a new UserPreference.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await userPreferenceService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: UserPreferencePlainInputCreate
  })

  /**
   * GET /user-preference/:id
   * Retrieves a single UserPreference by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await userPreferenceService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "UserPreference not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /user-preference/:id
   * Updates an existing UserPreference.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await userPreferenceService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "UserPreference not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: UserPreferencePlainInputUpdate
  })

  /**
   * DELETE /user-preference/:id
   * Deletes a UserPreference.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await userPreferenceService.withDB(db as any).delete(params.id);
      return { success: true, message: "UserPreference deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "UserPreference not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * GET /user-preference/user/:userId
   * Retrieves all preferences for a specific user
   */
  .get("/user/:userId", async ({ orgId, db, params }) => {
    const data = await prisma.userPreference.findFirst({
      where: { userId: params.userId }
    });
    return { data };
  }, {
    params: t.Object({ userId: t.String() })
  })

  /**
   * GET /user-preference/user/:userId/key/:key
   * Retrieves a specific preference by key for a user
   */
  .get("/user/:userId/key/:key", async ({ orgId, db, params, set }) => {
    const data = await prisma.userPreference.findFirst({
      where: { userId: params.userId }
    });
    
    if (!data) {
      set.status = 404;
      return { error: "Preference not found" };
    }
    return { data: (data as any)[params.key] };
  }, {
    params: t.Object({ 
      userId: t.String(),
      key: t.String()
    })
  })

  /**
   * PUT /user-preference/user/:userId/:key
   * Upserts a specific preference by key for a user
   */
  .put("/user/:userId/:key", async ({ orgId, db, params, body }) => {
    const { value } = body as any;
    
    const existing = await prisma.userPreference.findFirst({
      where: { userId: params.userId }
    });

    let data;
    if (existing) {
      data = await prisma.userPreference.update({
        where: { id: existing.id },
        data: { [params.key]: value }
      });
    } else {
      data = await prisma.userPreference.create({
        data: {
          userId: params.userId,
          [params.key]: value
        } as any
      });
    }
    
    return { data };
  }, {
    params: t.Object({ 
      userId: t.String(),
      key: t.String()
    }),
    body: t.Object({
      value: t.Any()
    })
  })

  /**
   * PUT /user-preference/user/:userId/bulk
   * Bulk updates multiple preferences for a user
   */
  .put("/user/:userId/bulk", async ({ orgId, db, params, body }) => {
    const { preferences } = body as any;
    
    const existing = await prisma.userPreference.findFirst({
      where: { userId: params.userId }
    });

    let data;
    if (existing) {
      data = await prisma.userPreference.update({
        where: { id: existing.id },
        data: preferences
      });
    } else {
      data = await prisma.userPreference.create({
        data: {
          userId: params.userId,
          ...preferences
        } as any
      });
    }
    
    return { data: [data], success: true };
  }, {
    params: t.Object({ userId: t.String() }),
    body: t.Object({
      preferences: t.Record(t.String(), t.Any())
    })
  });
