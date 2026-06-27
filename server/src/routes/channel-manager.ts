import { Elysia, t } from "elysia";
import { prismaManager } from "../lib/prisma";

export const channelManagerRoutes = new Elysia({ prefix: "/channel-manager" })
  .post("/push-availability", async ({ body }) => {
    const db = prismaManager.getClient();
    const { rentalId, platform } = body;

    const rentalPlatform = await db.vacationRentalPlatform.findUnique({
      where: {
        rentalId_platform: {
          rentalId,
          platform: platform as any
        }
      },
      include: { rental: true }
    });

    if (!rentalPlatform) {
      return { error: "Rental Platform mapping not found." };
    }

    // In a real system, you would call the external API here (e.g. Airbnb API, Webbeds API)
    console.log(`[ChannelManager] Pushing availability to ${platform} for rental ${rentalId}`);

    await db.vacationRentalPlatform.update({
      where: { id: rentalPlatform.id },
      data: {
        lastSyncedAt: new Date(),
        status: "ACTIVE"
      }
    });

    return { success: true, message: `Successfully pushed availability to ${platform}` };
  }, {
    body: t.Object({
      rentalId: t.String(),
      platform: t.String() // E.g., AIRBNB, BOOKING_COM, WEBBEDS, HOTELBEDS
    })
  })
  .post("/webhook/:platform", async ({ params, body }) => {
    // This webhook would receive bookings from external channels like Webbeds
    const db = prismaManager.getClient();
    const { platform } = params;
    
    console.log(`[ChannelManager] Webhook received from ${platform}:`, body);

    // If it's a booking payload, we create an escrow and reservation locally.
    // E.g.
    /*
      const reservation = await db.reservation.create({ ... });
      const escrow = await db.escrowAccount.create({ ... });
    */
    
    return { success: true, received: true };
  });
