import { Elysia, t } from "elysia";
import { prismaManager } from "../lib/prisma";

export const experiencesRoutes = new Elysia({ prefix: "/experiences" })
  /**
   * GET /experiences
   * List available experiences, optionally filtered by location or orgId
   */
  .get(
    "/",
    async ({ query }) => {
      try {
        const db = prismaManager.getClient();
        const { orgId, location } = query;

        const whereClause: any = { status: "ACTIVE" };
        if (orgId) whereClause.orgId = orgId;
        if (location) whereClause.location = { contains: location, mode: "insensitive" };

        const experiences = await db.experience.findMany({
          where: whereClause,
          orderBy: { createdAt: "desc" },
        });

        return { success: true, total: experiences.length, data: experiences };
      } catch (error) {
        console.error("[Experiences] Fetch error:", error);
        return { success: false, error: "Failed to fetch experiences." };
      }
    },
    {
      query: t.Object({
        orgId: t.Optional(t.String()),
        location: t.Optional(t.String()),
      }),
    }
  )

  /**
   * POST /experiences/book
   * Book an experience. Associates with a Reservation if reservationId is provided.
   */
  .post(
    "/book",
    async ({ body }) => {
      try {
        const db = prismaManager.getClient();
        const { orgId, experienceId, reservationId, date, guestCount } = body;

        const experience = await db.experience.findUnique({
          where: { id: experienceId }
        });

        if (!experience) {
          return { success: false, error: "Experience not found." };
        }

        const totalAmount = Number(experience.price) * guestCount;

        const booking = await db.experienceBooking.create({
          data: {
            orgId,
            reservationId,
            experienceId,
            date: new Date(date),
            guestCount,
            totalAmount,
            status: "PENDING"
          }
        });

        return { success: true, data: booking };
      } catch (error) {
        console.error("[Experiences] Booking error:", error);
        return { success: false, error: "Failed to book experience." };
      }
    },
    {
      body: t.Object({
        orgId: t.String(),
        experienceId: t.String(),
        reservationId: t.Optional(t.String()),
        date: t.String(),
        guestCount: t.Numeric(),
      }),
    }
  );
