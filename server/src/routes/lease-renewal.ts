import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { leaseRenewalService } from "../services/leaserenewal";
import { 
  LeaseRenewalPlainInputCreate, 
  LeaseRenewalPlainInputUpdate 
} from "../../generated/prismabox/LeaseRenewal";

export const leaseRenewalRoutes = new Elysia({ prefix: "/lease-renewals" })
  .use(authMiddleware)

  /**
   * GET /lease-renewal
   * Retrieves all LeaseRenewal with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return leaseRenewalService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { id: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /lease-renewal
   * Creates a new LeaseRenewal.
   */
  .post("/", async ({ body, set }) => {
    const data = await leaseRenewalService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: LeaseRenewalPlainInputCreate
  })

  /**
   * GET /lease-renewal/:id
   * Retrieves a single LeaseRenewal by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await leaseRenewalService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "LeaseRenewal not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /lease-renewal/:id
   * Updates an existing LeaseRenewal.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await leaseRenewalService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "LeaseRenewal not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: LeaseRenewalPlainInputUpdate
  })

  /**
   * DELETE /lease-renewal/:id
   * Deletes a LeaseRenewal.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await leaseRenewalService.delete(params.id);
      return { success: true, message: "LeaseRenewal deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "LeaseRenewal not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
