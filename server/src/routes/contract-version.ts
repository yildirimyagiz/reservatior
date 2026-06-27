import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { contractVersionService } from "../services/contractversion";
import { 
  ContractVersionPlainInputCreate, 
  ContractVersionPlainInputUpdate 
} from "../../generated/prismabox/ContractVersion";
import { regionMiddleware } from "../middleware/region";

export const contractVersionRoutes = new Elysia({ prefix: "/contract-versions" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /contract-version
   * Retrieves all ContractVersion with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return contractVersionService.withDB(db as any).getAll({
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
   * POST /contract-version
   * Creates a new ContractVersion.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await contractVersionService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ContractVersionPlainInputCreate
  })

  /**
   * GET /contract-version/:id
   * Retrieves a single ContractVersion by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await contractVersionService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ContractVersion not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /contract-version/:id
   * Updates an existing ContractVersion.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await contractVersionService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ContractVersion not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ContractVersionPlainInputUpdate
  })

  /**
   * DELETE /contract-version/:id
   * Deletes a ContractVersion.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await contractVersionService.withDB(db as any).delete(params.id);
      return { success: true, message: "ContractVersion deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ContractVersion not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
