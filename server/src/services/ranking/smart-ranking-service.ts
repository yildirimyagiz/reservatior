import { eventBus } from "../../core/events/event-bus";
import { DomainEvents } from "../../core/events/domain-events";
import { prisma } from "../../lib/prisma";
import {
  SmartRankingConfig,
  defaultRankingConfig,
} from "./smart-ranking-config";

export class SmartRankingService {
  private config: SmartRankingConfig;

  constructor(config?: Partial<SmartRankingConfig>) {
    this.config = {
      ...defaultRankingConfig,
      ...config,
      weights: { ...defaultRankingConfig.weights, ...config?.weights },
      boost: { ...defaultRankingConfig.boost, ...config?.boost },
      vacancy: { ...defaultRankingConfig.vacancy, ...config?.vacancy },
      optimization: {
        ...defaultRankingConfig.optimization,
        ...config?.optimization,
      },
    };
  }

  async calculateRankingScore(
    listing: {
      id: string;
      title?: string;
      description?: string;
      photos?: string[];
      qualityScore?: number;
      agentReputation?: number;
      isVerified?: boolean;
      boostScore?: number;
      isPromoted?: boolean;
      isOptimizedForSpeed?: boolean;
      createdAt?: Date;
      updatedAt?: Date;
      likes?: number;
      views?: number;
      saves?: number;
      chatRequests?: number;
    },
    config?: Partial<SmartRankingConfig>,
  ): Promise<number> {
    try {
      const cfg = config
        ? { ...this.config, ...config, weights: { ...this.config.weights, ...config.weights } }
        : this.config;

      const qualityScore = this.computeQualityScore(listing);
      const trustScore = this.computeTrustScore(listing);
      const boostScore = this.computeBoostScore(listing, cfg);
      const freshnessScore = this.computeFreshnessScore(listing);
      const engagementScore = this.computeEngagementScore(listing);

      const rankingScore =
        qualityScore * cfg.weights.qualityScore +
        trustScore * cfg.weights.trustScore +
        boostScore * cfg.weights.boostScore +
        freshnessScore * cfg.weights.freshnessScore +
        engagementScore * cfg.weights.engagementScore;

      const finalScore = Math.round(rankingScore * 100) / 100;

      console.log(
        `[SmartRankingService] Listing ${listing.id} ranking score: ${finalScore} ` +
          `(quality=${qualityScore}, trust=${trustScore}, boost=${boostScore}, ` +
          `freshness=${freshnessScore}, engagement=${engagementScore})`,
      );

      return finalScore;
    } catch (error) {
      console.error(
        `[SmartRankingService] Error calculating ranking score for listing ${listing.id}:`,
        error,
      );
      throw error;
    }
  }

  private computeQualityScore(listing: {
    title?: string;
    description?: string;
    photos?: string[];
    qualityScore?: number;
  }): number {
    let score = 0;

    if (listing.title && listing.title.length > 0) {
      score += 0.2;
      if (listing.title.length >= 10) {
        score += 0.05;
      }
    }

    if (listing.description && listing.description.length > 0) {
      score += 0.2;
      if (listing.description.length >= 50) {
        score += 0.1;
      }
    }

    const photoCount = listing.photos?.length ?? 0;
    if (photoCount > 0) {
      score += 0.1;
      if (photoCount >= 3) {
        score += 0.05;
      }
      if (photoCount >= 5) {
        score += 0.05;
      }
    }

    if (listing.qualityScore !== undefined) {
      score += listing.qualityScore * 0.3;
    }

    return Math.min(score, 1.0);
  }

  private computeTrustScore(listing: {
    agentReputation?: number;
    isVerified?: boolean;
  }): number {
    let score = 0.3;

    if (listing.isVerified) {
      score += 0.3;
    }

    if (listing.agentReputation !== undefined) {
      score += listing.agentReputation * 0.4;
    }

    return Math.min(score, 1.0);
  }

  private computeBoostScore(
    listing: {
      boostScore?: number;
      isPromoted?: boolean;
      isOptimizedForSpeed?: boolean;
    },
    config: SmartRankingConfig,
  ): number {
    let baseScore = listing.boostScore ?? 0.5;

    if (listing.isOptimizedForSpeed) {
      baseScore *= config.boost.optimizationBoostMultiplier;
    }

    if (listing.isPromoted) {
      baseScore *= config.boost.promotedBoostMultiplier;
    }

    return Math.min(baseScore, 1.0);
  }

