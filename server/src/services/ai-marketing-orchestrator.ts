import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { AIStagerService } from "./ai-stager";

export class AIMarketingOrchestrator extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aiServiceTask, "aiServiceTask");
  }

  /**
   * Triggers a virtual staging task for a specific property
   */
  async triggerStaging(propertyId: string, orgId: string) {
    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: { photos: true }
    });

    if (!property) throw new Error("Property not found");

    // Use the AIStagerService to queue a real AtlasVS task
    return await AIStagerService.stageImage({
      propertyId,
      orgId,
      imageUrl: property.photos[0]?.url || "https://storage.reservatior.com/demo/empty-room.jpg",
      style: "luxury",
      roomType: "living_room"
    });
  }

  /**
   * Triggers video generation (Neural Reel)
   */
  async triggerVideo(propertyId: string, orgId: string) {
    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: { photos: true }
    });

    return await AIStagerService.generateNeuralReels({
      propertyId,
      orgId,
      photos: property?.photos.map(p => p.url) || []
    });
  }

  /**
   * Triggers brochure generation
   */
  async triggerBrochure(propertyId: string, orgId: string) {
    const brochure = await prisma.aiBrochureGeneration.create({
      data: {
        propertyId,
        templateId: "PREMIUM_LUXURY",
        status: "PENDING"
      }
    });

    await prisma.aiServiceTask.create({
      data: {
        orgId,
        propertyId,
        taskType: "PDF_BROCHURE_GEN",
        status: "QUEUED",
        inputData: { brochureId: brochure.id }
      }
    });

    return brochure;
  }
}

export const aiMarketingOrchestrator = new AIMarketingOrchestrator();
