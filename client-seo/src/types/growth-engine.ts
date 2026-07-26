// ============================================================================
// MODULE 5: TELEMETRY, GAMIFICATION & OUTPUT SPECIFICATION
// ============================================================================

export type TelemetryEventType =
  | "AD_BUDGET_SHIFTED"
  | "PROPERTY_ANALYZED"
  | "DEFECT_DETECTED"
  | "INSURANCE_ATTACHED"
  | "LEAD_CAPTURED"
  | "DEPOSIT_SECURED"
  | "BROCHURE_GENERATED"
  | "VIDEO_LOCALIZED"
  | "CAMPAIGN_LAUNCHED"
  | "CREATIVE_OPTIMIZED"
  | "CONVERSION_TRACKED"
  | "ESCROW_FUNDED"
  | "PAYOUT_PROCESSED"
  | "ARBITRAGE_COMPLETED"
  | "REBATE_APPLIED"
  | "STAGE_GENERATED"
  | "HEALTH_REPORT_CREATED"
  | "OFFLINE_CONVERSION_SYNCED";

export type GamificationAchievementType =
  | "FIRST_PROPERTY_ANALYZED"
  | "100_LEADS_CAPTURED"
  | "FIRST_CONVERSION"
  | "BUDGET_OPTIMIZER"
  | "ARBITRAGE_MASTER"
  | "CONTENT_VIRAL"
  | "ZERO_EFFORT_ENABLED"
  | "INSURANCE_CROSS_SELL"
  | "MULTI_NETWORK_ACTIVE"
  | "CREATOR_ENGAGEMENT";

export type DashboardWidgetType =
  | "SPATIAL_HEALTH"
  | "AD_PERFORMANCE"
  | "CREATOR_LEADERBOARD"
  | "ESCROW_STATUS"
  | "ARBITRAGE_ENGINE"
  | "INSURANCE_PIPE"
  | "CONVERSION_FUNNEL"
  | "TELEMETRY_FEED"
  | "GAMIFICATION_PROGRESS"
  | "BROCHURE_PIPELINE";

export interface TelemetryEvent {
  id: string;
  orgId: string;
  type: TelemetryEventType;
  emoji: string;
  title: string;
  description: string;
  metadata: Record<string, any>;
  severity: "INFO" | "SUCCESS" | "WARNING" | "ERROR";
  timestamp: string;
  source: string;
  acknowledged: boolean;
}

export interface TelemetryFeed {
  events: TelemetryEvent[];
  totalEvents: number;
  unreadCount: number;
  lastUpdated: string;
}

export interface GamificationAchievement {
  id: string;
  type: GamificationAchievementType;
  name: string;
  description: string;
  emoji: string;
  points: number;
  tier: "BRONZE" | "SILVER" | "GOLD" | "PLATINUM";
  unlockedAt?: string;
  progress: number;
  target: number;
  unlocked: boolean;
}

export interface GamificationState {
  totalPoints: number;
  level: number;
  levelName: string;
  nextLevelPoints: number;
  achievements: GamificationAchievement[];
  unlockedCount: number;
  totalAchievements: number;
  streak: number;
  lastActivity: string;
}

export interface ConversionFunnelStage {
  stage: string;
  count: number;
  conversionRate: number;
  averageTimeDays: number;
  value: number;
}

export interface ConversionFunnel {
  propertyViews: number;
  leadCaptures: number;
  qualifiedLeads: number;
  viewingsScheduled: number;
  applicationsSubmitted: number;
  escrowDeposits: number;
  transactionsClosed: number;
  overallConversionRate: number;
  averageCycleDays: number;
  stages: ConversionFunnelStage[];
}

export interface DashboardWidget {
  id: string;
  type: DashboardWidgetType;
  title: string;
  emoji: string;
  data: any;
  lastUpdated: string;
  size: "SMALL" | "MEDIUM" | "LARGE";
}

export interface GrowthEngineSummary {
  id: string;
  orgId: string;
  period: string;
  spatialAnalytics: {
    propertiesAnalyzed: number;
    defectsFound: number;
    healthReportsGenerated: number;
    virtualStagesCreated: number;
    insurancePoliciesAttached: number;
  };
  adRouter: {
    totalSpend: number;
    totalRevenue: number;
    overallROAS: number;
    networkShifts: number;
    arbitrageSavings: number;
    rebateSavings: number;
    activeCampaigns: number;
  };
  creatorCommerce: {
    activeCreators: number;
    totalContentViews: number;
    leadsFromCreators: number;
    creatorConversions: number;
    liquidityPoolUtilization: number;
    zeroUpfrontCampaigns: number;
  };
  escrow: {
    totalLocked: number;
    totalReleased: number;
    totalRecouped: number;
    pendingSettlements: number;
    disputesOpen: number;
  };
  telemetry: {
    eventsToday: number;
    achievementsUnlocked: number;
    gamificationPoints: number;
    systemHealth: number;
  };
  generatedAt: string;
}
