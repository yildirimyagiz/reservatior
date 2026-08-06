import { Elysia, t } from "elysia";
import { HotelPriceComparisonEngine } from "../services/hotel-price-comparison";
import { hotelbedsService } from "../services/hotelbeds";
import { webbedsService } from "../services/webbeds";
import { propertyCrossSellService } from "../services/property-cross-sell";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";
import { prismaManager } from "../lib/prisma";

export const b2bHotelsRoutes = new Elysia({ prefix: "/b2b-hotels" })

  /**
   * GET /b2b-hotels/search
   * Smart search across Hotelbeds + WebBeds.
   * Returns deduplicated hotels with the cheapest rate for each.
   */
  .get(
    "/search",
    async ({ query }) => {
      try {
        const { destination, checkIn, checkOut, guests, rooms, currency, nationality, include_apartments } = query;

        const results = await HotelPriceComparisonEngine.search({
          destination,
          checkIn,
          checkOut,
          guests: parseInt(guests) || 2,
          rooms: rooms ? parseInt(rooms) : undefined,
          currency: currency || "USD",
          nationality: nationality || "TR",
        });

        let apartments: any[] = [];
        if (include_apartments === "true") {
          const apts = await propertyCrossSellService.findPropertiesByCity({
            destination,
            maxResults: 5,
          });
          apartments = apts.map((a: any) => ({
            type: "APARTMENT",
            id: a.id,
            name: a.name,
            description: a.description,
            address: a.address,
            city: a.city,
            country: a.country,
            lat: a.lat,
            lng: a.lng,
            rating: a.rating,
            starRating: a.starRating,
            photos: a.photos,
            amenities: a.amenities,
            currency: a.currency,
            bedrooms: a.bedrooms,
            bathrooms: a.bathrooms,
            areaSqm: a.areaSqm,
            bestRate: {
              roomType: "APARTMENT",
              roomName: `${a.bedrooms} Bedroom${a.areaSqm > 0 ? ` · ${a.areaSqm}m²` : ""}`,
              boardCode: "SC",
              boardName: "Self Catering",
              netPrice: a.listingPrice,
              grossPrice: a.listingPrice,
              provider: `${a.region.toUpperCase()} · ${a.listingType}`,
              rateKey: `APT-${a.id}`,
              isRefundable: true,
              maxGuests: a.bedrooms * 2,
            },
            otherRates: [],
            providers: [a.region],
          }));
        }

        return {
          success: true,
          total: results.length + apartments.length,
          data: [...results, ...apartments],
        };
      } catch (error) {
        console.error("[B2B] Search error:", error);
        return { success: false, error: "Failed to search hotels." };
      }
    },
    {
      query: t.Object({
        destination: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
        guests: t.String(),
        rooms: t.Optional(t.String()),
        currency: t.Optional(t.String()),
        nationality: t.Optional(t.String()),
        include_apartments: t.Optional(t.String()),
      }),
    }
  )

  /**
   * GET /b2b-hotels/provider/:provider/search
   * Search a single provider directly (Hotelbeds or WebBeds only).
   */
  .get(
    "/provider/:provider/search",
    async ({ params, query }) => {
      try {
        const { provider } = params;
        const { destination, checkIn, checkOut, guests } = query;
        const guestCount = parseInt(guests) || 2;

        let results: any[] = [];

        if (provider.toUpperCase() === "HOTELBEDS") {
          results = await hotelbedsService.searchHotels({ destination, checkIn, checkOut, guests: guestCount });
        } else if (provider.toUpperCase() === "WEBBEDS") {
          results = await webbedsService.searchHotels({ destination, checkIn, checkOut, guests: guestCount });
        } else {
          return { success: false, error: `Unknown provider: ${provider}. Use HOTELBEDS or WEBBEDS.` };
        }

        return { success: true, total: results.length, data: results };
      } catch (error) {
        console.error(`[B2B] Provider search error:`, error);
        return { success: false, error: "Failed to search provider." };
      }
    },
    {
      params: t.Object({ provider: t.String() }),
      query: t.Object({
        destination: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
        guests: t.String(),
      }),
    }
  )

  /**
   * POST /b2b-hotels/price
   * Check current price for a specific rate before booking.
   */
  .post(
    "/price",
    async ({ body }) => {
      try {
        const { provider, rateKey, checkIn, checkOut } = body;

        let result: any;

        if (provider.toUpperCase() === "HOTELBEDS") {
          result = await hotelbedsService.checkRate(rateKey);
        } else if (provider.toUpperCase() === "WEBBEDS") {
          result = await webbedsService.checkPrice(rateKey, checkIn, checkOut);
        } else {
          return { success: false, error: `Unknown provider: ${provider}` };
        }

        return { success: true, data: result };
      } catch (error) {
        console.error("[B2B] Price check error:", error);
        return { success: false, error: "Failed to check price." };
      }
    },
    {
      body: t.Object({
        provider: t.String(),
        rateKey: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
      }),
    }
  )

  /**
   * POST /b2b-hotels/book
   * Create a booking on the selected provider.
   */
  .post(
    "/book",
    async ({ body }) => {
      try {
        const { provider, hotelId, rateKey, checkIn, checkOut, guestDetails, holder } = body;

        let result: any;

        if (provider.toUpperCase() === "HOTELBEDS") {
          result = await hotelbedsService.createBooking({
            hotelCode: parseInt(hotelId.replace("HB-", "")),
            checkIn,
            checkOut,
            rooms: [
              {
                rateCode: rateKey,
                guests: (guestDetails ?? []).map((g: any) => ({
                  type: g.type || "ADULT",
                  name: g.name,
                  surname: g.surname,
                })),
              },
            ],
            holder: { name: holder.name, surname: holder.surname },
          });
        } else if (provider.toUpperCase() === "WEBBEDS") {
          result = await webbedsService.createBooking({
            hotelId,
            checkIn,
            checkOut,
            rooms: [
              {
                rateId: rateKey,
                guests: (guestDetails ?? []).map((g: any) => ({
                  type: g.type || "ADULT",
                  firstName: g.firstName || g.name,
                  lastName: g.lastName || g.surname,
                })),
              },
            ],
            holder: { firstName: holder.name, lastName: holder.surname, email: holder.email },
          });
        } else {
          return { success: false, error: `Unknown provider: ${provider}` };
        }

        // ML Feedback Loop: B2B Hotel Booked -> Boost Hotel Ranking
        if (result && (result.bookingId || result.reference)) {
          MLBridgeService.sendFeedback("b2b-demand-model", "HOTEL_BOOKED", 1.0, {
            provider: provider.toUpperCase(),
            hotelId: hotelId,
            rateKey: rateKey,
            bookingReference: result.bookingId || result.reference
          }).catch(console.error);

          // Create local Reservation for Escrow and Ledger tracking
          try {
            const db = prismaManager.getClient();
            await db.reservation.create({
              data: {
                orgId: "default-org-id", // Should come from auth in real scenario
                contactId: "dummy-contact-id", // Should come from auth/body
                b2bProvider: provider.toUpperCase(),
                b2bHotelId: hotelId,
                b2bBookingRef: result.bookingId || result.reference,
                checkInDate: new Date(checkIn),
                checkOutDate: new Date(checkOut),
                guestCount: (guestDetails ?? []).length || 1,
                nightlyRate: 0, // Should be passed from the frontend or result
                cleaningFee: 0,
                totalAmount: result.totalNet || 0, // Placeholder
                status: "CONFIRMED",
              }
            });
          } catch (e) {
            console.error("[B2B] Failed to save local reservation:", e);
          }
        }

        return { success: true, data: result };
      } catch (error) {
        console.error("[B2B] Booking error:", error);
        return { success: false, error: "Failed to create booking." };
      }
    },
    {
      body: t.Object({
        provider: t.String(),
        hotelId: t.String(),
        rateKey: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
        guestDetails: t.Optional(t.Array(t.Any())),
        holder: t.Object({
          name: t.String(),
          surname: t.String(),
          email: t.Optional(t.String()),
        }),
      }),
    }
  )

  /**
   * GET /b2b-hotels/booking/:provider/:bookingId
   * Retrieve booking details from the provider.
   */
  .get(
    "/booking/:provider/:bookingId",
    async ({ params }) => {
      try {
        const { provider, bookingId } = params;

        let result: any;

        if (provider.toUpperCase() === "HOTELBEDS") {
          result = await hotelbedsService.getBookingDetails(bookingId);
        } else if (provider.toUpperCase() === "WEBBEDS") {
          result = await webbedsService.getBookingDetails(bookingId);
        } else {
          return { success: false, error: `Unknown provider: ${provider}` };
        }

        return { success: true, data: result };
      } catch (error) {
        console.error("[B2B] Booking details error:", error);
        return { success: false, error: "Failed to get booking details." };
      }
    },
    {
      params: t.Object({ provider: t.String(), bookingId: t.String() }),
    }
  )

  /**
   * DELETE /b2b-hotels/booking/:provider/:bookingId
   * Cancel a booking on the provider.
   */
  .delete(
    "/booking/:provider/:bookingId",
    async ({ params }) => {
      try {
        const { provider, bookingId } = params;

        let result: any;

        if (provider.toUpperCase() === "HOTELBEDS") {
          result = await hotelbedsService.cancelBooking(bookingId);
        } else if (provider.toUpperCase() === "WEBBEDS") {
          result = await webbedsService.cancelBooking(bookingId);
        } else {
          return { success: false, error: `Unknown provider: ${provider}` };
        }

        // ML Feedback Loop: B2B Hotel Cancelled -> Penalize Hotel Ranking
        if (result && (result.status === 'CANCELLED' || result.success)) {
          MLBridgeService.sendFeedback("b2b-demand-model", "HOTEL_CANCELLED", -1.0, {
            provider: provider.toUpperCase(),
            bookingId: bookingId
          }).catch(console.error);
        }

        return { success: true, data: result };
      } catch (error) {
        console.error("[B2B] Cancel error:", error);
        return { success: false, error: "Failed to cancel booking." };
      }
    },
    {
      params: t.Object({ provider: t.String(), bookingId: t.String() }),
    }
  )

  /**
   * GET /b2b-hotels/cancellation-policy/:provider/:bookingId
   */
  .get(
    "/cancellation-policy/:provider/:bookingId",
    async ({ params }) => {
      try {
        const { provider, bookingId } = params;

        let result: any;

        if (provider.toUpperCase() === "HOTELBEDS") {
          result = await hotelbedsService.getCancellationPolicy(bookingId);
        } else if (provider.toUpperCase() === "WEBBEDS") {
          result = await webbedsService.getCancellationPolicy(bookingId);
        } else {
          return { success: false, error: `Unknown provider: ${provider}` };
        }

        return { success: true, data: result };
      } catch (error) {
        console.error("[B2B] Cancellation policy error:", error);
        return { success: false, error: "Failed to get cancellation policy." };
      }
    },
    {
      params: t.Object({ provider: t.String(), bookingId: t.String() }),
    }
  );
