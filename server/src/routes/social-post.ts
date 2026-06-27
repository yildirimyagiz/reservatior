import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { socialPostService } from "../services/socialpost";
import { 
  SocialPostPlainInputCreate, 
  SocialPostPlainInputUpdate 
} from "../../generated/prismabox/SocialPost";

export const socialPostRoutes = new Elysia({ prefix: "/social-post" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return socialPostService.getAll({
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

  .post("/", async ({ body, set }) => {
    const data = await socialPostService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SocialPostPlainInputCreate
  })

  .get("/:id", async ({ params, set }) => {
    const data = await socialPostService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SocialPost not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await socialPostService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SocialPost not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SocialPostPlainInputUpdate
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await socialPostService.delete(params.id);
      return { success: true, message: "SocialPost deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SocialPost not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
