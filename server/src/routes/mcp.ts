import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

/**
 * MCP (Model Context Protocol) Server Endpoint
 * 
 * Exposes Reservatior's property database as MCP tools.
 * Compatible with Google Cloud AI Agent Builder, Cursor, Claude, etc.
 * 
 * Protocol: JSON-RPC 2.0 over HTTP POST
 * Endpoint: POST /api/mcp
 */

const MCP_TOOLS = [
  {
    name: "search_properties",
    description: "Search properties by location, price range, type, bedrooms, and other filters. Returns property listings with photos and key details.",
    inputSchema: {
      type: "object",
      properties: {
        query: { type: "string", description: "Free text search (city, neighborhood, address)" },
        city: { type: "string", description: "Filter by city name" },
        country: { type: "string", description: "Filter by country name or ISO code" },
        type: { type: "string", enum: ["DETACHED_HOUSE", "APARTMENT", "CONDO", "TOWNHOUSE", "VILLA", "LAND", "COMMERCIAL", "STUDIO"], description: "Property type" },
        listingType: { type: "string", enum: ["SALE", "RENTAL"], description: "Sale or rental" },
        minPrice: { type: "number", description: "Minimum price" },
        maxPrice: { type: "number", description: "Maximum price" },
        bedrooms: { type: "number", description: "Minimum bedrooms" },
        bathrooms: { type: "number", description: "Minimum bathrooms" },
        minAreaSqm: { type: "number", description: "Minimum area in square meters" },
        limit: { type: "number", description: "Max results (default 10, max 50)" },
        page: { type: "number", description: "Page number (default 1)" },
      },
      required: [],
    },
  },
  {
    name: "get_property",
    description: "Get detailed information about a specific property by ID. Includes photos, AI analysis, neighborhood score, and financial details.",
    inputSchema: {
      type: "object",
      properties: {
        id: { type: "string", description: "Property ID (cuid)" },
      },
      required: ["id"],
    },
  },
  {
    name: "search_listings",
    description: "Search active listings with advanced filters. Returns listings with property details, agent info, and pricing.",
    inputSchema: {
      type: "object",
      properties: {
        query: { type: "string", description: "Free text search" },
        type: { type: "string", enum: ["SALE", "RENTAL"], description: "Listing type" },
        status: { type: "string", enum: ["AVAILABLE", "PENDING", "SOLD", "RENTED"], description: "Listing status" },
        city: { type: "string", description: "Filter by city" },
        country: { type: "string", description: "Filter by country" },
        minPrice: { type: "number", description: "Minimum price" },
        maxPrice: { type: "number", description: "Maximum price" },
        bedrooms: { type: "number", description: "Minimum bedrooms" },
        sortBy: { type: "string", enum: ["price_asc", "price_desc", "date_asc", "date_desc", "recommended"], description: "Sort order" },
        limit: { type: "number", description: "Max results (default 10, max 50)" },
        page: { type: "number", description: "Page number (default 1)" },
      },
      required: [],
    },
  },
  {
    name: "get_listing",
    description: "Get detailed listing information including property details, agent contact, pricing history, and AI recommendations.",
    inputSchema: {
      type: "object",
      properties: {
        id: { type: "string", description: "Listing ID (cuid)" },
      },
      required: ["id"],
    },
  },
  {
    name: "get_feed",
    description: "Get the public video feed of featured properties. Returns promoted and popular listings with video content.",
    inputSchema: {
      type: "object",
      properties: {
        region: { type: "string", description: "Filter by region" },
        category: { type: "string", description: "Filter by property category" },
        type: { type: "string", enum: ["SALE", "RENTAL"], description: "Listing type" },
        limit: { type: "number", description: "Max results (default 10)" },
        page: { type: "number", description: "Page number (default 1)" },
      },
      required: [],
    },
  },
  {
    name: "get_areas",
    description: "Get available areas, neighborhoods, and regions in the database. Useful for understanding coverage and suggesting locations.",
    inputSchema: {
      type: "object",
      properties: {
        country: { type: "string", description: "Filter by country" },
        city: { type: "string", description: "Filter by city" },
      },
      required: [],
    },
  },
  {
    name: "get_market_stats",
    description: "Get market statistics: average prices, listing counts, popular areas. Useful for investment analysis.",
    inputSchema: {
      type: "object",
      properties: {
        city: { type: "string", description: "City to analyze" },
        country: { type: "string", description: "Country to analyze" },
      },
      required: [],
    },
  },
];

