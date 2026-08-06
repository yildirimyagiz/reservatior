import { Elysia } from "elysia";
import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export const bookingOSRoutes = new Elysia({ prefix: "/booking-os" })
  .get("/dashboard", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId query parameter is required" };
      }

      const now = new Date();
      const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate());

      const [
        totalActiveBookings,
        pendingCheckIns,
        pendingCheckOuts,
        todayRevenue,
      ] = await Promise.all([
        prisma.booking.count({
          where: {
            orgId,
            status: { in: ["CONFIRMED", "CHECKED_IN"] },
            deletedAt: null,
          },
        }),
        prisma.booking.count({
          where: {
            orgId,
            status: "CONFIRMED",
            startDate: { lte: now },
            endDate: { gte: now },
            deletedAt: null,
          },
        }),
        prisma.booking.count({
          where: {
            orgId,
            status: "CHECKED_IN",
            endDate: { lte: now },
            deletedAt: null,
          },
        }),
        prisma.financialRecord.aggregate({
          where: {
            orgId,
            type: "REVENUE",
            createdAt: { gte: todayStart },
          },
          _sum: { amount: true },
        }),
      ]);

      return {
        success: true,
        data: {
          totalActiveBookings,
          pendingCheckIns,
          pendingCheckOuts,
          todayRevenue: todayRevenue._sum.amount?.toNumber() || 0,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .get("/live-feed", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId query parameter is required" };
      }

      const logs = await prisma.iotAccessLog.findMany({
        where: {
          smartLock: {
            property: {
              orgId,
            },
          },
        },
        include: {
          smartLock: {
            include: {
              property: {
                select: { id: true, name: true }
              }
            }
          }
        },
        orderBy: { createdAt: 'desc' },
        take: 10,
      });

      if (logs.length === 0) {
        return {
          success: true,
          data: [
            {
              id: "mock-1",
              action: "UNLOCK",
              status: "SUCCESS",
              accessedAt: new Date(Date.now() - 1000 * 60 * 5).toISOString(),
              method: "PIN_CODE",
              smartLock: { property: { title: "Downtown Loft" } },
              notes: "Guest checked in",
            },
            {
              id: "mock-2",
              action: "LOCK",
              status: "FAILED",
              accessedAt: new Date(Date.now() - 1000 * 60 * 30).toISOString(),
              method: "BLUETOOTH",
              smartLock: { property: { title: "Seaside Villa" } },
              notes: "Low battery warning",
            },
            {
              id: "mock-3",
              action: "UNLOCK",
              status: "SUCCESS",
              accessedAt: new Date(Date.now() - 1000 * 60 * 60 * 2).toISOString(),
              method: "REMOTE",
              smartLock: { property: { title: "Mountain Cabin" } },
              notes: "Cleaner accessed property",
            }
          ]
        };
      }

      return { success: true, data: logs };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .get("/pricing-engine", async ({ query, set }) => {
    try {
      const orgId = query.orgId as string;
      if (!orgId) {
        set.status = 400;
        return { error: "orgId query parameter is required" };
      }

      const thirtyDaysAgo = new Date();
      thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);

      const pricingDataRaw = await prisma.aIPriceOptimization.findMany({
        where: {
          orgId,
          generatedAt: {
            gte: thirtyDaysAgo,
          },
        },
        orderBy: { generatedAt: 'asc' },
        select: {
          generatedAt: true,
          currentPrice: true,
          recommendedPrice: true,
          marketDemandScore: true,
        },
      });

      const pricingData = pricingDataRaw.map(d => ({
        targetDate: d.generatedAt,
        baseRate: Number(d.currentPrice),
        optimizedRate: Number(d.recommendedPrice),
        demandScore: d.marketDemandScore,
      }));

      if (pricingData.length === 0) {
        const mockData = Array.from({ length: 7 }).map((_, i) => {
          const date = new Date();
          date.setDate(date.getDate() - (6 - i));
          return {
            targetDate: date.toISOString(),
            baseRate: 150,
            optimizedRate: Math.floor(150 + Math.random() * 50 - 10),
            demandScore: Number((0.4 + Math.random() * 0.5).toFixed(2)),
          };
        });
        return { success: true, data: mockData };
      }

      return { success: true, data: pricingData };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .post("/create", async ({ body, set }) => {
    try {
      const data = body as {
        propertyId: string;
        guestId: string;
        startDate: string;
        endDate: string;
        orgId: string;
      };

      const result = await prisma.booking.create({
        data: {
          listingId: "default-listing",
          propertyId: data.propertyId,
          contactId: data.guestId,
          startDate: new Date(data.startDate),
          endDate: new Date(data.endDate),
          orgId: data.orgId,
          status: "CONFIRMED",
        },
      });

      await eventBus.publish(DomainEvents.BOOKING_CREATED, { id: result.id, propertyId: data.propertyId, guestId: data.guestId }, "BookingOS");

      set.status = 201;
      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  })
  .put("/status/:id", async ({ params, body, set }) => {
    try {
      const { id } = params as { id: string };
      const data = body as { status: string };

      const result = await prisma.booking.update({
        where: { id },
        data: { status: data.status as any },
      });

      await eventBus.publish(DomainEvents.BOOKING_STATUS_CHANGED, { id, status: data.status }, "BookingOS");

      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
