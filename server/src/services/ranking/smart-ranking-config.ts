export interface RankingWeights {
  qualityScore: number;
  trustScore: number;
  boostScore: number;
  freshnessScore: number;
  engagementScore: number;
}

export interface BoostConfig {
  optimizationBoostMultiplier: number;
  promotedBoostMultiplier: number;
  boostDurationDays: number;
}

export interface VacancyConfig {
  vacancyThresholdDays: number;
  highVacancyThresholdDays: number;
  criticalVacancyThresholdDays: number;
}

export interface OptimizationConfig {
  minOptimizationRate: number;
  maxOptimizationRate: number;
  optimizationDurationDays: number;
}

export interface SmartRankingConfig {
  weights: RankingWeights;
  boost: BoostConfig;
  vacancy: VacancyConfig;
  optimization: OptimizationConfig;
  notificationTimingDays: number[];
}

export const defaultRankingConfig: SmartRankingConfig = {
  weights: {
    qualityScore: 0.35,
    trustScore: 0.20,
    boostScore: 0.20,
    freshnessScore: 0.15,
    engagementScore: 0.10,
  },
  boost: {
    optimizationBoostMultiplier: 1.5,
    promotedBoostMultiplier: 2.0,
    boostDurationDays: 30,
  },
  vacancy: {
    vacancyThresholdDays: 30,
    highVacancyThresholdDays: 60,
    criticalVacancyThresholdDays: 90,
  },
  optimization: {
    minOptimizationRate: 0.05,
    maxOptimizationRate: 0.07,
    optimizationDurationDays: 30,
  },
  notificationTimingDays: [30, 41, 60, 90],
};
