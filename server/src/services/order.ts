import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { commissionEngine } from "./commission-engine";

export class OrderService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.order, "order");
  }

  async createOrder(data: any) {
    const count = await prisma.order.count();
    const orderNumber = `ORD-${Date.now()}-${String(count + 1).padStart(4, '0')}`;

    const order = await prisma.order.create({
      data: {
        ...data,
        orderNumber,
        status: "PENDING",
        paymentStatus: data.paymentStatus || "PENDING",
      },
      include: { items: true, bundle: true, agent: true }
    });

    // Auto-calculate commission if agent is assigned
    if (order.agentId && order.total) {
      try {
        const agent = await prisma.agent.findUnique({ where: { id: order.agentId } });
        const rate = agent?.baseCommissionRate || 3.0;

        const commission = await commissionEngine.calculate({
          sourceType: "ORDER",
          sourceId: order.id,
          type: "AGENT_SALE",
          basisAmount: Number(order.total),
          rate: rate,
          agentId: order.agentId,
          orgId: order.orgId,
        });

        // Link commission to order
        await prisma.commission.update({
          where: { id: commission.id },
          data: { orderId: order.id }
        });
      } catch (e) {
        console.error("Auto-commission calculation failed for order:", order.id, e);
      }
    }

    // Return order with commissions
    return prisma.order.findUnique({
      where: { id: order.id },
      include: { items: true, bundle: true, agent: true, commissions: true }
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

  async getOrderWithCommissions(orderId: string) {
    return prisma.order.findUnique({
      where: { id: orderId },
      include: {
        items: { include: { product: true } },
        bundle: true,
        agent: true,
        commissions: { include: { revenueShares: true } }
      }
    });
  }

  async getAgentOrders(agentId: string) {
    return prisma.order.findMany({
      where: { agentId },
      include: {
        items: true,
        bundle: true,
        commissions: true
      },
      orderBy: { createdAt: "desc" }
    });
  }
}

export const orderService = new OrderService();
