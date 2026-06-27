import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { attachmentService } from "../services/attachment";
import { 
  AttachmentPlainInputCreate, 
  AttachmentPlainInputUpdate 
} from "../../generated/prismabox/Attachment";
import { regionMiddleware } from "../middleware/region";

export const attachmentRoutes = new Elysia({ prefix: "/attachment" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /attachment
   * Retrieves all Attachment with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return attachmentService.withDB(db as any).getAll({
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
   * POST /attachment
   * Creates a new Attachment.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await attachmentService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AttachmentPlainInputCreate
  })

  /**
   * GET /attachment/:id
   * Retrieves a single Attachment by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await attachmentService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Attachment not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /attachment/:id
   * Updates an existing Attachment.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await attachmentService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Attachment not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AttachmentPlainInputUpdate
  })

  /**
   * DELETE /attachment/:id
   * Deletes a Attachment.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await attachmentService.withDB(db as any).delete(params.id);
      return { success: true, message: "Attachment deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Attachment not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
