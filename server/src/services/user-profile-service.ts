import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

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
    return this.model.upsert({ where: { userId }, update: data, create: { userId, ...data } });
  }
}

export const userProfileService = new UserProfileService();
