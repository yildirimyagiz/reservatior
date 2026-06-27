import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ambassadorContractService } from "../services/ambassadorcontract";
import { 
  AmbassadorContractPlainInputCreate, 
  AmbassadorContractPlainInputUpdate 
} from "../../generated/prismabox/AmbassadorContract";
import { regionMiddleware } from "../middleware/region";

export const ambassadorContractRoutes = new Elysia({ prefix: "/ambassador-contracts" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /ambassador-contract
   * Retrieves all AmbassadorContract with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return ambassadorContractService.withDB(db as any).getAll({
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
   * POST /ambassador-contract
   * Creates a new AmbassadorContract.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await ambassadorContractService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: AmbassadorContractPlainInputCreate
  })

  /**
   * GET /ambassador-contract/:id
   * Retrieves a single AmbassadorContract by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await ambassadorContractService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "AmbassadorContract not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ambassador-contract/:id
   * Updates an existing AmbassadorContract.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await ambassadorContractService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "AmbassadorContract not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: AmbassadorContractPlainInputUpdate
  })

  /**
   * DELETE /ambassador-contract/:id
   * Deletes a AmbassadorContract.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await ambassadorContractService.withDB(db as any).delete(params.id);
      return { success: true, message: "AmbassadorContract deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AmbassadorContract not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
