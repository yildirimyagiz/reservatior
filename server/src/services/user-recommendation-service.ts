import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserRecommendationService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userRecommendation, "userRecommendation");
  }

  async getByUser(userId: string, limit = 10) {
    return this.model.findMany({ where: { userId }, orderBy: { score: "desc" }, take: limit });
  }

  async generateRecommendation(userId: string, entityType: string, entityId: string, score: number, reason?: string) {
    const result = await this.model.upsert({
      where: { userId_entityType_entityId: { userId, entityType, entityId } } as any,
      update: { score, reason, updatedAt: new Date() },
      create: { userId, entityType, entityId, score, reason, createdAt: new Date() },
    }).catch(() => this.model.create({ data: { userId, entityType, entityId, score, reason, createdAt: new Date() } }));
    await eventBus.publish("USER_RECOMMENDATION_GENERATED", { id: result.id, userId, count: 1 }, "UserOS");
    return result;
  }

  async trackInteraction(id: string) {
    return this.model.update({ where: { id }, data: { interacted: true, interactedAt: new Date() } });
  }
}

export const userRecommendationService = new UserRecommendationService();