async function handleSearchProperties(args: any) {
  const { query, city, country, type, listingType, minPrice, maxPrice, bedrooms, bathrooms, minAreaSqm, limit = 10, page = 1 } = args;
  
  const where: any = { deletedAt: null };
  
  if (city) where.city = { contains: city, mode: "insensitive" };
  if (country) where.OR = [
    { country: { contains: country, mode: "insensitive" } },
    { countryIsoCode: { contains: country, mode: "insensitive" } },
  ];
  if (type) where.type = type;
  if (listingType) where.listingType = listingType;
  if (bedrooms) where.bedrooms = { gte: bedrooms };
  if (bathrooms) where.bathrooms = { gte: bathrooms };
  if (minAreaSqm) where.areaSqm = { gte: minAreaSqm };
  if (minPrice || maxPrice) {
    where.listingPrice = {};
    if (minPrice) where.listingPrice.gte = minPrice;
    if (maxPrice) where.listingPrice.lte = maxPrice;
  }
  if (query) {
    where.AND = [
      ...(where.AND || []),
      {
        OR: [
          { name: { contains: query, mode: "insensitive" } },
          { addressLine1: { contains: query, mode: "insensitive" } },
          { city: { contains: query, mode: "insensitive" } },
          { notes: { contains: query, mode: "insensitive" } },
        ],
      },
    ];
  }

  const take = Math.min(Math.max(parseInt(limit) || 10, 1), 50);
  const skip = ((parseInt(page) || 1) - 1) * take;

  const [properties, total] = await Promise.all([
    prisma.property.findMany({
      where,
      skip,
      take,
      orderBy: { createdAt: "desc" },
      include: {
        propertyPhotos: { take: 3, orderBy: { isPrimary: "desc" } },
        listings: { take: 1, where: { status: "AVAILABLE", deletedAt: null } },
      },
    }),
    prisma.property.count({ where }),
  ]);

  return {
    content: [{
      type: "text",
      text: JSON.stringify({
        total,
        page: Math.floor(skip / take) + 1,
        limit: take,
        properties: properties.map((p: any) => ({
          id: p.id,
          name: p.name,
          type: p.type,
          city: p.city,
          country: p.country,
          address: p.addressLine1,
          bedrooms: p.bedrooms,
          bathrooms: p.bathrooms,
          areaSqm: p.areaSqm,
          price: p.listingPrice?.toString(),
          currency: p.currency,
          listingType: p.listingType,
          photos: p.propertyPhotos?.length || 0,
          aiScore: p.aiNeighborhoodScore,
          aiSummary: p.aiSummary?.substring(0, 200),
        })),
      }, null, 2),
    }],
  };
}

async function handleGetProperty(args: any) {
  const property = await prisma.property.findUnique({
    where: { id: args.id },
    include: {
      propertyPhotos: { orderBy: { isPrimary: "desc" } },
      listings: { where: { status: "AVAILABLE", deletedAt: null }, take: 1 },
    },
  });

  if (!property) {
    return { content: [{ type: "text", text: "Property not found" }], isError: true };
  }

  return {
    content: [{
      type: "text",
      text: JSON.stringify({
        id: property.id,
        name: property.name,
        type: property.type,
        city: property.city,
        state: property.state,
        country: property.country,
        address: property.addressLine1,
        lat: property.lat,
        lng: property.lng,
        bedrooms: property.bedrooms,
        bathrooms: property.bathrooms,
        areaSqm: property.areaSqm,
        yearBuilt: property.yearBuilt,
        price: property.listingPrice?.toString(),
        currency: property.currency,
        listingType: property.listingType,
        status: property.listingStatus,
        aiSummary: property.aiSummary,
        aiProsCons: property.aiProsCons,
        aiScore: property.aiNeighborhoodScore,
        aiROIHint: property.aiROIHint,
        hoaFee: property.hoaFee?.toString(),
        propertyTaxRate: property.propertyTaxRate,
        floodZone: property.floodZone,
        photos: property.propertyPhotos?.map((p: any) => ({ url: p.url, isPrimary: p.isPrimary })),
        listing: property.listings?.[0] ? {
          id: property.listings[0].id,
          price: property.listings[0].price?.toString(),
          status: property.listings[0].status,
        } : null,
      }, null, 2),
    }],
  };
}

