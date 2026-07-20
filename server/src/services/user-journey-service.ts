import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserActivityService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userActivity, "userActivity");
  }

  async getByUser(userId: string, limit = 50) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" }, take: limit });
  }

  async logActivity(userId: string, action: string, metadata?: any) {
    return this.model.create({ data: { userId, action, metadata, createdAt: new Date() } });
  }
}

export class UserJourneyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userJourney, "userJourney");
  }

  async getByUser(userId: string) {
    return this.model.findFirst({ where: { userId }, orderBy: { updatedAt: "desc" } });
  }

  async advanceStage(userId: string, stage: string, data?: any) {
    const result = await this.model.upsert({
      where: { userId } as any,
      update: { currentStage: stage, stageHistory: data?.history, updatedAt: new Date() },
      create: { userId, currentStage: stage, stageHistory: [stage], createdAt: new Date() },
    }).catch(() => this.model.create({ data: { userId, currentStage: stage, stageHistory: [stage], createdAt: new Date() } }));
    await eventBus.publish("USER_JOURNEY_UPDATED", { id: result.id, userId, stage }, "UserOS");
    return result;
  }

  async getStats(userId: string) {
    const journey = await this.model.findFirst({ where: { userId } });
    return { userId, currentStage: journey?.currentStage || "NEW", daysSinceCreation: journey?.createdAt ? Math.floor((Date.now() - journey.createdAt.getTime()) / 86400000) : 0 };
  }
}

export const userActivityService = new UserActivityService();
export const userJourneyService = new UserJourneyService();