  private computeFreshnessScore(listing: {
    createdAt?: Date;
    updatedAt?: Date;
  }): number {
    const lastActivity = listing.updatedAt ?? listing.createdAt;
    if (!lastActivity) return 0.5;

    const now = new Date();
    const daysSinceUpdate =
      (now.getTime() - new Date(lastActivity).getTime()) / (1000 * 60 * 60 * 24);

    const decayRate = 0.9;
    const score = Math.pow(decayRate, daysSinceUpdate);

    return Math.round(score * 100) / 100;
  }

  private computeEngagementScore(listing: {
    likes?: number;
    views?: number;
    saves?: number;
    chatRequests?: number;
  }): number {
    const likes = listing.likes ?? 0;
    const views = listing.views ?? 0;
    const saves = listing.saves ?? 0;
    const chatRequests = listing.chatRequests ?? 0;

    const normalizedLikes = Math.min(likes / 100, 1.0);
    const normalizedViews = Math.min(views / 1000, 1.0);
    const normalizedSaves = Math.min(saves / 50, 1.0);
    const normalizedChats = Math.min(chatRequests / 20, 1.0);

    const score =
      normalizedLikes * 0.25 +
      normalizedViews * 0.25 +
      normalizedSaves * 0.25 +
      normalizedChats * 0.25;

    return Math.round(score * 100) / 100;
  }

  async activateOptimizationBoost(
    listingId: string,
    rate: number,
    reason: string,
    source: string,
  ): Promise<{ listingId: string; boostScore: number; rankingScore: number }> {
    try {
      const { minOptimizationRate, maxOptimizationRate, optimizationDurationDays } =
        this.config.optimization;

      if (rate < minOptimizationRate || rate > maxOptimizationRate) {
        throw new Error(
          `Optimization rate ${rate} is outside allowed range [${minOptimizationRate}, ${maxOptimizationRate}]`,
        );
      }

      const boostExpirationDate = new Date();
      boostExpirationDate.setDate(boostExpirationDate.getDate() + optimizationDurationDays);

      const boostScore = Math.min(rate / this.config.optimization.maxOptimizationRate, 1.0);

      const listing = await (prisma as any).listing.update({
        where: { id: listingId },
        data: {
          optimizationStatus: "ACTIVE",
          isOptimizedForSpeed: true,
          optimizationRate: rate,
          boostScore,
          boostExpiresAt: boostExpirationDate,
          updatedAt: new Date(),
        },
      });

      console.log(
        `[SmartRankingService] Activated optimization boost for listing ${listingId}: ` +
          `rate=${rate}, reason=${reason}, source=${source}, expires=${boostExpirationDate.toISOString()}`,
      );

      const rankingScore = await this.calculateRankingScore({
        id: listing.id,
        title: listing.title,
        description: listing.description,
        photos: listing.photos as string[],
        qualityScore: listing.qualityScore ?? undefined,
        boostScore: listing.boostScore ?? undefined,
        isOptimizedForSpeed: listing.isOptimizedForSpeed,
        createdAt: listing.createdAt,
        updatedAt: listing.updatedAt,
      });

      await (prisma as any).listing.update({
        where: { id: listingId },
        data: { rankingScore },
      });

      await eventBus.publish(
        DomainEvents.LISTING_BOOSTED,
        {
          listingId,
          rate,
          reason,
          source,
          boostScore,
          boostExpiresAt: boostExpirationDate,
        },
        "SmartRanking",
      );

      await eventBus.publish(
        DomainEvents.BOOST_SCORE_UPDATED,
        {
          listingId,
          previousBoostScore: 0.5,
          newBoostScore: boostScore,
          rankingScore,
        },
        "SmartRanking",
      );

      await this.scheduleBoostExpiration(listingId, optimizationDurationDays);

      return { listingId, boostScore, rankingScore };
    } catch (error) {
      console.error(
        `[SmartRankingService] Error activating optimization boost for listing ${listingId}:`,
        error,
      );
      throw error;
    }
  }

