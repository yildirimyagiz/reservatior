import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { channelService } from "../services/channel";
import { 
  ChannelPlainInputCreate, 
  ChannelPlainInputUpdate 
} from "../../generated/prismabox/Channel";
import { regionMiddleware } from "../middleware/region";

export const channelRoutes = new Elysia({ prefix: "/communications/channels" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /channel
   * Retrieves all Channel with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return channelService.withDB(db as any).getAll({
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
   * POST /channel
   * Creates a new Channel.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await channelService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ChannelPlainInputCreate
  })

  /**
   * GET /channel/:id
   * Retrieves a single Channel by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await channelService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Channel not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /channel/:id
   * Updates an existing Channel.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await channelService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Channel not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ChannelPlainInputUpdate
  })

  /**
   * DELETE /channel/:id
   * Deletes a Channel.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await channelService.withDB(db as any).delete(params.id);
      return { success: true, message: "Channel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Channel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
