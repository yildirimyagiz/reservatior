import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { socialAccountMetricService } from "../services/socialaccountmetric";
import { 
  SocialAccountMetricPlainInputCreate, 
  SocialAccountMetricPlainInputUpdate 
} from "../../generated/prismabox/SocialAccountMetric";

export const socialAccountMetricRoutes = new Elysia({ prefix: "/social-accountmetric" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return socialAccountMetricService.getAll({
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
    const data = await socialAccountMetricService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SocialAccountMetricPlainInputCreate
  })

  .get("/:id", async ({ params, set }) => {
    const data = await socialAccountMetricService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SocialAccountMetric not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await socialAccountMetricService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SocialAccountMetric not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SocialAccountMetricPlainInputUpdate
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await socialAccountMetricService.delete(params.id);
      return { success: true, message: "SocialAccountMetric deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SocialAccountMetric not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
