import { Elysia } from "elysia";
import { prisma } from "../lib/prisma";

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
  });
