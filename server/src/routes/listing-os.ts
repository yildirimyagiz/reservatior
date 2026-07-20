import { Elysia } from "elysia";
import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

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
  })
  .post("/create", async ({ body, set }) => {
    try {
      const data = body as {
        title: string;
        price: number;
        orgId: string;
        propertyId: string;
      };

      const result = await prisma.listing.create({
        data: {
          title: data.title,
          price: data.price,
          orgId: data.orgId,
          propertyId: data.propertyId,
          status: "AVAILABLE",
        },
      });

      await eventBus.publish(DomainEvents.LISTING_CREATED, { id: result.id, title: data.title, price: data.price }, "ListingOS");

      set.status = 201;
      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .put("/update/:id", async ({ params, body, set }) => {
    try {
      const { id } = params as { id: string };
      const data = body as { title?: string; price?: number; status?: string };

      const result = await prisma.listing.update({
        where: { id },
        data,
      });

      await eventBus.publish(DomainEvents.LISTING_UPDATED, { id, changes: data }, "ListingOS");

      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
