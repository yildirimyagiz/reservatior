import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { photoService } from "../services/photo";
import { 
  PhotoPlainInputCreate, 
  PhotoPlainInputUpdate 
} from "../../generated/prismabox/Photo";
import { regionMiddleware } from "../middleware/region";

export const photoRoutes = new Elysia({ prefix: "/photos" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /photo
   * Retrieves all Photo with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return photoService.withDB(db as any).getAll({
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
   * POST /photo
   * Creates a new Photo.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await photoService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PhotoPlainInputCreate
  })

  /**
   * GET /photo/:id
   * Retrieves a single Photo by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await photoService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Photo not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /photo/:id
   * Updates an existing Photo.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await photoService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Photo not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PhotoPlainInputUpdate
  })

  /**
   * DELETE /photo/:id
   * Deletes a Photo.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await photoService.withDB(db as any).delete(params.id);
      return { success: true, message: "Photo deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Photo not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
