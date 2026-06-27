import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { listingTagService } from "../services/listingtag";
import { 
  ListingTagPlainInputCreate, 
  ListingTagPlainInputUpdate 
} from "../../generated/prismabox/ListingTag";
import { prismaManager } from "../lib/prisma";

export const listingTagRoutes = new Elysia({ prefix: "/listing-tag" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /listing-tag
   * Retrieves all ListingTag with pagination and basic filtering.
   */
  .get("/", async ({ query, db, orgId }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    const regionDb = db as any;
    
    if (orgId) where.orgId = orgId;

    const data = await regionDb.listingTag.findMany({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
      include: { tag: true }
    });
    return { data };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      listingId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /listing-tag/doping
   * Applies a doping tag (e.g., FEATURED, URGENT) to a listing and enforces quota.
   */
  .post("/doping", async ({ body, set, orgId, db }) => {
    if (!orgId) {
      set.status = 401;
      return { error: "Organization ID is required." };
    }

    const { listingId, tagName } = body;
    const regionDb = db as any;

    const globalPrisma = prismaManager.getDefault();

    // 1. Get active subscription
    const activeSub = await globalPrisma.subscription.findFirst({
      where: { orgId, isActive: true },
      orderBy: { createdAt: "desc" }
    });

    // 2. If doping is FEATURED (Öne Çıkan), check quota
    if (tagName === "FEATURED") {
      const maxFeatured = activeSub ? activeSub.featuredListings : 0;
      
      // Count current featured listings for this org
      const currentFeaturedCount = await regionDb.listingTag.count({
        where: { 
          orgId,
          tag: { name: "FEATURED" }
        }
      });

      if (currentFeaturedCount >= maxFeatured) {
        set.status = 403;
        return { 
          error: `Quota Exceeded: Your subscription allows a maximum of ${maxFeatured} featured listings. Please upgrade your package.` 
        };
      }
    }

    // 3. Ensure Tag exists
    let tag = await regionDb.tag.findFirst({
      where: { orgId, name: tagName }
    });

    if (!tag) {
      tag = await regionDb.tag.create({
        data: {
          orgId,
          name: tagName,
          color: tagName === "FEATURED" ? "amber" : "blue"
        }
      });
    }

    // 4. Check if listing already has this tag
    const existing = await regionDb.listingTag.findFirst({
      where: { listingId, tagId: tag.id }
    });

    if (existing) {
      return { data: existing, message: "Listing already has this doping." };
    }

    // 5. Apply Tag
    const data = await regionDb.listingTag.create({
      data: {
        listingId,
        tagId: tag.id,
        orgId
      }
    });

    set.status = 201;
    return { data };
  }, {
    body: t.Object({
      listingId: t.String(),
      tagName: t.String()
    })
  })

  /**
   * POST /listing-tag
   * Creates a new ListingTag.
   */
  .post("/", async ({ body, set, db, orgId }) => {
    const regionDb = db as any;
    const data = await regionDb.listingTag.create({
      data: { ...body, orgId }
    });
    set.status = 201;
    return { data };
  }, {
    body: t.Any()
  })

  /**
   * GET /listing-tag/:id
   * Retrieves a single ListingTag by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await listingTagService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "ListingTag not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /listing-tag/:id
   * Updates an existing ListingTag.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await listingTagService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "ListingTag not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ListingTagPlainInputUpdate
  })

  /**
   * DELETE /listing-tag/:id
   * Deletes a ListingTag.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await listingTagService.withDB(db as any).delete(params.id);
      return { success: true, message: "ListingTag deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "ListingTag not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
