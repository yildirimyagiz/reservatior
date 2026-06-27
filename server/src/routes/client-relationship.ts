import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { clientRelationshipService } from "../services/clientrelationship";
import { 
  ClientRelationshipPlainInputCreate, 
  ClientRelationshipPlainInputUpdate 
} from "../../generated/prismabox/ClientRelationship";

export const clientRelationshipRoutes = new Elysia({ prefix: "/client-relationship" })
  .use(authMiddleware)

  /**
   * GET /client-relationship
   * Retrieves all ClientRelationship with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return clientRelationshipService.getAll({
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
   * POST /client-relationship
   * Creates a new ClientRelationship.
   */
  .post("/", async ({ body, set }) => {
    const data = await clientRelationshipService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: ClientRelationshipPlainInputCreate
  })

  /**
   * GET /client-relationship/:id
   * Retrieves a single ClientRelationship by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await clientRelationshipService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ClientRelationship not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /client-relationship/:id
   * Updates an existing ClientRelationship.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await clientRelationshipService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ClientRelationship not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ClientRelationshipPlainInputUpdate
  })

  /**
   * DELETE /client-relationship/:id
   * Deletes a ClientRelationship.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await clientRelationshipService.delete(params.id);
      return { success: true, message: "ClientRelationship deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ClientRelationship not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