  async expireOptimization(
    listingId: string,
  ): Promise<{ listingId: string; rankingScore: number }> {
    try {
      const listing = await (prisma as any).listing.findUnique({
        where: { id: listingId },
      });

      if (!listing) {
        throw new Error(`Listing ${listingId} not found`);
      }

      const previousBoostScore = listing.boostScore ?? 0.5;
      const newBoostScore = previousBoostScore * 0.5;

      const updatedListing = await (prisma as any).listing.update({
        where: { id: listingId },
        data: {
          optimizationStatus: "EXPIRED",
          isOptimizedForSpeed: false,
          boostScore: newBoostScore,
          boostExpiresAt: null,
          updatedAt: new Date(),
        },
      });

      console.log(
        `[SmartRankingService] Expired optimization for listing ${listingId}: ` +
          `boostScore ${previousBoostScore} -> ${newBoostScore}`,
      );

      const rankingScore = await this.calculateRankingScore({
        id: updatedListing.id,
        title: updatedListing.title,
        description: updatedListing.description,
        photos: updatedListing.photos as string[],
        qualityScore: updatedListing.qualityScore ?? undefined,
        boostScore: updatedListing.boostScore ?? undefined,
        isOptimizedForSpeed: updatedListing.isOptimizedForSpeed,
        createdAt: updatedListing.createdAt,
        updatedAt: updatedListing.updatedAt,
      });

      await (prisma as any).listing.update({
        where: { id: listingId },
        data: { rankingScore },
      });

      await eventBus.publish(
        DomainEvents.BOOST_SCORE_UPDATED,
        {
          listingId,
          previousBoostScore,
          newBoostScore,
          rankingScore,
          expired: true,
        },
        "SmartRanking",
      );

      return { listingId, rankingScore };
    } catch (error) {
      console.error(
        `[SmartRankingService] Error expiring optimization for listing ${listingId}:`,
        error,
      );
      throw error;
    }
  }

  async vacancyAnalysis(
    listingId: string,
  ): Promise<{
    listingId: string;
    vacancyDays: number;
    vacancyScore: number;
    thresholdReached: boolean;
  }> {
    try {
      const statusHistory = await (prisma as any).listingStatusHistory.findMany({
        where: { listingId },
        orderBy: { createdAt: "desc" },
      });

      let vacancyDays = 0;

      if (statusHistory.length > 0) {
        const now = new Date();

        const lastOccupiedEntry = statusHistory.find(
          (entry: { status: string; }) => entry.status !== "AVAILABLE" && entry.status !== "VACANT",
        );

        if (lastOccupiedEntry) {
          vacancyDays = Math.floor(
            (now.getTime() - new Date(lastOccupiedEntry.createdAt).getTime()) /
              (1000 * 60 * 60 * 24),
          );
        } else {
          const oldestEntry = statusHistory[statusHistory.length - 1];
          vacancyDays = Math.floor(
            (now.getTime() - new Date(oldestEntry.createdAt).getTime()) /
              (1000 * 60 * 60 * 24),
          );
        }
      }

      const { vacancyThresholdDays, highVacancyThresholdDays, criticalVacancyThresholdDays } =
        this.config.vacancy;

      let vacancyScore: number;
      if (vacancyDays >= criticalVacancyThresholdDays) {
        vacancyScore = 0.0;
      } else if (vacancyDays >= highVacancyThresholdDays) {
        vacancyScore = 0.1;
      } else if (vacancyDays >= vacancyThresholdDays) {
        vacancyScore = 0.3;
      } else {
        vacancyScore = 1.0 - vacancyDays / (vacancyThresholdDays * 10);
      }

      const thresholdReached =
        vacancyDays >= vacancyThresholdDays ||
        vacancyDays >= highVacancyThresholdDays ||
        vacancyDays >= criticalVacancyThresholdDays;

      await (prisma as any).listing.update({
        where: { id: listingId },
        data: {
          vacancyDays,
          vacancyScore,
          updatedAt: new Date(),
        },
      });

      console.log(
        `[SmartRankingService] Vacancy analysis for listing ${listingId}: ` +
          `days=${vacancyDays}, score=${vacancyScore}, thresholdReached=${thresholdReached}`,
      );

      if (thresholdReached) {
        let severity: string;
        if (vacancyDays >= criticalVacancyThresholdDays) {
          severity = "CRITICAL";
        } else if (vacancyDays >= highVacancyThresholdDays) {
          severity = "HIGH";
        } else {
          severity = "WARNING";
        }

        const shouldNotify = this.config.notificationTimingDays.includes(vacancyDays);

        await eventBus.publish(
          DomainEvents.VACANCY_THRESHOLD_REACHED,
          {
            listingId,
            vacancyDays,
            vacancyScore,
            severity,
            shouldNotify,
          },
          "SmartRankingService"
        );

        console.log(
          `[SmartRankingService] Published VACANCY_THRESHOLD_REACHED for listing ${listingId}: ` +
            `severity=${severity}, shouldNotify=${shouldNotify}`,
        );
      }

      await eventBus.publish(
        DomainEvents.VACANCY_ANALYZED,
        {
          listingId,
          vacancyDays,
          vacancyScore,
          thresholdReached,
        },
        "SmartRankingService"
      );

      return { listingId, vacancyDays, vacancyScore, thresholdReached };
    } catch (error) {
      console.error(
        `[SmartRankingService] Error analyzing vacancy for listing ${listingId}:`,
        error,
      );
      throw error;
    }
  }

