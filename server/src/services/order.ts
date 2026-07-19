import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class OrderService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.order, "order");
  }

  async createOrder(data: any) {
    const count = await prisma.order.count();
    const orderNumber = `ORD-${Date.now()}-${String(count + 1).padStart(4, '0')}`;

    return prisma.order.create({
      data: {
        ...data,
        orderNumber,
        status: "PENDING",
        paymentStatus: "PENDING",
      },
      include: { items: true, bundle: true, agent: true }
    });
  }

  async updateStatus(orderId: string, status: string) {
    return prisma.order.update({
      where: { id: orderId },
      data: { status: status as any, updatedAt: new Date() }
    });
  }

  async getByBuyer(buyerType: string, buyerId: string) {
    return prisma.order.findMany({
      where: { buyerType, buyerId },
      include: { items: true, bundle: true, agent: true },
      orderBy: { createdAt: "desc" }
    });
  }
}

export const orderService = new OrderService();
