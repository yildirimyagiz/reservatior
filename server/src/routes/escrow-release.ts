import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { escrowReleaseService } from "../services/escrowrelease";
import { 
  EscrowReleasePlainInputCreate, 
  EscrowReleasePlainInputUpdate 
} from "../../generated/prismabox/EscrowRelease";

export const escrowReleaseRoutes = new Elysia({ prefix: "/escrow-release" })
  .use(authMiddleware)

  /**
   * GET /escrow-release
   * Retrieves all EscrowRelease with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return escrowReleaseService.getAll({
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
   * POST /escrow-release
   * Creates a new EscrowRelease.
   */
  .post("/", async ({ body, set }) => {
    const data = await escrowReleaseService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: EscrowReleasePlainInputCreate
  })

  /**
   * GET /escrow-release/:id
   * Retrieves a single EscrowRelease by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await escrowReleaseService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "EscrowRelease not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /escrow-release/:id
   * Updates an existing EscrowRelease.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await escrowReleaseService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowRelease not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: EscrowReleasePlainInputUpdate
  })

  /**
   * DELETE /escrow-release/:id
   * Deletes a EscrowRelease.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await escrowReleaseService.delete(params.id);
      return { success: true, message: "EscrowRelease deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "EscrowRelease not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
