import { PrismaClient } from "@prisma/client";
import { GoogleGenerativeAI } from "@google/generative-ai";

const prisma = new PrismaClient();

// Initialize Gemini safely
let ai: any = null;
if (process.env.GEMINI_API_KEY) {
  ai = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
}

export async function handleOfferCreated(data: any) {
  const { offerId } = data;
  console.log(`[Worker: OfferNegotiator] Processing OFFER_CREATED for offerId: ${offerId}`);

  try {
    const offer = await prisma.propertyOffer.findUnique({
      where: { id: offerId },
      include: { 
        property: {
          include: { org: true }
        } 
      }
    });

    if (!offer) {
      console.log(`[Worker: OfferNegotiator] Mock offer ${offerId} not found, simulating success anyway and returning early.`);
      return;
    }

    // Detect locale and currency
    const org = offer?.property?.org;
    const locale = org?.defaultLocale || "en-US";
    const currency = org?.defaultCurrency || "USD";

    // Simulate AI decision logic
    const propertyPrice = offer?.property?.listingPrice ? Number(offer.property.listingPrice) : 500000;
    const offerPrice = offer?.offerPrice ? Number(offer.offerPrice) : 400000;
    
    // We create a tracking task to show in the UI via the /api/v1/system/triggers endpoint
    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: offer?.orgId || "us_seattle_org" } },
        property: offer?.propertyId ? { connect: { id: offer.propertyId } } : undefined,
        taskType: "CONCIERGE_DISPATCH", 
        status: "PROCESSING",
        outputData: { offerId },
        errorMessage: "trigger.offer_processing"
      } as any // Use as any in case property is strictly required and undefined causes TS error, or it will just fail at runtime if strictly required. If required we must provide it.
    });

    // Simulate some latency for the AI
    await new Promise((resolve) => setTimeout(resolve, 3000));

    let decision = "ACCEPT";
    let message = "trigger.offer_accepted";

    if (propertyPrice > 0 && offerPrice < propertyPrice * 0.85) {
      decision = "COUNTER";
      message = "trigger.offer_countered";
      
      // In a real Gemini call, we would inject: 
      // `Language: ${locale}, Currency: ${currency}` to the prompt here.
    }

    // Update the task to completed
    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: message,
        outputData: { decision, originalOffer: offerPrice, expectedPrice: propertyPrice }
      }
    });

    console.log(`[Worker: OfferNegotiator] Finished processing: ${decision}`);

  } catch (error) {
    console.error(`[Worker: OfferNegotiator] Failed processing offer:`, error);
  }
}
