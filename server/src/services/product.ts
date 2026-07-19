import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ProductService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.product, "product");
  }

  async getByCategory(category: string, params?: { skip?: number; take?: number }) {
    return prisma.product.findMany({
      where: { category: category as any, isActive: true },
      include: { supplier: true },
      skip: params?.skip,
      take: params?.take,
      orderBy: { createdAt: "desc" }
    });
  }

  async getBySupplier(supplierId: string) {
    return prisma.product.findMany({
      where: { supplierId, isActive: true },
      orderBy: { createdAt: "desc" }
    });
  }
}

export const productService = new ProductService();
