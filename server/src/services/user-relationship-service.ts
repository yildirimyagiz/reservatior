import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserRelationshipService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.userRelationship, "userRelationship");
  }

  async getByUser(userId: string) {
    return this.model.findMany({ where: { OR: [{ userId }, { relatedUserId: userId }] }, orderBy: { createdAt: "desc" } });
  }

  async createRelationship(userId: string, relatedUserId: string, type: string) {
    return this.model.create({ data: { userId, relatedUserId, type, createdAt: new Date() } });
  }

  async removeRelationship(id: string) {
    return this.model.delete({ where: { id } });
  }
}

export const userRelationshipService = new UserRelationshipService();
