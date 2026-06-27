import { prismaManager } from "../lib/prisma";

export interface GlobalSearchQuery {
  keyword?: string;
  minPrice?: number;
  maxPrice?: number;
  type?: string;
  bedrooms?: number;
  limit?: number;
}

export class GlobalSearchService {
  /**
   * Performs a federated search across all active country databases.
   * Uses Promise.all to fetch results concurrently and merges them.
   */
  async searchProperties(query: GlobalSearchQuery) {
    const activeRegions = prismaManager.getActiveRegions();
    const limitPerRegion = query.limit ? Math.ceil(query.limit / activeRegions.length) : 10;

    const searchPromises = activeRegions.map(async (region) => {
      try {
        const prisma = prismaManager.getClient(region);

        // Build Prisma query dynamically based on search params
        const where: any = {};
        
        if (query.keyword) {
          where.OR = [
            { name: { contains: query.keyword, mode: "insensitive" } },
            { city: { contains: query.keyword, mode: "insensitive" } },
            { addressLine1: { contains: query.keyword, mode: "insensitive" } }
          ];
        }
        if (query.type) where.type = query.type;
        if (query.bedrooms) where.bedrooms = { gte: query.bedrooms };

        // Fetch properties for this region
        const properties = await prisma.property.findMany({
          where,
          take: limitPerRegion,
          orderBy: { createdAt: 'desc' },
          select: {
            id: true,
            name: true,
            type: true,
            city: true,
            country: true,
            bedrooms: true,
            bathrooms: true,
            areaSqm: true,
            currency: true,
            createdAt: true,
          }
        });

        // Tag each result with its origin database region
        return properties.map(p => ({
          ...p,
          _databaseRegion: region // Important for frontend to know which region to route clicks to
        }));
      } catch (err) {
        console.error(`[GlobalSearchService] Failed to search in region ${region}:`, err);
        return []; // Fail gracefully for individual regions
      }
    });

    const resultsArray = await Promise.all(searchPromises);
    
    // Flatten and sort the aggregated results (newest first)
    const aggregated = resultsArray.flat().sort((a, b) => 
      new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
    );

    // Apply global limit if requested
    if (query.limit && aggregated.length > query.limit) {
      return aggregated.slice(0, query.limit);
    }

    return aggregated;
  }
}

export const globalSearchService = new GlobalSearchService();
