import { prismaManager } from "../../lib/prisma";

export class GuestCommunicationBot {
  public static async executeHourlyComms() {
    console.log("[GuestCommunicationBot] Starting hourly guest communication scan...");
    const db = prismaManager.getClient();

    try {
      const now = new Date();
      const tomorrow = new Date(now.getTime() + 24 * 60 * 60 * 1000);
      const twoDaysAgo = new Date(now.getTime() - 2 * 24 * 60 * 60 * 1000);

      // 1. Check-in tomorrow (Send Welcome & Door Code)
      const upcomingCheckIns = await db.reservation.findMany({
        where: {
          checkInDate: {
            gte: new Date(tomorrow.setHours(0,0,0,0)),
            lte: new Date(tomorrow.setHours(23,59,59,999))
          },
          status: "CONFIRMED"
        },
        include: { guest: true, property: true }
      });

      for (const res of upcomingCheckIns) {
        // Send WhatsApp simulation via CommunicationLog
        await db.communicationLog.create({
          data: {
            orgId: res.orgId,
            recipientId: res.guestId,
            senderId: "SYSTEM",
            channel: "WHATSAPP",
            status: "DELIVERED",
            content: `Merhaba ${res.guest?.firstName}, ${res.property?.name} için girişinize 1 gün kaldı! Akıllı kilit şifreniz: ${Math.floor(100000 + Math.random() * 900000)}. Ulaşım rehberini incelemek için linke tıklayın.`,
            sentAt: new Date()
          }
        });

        await db.auditLog.create({
          data: {
            action: "GUEST_COMM_WELCOME_SENT",
            entityType: "Reservation",
            entityId: res.id,
            newValues: { messageType: "WELCOME_AND_CODE" },
            orgId: res.orgId
          }
        });
      }

      // 2. Check-out today (Send Checkout Instructions)
      const checkingOutToday = await db.reservation.findMany({
        where: {
          checkOutDate: {
            gte: new Date(now.setHours(0,0,0,0)),
            lte: new Date(now.setHours(23,59,59,999))
          },
          status: "CONFIRMED"
        },
        include: { guest: true, property: true }
      });

      for (const res of checkingOutToday) {
        await db.communicationLog.create({
          data: {
            orgId: res.orgId,
            recipientId: res.guestId,
            senderId: "SYSTEM",
            channel: "WHATSAPP",
            status: "DELIVERED",
            content: `Günaydın ${res.guest?.firstName}, umarız konaklamanız harika geçmiştir! Bugün çıkış gününüz. Lütfen 11:00'e kadar anahtarı kutuya bırakmayı ve camları kapatmayı unutmayın. İyi yolculuklar!`,
            sentAt: new Date()
          }
        });

        await db.auditLog.create({
          data: {
            action: "GUEST_COMM_CHECKOUT_SENT",
            entityType: "Reservation",
            entityId: res.id,
            newValues: { messageType: "CHECKOUT_INSTRUCTIONS" },
            orgId: res.orgId
          }
        });
      }

      // 3. Checked out 2 days ago (Send Review Request)
      const recentlyCheckedOut = await db.reservation.findMany({
        where: {
          checkOutDate: {
            gte: new Date(twoDaysAgo.setHours(0,0,0,0)),
            lte: new Date(twoDaysAgo.setHours(23,59,59,999))
          },
          status: "COMPLETED" // assuming it transitions to completed
        },
        include: { guest: true, property: true }
      });

      for (const res of recentlyCheckedOut) {
        await db.communicationLog.create({
          data: {
            orgId: res.orgId,
            recipientId: res.guestId,
            senderId: "SYSTEM",
            channel: "WHATSAPP",
            status: "DELIVERED",
            content: `Merhaba ${res.guest?.firstName}, ${res.property?.name} konaklamanızı nasıl buldunuz? Bizim için çok değerlisiniz, 1 dakikanızı ayırıp puan vermek ister misiniz? Link: https://reservatior.com/review/${res.id}`,
            sentAt: new Date()
          }
        });

        await db.auditLog.create({
          data: {
            action: "GUEST_COMM_REVIEW_REQ_SENT",
            entityType: "Reservation",
            entityId: res.id,
            newValues: { messageType: "REVIEW_REQUEST" },
            orgId: res.orgId
          }
        });
      }

      console.log(`[GuestCommunicationBot] Handled ${upcomingCheckIns.length} welcomes, ${checkingOutToday.length} checkouts, ${recentlyCheckedOut.length} review requests.`);
    } catch (error) {
      console.error("[GuestCommunicationBot] Error during comms sweep:", error);
    }
  }
}