async function handleSearchListings(args: any) {
  const { query, type, status, city, country, minPrice, maxPrice, bedrooms, sortBy, limit = 10, page = 1 } = args;
  
  const where: any = { deletedAt: null };
  
  if (type) where.type = type;
  if (status) where.status = status;
  if (minPrice || maxPrice) {
    where.price = {};
    if (minPrice) where.price.gte = minPrice;
    if (maxPrice) where.price.lte = maxPrice;
  }
  
  if (city || country || bedrooms || query) {
    where.property = {};
    if (city) where.property.city = { contains: city, mode: "insensitive" };
    if (country) where.property.OR = [
      { country: { contains: country, mode: "insensitive" } },
      { countryIsoCode: { contains: country, mode: "insensitive" } },
    ];
    if (bedrooms) where.property.bedrooms = { gte: bedrooms };
    if (query) {
      where.property.OR = [
        { name: { contains: query, mode: "insensitive" } },
        { addressLine1: { contains: query, mode: "insensitive" } },
        { city: { contains: query, mode: "insensitive" } },
      ];
    }
  }

  let orderBy: any = { createdAt: "desc" };
  switch (sortBy) {
    case "price_asc": orderBy = { price: "asc" }; break;
    case "price_desc": orderBy = { price: "desc" }; break;
    case "date_asc": orderBy = { createdAt: "asc" }; break;
    case "recommended": orderBy = [{ rankingScore: "desc" }, { boostScore: "desc" }]; break;
  }

  const take = Math.min(Math.max(parseInt(limit) || 10, 1), 50);
  const skip = ((parseInt(page) || 1) - 1) * take;

  const [listings, total] = await Promise.all([
    prisma.listing.findMany({
      where,
      skip,
      take,
      orderBy,
      include: {
        property: {
          include: {
            propertyPhotos: { take: 2, orderBy: { isPrimary: "desc" } },
          },
        },
        user: { select: { id: true, name: true, email: true } },
        tags: { include: { tag: true } },
      },
    }),
    prisma.listing.count({ where }),
  ]);

  return {
    content: [{
      type: "text",
      text: JSON.stringify({
        total,
        page: Math.floor(skip / take) + 1,
        limit: take,
        listings: listings.map((l: any) => ({
          id: l.id,
          title: l.title,
          type: l.type,
          status: l.status,
          price: l.price?.toString(),
          currency: l.priceCurrency,
          property: l.property ? {
            id: l.property.id,
            name: l.property.name,
            city: l.property.city,
            country: l.property.country,
            bedrooms: l.property.bedrooms,
            bathrooms: l.property.bathrooms,
            areaSqm: l.property.areaSqm,
          } : null,
          agent: l.user ? { name: l.user.name, email: l.user.email } : null,
          tags: l.tags?.map((t: any) => t.tag?.name).filter(Boolean),
          likes: l.likesCount,
          createdAt: l.createdAt,
        })),
      }, null, 2),
    }],
  };
}

