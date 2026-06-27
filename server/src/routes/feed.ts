import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { regionMiddleware } from "../middleware/region";

// Simple in-memory cache to prevent B2B API / AI API quota exhaustion
let b2bCache: any = null;
let b2bCacheTime: number = 0;
let aiUpsellCache: any = null;
let aiUpsellCacheTime: number = 0;
const CACHE_TTL = 1000 * 60 * 30; // 30 minutes

export const feedRoutes = new Elysia({ prefix: "/feed" })
  .use(regionMiddleware)

  /**
   * Main Video Discovery Feed
   * Logic:
   * 1. Promoted listings (Tier desc)
   * 2. Most liked (Top popularity)
   * 3. Freshness (Latest uploaded)
   */
  .get("/", async ({ orgId, db, query }) => {
    const { 
      page = "1", 
      limit = "10", 
      region, 
      category,
      type // SALE, RENTAL
    } = query as any;
    
    const skip = (parseInt(page) - 1) * parseInt(limit);
    
    const where: any = {
      status: "AVAILABLE",
      deletedAt: null,
      property: {
        videoContents: { some: {} } 
      }
    };
    
    if (region) where.property.region = region;
    if (category) where.property.propertyCategory = category;
    if (type) where.type = type;

    // Fetch Listings & Projects
    const [listings, projects] = await Promise.all([
      prisma.listing.findMany({
        where,
        skip,
        take: parseInt(limit),
        orderBy: [
          { promotionTier: "desc" }, 
          { likesCount: "desc" },    
          { createdAt: "desc" }      
        ] as any,
        include: {
          property: {
            include: {
              propertyPromotions: { 
                where: { status: "ACTIVE", endDate: { gte: new Date() } },
                take: 1
              },
              videoContents: { take: 1 }
            }
          },
          org: { select: { name: true, legalName: true } }
        }
      }),
      prisma.project.findMany({
        where: { status: "ACTIVE", deletedAt: null },
        take: 5, // Projects are higher value, less many
        include: {
          org: { select: { name: true } },
          property: { 
             include: {
               videoContents: { take: 1 }
             }
          }
        }
      })
    ]);

    // Map projects to a similar format for the feed
    const formattedProjects = projects.map(p => ({
...p, // include other fields if needed
      id: p.id,
      title: p.name,
      description: p.description,
      price: Number(p.budget),
      priceCurrency: p.currency,
      isProject: true,
      org: p.org,
      property: p.property || { city: "N/A", region: "GLOBAL" },
      videoContents: p.property?.videoContents || [],
      isPromoted: true, // Projects are naturally "Promoted" in the feed
      promotionTier: 3,
      likesCount: 100 // Mock for now
    }));

    const combined = [...listings, ...formattedProjects].sort((a: any, b: any) => {
       // Primary: Promotion Tier
       if (b.promotionTier !== a.promotionTier) {
         return (b.promotionTier || 0) - (a.promotionTier || 0);
       }
       // Secondary: Likes
       if (b.likesCount !== a.likesCount) {
         return (b.likesCount || 0) - (a.likesCount || 0);
       }
       // Tertiary: Freshness
       return new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime();
    });

    try {
      const { B2BHotelAggregator } = await import("../services/b2b-hotel-aggregator");
      const { AIArbitrageService } = await import("../services/ai-arbitrage");

      // Inject 1 B2B Hotel (Discovery mode, mock Antalya)
      if (!b2bCache || Date.now() - b2bCacheTime > CACHE_TTL) {
        b2bCache = await B2BHotelAggregator.searchHotels({
          destination: "Antalya",
          checkIn: new Date().toISOString(),
          checkOut: new Date(Date.now() + 5 * 86400000).toISOString(),
          guests: 2
        });
        b2bCacheTime = Date.now();
      }
      
      if (b2bCache.length > 0) {
        const hotel = b2bCache[0];
        combined.splice(1, 0, {
          id: hotel.id,
          title: `B2B Fırsatı: ${hotel.name}`,
          description: hotel.description || "Toptancı API'sinden özel indirimli fiyat.",
          price: hotel.grossPrice,
          priceCurrency: hotel.currency,
          isB2B: true,
          org: { name: hotel.provider },
          property: { city: "Antalya", region: "TÜRKİYE" },
          videoContents: [{ videoUrl: "", thumbnailUrl: hotel.photos[0] || "" }], 
          isPromoted: true,
          promotionTier: 2,
          likesCount: 50
        } as any);
      }

      // Inject 1 AI Arbitrage Upsell
      if (!aiUpsellCache || Date.now() - aiUpsellCacheTime > CACHE_TTL) {
        aiUpsellCache = await AIArbitrageService.withDB(db as any).evaluateUpsell({
          destination: "Antalya",
          checkIn: new Date().toISOString(),
          checkOut: new Date(Date.now() + 5 * 86400000).toISOString(),
          guests: 2
        });
        aiUpsellCacheTime = Date.now();
      }
      
      if (aiUpsellCache.hasUpsell && aiUpsellCache.upsell) {
        const upsell = aiUpsellCache.upsell;
        combined.splice(3, 0, {
          id: upsell.propertyId,
          title: `AI Önerisi: ${upsell.name}`,
          description: upsell.aiMessage,
          price: upsell.pricePerNight,
          priceCurrency: upsell.currency || "USD",
          isAiArbitrage: true,
          aiMessage: upsell.aiMessage,
          org: { name: "SafeStay AI" },
          property: { city: upsell.city, region: "TÜRKİYE" },
          videoContents: [{ videoUrl: "", thumbnailUrl: upsell.image }],
          isPromoted: true,
          promotionTier: 3,
          likesCount: 150
        } as any);
      }
    } catch (e) {
      console.error("[FEED] B2B/AI Injection Error:", e);
    }

    const total = await prisma.listing.count({ where });

    return { 
      data: combined, 
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / parseInt(limit))
      }
    };
  })

  /**
   * Promoted Packages / Monetization options
   */
  .get("/promotion-packages", () => {
    return {
      packages: [
        { id: "basic", name: "Premium Placement", tier: 1, durationDays: 7, price: 9.99, icon: "Star" },
        { id: "extra", name: "Featured Spotlight", tier: 2, durationDays: 14, price: 19.99, icon: "Zap" },
        { id: "ultra", name: "Video Feed Boost", tier: 3, durationDays: 30, price: 49.99, icon: "TrendingUp" }
      ]
    };
  })

  /**
   * Promotion Activation
   */
  .post("/promote/:id", async ({ orgId, db, params, body, set }) => {
    const { packageId } = body as any;
    
    const packages: any = {
      basic: { tier: 1, days: 7 },
      extra: { tier: 2, days: 14 },
      ultra: { tier: 3, days: 30 }
    };

    const pkg = packages[packageId];
    if (!pkg) { set.status = 400; return { error: "Invalid package" }; }

    const promotedUntil = new Date();
    promotedUntil.setDate(promotedUntil.getDate() + pkg.days);

    const listing = await prisma.listing.update({
      where: { id: params.id },
      data: {
        isPromoted: true,
        promotionTier: pkg.tier,
        promotedUntil
      }
    });

    return { 
      success: true, 
      data: listing,
      message: `${packageId} promotion activated for ${pkg.days} days.`
    };
  }, {
    body: t.Object({
      packageId: t.String()
    })
  })
  
  /**
   * Like a listing / project from the feed
   */
  .post("/like/:id", async ({ orgId, db, params }) => {
    // Determine if id is project or listing (for now projects are mocked)
    if (params.id.startsWith("prj_")) {
      return { success: true, message: "Project like recorded (mock)" };
    }

    try {
      const listing = await prisma.listing.update({
        where: { id: params.id },
        data: {
          likesCount: { increment: 1 }
        }
      });
      return { success: true, count: listing.likesCount };
    } catch (error) {
      return { success: false, error: "Listing not found" };
    }
  })

  /**
   * Track Impression / View
   */
  .post("/view/:id", async ({ orgId, db, params }) => {
    // This would increment a Views table in a real app
    // For now we just return success to maintain the analytics bridge
    return { success: true };
  });
