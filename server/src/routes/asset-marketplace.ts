import { Elysia, t } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { assetMarketplaceService } from "../services/asset-marketplace";

export const assetMarketplaceRoutes = new Elysia({ prefix: "/asset-marketplace" })
  .use(authMiddleware)

  .get("/", async ({ query }) => {
    const filters = {
      city: query.city,
      country: query.country,
      minPrice: query.minPrice ? Number(query.minPrice) : undefined,
      maxPrice: query.maxPrice ? Number(query.maxPrice) : undefined,
      minBedrooms: query.minBedrooms ? Number(query.minBedrooms) : undefined,
      maxBedrooms: query.maxBedrooms ? Number(query.maxBedrooms) : undefined,
      minYield: query.minYield ? Number(query.minYield) : undefined,
      maxYield: query.maxYield ? Number(query.maxYield) : undefined,
      listingType: query.listingType,
      certificateTier: query.certificateTier,
      minTrustScore: query.minTrustScore ? Number(query.minTrustScore) : undefined,
      sortBy: query.sortBy,
      page: query.page ? Number(query.page) : 1,
      limit: query.limit ? Number(query.limit) : 20,
    };
    return assetMarketplaceService.listAssets(filters);
  }, {
    query: t.Object({
      city: t.Optional(t.String()),
      country: t.Optional(t.String()),
      minPrice: t.Optional(t.String()),
      maxPrice: t.Optional(t.String()),
      minBedrooms: t.Optional(t.String()),
      maxBedrooms: t.Optional(t.String()),
      minYield: t.Optional(t.String()),
      maxYield: t.Optional(t.String()),
      listingType: t.Optional(t.String()),
      certificateTier: t.Optional(t.String()),
      minTrustScore: t.Optional(t.String()),
      sortBy: t.Optional(t.String()),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: {
      summary: "List Asset Listings",
      description: "List income-verified residential properties available for investment with filters",
      tags: ["Asset Marketplace"]
    }
  })

  .get("/summary", async () => {
    return assetMarketplaceService.getMarketplaceSummary();
  }, {
    detail: {
      summary: "Marketplace Summary",
      description: "Get aggregate marketplace statistics including total value, yield, and trust scores",
      tags: ["Asset Marketplace"]
    }
  })

  .get("/opportunities", async ({ query }) => {
    const limit = query.limit ? Number(query.limit) : 10;
    return assetMarketplaceService.getInvestmentOpportunities(limit);
  }, {
    query: t.Object({
      limit: t.Optional(t.String()),
    }),
    detail: {
      summary: "Investment Opportunities",
      description: "Get top-ranked investment opportunities with risk analysis and recommendations",
      tags: ["Asset Marketplace"]
    }
  })

  .get("/property/:propertyId", async ({ params, set }) => {
    try {
      return await assetMarketplaceService.getPropertyMarketData(params.propertyId);
    } catch (e: any) {
      set.status = 404;
      return { error: e.message || "Property not found" };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: {
      summary: "Property Market Data",
      description: "Get detailed market data for a property including comparables and trends",
      tags: ["Asset Marketplace"]
    }
  });
