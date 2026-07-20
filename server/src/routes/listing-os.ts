import { Elysia } from "elysia";
import { prisma } from "../lib/prisma";

export const listingOSRoutes = new Elysia({ prefix: "/listing-os" })
  .get("/dashboard", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId query parameter is required" };
      }

      const [
        totalProperties,
        activeListings,
        compliantCount,
        totalCompliance,
      ] = await Promise.all([
        prisma.property.count({
          where: { orgId, deletedAt: null },
        }),
        prisma.listing.count({
          where: { orgId, status: "AVAILABLE", deletedAt: null },
        }),
        prisma.propertyCompliance.count({
          where: { orgId, type: "CLEANING", status: "passed" },
        }),
        prisma.propertyCompliance.count({
          where: { orgId, type: "CLEANING" },
        }),
      ]);

      return {
        success: true,
        data: {
          totalProperties,
          activeListings,
          totalViews: 0,
          averageQualityScore: totalCompliance > 0
            ? Math.round((compliantCount / totalCompliance) * 100)
            : 0,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