async function handleGetListing(args: any) {
  const listing = await prisma.listing.findUnique({
    where: { id: args.id },
    include: {
      property: {
        include: {
          propertyPhotos: { orderBy: { isPrimary: "desc" } },
        },
      },
      user: { select: { id: true, name: true, email: true } },
      agent: { select: { id: true, name: true, email: true } },
      tags: { include: { tag: true } },
    },
  });

  if (!listing) {
    return { content: [{ type: "text", text: "Listing not found" }], isError: true };
  }

  return {
    content: [{
      type: "text",
      text: JSON.stringify({
        id: listing.id,
        title: listing.title,
        description: listing.description,
        type: listing.type,
        status: listing.status,
        price: listing.price?.toString(),
        currency: listing.priceCurrency,
        strategy: listing.strategy,
        isPromoted: listing.isPromoted,
        vacancyDays: listing.vacancyDays,
        likes: listing.likesCount,
        createdAt: listing.createdAt,
        property: listing.property ? {
          id: listing.property.id,
          name: listing.property.name,
          type: listing.property.type,
          city: listing.property.city,
          state: listing.property.state,
          country: listing.property.country,
          address: listing.property.addressLine1,
          lat: listing.property.lat,
          lng: listing.property.lng,
          bedrooms: listing.property.bedrooms,
          bathrooms: listing.property.bathrooms,
          areaSqm: listing.property.areaSqm,
          yearBuilt: listing.property.yearBuilt,
          aiSummary: listing.property.aiSummary,
          aiProsCons: listing.property.aiProsCons,
          aiScore: listing.property.aiNeighborhoodScore,
          photos: listing.property.propertyPhotos?.map((p: any) => ({ url: p.url, isPrimary: p.isPrimary })),
        } : null,
        agent: listing.user ? { name: listing.user.name, email: listing.user.email } : null,
        tags: listing.tags?.map((t: any) => t.tag?.name).filter(Boolean),
      }, null, 2),
    }],
  };
}

async function handleGetFeed(args: any) {
  const { region, category, type, limit = 10, page = 1 } = args;
  
  const where: any = {
    status: "AVAILABLE",
    deletedAt: null,
  };
  
  if (region) where.property = { ...where.property, region };
  if (category) where.property = { ...where.property, propertyCategory: category };
  if (type) where.type = type;

  const take = Math.min(parseInt(limit) || 10, 50);
  const skip = ((parseInt(page) || 1) - 1) * take;

  const listings = await prisma.listing.findMany({
    where,
    skip,
    take,
    orderBy: [
      { promotionTier: "desc" },
      { likesCount: "desc" },
      { createdAt: "desc" },
    ],
    include: {
      property: {
        include: {
          propertyPhotos: { take: 3, orderBy: { isPrimary: "desc" } },
        },
      },
    },
  });

  return {
    content: [{
      type: "text",
      text: JSON.stringify({
        listings: listings.map((l: any) => ({
          id: l.id,
          title: l.title,
          type: l.type,
          price: l.price?.toString(),
          currency: l.priceCurrency,
          isPromoted: l.isPromoted,
          likes: l.likesCount,
          property: l.property ? {
            name: l.property.name,
            city: l.property.city,
            country: l.property.country,
            bedrooms: l.property.bedrooms,
            areaSqm: l.property.areaSqm,
            photos: l.property.propertyPhotos?.length || 0,
          } : null,
        })),
      }, null, 2),
    }],
  };
}

async function handleGetAreas(args: any) {
  const { country, city } = args;
  
  const where: any = { deletedAt: null };
  if (country) where.OR = [
    { country: { contains: country, mode: "insensitive" } },
    { countryIsoCode: { contains: country, mode: "insensitive" } },
  ];
  if (city) where.city = { contains: city, mode: "insensitive" };

  const properties = await prisma.property.groupBy({
    by: ["city", "country", "region"],
    where,
    _count: { id: true },
    _avg: { listingPrice: true, areaSqm: true },
    orderBy: { _count: { id: "desc" } },
    take: 100,
  });

  return {
    content: [{
      type: "text",
      text: JSON.stringify({
        areas: properties.map((p: any) => ({
          city: p.city,
          country: p.country,
          region: p.region,
          propertyCount: p._count.id,
          avgPrice: p._avg.listingPrice?.toString(),
          avgAreaSqm: p._avg.areaSqm ? Math.round(p._avg.areaSqm) : null,
        })),
      }, null, 2),
    }],
  };
}

