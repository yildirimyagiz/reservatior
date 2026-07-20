import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserSavedSearchService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userSavedSearch, "userSavedSearch");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { userId }, orderBy: { createdAt: "desc" } });
  }

  async createSearch(userId: string, data: { name: string; filters: any; alertEnabled?: boolean }) {
    return this.model.create({ data: { userId, ...data, alertEnabled: data.alertEnabled ?? true, createdAt: new Date() } });
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
