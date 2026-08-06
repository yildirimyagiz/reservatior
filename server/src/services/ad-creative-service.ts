import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class AdCreativeService {
  async getByCampaign(campaignId: string) {
    const campaign = await prisma.adCampaign.findUnique({ where: { id: campaignId } });
    const creatives = Array.isArray(campaign?.creatives) ? campaign?.creatives as any[] : [];
    return creatives.sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
  }

  async createCreative(data: any) {
    const creative = { id: `crt_${Date.now()}`, ...data, createdAt: new Date() };
    const campaign = await prisma.adCampaign.findUnique({ where: { id: data.campaignId } });
    
    if (campaign) {
      const creatives = Array.isArray(campaign.creatives) ? campaign.creatives : [];
      await prisma.adCampaign.update({
        where: { id: data.campaignId },
        data: { creatives: [...creatives, creative] as any }
      });
    }

    await eventBus.publish(
      DomainEvents.AD_GENERATED, 
      { id: creative.id, campaignId: data.campaignId, name: data.title }, 
      "AdsOS"
    );
    return creative;
  }

  async startABTest(id: string, variantB: any) {
    return { id, abTestEnabled: true, variantB, abTestStartedAt: new Date() };
  }
}

export const adCreativeService = new AdCreativeService();
