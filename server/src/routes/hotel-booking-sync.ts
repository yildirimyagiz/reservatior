import { Elysia, t } from "elysia";
import { HotelBookingSyncService } from "../services/hotel-booking-sync";

export const hotelBookingSyncRoutes = new Elysia({ prefix: "/hotel-booking-sync" })

  /**
   * POST /hotel-booking-sync/alternatives
   *
   * Takes current booking details and returns hotel alternatives
   * from Hotelbeds/WebBeds with price comparison.
   *
   * Frontend çağrı örneği:
   *   POST /api/v1/hotel-booking-sync/alternatives
   *   {
   *     "destination": "Antalya",
   *     "checkIn": "2026-07-01",
   *     "checkOut": "2026-07-05",
   *     "guests": 2,
   *     "propertyName": "Sahil Dairesi",
   *     "currentPrice": 150
   *   }
   */
  .post(
    "/alternatives",
    async ({ body }) => {
      try {
        const result = await HotelBookingSyncService.findAlternatives(body);
        return {
          success: true,
          data: result,
        };
      } catch (error) {
        console.error("[HOTEL-BOOKING-SYNC] Error:", error);
        return { success: false, error: "Failed to find hotel alternatives." };
      }
    },
    {
      body: t.Object({
        destination: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
        guests: t.Number(),
        rooms: t.Optional(t.Number()),
        propertyName: t.Optional(t.String()),
        propertyCity: t.Optional(t.String()),
        currentPrice: t.Optional(t.Number()),
        currency: t.Optional(t.String()),
      }),
    }
  )

  /**
   * POST /hotel-booking-sync/has-cheaper
   *
   * Quick check: are there hotel options cheaper than current booking?
   * Frontend'de "Bu bölgede daha ucuz otel seçenekleri var!" bildirimi için.
   */
  .post(
    "/has-cheaper",
    async ({ body }) => {
      try {
        const result = await HotelBookingSyncService.hasCheaperOptions(body);
        return {
          success: true,
          data: result,
        };
      } catch (error) {
        console.error("[HOTEL-BOOKING-SYNC] Error:", error);
        return { success: false, error: "Failed to check cheaper options." };
      }
    },
    {
      body: t.Object({
        destination: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
        guests: t.Number(),
        currentPrice: t.Optional(t.Number()),
        rooms: t.Optional(t.Number()),
        currency: t.Optional(t.String()),
      }),
    }
  );
