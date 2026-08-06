// ============================================================================
// MODULE 3: UNIVERSAL AD ROUTER & ARBITRAGE (OMNICHANNEL AD ENGINE)
// ============================================================================

export type AdNetwork =
  | "GOOGLE_ADS" | "META_CAPI" | "TIKTOK" | "LINKEDIN" | "MICROSOFT_BING"
  | "BAIDU_MARKETING" | "NAVER_SEARCH_ADS" | "YAHOO_JAPAN"
  | "YANDEX_DIRECT" | "WHATSAPP_BUSINESS" | "SNAPCHAT";

export type AdNetworkCategory = "GLOBAL_WESTERN" | "EAST_ASIA_APAC" | "CIS_EASTERN_EUROPE" | "MESSAGING";

export type CampaignObjective = "LEAD_GENERATION" | "PROPERTY_AWARENESS" | "OPEN_HOUSE" | "RENTAL_INQUIRY" | "SALE_CONVERSION" | "BRAND_AWARENESS" | "RETARGETING";

export type AdCampaignStatus = "DRAFT" | "PENDING_REVIEW" | "ACTIVE" | "PAUSED" | "COMPLETED" | "REJECTED" | "SCHEDULED";

export type BidStrategy = "MANUAL_CPC" | "MAXIMIZE_CLICKS" | "TARGET_CPA" | "TARGET_ROAS" | "MAXIMIZE_CONVERSIONS" | "COST_PER_EXECUTED_TRANSACTION";

export type AdCreativeFormat = "IMAGE" | "VIDEO" | "CAROUSEL" | "STORY" | "REEL" | "SEARCH_TEXT" | "DISPLAY" | "NATIVE" | "LANDING_PAGE";

export interface AdNetworkConfig {
  network: AdNetwork;
  category: AdNetworkCategory;
  isEnabled: boolean;
  apiKeyRef: string;
  accountId: string;
  currency: string;
  timezone: string;
  monthlyBudgetCap: number;
  dailyBudgetCap: number;
  cpetTarget: number;
  cpqlTarget: number;
  volumeRebateTier: VolumeRebateTier;
  lastSyncAt: string;
  status: "CONNECTED" | "DISCONNECTED" | "ERROR" | "PENDING_SETUP";
  connectedRegions: string[];
}

export interface VolumeRebateTier {
  tier: "STANDARD" | "BRONZE" | "SILVER" | "GOLD" | "PLATINUM";
  monthlySpendMin: number;
  monthlySpendMax: number;
  rebatePercent: number;
  description: string;
}

export interface AdCampaign {
  id: string;
  orgId: string;
  name: string;
  objective: CampaignObjective;
  status: AdCampaignStatus;
  networks: AdNetwork[];
  totalBudget: number;
  spentAmount: number;
  currency: string;
  startDate: string;
  endDate?: string;
  targetDemographics: string[];
  targetLocations: string[];
  targetLanguages: string[];
  creatives: AdCreative[];
  performance: CampaignPerformance;
  arbitrage: ArbitrageState;
  createdAt: string;
  updatedAt: string;
}

export interface AdCreative {
  id: string;
  campaignId: string;
  format: AdCreativeFormat;
  headline: string;
  description: string;
  callToAction: string;
  imageUrl?: string;
  videoUrl?: string;
  landingPageUrl: string;
  localizedVariants: AdCreativeVariant[];
  performance: CreativePerformance;
}

export interface AdCreativeVariant {
  language: string;
  headline: string;
  description: string;
  callToAction: string;
  culturalAdaptation?: string;
}

export interface CampaignPerformance {
  impressions: number;
  clicks: number;
  ctr: number;
  conversions: number;
  conversionRate: number;
  cpc: number;
  cpet: number;
  cpql: number;
  totalSpend: number;
  revenue: number;
  roas: number;
  qualifiedLeads: number;
  executedTransactions: number;
  networkBreakdown: NetworkPerformance[];
  dailyTrend: DailyMetric[];
}

export interface CreativePerformance {
  impressions: number;
  clicks: number;
  ctr: number;
  conversions: number;
  cpc: number;
  cpet: number;
  cpql: number;
  spend: number;
  revenue: number;
  roas: number;
  qualifiedLeads: number;
  executedTransactions: number;
  engagementRate: number;
}

export interface NetworkPerformance {
  network: AdNetwork;
  impressions: number;
  clicks: number;
  ctr: number;
  conversions: number;
  cpc: number;
  spend: number;
  roas: number;
  qualifiedLeads: number;
  executedTransactions: number;
  cpet: number;
  cpql: number;
  healthScore: number;
}

export interface DailyMetric {
  date: string;
  impressions: number;
  clicks: number;
  spend: number;
  conversions: number;
  revenue: number;
}

export interface ArbitrageState {
  totalBudget: number;
  allocatedBudgets: NetworkAllocation[];
  lastShiftAt: string;
  shiftCount: number;
  totalSavings: number;
  appliedRebates: AppliedRebate[];
  optimizationScore: number;
}

export interface NetworkAllocation {
  network: AdNetwork;
  allocatedBudget: number;
  utilizationPercent: number;
  efficiencyScore: number;
  reason: string;
}

export interface AppliedRebate {
  network: AdNetwork;
  tier: string;
  rebatePercent: number;
  amountSaved: number;
  period: string;
}

export interface AdBudgetShiftEvent {
  id: string;
  campaignId: string;
  fromNetwork: AdNetwork;
  toNetwork: AdNetwork;
  amount: number;
  reason: string;
  cpetBefore: number;
  cpetAfter: number;
  triggeredBy: "AI_ARBITRAGE" | "MANUAL" | "SCHEDULED" | "BUDGET_EXHAUSTED";
  timestamp: string;
}

export interface OfflineConversionEvent {
  id: string;
  campaignId: string;
  network: AdNetwork;
  conversionType: "INQUIRY" | "VIEWING" | "APPLICATION" | "LEASE_SIGNED" | "PURCHASE_CLOSED" | "DEPOSIT_PLACED";
  value: number;
  currency: string;
  attributedTo: string;
  sentToNetwork: boolean;
  sentAt?: string;
  matchRate: number;
  timestamp: string;
}

export interface AdArbitrageReport {
  id: string;
  period: string;
  totalSpend: number;
  totalRevenue: number;
  overallROAS: number;
  overallCPET: number;
  overallCPQL: number;
  networkComparison: NetworkPerformance[];
  budgetShifts: AdBudgetShiftEvent[];
  savingsFromArbitrage: number;
  savingsFromRebates: number;
  recommendations: ArbitrageRecommendation[];
  generatedAt: string;
}

export interface ArbitrageRecommendation {
  type: "SHIFT_BUDGET" | "INCREASE_SPEND" | "DECREASE_SPEND" | "PAUSE_NETWORK" | "ADD_NETWORK" | "OPTIMIZE_CREATIVE";
  network: AdNetwork;
  currentCPET: number;
  projectedCPET: number;
  budgetImpact: number;
  confidence: number;
  rationale: string;
  priority: "HIGH" | "MEDIUM" | "LOW";
}
