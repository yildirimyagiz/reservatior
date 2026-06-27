import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { contactService } from "../services/contact";
import { 
  ContactPlainInputCreate, 
  ContactPlainInputUpdate 
} from "../../generated/prismabox/Contact";
import { regionMiddleware } from "../middleware/region";

export const contactRoutes = new Elysia({ prefix: "/contact" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /contact
   * Retrieves all Contact with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return contactService.withDB(db as any).getAll({
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
   * POST /contact
   * Creates a new Contact.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await contactService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ContactPlainInputCreate
  })

  /**
   * GET /contact/:id
   * Retrieves a single Contact by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await contactService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Contact not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /contact/:id
   * Updates an existing Contact.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await contactService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Contact not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ContactPlainInputUpdate
  })

  /**
   * DELETE /contact/:id
   * Deletes a Contact.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await contactService.withDB(db as any).delete(params.id);
      return { success: true, message: "Contact deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Contact not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
