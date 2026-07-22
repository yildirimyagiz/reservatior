import { prisma } from "../../lib/prisma";
import { eventBus } from "../../core/events/event-bus";
import { DomainEvents } from "../../core/events/domain-events";
import { NotificationDispatcher } from "../notification-dispatcher";
import { defaultRankingConfig, VacancyConfig } from "../ranking/smart-ranking-config";

export interface VacancyAlert {
  listingId: string;
  ownerId: string;
  ownerEmail: string;
  ownerName: string;
  listingTitle: string;
  vacancyDays: number;
  severity: "LOW" | "MEDIUM" | "HIGH" | "CRITICAL";
  suggestedDiscount: number;
  estimatedOccupancyImprovement: number;
  estimatedMonthlyGain: number;
}

export class VacancyNotificationService {
  static async checkAndNotify(
    listingId: string,
    vacancyDays: number,
    config: VacancyConfig = defaultRankingConfig.vacancy
  ): Promise<void> {
    console.log(`[VacancyNotification] Checking vacancy for listing ${listingId} (${vacancyDays} days)...`);

    const listing = await prisma.listing.findUnique({
      where: { id: listingId },
      include: {
        property: true,
        org: { include: { members: { include: { user: true }, where: { role: "OWNER" } } } },
      },
    });

    if (!listing) return;

    const owner = listing.org?.members?.[0]?.user;
    if (!owner?.email) return;

    let severity: VacancyAlert["severity"] = "LOW";
    if (vacancyDays >= config.criticalVacancyThresholdDays) severity = "CRITICAL";
    else if (vacancyDays >= config.highVacancyThresholdDays) severity = "HIGH";
    else if (vacancyDays >= config.vacancyThresholdDays) severity = "MEDIUM";

    const suggestedDiscount = vacancyDays > 60 ? 0.07 : vacancyDays > 30 ? 0.06 : 0.05;
    const estimatedOccupancyImprovement = Math.min(0.5, 0.1 + vacancyDays * 0.003);
    const monthlyPrice = Number(listing.price || 0) / 30;
    const estimatedMonthlyGain = monthlyPrice * 30 * estimatedOccupancyImprovement;

    const alert: VacancyAlert = {
      listingId,
      ownerId: owner.id,
      ownerEmail: owner.email,
      ownerName: owner.name || "Owner",
      listingTitle: listing.title || listing.property?.name || "Property",
      vacancyDays,
      severity,
      suggestedDiscount,
      estimatedOccupancyImprovement,
      estimatedMonthlyGain: Math.round(estimatedMonthlyGain * 100) / 100,
    };

    await prisma.notification.create({
      data: {
        userId: owner.id,
        orgId: listing.orgId,
        title: this.getNotificationTitle(severity),
        body: this.getNotificationBody(alert),
        type: "VACANCY_ALERT",
        ruleKey: "ALERT",
        status: "QUEUED",
        priority: severity === "CRITICAL" ? "HIGH" : "NORMAL",
        metadata: alert as any,
      },
    });

    await NotificationDispatcher.sendEmail(
      alert.ownerEmail,
      this.getNotificationTitle(severity),
      this.getNotificationBody(alert)
    );

    console.log(
      `[VacancyNotification] Alert sent to ${alert.ownerEmail}: ` +
        `${alert.vacancyDays} days vacant, suggested ${(alert.suggestedDiscount * 100).toFixed(0)}% discount`
    );
  }

  static async scanAllVacantListings(): Promise<{ checked: number; alerted: number }> {
    const config = defaultRankingConfig;
    const threshold = config.vacancy.vacancyThresholdDays;

    const vacantListings = await prisma.listing.findMany({
      where: {
        status: "VACANT",
        optimizationStatus: { not: "ACTIVE" },
        deletedAt: null,
      },
      include: {
        statusHistory: {
          where: { status: "VACANT" },
          orderBy: { fromDate: "asc" },
          take: 1,
        },
      },
    });

    let alerted = 0;
    for (const listing of vacantListings) {
      const vacantSince = listing.statusHistory[0]?.fromDate || listing.createdAt;
      const vacancyDays = Math.floor(
        (Date.now() - new Date(vacantSince).getTime()) / (1000 * 60 * 60 * 24)
      );

      if (vacancyDays >= threshold) {
        await this.checkAndNotify(listing.id, vacancyDays, config.vacancy);
        alerted++;
      }
    }

    console.log(`[VacancyNotification] Scanned ${vacantListings.length} listings, alerted ${alerted}`);
    return { checked: vacantListings.length, alerted };
  }

  private static getNotificationTitle(severity: VacancyAlert["severity"]): string {
    switch (severity) {
      case "CRITICAL":
        return "Urgent: Your Property Has Been Vacant for Over 90 Days";
      case "HIGH":
        return "Important: Your Property Has Been Vacant for Over 60 Days";
      case "MEDIUM":
        return "Vacancy Alert: Time to Optimize Your Listing";
      default:
        return "Vacancy Update: Market Suggestion Available";
    }
  }

  private static getNotificationBody(alert: VacancyAlert): string {
    return (
      `Your property "${alert.listingTitle}" has been vacant for ${alert.vacancyDays} days. ` +
      `AI recommends a ${(alert.suggestedDiscount * 100).toFixed(0)}% price optimization. ` +
      `Estimated occupancy improvement: ${(alert.estimatedOccupancyImprovement * 100).toFixed(0)}%. ` +
      `Expected additional monthly income: $${alert.estimatedMonthlyGain.toFixed(0)}.`
    );
  }
}
