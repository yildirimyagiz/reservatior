import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ProductBundleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.productBundle, "productBundle");
  }

  async getByIdWithItems(id: string) {
    return prisma.productBundle.findUnique({
      where: { id },
      include: {
        items: {
          include: { product: true }
        }
      }
    });
  }

  async createWithItems(data: any) {
    const { items, ...bundleData } = data;
    return prisma.productBundle.create({
      data: {
        ...bundleData,
        items: items ? {
          create: items.map((item: any) => ({
            productId: item.productId,
            quantity: item.quantity || 1,
            unitPrice: item.unitPrice,
            totalAmount: (item.unitPrice || 0) * (item.quantity || 1),
          }))
        } : undefined,
      },
      include: { items: { include: { product: true } } }
    });
  }

  async updateWithItems(id: string, data: any) {
    const { items, ...bundleData } = data;
    if (items) {
      await prisma.bundleItem.deleteMany({ where: { bundleId: id } });
      for (const item of items) {
        await prisma.bundleItem.create({
          data: {
            bundleId: id,
            productId: item.productId,
            quantity: item.quantity || 1,
            unitPrice: item.unitPrice,
            totalAmount: (item.unitPrice || 0) * (item.quantity || 1),
          }
        });
      }
    }
    return prisma.productBundle.update({
      where: { id },
      data: bundleData,
      include: { items: { include: { product: true } } }
    });
  }
}

export const productBundleService = new ProductBundleService();
