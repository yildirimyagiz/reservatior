import { prismaManager } from "../../lib/prisma";
import { reputationEngine } from "./reputation-engine";

const DECAY_THRESHOLD_DAYS = 30;
const DECAY_RATE = 0.05; // 5% decay per period
const FULL_RESET_DAYS = 180; // 6 months no activity = score reset to 0.5 base

const REGION_TIMEZONES: Record<string, string> = {
  US: "America/New_York",
  TR: "Europe/Istanbul",
  UK: "Europe/London",
  DE: "Europe/Berlin",
  FR: "Europe/Paris",
  ES: "Europe/Madrid",
  IT: "Europe/Rome",
  AE: "Asia/Dubai",
  SA: "Asia/Riyadh",
  CA: "America/Toronto",
  AU: "Australia/Sydney",
  NL: "Europe/Amsterdam",
  MX: "America/Mexico_City",
  BR: "America/Sao_Paulo",
  AR: "America/Argentina/Buenos_Aires",
  NZ: "Pacific/Auckland",
  JP: "Asia/Tokyo",
  KR: "Asia/Seoul",
  CN: "Asia/Shanghai",
  IN: "Asia/Kolkata",
  SG: "Asia/Singapore",
  MY: "Asia/Kuala_Lumpur",
  TH: "Asia/Bangkok",
};

function getLocalNow(timezone: string): Date {
  try {
    const now = new Date();
    const localStr = now.toLocaleString("en-US", { timeZone: timezone });
    return new Date(localStr);
  } catch {
    return new Date();
  }
}

export class DecayScheduler {
  async applyDecay(region: string = "US"): Promise<{ agentsDecayed: number; scoreResets: number }> {
    const prisma = prismaManager.getClient(region);
    const timezone = REGION_TIMEZONES[region] || "UTC";
    const now = getLocalNow(timezone);
    let agentsDecayed = 0;
    let scoreResets = 0;

    const agents = await prisma.agent.findMany({
      where: {
        agentPerformances: {
          none: { endDate: { gte: new Date(now.getTime() - DECAY_THRESHOLD_DAYS * 24 * 60 * 60 * 1000) } },
        },
      },
      include: { agentPerformances: { orderBy: { endDate: "desc" }, take: 1 } },
    });

    for (const agent of agents) {
      const lastActivity = agent.agentPerformances[0]?.endDate || agent.createdAt;
      const daysSinceActivity = Math.floor((now.getTime() - new Date(lastActivity).getTime()) / (1000 * 60 * 60 * 24));
      const decayPeriods = Math.floor(daysSinceActivity / DECAY_THRESHOLD_DAYS);

      if (daysSinceActivity >= FULL_RESET_DAYS) {
        await this.recordDecay(agent.id, 0.5, 1.0, "FULL_RESET", region);
        scoreResets++;
        agentsDecayed++;
      } else if (decayPeriods >= 1) {
        const decayFactor = Math.pow(1 - DECAY_RATE, decayPeriods);
        const currentScore = await reputationEngine.getPublicExport(agent.id, region);
        const newScore = currentScore.publicScore * decayFactor;
        await this.recordDecay(agent.id, newScore, 1 - decayFactor, "DECAY", region);
        agentsDecayed++;
      }
    }

    return { agentsDecayed, scoreResets };
  }

  async applyReEngagementBoost(entityId: string, entityType: "AGENT" | "TENANT" | "LANDLORD", region: string = "US"): Promise<void> {
    const prisma = prismaManager.getClient(region);
    const boostAmount = 0.1;

    if (entityType === "AGENT") {
      await prisma.reputationDecayLog.create({
        data: {
          entityId,
          entityType,
          region,
          previousScore: 0,
          newScore: 0,
          decayAmount: -boostAmount,
          reason: "RE_ENGAGEMENT_BOOST",
          appliedAt: new Date(),
        },
      });
    }
  }

  async getDecayHistory(entityId: string, region: string = "US"): Promise<any[]> {
    const prisma = prismaManager.getClient(region);
    return prisma.reputationDecayLog.findMany({
      where: { entityId, region },
      orderBy: { appliedAt: "desc" },
      take: 20,
    });
  }

  private async recordDecay(entityId: string, newScore: number, decayAmount: number, reason: string, region: string): Promise<void> {
    const prisma = prismaManager.getClient(region);
    await prisma.reputationDecayLog.create({
      data: {
        entityId,
        entityType: "AGENT",
        region,
        previousScore: newScore + decayAmount,
        newScore,
        decayAmount,
        reason,
        appliedAt: new Date(),
      },
    });
  }
}

export const decayScheduler = new DecayScheduler();
