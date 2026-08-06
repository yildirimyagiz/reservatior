import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserRelationshipService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userRelationship, "userRelationship");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { OR: [{ userId }, { relatedUserId: userId }] }, orderBy: { createdAt: "desc" } });
  }

  async createRelationship(userId: string, relatedUserId: string, type: string) {
    const result = await this.model.create({ data: { userId, relatedUserId, type, createdAt: new Date() } });
    await eventBus.publish("USER_RELATIONSHIP_CREATED", { id: result.id, userId, targetUserId: relatedUserId, type }, "UserOS");
    return result;
  }

  async removeRelationship(id: string) {
    return this.model.delete({ where: { id } });
  }
}

export const userRelationshipService = new UserRelationshipService();
