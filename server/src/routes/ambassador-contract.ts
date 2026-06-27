import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ambassadorContractService } from "../services/ambassadorcontract";
import { 
  AmbassadorContractPlainInputCreate, 
  AmbassadorContractPlainInputUpdate 
} from "../../generated/prismabox/AmbassadorContract";

export const ambassadorContractRoutes = new Elysia({ prefix: "/ambassador-contracts" })
  .use(authMiddleware)

  /**
   * GET /ambassador-contract
   * Retrieves all AmbassadorContract with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return ambassadorContractService.getAll({
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
  .post("/", async ({ body, set }) => {
    const data = await ambassadorContractService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: AmbassadorContractPlainInputCreate
  })

  /**
   * GET /ambassador-contract/:id
   * Retrieves a single AmbassadorContract by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await ambassadorContractService.getById(params.id);
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
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await ambassadorContractService.update(params.id, body);
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
  .delete("/:id", async ({ params, set }) => {
    try {
      await ambassadorContractService.delete(params.id);
      return { success: true, message: "AmbassadorContract deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "AmbassadorContract not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