  async recalculateAllRankings(): Promise<{ totalProcessed: number; failed: number }> {
    try {
      console.log("[SmartRankingService] Starting batch ranking recalculation...");

      const activeListings: any[] = await (prisma as any).listing.findMany({
        where: {
          status: "ACTIVE",
        },
      });

      let failed = 0;

      for (const listing of activeListings) {
        try {
          const rankingScore = await this.calculateRankingScore({
            id: listing.id,
            title: listing.title,
            description: listing.description,
            photos: listing.photos as string[],
            qualityScore: listing.qualityScore ?? undefined,
            agentReputation: listing.agentReputation ?? undefined,
            isVerified: listing.isVerified,
            boostScore: listing.boostScore ?? undefined,
            isPromoted: listing.isPromoted,
            isOptimizedForSpeed: listing.isOptimizedForSpeed,
            createdAt: listing.createdAt,
            updatedAt: listing.updatedAt,
            likes: listing.likes,
            views: listing.views,
            saves: listing.saves,
            chatRequests: listing.chatRequests,
          });

          await (prisma as any).listing.update({
            where: { id: listing.id },
            data: { rankingScore },
          });
        } catch (error) {
          failed++;
          console.error(
            `[SmartRankingService] Failed to recalculate ranking for listing ${listing.id}:`,
            error,
          );
        }
      }

      const totalProcessed = activeListings.length;

      console.log(
        `[SmartRankingService] Batch recalculation complete: ` +
          `${totalProcessed} processed, ${failed} failed`,
      );

      return { totalProcessed, failed };
    } catch (error) {
      console.error("[SmartRankingService] Error during batch ranking recalculation:", error);
      throw error;
    }
  }

  async getOptimizedListings(): Promise<
    Array<{
      id: string;
      title: string;
      optimizationStatus: string;
      optimizationRate: number | null;
      boostScore: number | null;
      boostExpiresAt: Date | null;
      rankingScore: number | null;
    }>
  > {
    try {
      const listings: any[] = await (prisma as any).listing.findMany({
        where: {
          optimizationStatus: "ACTIVE",
        },
        select: {
          id: true,
          title: true,
          optimizationStatus: true,
          optimizationRate: true,
          boostScore: true,
          boostExpiresAt: true,
          rankingScore: true,
        },
        orderBy: { rankingScore: "desc" },
      });

      console.log(
        `[SmartRankingService] Retrieved ${listings.length} optimized listings`,
      );

      return listings;
    } catch (error) {
      console.error("[SmartRankingService] Error retrieving optimized listings:", error);
      throw error;
    }
  }

  private async scheduleBoostExpiration(
    listingId: string,
    durationDays: number,
  ): Promise<void> {
    try {
      const expirationDate = new Date();
      expirationDate.setDate(expirationDate.getDate() + durationDays);

      const delayMs = expirationDate.getTime() - Date.now();

      setTimeout(async () => {
        try {
          const listing = await (prisma as any).listing.findUnique({
            where: { id: listingId },
          });

          if (listing && listing.optimizationStatus === "ACTIVE") {
            await this.expireOptimization(listingId);
            console.log(
              `[SmartRankingService] Boost expired for listing ${listingId} via scheduled task`,
            );
          }
        } catch (error) {
          console.error(
            `[SmartRankingService] Error in scheduled boost expiration for listing ${listingId}:`,
            error,
          );
        }
      }, delayMs);

      console.log(
        `[SmartRankingService] Scheduled boost expiration for listing ${listingId} in ${durationDays} days`,
      );
    } catch (error) {
      console.error(
        `[SmartRankingService] Error scheduling boost expiration for listing ${listingId}:`,
        error,
      );
    }
  }
}

export const smartRankingService = new SmartRankingService();
