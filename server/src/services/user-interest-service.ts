import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

export class UserCategoryPreferenceService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userCategoryPreference, "userCategoryPreference");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId } });
  }

  async setPreference(userId: string, category: string, weight: number) {
    return this.model.upsert({
      where: { userId_category: { userId, category } } as any,
      update: { weight },
      create: { userId, category, weight },
    }).catch(() => this.model.create({ data: { userId, category, weight } }));
  }
}

export class UserInterestService extends BaseService<any, any, any> {
  constructor() {
    super((prisma as any).userInterest, "userInterest");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" } });
  }

  async addInterest(userId: string, data: { category: string; subcategory?: string; priority?: number }) {
    const result = await this.model.create({ data: { userId, ...data, createdAt: new Date() } });
    await eventBus.publish("USER_INTEREST_RECORDED", { id: result.id, userId, category: data.category }, "UserOS");
    return result;
  }

  async removeInterest(id: string) {
    return this.model.delete({ where: { id } });
  }
}

export const userCategoryPreferenceService = new UserCategoryPreferenceService();
export const userInterestService = new UserInterestService();
