import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserSavedSearchService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userSavedSearch, "userSavedSearch");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" } });
  }

  async createSearch(userId: string, data: { name: string; filters: any; alertEnabled?: boolean }) {
    const result = await this.model.create({ data: { userId, ...data, alertEnabled: data.alertEnabled ?? true, createdAt: new Date() } });
    await eventBus.publish("USER_SEARCH_SAVED", { id: result.id, userId, query: data.name }, "UserOS");
    return result;
  }

  async updateSearch(id: string, data: any) {
    return this.model.update({ where: { id }, data });
  }

  async deleteSearch(id: string) {
    return this.model.delete({ where: { id } });
  }

  async toggleAlerts(id: string, enabled: boolean) {
    return this.model.update({ where: { id }, data: { alertEnabled: enabled } });
  }
}

export const userSavedSearchService = new UserSavedSearchService();
