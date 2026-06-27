import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { channelService } from "../services/channel";
import { 
  ChannelPlainInputCreate, 
  ChannelPlainInputUpdate 
} from "../../generated/prismabox/Channel";

export const channelRoutes = new Elysia({ prefix: "/communications/channels" })
  .use(authMiddleware)

  /**
   * GET /channel
   * Retrieves all Channel with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return channelService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await channelService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ChannelPlainInputCreate
  })

  /**
   * GET /channel/:id
   * Retrieves a single Channel by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await channelService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await channelService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await channelService.delete(params.id);
      return { success: true, message: "Channel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Channel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
