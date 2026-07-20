import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ServiceProviderService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.serviceProvider, "serviceProvider");
  }

  async getByOrg(orgId: string, params?: { skip?: number; take?: number; category?: string }) {
    return this.model.findMany({
      where: {
        orgId,
        ...(params?.category && { category: params.category }),
      },
      orderBy: { createdAt: "desc" },
      skip: params?.skip ?? 0,
      take: params?.take ?? 20,
    });
  }

  async search(query: string, orgId?: string) {
    return this.model.findMany({
      where: {
        ...(orgId && { orgId }),
        OR: [
          { name: { contains: query, mode: "insensitive" } },
          { category: { contains: query, mode: "insensitive" } },
        ],
      },
      take: 20,
    });
  }

  async register(data: any) {
    return this.model.create({
      data: {
        ...data,
        createdAt: new Date(),
      },
    });
  }
}

export const serviceProviderService = new ServiceProviderService();
