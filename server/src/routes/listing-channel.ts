import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { listingChannelService } from "../services/listingchannel";
import { 
  ListingChannelPlainInputCreate, 
  ListingChannelPlainInputUpdate 
} from "../../generated/prismabox/ListingChannel";

export const listingChannelRoutes = new Elysia({ prefix: "/listing-channel" })
  .use(authMiddleware)

  /**
   * GET /listing-channel
   * Retrieves all ListingChannel with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return listingChannelService.getAll({
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
   * POST /listing-channel
   * Creates a new ListingChannel.
   */
  .post("/", async ({ body, set }) => {
    const data = await listingChannelService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ListingChannelPlainInputCreate
  })

  /**
   * GET /listing-channel/:id
   * Retrieves a single ListingChannel by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await listingChannelService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ListingChannel not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /listing-channel/:id
   * Updates an existing ListingChannel.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await listingChannelService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ListingChannel not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ListingChannelPlainInputUpdate
  })

  /**
   * DELETE /listing-channel/:id
   * Deletes a ListingChannel.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await listingChannelService.delete(params.id);
      return { success: true, message: "ListingChannel deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ListingChannel not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
