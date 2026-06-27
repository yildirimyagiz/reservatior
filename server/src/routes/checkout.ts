import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";

export const checkoutService = new Elysia({ prefix: "/checkout" })
  .post("/calculate", async ({ body }) => {
    const { listingId, checkIn, checkOut, rentalType } = body as any;

    const listing = await prisma.listing.findUnique({
      where: { id: listingId },
      include: { property: true }
    });

    if (!listing) {
      throw new Error("Listing not found.");
    }

    const basePricePerNight = Number(listing.price);
    
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    const timeDifference = checkOutDate.getTime() - checkInDate.getTime();
    const nights = Math.max(1, Math.ceil(timeDifference / (1000 * 3600 * 24)));

    const baseTotal = basePricePerNight * nights;

    let guestServiceFeeRate = 0;
    let hostServiceFeeRate = 0;

    if (rentalType === "SHORT_TERM") {
      guestServiceFeeRate = 0.05;
      hostServiceFeeRate = 0.05;
    } else if (rentalType === "LONG_TERM") {
      guestServiceFeeRate = 0.035;
      hostServiceFeeRate = 0.035;
    }

    const guestServiceFeeAmount = baseTotal * guestServiceFeeRate;
    const hostServiceFeeAmount = baseTotal * hostServiceFeeRate;

    const finalAmountChargedToGuest = baseTotal + guestServiceFeeAmount;
    const finalPayoutToHost = baseTotal - hostServiceFeeAmount;
    const totalReservatiorRevenue = guestServiceFeeAmount + hostServiceFeeAmount;

    return {
      success: true,
      data: {
        currency: listing.priceCurrency || "USD",
        nights: nights,
        basePricePerNight: basePricePerNight,
        subtotal: baseTotal,
        guestInvoice: {
          subtotal: baseTotal,
          serviceFee: guestServiceFeeAmount,
          serviceFeePercentage: `${guestServiceFeeRate * 100}%`,
          totalCharge: finalAmountChargedToGuest,
          marketingMessage: "Reservatior charges an ultra-low fee compared to standard platforms."
        },
        hostPayout: {
          subtotal: baseTotal,
          platformFee: hostServiceFeeAmount,
          platformFeePercentage: `${hostServiceFeeRate * 100}%`,
          netEarnings: finalPayoutToHost
        },
        platformRevenue: totalReservatiorRevenue
      }
    };
  }, {
    body: t.Object({
      listingId: t.String(),
      checkIn: t.String(),
      checkOut: t.String(),
      rentalType: t.Union([t.Literal("SHORT_TERM"), t.Literal("LONG_TERM")])
    })
  });
