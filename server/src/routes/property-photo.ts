import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { propertyPhotoService } from "../services/propertyphoto";
import { prismaManager } from "../lib/prisma";
import { 
  PropertyPhotoPlainInputCreate, 
  PropertyPhotoPlainInputUpdate 
} from "../../generated/prismabox/PropertyPhoto";
import { regionMiddleware } from "../middleware/region";

export const propertyPhotoRoutes = new Elysia({ prefix: "/property-photo" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /property-photo
   * Retrieves all PropertyPhoto with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query, headers }) => {
    const { page = "1", limit = "20", propertyId, ...where } = query as any;
      if (orgId) where.orgId = orgId;
    const region = headers["x-region"] || headers["X-Region"];
    const regionPrisma = region ? prismaManager.getClient(region) : prismaManager.getDefault();
    
    // Use direct query instead of service to avoid relationship issues
    const photos = await regionPrisma.propertyPhoto.findMany({
      where: {
        ...where,
        ...(propertyId && { propertyId }),
      },
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
    
    return { data: photos };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /property-photo
   * Creates a new PropertyPhoto.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await propertyPhotoService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: PropertyPhotoPlainInputCreate
  })

  /**
   * GET /property-photo/:id
   * Retrieves a single PropertyPhoto by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await propertyPhotoService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "PropertyPhoto not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /property-photo/:id
   * Updates an existing PropertyPhoto.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await propertyPhotoService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyPhoto not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: PropertyPhotoPlainInputUpdate
  })

  /**
   * DELETE /property-photo/:id
   * Deletes a PropertyPhoto.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await propertyPhotoService.withDB(db as any).delete(params.id);
      return { success: true, message: "PropertyPhoto deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "PropertyPhoto not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
