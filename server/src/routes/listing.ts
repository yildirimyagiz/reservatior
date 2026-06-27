import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { regionMiddleware } from "../middleware/region";
import { listingService } from "../services/listing";
import { 
  ListingPlainInputCreate, 
  ListingPlainInputUpdate 
} from "../../generated/prismabox/Listing";

export const listingRoutes = new Elysia({ prefix: "/listing" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /listing
   * Retrieves all Listing with pagination and basic filtering.
   */
  .get("/", async ({ query, db, orgId, userId }) => {
    const { page = "1", limit = "20", mine, ...where } = query as any;
    const regionDb = db as any;

    // Filter by the user's organization if present
    if (orgId) {
      where.orgId = orgId;
    }

    // If mine=true, filter by the current user's ownership
    if (mine === "true" && userId) {
      where.OR = [
        { userId },
        { agentId: userId },
        { agencyId: userId },
        { createdBy: userId }
      ];
    }

    const listings = await regionDb.listing.findMany({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" },
      include: {
        property: true,
        category: true,
        user: { select: { id: true, name: true, email: true } },
        agent: { select: { id: true, name: true, email: true } },
        agency: { select: { id: true, name: true } },
        tags: { include: { tag: true } }
      }
    });

    const total = await regionDb.listing.count({ where });

    return { 
      data: listings, 
      total, 
      page: Math.floor((parseInt(page) - 1) / parseInt(limit)) + 1,
      limit: parseInt(limit) 
    };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
      mine: t.Optional(t.String()),
      userId: t.Optional(t.String()),
      agentId: t.Optional(t.String()),
      agencyId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /listing
   * Creates a new Listing.
   */
  .post("/", async ({ body, set, orgId, userId, role, db }) => {
    if (!orgId) {
      set.status = 401;
      return { error: "Organization ID is required to create a listing." };
    }

    const { PrismaClient } = await import("@prisma/client");
    const globalPrisma = new PrismaClient();
    const regionDb = db as any;

    // Get active subscription
    const activeSub = await globalPrisma.subscription.findFirst({
      where: { orgId, isActive: true },
      orderBy: { createdAt: "desc" }
    });

    const maxListings = activeSub ? activeSub.maxListings : 1; // Default to 1 if no subscription

    // Check current usage
    const currentListingsCount = await regionDb.listing.count({
      where: { orgId }
    });

    if (currentListingsCount >= maxListings) {
      set.status = 403;
      return { 
        error: `Quota Exceeded: Your subscription allows a maximum of ${maxListings} listings. You currently have ${currentListingsCount}. Please upgrade your subscription to add more.` 
      };
    }

    // Assign orgId and appropriate ownership ID based on role
    const dataToCreate = { 
      ...body, 
      orgId,
      createdBy: userId || undefined,
    } as any;

    if (role === "AGENCY") {
      dataToCreate.agencyId = userId;
    } else if (role === "AGENT") {
      dataToCreate.agentId = userId;
    } else {
      dataToCreate.userId = userId;
    }

    const data = await regionDb.listing.create({ data: dataToCreate });
    set.status = 201;
    return { data };
  }, {
    body: ListingPlainInputCreate
  })

  /**
   * GET /listing/:id
   * Retrieves a single Listing by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await listingService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Listing not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /listing/:id
   * Updates an existing Listing.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await listingService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Listing not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ListingPlainInputUpdate
  })

  /**
   * DELETE /listing/:id
   * Deletes a Listing.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await listingService.delete(params.id);
      return { success: true, message: "Listing deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Listing not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
