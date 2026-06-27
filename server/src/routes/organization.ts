import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { organizationService } from "../services/organization";
import { 
  OrganizationPlainInputCreate, 
  OrganizationPlainInputUpdate 
} from "../../generated/prismabox/Organization";

export const organizationRoutes = new Elysia({ prefix: "/organization" })
  .use(authMiddleware)

  /**
   * GET /organization
   * Retrieves all Organization with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return organizationService.getAll({
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
   * POST /organization
   * Creates a new Organization.
   */
  .post("/", async ({ body, set }) => {
    const data = await organizationService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: OrganizationPlainInputCreate
  })

  /**
   * GET /organization/:id
   * Retrieves a single Organization by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await organizationService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Organization not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /organization/:id
   * Updates an existing Organization.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await organizationService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Organization not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: OrganizationPlainInputUpdate
  })

  /**
   * DELETE /organization/:id
   * Deletes a Organization.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await organizationService.delete(params.id);
      return { success: true, message: "Organization deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Organization not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
