import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function handleListingMarketingBlitz(data: any) {
  const { propertyId } = data;
  console.log(`[Worker: ListingMarketingBlitz] Processing PROPERTY_STATUS_CHANGED to AVAILABLE for propertyId: ${propertyId}`);

  try {
    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: { org: true }
    });

    if (!property) {
      console.log(`[Worker: ListingMarketingBlitz] Mock property ${propertyId} not found, simulating anyway and returning early.`);
      return;
    }

    const orgId = property?.orgId || "us_seattle_org";
    const org = property?.org;
    const locale = org?.defaultLocale || "en-US";
    const currency = org?.defaultCurrency || "USD";

    // Create an AI task indicating marketing material is being generated
    const aiTask = await prisma.aiServiceTask.create({
      data: {
        organization: { connect: { id: orgId } },
        taskType: "REELS_VIDEO_GEN", 
        status: "PROCESSING",
        outputData: { propertyId },
        errorMessage: "trigger.marketing_started"
      } as any
    });

    // Simulate AI latency
    await new Promise((resolve) => setTimeout(resolve, 4000));

    // In a real Gemini call, we would inject: 
    // `Language: ${locale}, Currency: ${currency}` to the prompt here to ensure the AI writes the post in the correct language!
    const aiCaption = `[${locale}] 🔥 NEW LISTING!\nThis stunning ${property?.bedrooms || 3}-bedroom home is looking for its new owner. Modern architecture in a prime location — don't miss out!\n\n📍 ${property?.addressLine1 || "Downtown"}\n💰 ${currency} ${property?.listingPrice || "500,000"}\n\nDM for details!\n#realestate #homeforsale #property`;

    // Complete the task
    await prisma.aiServiceTask.update({
      where: { id: aiTask.id },
      data: {
        status: "COMPLETED",
        progress: 100,
        errorMessage: "trigger.marketing_completed",
        outputData: { caption: aiCaption, platforms: ["Instagram", "Twitter"], status: "SCHEDULED" }
      }
    });

    console.log(`[Worker: ListingMarketingBlitz] Finished generation. Caption: ${aiCaption.substring(0, 30)}...`);
  } catch (error) {
    console.error(`[Worker: ListingMarketingBlitz] Failed:`, error);
  }
}
