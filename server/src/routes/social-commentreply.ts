import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { socialCommentReplyService } from "../services/socialcommentreply";
import { 
  SocialCommentReplyPlainInputCreate, 
  SocialCommentReplyPlainInputUpdate 
} from "../../generated/prismabox/SocialCommentReply";

export const socialCommentReplyRoutes = new Elysia({ prefix: "/social-commentreply" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return socialCommentReplyService.getAll({
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
    // Security Measure: Prevent sharing phone numbers in comments/replies
    const phoneRegex = /(?:\d[\s\-\.\_]?){8,}/;
    if (body.text && phoneRegex.test(body.text)) {
      set.status = 400;
      return { error: "Security Policy: Phone numbers are not allowed in comments/replies for your safety." };
    }

    const data = await socialCommentReplyService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: SocialCommentReplyPlainInputCreate
  })

  .get("/:id", async ({ params, set }) => {
    const data = await socialCommentReplyService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "SocialCommentReply not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  .patch("/:id", async ({ params, body, set }) => {
    // Security Measure: Prevent sharing phone numbers in comments/replies
    const phoneRegex = /(?:\d[\s\-\.\_]?){8,}/;
    if (body.text && typeof body.text === 'string' && phoneRegex.test(body.text)) {
      set.status = 400;
      return { error: "Security Policy: Phone numbers are not allowed in comments/replies for your safety." };
    }

    try {
      const data = await socialCommentReplyService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "SocialCommentReply not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: SocialCommentReplyPlainInputUpdate
  })

  .delete("/:id", async ({ params, set }) => {
    try {
      await socialCommentReplyService.delete(params.id);
      return { success: true, message: "SocialCommentReply deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "SocialCommentReply not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
