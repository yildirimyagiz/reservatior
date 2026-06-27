import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { contractService } from "../services/contract";
import { 
  ContractPlainInputCreate, 
  ContractPlainInputUpdate 
} from "../../generated/prismabox/Contract";
import { regionMiddleware } from "../middleware/region";

export const contractRoutes = new Elysia({ prefix: "/contract" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /contract
   * Retrieves all Contract with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return contractService.withDB(db as any).getAll({
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
   * POST /contract
   * Creates a new Contract.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await contractService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ContractPlainInputCreate
  })

  /**
   * GET /contract/:id
   * Retrieves a single Contract by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await contractService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Contract not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /contract/:id
   * Updates an existing Contract.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await contractService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Contract not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ContractPlainInputUpdate
  })

  /**
   * DELETE /contract/:id
   * Deletes a Contract.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await contractService.withDB(db as any).delete(params.id);
      return { success: true, message: "Contract deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Contract not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
