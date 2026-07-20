import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserProfileService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userProfile, "userProfile");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number }) {
    return this.model.findMany({ where: { organizationId: orgId }, orderBy: { createdAt: "desc" }, skip: params?.skip ?? 0, take: params?.take ?? 20 });
  }

  async getByUser(userId: string) {
    return this.model.findFirst({ where: { userId } });
  }

  async upsertProfile(userId: string, data: any) {
    const result = await this.model.upsert({ where: { userId }, update: data, create: { userId, ...data } });
    await eventBus.publish(DomainEvents.USER_REGISTERED, { id: result.id, email: result.email, name: result.name }, "UserOS");
    await eventBus.publish(DomainEvents.USER_PROFILE_UPDATED, { id: result.id, changes: data }, "UserOS");
    return result;
  }
}

export const userProfileService = new UserProfileService();
