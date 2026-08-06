import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserIdentityService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userIdentity, "userIdentity");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" } });
  }

  async linkProvider(userId: string, provider: string, providerId: string, data?: any) {
    const result = await this.model.create({ data: { userId, provider, providerId, verified: false, ...data, createdAt: new Date() } });
    await eventBus.publish(DomainEvents.USER_REGISTERED, { id: result.id, email: userId }, "UserOS");
    return result;
  }

  async unlinkProvider(id: string) {
    return this.model.delete({ where: { id } });
  }

  async verifyIdentity(id: string) {
    return this.model.update({ where: { id }, data: { verified: true, verifiedAt: new Date() } });
  }
}

export const userIdentityService = new UserIdentityService();