async function handleGetMarketStats(args: any) {
  const { city, country } = args;
  
  const where: any = { deletedAt: null };
  if (city) where.city = { contains: city, mode: "insensitive" };
  if (country) where.OR = [
    { country: { contains: country, mode: "insensitive" } },
    { countryIsoCode: { contains: country, mode: "insensitive" } },
  ];

  const [totalProperties, totalListings, priceStats, typeStats] = await Promise.all([
    prisma.property.count({ where }),
    prisma.listing.count({ where: { ...where, property: undefined } }),
    prisma.property.aggregate({
      where,
      _avg: { listingPrice: true, areaSqm: true, aiNeighborhoodScore: true },
      _min: { listingPrice: true },
      _max: { listingPrice: true },
    }),
    prisma.property.groupBy({
      by: ["type"],
      where,
      _count: { id: true },
      orderBy: { _count: { id: "desc" } },
    }),
  ]);

  return {
    content: [{
      type: "text",
      text: JSON.stringify({
        totalProperties,
        totalListings,
        avgPrice: priceStats._avg.listingPrice?.toString(),
        minPrice: priceStats._min.listingPrice?.toString(),
        maxPrice: priceStats._max.listingPrice?.toString(),
        avgAreaSqm: priceStats._avg.areaSqm ? Math.round(priceStats._avg.areaSqm) : null,
        avgAIScore: priceStats._avg.aiNeighborhoodScore ? Math.round(priceStats._avg.aiNeighborhoodScore * 100) / 100 : null,
        byType: typeStats.map((t: any) => ({
          type: t.type,
          count: t._count.id,
        })),
      }, null, 2),
    }],
  };
}

const TOOL_HANDLERS: Record<string, (args: any) => Promise<any>> = {
  search_properties: handleSearchProperties,
  get_property: handleGetProperty,
  search_listings: handleSearchListings,
  get_listing: handleGetListing,
  get_feed: handleGetFeed,
  get_areas: handleGetAreas,
  get_market_stats: handleGetMarketStats,
};

export const mcpRoutes = new Elysia({ prefix: "/api/mcp" })
  .post("/", async ({ body }) => {
    const { jsonrpc = "2.0", method, params = {}, id } = body as any;

    // MCP Protocol: initialize
    if (method === "initialize") {
      return {
        jsonrpc: "2.0",
        id,
        result: {
          protocolVersion: "2024-11-05",
          capabilities: { tools: {} },
          serverInfo: {
            name: "reservatior",
            version: "1.0.0",
          },
        },
      };
    }

    // MCP Protocol: tools/list
    if (method === "tools/list") {
      return {
        jsonrpc: "2.0",
        id,
        result: { tools: MCP_TOOLS },
      };
    }

    // MCP Protocol: tools/call
    if (method === "tools/call") {
      const { name, arguments: args = {} } = params;
      
      const handler = TOOL_HANDLERS[name];
      if (!handler) {
        return {
          jsonrpc: "2.0",
          id,
          error: { code: -32601, message: `Tool not found: ${name}` },
        };
      }

      try {
        const result = await handler(args);
        return { jsonrpc: "2.0", id, result };
      } catch (error: any) {
        return {
          jsonrpc: "2.0",
          id,
          error: { code: -32000, message: error.message || "Internal error" },
        };
      }
    }

    // MCP Protocol: ping
    if (method === "ping") {
      return { jsonrpc: "2.0", id, result: {} };
    }

    return {
      jsonrpc: "2.0",
      id,
      error: { code: -32601, message: `Method not found: ${method}` },
    };
  }, {
    body: t.Object({
      jsonrpc: t.Optional(t.String()),
      method: t.String(),
      params: t.Optional(t.Any()),
      id: t.Optional(t.Union([t.String(), t.Number()])),
    }),
  })

  // Health check
  .get("/", () => ({
    status: "ok",
    protocol: "mcp-2024-11-05",
    tools: MCP_TOOLS.length,
    endpoint: "POST /api/mcp",
  }))

  // SSE endpoint for clients that need streaming
  .get("/sse", () => {
    return new Response(
      `event: endpoint\ndata: /api/mcp\n\n`,
      {
        headers: {
          "Content-Type": "text/event-stream",
          "Cache-Control": "no-cache",
          "Connection": "keep-alive",
        },
      }
    );
  });
