import { Elysia, t } from "elysia";
import { B2BHotelAggregator } from "../services/b2b-hotel-aggregator";
import { regionMiddleware } from "../middleware/region";

export const b2bHotelsRoutes = new Elysia({ prefix: "/b2b-hotels" })
  .use(regionMiddleware)
  .get(
    "/search",
    async ({ orgId, db, query }) => {
      try {
        const { destination, checkIn, checkOut, guests } = query;
        
        const results = await B2BHotelAggregator.searchHotels({
          destination,
          checkIn,
          checkOut,
          guests: parseInt(guests) || 2
        });

        return {
          success: true,
          data: results
        };
      } catch (error) {
        console.error("Error searching B2B hotels:", error);
        return { success: false, error: "Failed to search B2B hotels." };
      }
    },
    {
      query: t.Object({
        destination: t.String(),
        checkIn: t.String(),
        checkOut: t.String(),
        guests: t.String()
      })
    }
  )
  .post(
    "/book",
    async ({ orgId, db, body }) => {
      try {
        const { provider, hotelId, params } = body;
        
        const result = await B2BHotelAggregator.createBooking(provider, hotelId, params);

        return {
          success: true,
          data: result
        };
      } catch (error) {
        console.error("Error creating B2B hotel booking:", error);
        return { success: false, error: "Failed to create B2B booking." };
      }
    },
    {
      body: t.Object({
        provider: t.String(),
        hotelId: t.String(),
        params: t.Any()
      })
    }
  );
