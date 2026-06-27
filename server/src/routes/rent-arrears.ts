import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { rentArrearsService } from "../services/rentarrears";
import { 
  RentArrearsPlainInputCreate, 
  RentArrearsPlainInputUpdate 
} from "../../generated/prismabox/RentArrears";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const rentArrearsRoutes = new Elysia({ prefix: "/rent-arrears" })
  .use(authMiddleware)

  /**
   * GET /rent-arrears
   * Retrieves all RentArrears with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return rentArrearsService.getAll({
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
   * POST /rent-arrears
   * Creates a new RentArrears.
   */
  .post("/", async ({ body, set }) => {
    const data = await rentArrearsService.create(body);
    
    // ML Feedback Loop: Financial Default -> Massive Risk Penalty
    if (data.arrearsAmount && Number(data.arrearsAmount) > 0) {
      MLBridgeService.sendFeedback("tenant-screening", "FINANCIAL_DEFAULT", -10.0, {
        arrearsId: data.id,
        tenantId: data.tenantId,
        leaseId: data.leaseId,
        arrearsAmount: data.arrearsAmount
      }).catch(console.error);
    }

    set.status = 201;
    return { data };
  }, {
    body: RentArrearsPlainInputCreate
  })

  /**
   * GET /rent-arrears/:id
   * Retrieves a single RentArrears by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await rentArrearsService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "RentArrears not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /rent-arrears/:id
   * Updates an existing RentArrears.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await rentArrearsService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "RentArrears not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: RentArrearsPlainInputUpdate
  })

  /**
   * DELETE /rent-arrears/:id
   * Deletes a RentArrears.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await rentArrearsService.delete(params.id);
      return { success: true, message: "RentArrears deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "RentArrears not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
