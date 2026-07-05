import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { contractService } from "../services/contract";
import { contractMutator, ContractState } from "../services/contract-mutator";
import { isExecutionLocked } from "../lib/config/execution-lock";
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
  .post("/", async ({ orgId, db, body, set, region }) => {
    const forceSMM = isExecutionLocked(region, "forceContractStateMachine");
    let data;
    if (forceSMM) {
      data = await contractService.withDB(db as any).createWithLifecycle(body, region);
    } else {
      data = await contractService.withDB(db as any).create(body);
    }
    set.status = 201;
    return { data };
  }, {
    body: ContractPlainInputCreate
  })

  /**
   * GET /contract/:id
   * Retrieves a single Contract by ID with its transition history.
   */
  .get("/:id", async ({ orgId, db, params, set, region }) => {
    const data = await contractService.withDB(db as any).getContractWithLifecycle(params.id, region);
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
   * Updates an existing Contract. Direct status updates are blocked if SMM is forced.
   */
  .patch("/:id", async ({ orgId, db, params, body, set, region }) => {
    try {
      const updateData = body as any;
      if (updateData.status && isExecutionLocked(region, "forceContractStateMachine")) {
        set.status = 403;
        return { 
          error: "CONTRACT_STATE_MACHINE_REQUIRED: Direct status updates are blocked. Use /contract/{id}/transition endpoint instead.",
          code: "EXECUTION_LOCK_ACTIVE"
        };
      }
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
  })

  /**
   * POST /contract/:id/transition
   * Performs a lifecycle transition on the contract.
   */
  .post("/:id/transition", async ({ params, body, set, region }) => {
    try {
      const { toState, triggerEvent, metadata } = body as { toState: ContractState; triggerEvent: string; metadata?: any };
      const updated = await contractMutator.withRegion(region).transition(params.id, toState, triggerEvent, metadata);
      return { data: updated };
    } catch (error: any) {
      set.status = 400;
      return { error: error.message || "Transition failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      toState: t.String(),
      triggerEvent: t.String(),
      metadata: t.Optional(t.Any())
    })
  })

  /**
   * GET /contract/:id/can-transition
   * Checks if a lifecycle transition is allowed on the contract.
   */
  .get("/:id/can-transition", async ({ params, query, region }) => {
    const { toState } = query as { toState: ContractState };
    const check = await contractMutator.withRegion(region).canTransition(params.id, toState);
    return check;
  }, {
    params: t.Object({ id: t.String() }),
    query: t.Object({
      toState: t.String()
    })
  });
