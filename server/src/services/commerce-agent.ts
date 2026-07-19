import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CommerceAgentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.agent, "agent");
  }

  async getPerformanceStats(agentId: string) {
    const agent = await prisma.agent.findUnique({ where: { id: agentId } });
    if (!agent) return null;

    const commissions = await prisma.commission.findMany({
      where: { agentId },
    });

    const totalSales = agent.totalSales;
    const totalRevenue = Number(agent.totalRevenue);
    const averageRating = agent.averageRating;

    const paidCommissions = commissions.filter(c => c.status === "PAID");
    const pendingCommissions = commissions.filter(c =>
      c.status === "PENDING" || c.status === "CALCULATED" || c.status === "APPROVED"
    );

    return {
      agentId,
      totalSales,
      totalRevenue,
      averageRating,
      totalCommissions: commissions.length,
      paidCommissions: paidCommissions.length,
      pendingCommissions: pendingCommissions.length,
      totalCommissionAmount: commissions.reduce((sum, c) => sum + Number(c.amount), 0),
      paidCommissionAmount: paidCommissions.reduce((sum, c) => sum + Number(c.amount), 0),
      pendingCommissionAmount: pendingCommissions.reduce((sum, c) => sum + Number(c.amount), 0),
    };
  }
}

export const commerceAgentService = new CommerceAgentService();
