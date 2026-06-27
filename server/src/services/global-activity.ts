import { prismaManager } from "../lib/prisma";

export class GlobalActivityService {
  /**
   * Fetches user's global activity (reservations and favorites) across all active country databases.
   * Matches by the user's email address (which is consistent across cloned regions).
   */
  async getUserGlobalActivity(email: string) {
    if (!email) return [];

    const activeRegions = prismaManager.getActiveRegions();

    const activityPromises = activeRegions.map(async (region) => {
      try {
        const prisma = prismaManager.getClient(region);

        // First find the user in this region
        const user = await prisma.user.findUnique({
          where: { email },
          select: { id: true }
        });

        if (!user) return []; // User doesn't exist in this region yet

        // Fetch Bookings (Reservations)
        const bookings = await prisma.booking.findMany({
          where: { contact: { email } },
          include: {
            listing: {
              select: { id: true, title: true, priceCurrency: true, property: { select: { city: true, country: true } } }
            }
          },
          orderBy: { createdAt: 'desc' },
          take: 5
        });

        // Format into a unified activity feed
        const activities = bookings.map(b => ({
          id: b.id,
          type: "BOOKING",
          region: region,
          status: b.status,
          title: `Reservation for ${b.listing.title || "Property"}`, // Fixed property
          description: `${b.listing.property?.city}, ${b.listing.property?.country}`, // Fixed property
          amount: b.priceTotal,
          currency: b.listing.priceCurrency, // Fixed currency
          date: b.createdAt
        }));

        return activities;
      } catch (err) {
        console.error(`[GlobalActivityService] Failed to fetch activity in region ${region}:`, err);
        return []; 
      }
    });

    const resultsArray = await Promise.all(activityPromises);
    
    // Flatten and sort by date descending
    const aggregated = resultsArray.flat().sort((a, b) => 
      new Date(b.date).getTime() - new Date(a.date).getTime()
    );

    return aggregated;
  }
}

export const globalActivityService = new GlobalActivityService();
