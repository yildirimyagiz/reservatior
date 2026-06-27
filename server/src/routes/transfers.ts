import { Elysia, t } from "elysia";
import { prismaManager } from "../lib/prisma";

export const transfersRoutes = new Elysia({ prefix: "/transfers" })
  /**
   * GET /transfers
   * List available transfer services
   */
  .get(
    "/",
    async ({ query }) => {
      try {
        const db = prismaManager.getClient();
        const { orgId } = query;

        const whereClause: any = { status: "ACTIVE" };
        if (orgId) whereClause.orgId = orgId;

        const transfers = await db.transferService.findMany({
          where: whereClause,
          orderBy: { createdAt: "desc" },
        });

        return { success: true, total: transfers.length, data: transfers };
      } catch (error) {
        console.error("[Transfers] Fetch error:", error);
        return { success: false, error: "Failed to fetch transfers." };
      }
    },
    {
      query: t.Object({
        orgId: t.Optional(t.String()),
      }),
    }
  )

  /**
   * POST /transfers/book
   * Book a transfer. Associates with a Reservation if provided.
   */
  .post(
    "/book",
    async ({ body }) => {
      try {
        const db = prismaManager.getClient();
        const { orgId, transferServiceId, reservationId, pickupLocation, dropoffLocation, pickupTime, flightNumber } = body;

        const service = await db.transferService.findUnique({
          where: { id: transferServiceId }
        });

        if (!service) {
          return { success: false, error: "Transfer service not found." };
        }

        const totalAmount = Number(service.basePrice);

        const booking = await db.transferBooking.create({
          data: {
            orgId,
            reservationId,
            transferServiceId,
            pickupLocation,
            dropoffLocation,
            flightNumber,
            pickupTime: new Date(pickupTime),
            totalAmount,
            status: "PENDING"
          }
        });

        return { success: true, data: booking };
      } catch (error) {
        console.error("[Transfers] Booking error:", error);
        return { success: false, error: "Failed to book transfer." };
      }
    },
    {
      body: t.Object({
        orgId: t.String(),
        transferServiceId: t.String(),
        reservationId: t.Optional(t.String()),
        pickupLocation: t.String(),
        dropoffLocation: t.String(),
        pickupTime: t.String(),
        flightNumber: t.Optional(t.String()),
      }),
    }
  );
