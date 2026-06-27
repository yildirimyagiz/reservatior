import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { homeInformationPackService } from "../services/homeinformationpack";
import { 
  HomeInformationPackPlainInputCreate, 
  HomeInformationPackPlainInputUpdate 
} from "../../generated/prismabox/HomeInformationPack";
import { regionMiddleware } from "../middleware/region";

export const homeInformationPackRoutes = new Elysia({ prefix: "/home-information-pack" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /home-information-pack
   * Retrieves all HomeInformationPack with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return homeInformationPackService.withDB(db as any).getAll({
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
   * POST /home-information-pack
   * Creates a new HomeInformationPack.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await homeInformationPackService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: HomeInformationPackPlainInputCreate
  })

  /**
   * GET /home-information-pack/:id
   * Retrieves a single HomeInformationPack by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await homeInformationPackService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "HomeInformationPack not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /home-information-pack/:id
   * Updates an existing HomeInformationPack.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await homeInformationPackService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "HomeInformationPack not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: HomeInformationPackPlainInputUpdate
  })

  /**
   * DELETE /home-information-pack/:id
   * Deletes a HomeInformationPack.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await homeInformationPackService.withDB(db as any).delete(params.id);
      return { success: true, message: "HomeInformationPack deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "HomeInformationPack not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
