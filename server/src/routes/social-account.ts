import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { socialAccountService } from "../services/socialaccount";
import { 
  SocialAccountPlainInputCreate, 
  SocialAccountPlainInputUpdate 
} from "../../generated/prismabox/SocialAccount";
import { regionMiddleware } from "../middleware/region";

export const socialAccountRoutes = new Elysia({ prefix: "/social-account" })
  .use(authMiddleware)
  .use(regionMiddleware)

  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return socialAccountService.withDB(db as any).getAll({
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

  .post("/", async ({ orgId, db, body, set }) => {
    const data = await socialAccountService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: SocialAccountPlainInputCreate
  })

  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await socialAccountService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SocialAccount not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await socialAccountService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SocialAccount not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SocialAccountPlainInputUpdate
  })

  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await socialAccountService.withDB(db as any).delete(params.id);
      return { success: true, message: "SocialAccount deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SocialAccount not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
