import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { mLSConnectionService } from "../services/mlsconnection";
import { 
  MLSConnectionPlainInputCreate, 
  MLSConnectionPlainInputUpdate 
} from "../../generated/prismabox/MLSConnection";

export const mlsconnectionRoutes = new Elysia({ prefix: "/mlsconnection" })
  .use(authMiddleware)

  /**
   * GET /mlsconnection
   * Retrieves all MLSConnection with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return mLSConnectionService.getAll({
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
   * POST /mlsconnection
   * Creates a new MLSConnection.
   */
  .post("/", async ({ body, set }) => {
    const data = await mLSConnectionService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: MLSConnectionPlainInputCreate
  })

  /**
   * GET /mlsconnection/:id
   * Retrieves a single MLSConnection by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await mLSConnectionService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "MLSConnection not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /mlsconnection/:id
   * Updates an existing MLSConnection.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await mLSConnectionService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "MLSConnection not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MLSConnectionPlainInputUpdate
  })

  /**
   * DELETE /mlsconnection/:id
   * Deletes a MLSConnection.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await mLSConnectionService.delete(params.id);
      return { success: true, message: "MLSConnection deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "MLSConnection not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
