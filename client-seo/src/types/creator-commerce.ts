// ============================================================================
// MODULE 4: CREATOR COMMERCE LOOP & PAY-AS-YOU-EARN FINTECH
// ============================================================================

export type CreatorTier = "PLATINUM" | "GOLD" | "SILVER" | "BRONZE";
export type CreatorStatus = "PENDING" | "ACTIVE" | "SUSPENDED" | "TERMINATED";
export type ContentFormat = "VIDEO_WALKTHROUGH" | "NEIGHBORHOOD_TOUR" | "REEL" | "STORY" | "BLOG" | "LIVE_STREAM" | "SHORT_FORM";
export type ContentStatus = "DRAFT" | "REVIEW" | "PUBLISHED" | "ARCHIVED" | "FLAGGED";
export type LeadStatus = "NEW" | "CONTACTED" | "QUALIFIED" | "VIEWING_SCHEDULED" | "APPLICATION_SUBMITTED" | "CONVERTED" | "LOST";
export type EscrowTrigger = "LEAD_CAPTURE" | "VIEWING_COMPLETED" | "APPLICATION_SUBMITTED" | "LEASE_SIGNED" | "DEPOSIT_RECEIVED" | "PURCHASE_CLOSED";
export type PayoutStatus = "PENDING" | "PROCESSING" | "COMPLETED" | "FAILED" | "HELD";

export interface CreatorProfile {
  id: string;
  orgId: string;
  userId: string;
  displayName: string;
  bio: string;
  avatarUrl: string;
  tier: CreatorTier;
  status: CreatorStatus;
  platforms: CreatorPlatform[];
  totalFollowers: number;
  averageEngagementRate: number;
  totalContentViews: number;
  totalLeadsGenerated: number;
  totalConversions: number;
  conversionRate: number;
  totalEarnings: number;
  pendingPayout: number;
  contractStart: string;
  contractEnd?: string;
  ndaSigned: boolean;
  commissionStructure: CommissionStructure;
  performanceMetrics: CreatorPerformanceMetrics;
  createdAt: string;
  updatedAt: string;
}

export interface CreatorPlatform {
  platform: "YOUTUBE" | "TIKTOK" | "INSTAGRAM" | "LINKEDIN" | "WEIBO" | "NAVER" | "VK" | "WHATSAPP";
  handle: string;
  followers: number;
  engagementRate: number;
  verified: boolean;
  connectedAt: string;
}

export interface CommissionStructure {
  leadCapturePercent: number;
  viewingCompletionPercent: number;
  leaseSigningPercent: number;
  saleClosingPercent: number;
  flatBonusPerConversion: number;
  tierMultiplier: number;
  currency: string;
}

export interface CreatorPerformanceMetrics {
  totalContentViews: number;
  averageWatchTimeMs: number;
  completionRate: number;
  totalLeads: number;
  qualifiedLeads: number;
  conversionRate: number;
  averageLeadResponseTimeMs: number;
  contentROI: number;
  monthlyTrend: MonthlyCreatorMetric[];
}

export interface MonthlyCreatorMetric {
  month: string;
  views: number;
  leads: number;
  conversions: number;
  earnings: number;
}

export interface CreatorContent {
  id: string;
  creatorId: string;
  propertyId: string;
  format: ContentFormat;
  title: string;
  description: string;
  mediaUrl: string;
  thumbnailUrl: string;
  duration?: number;
  status: ContentStatus;
  publishedAt?: string;
  platforms: string[];
  performance: ContentPerformance;
  localizedVersions: ContentLocalizedVersion[];
  leadTracking: LeadTracking;
  createdAt: string;
}

export interface ContentPerformance {
  views: number;
  likes: number;
  shares: number;
  comments: number;
  saves: number;
  averageWatchTimeMs: number;
  completionRate: number;
  clickThroughRate: number;
  leadCaptures: number;
  conversions: number;
  revenue: number;
}

export interface ContentLocalizedVersion {
  language: string;
  title: string;
  description: string;
  subtitlesUrl?: string;
  dubbingUrl?: string;
  semanticTags: string[];
}

export interface LeadTracking {
  totalLeads: number;
  qualifiedLeads: number;
  leads: LeadRecord[];
}

export interface LeadRecord {
  id: string;
  contentId: string;
  creatorId: string;
  propertyId: string;
  name: string;
  email: string;
  phone?: string;
  source: string;
  status: LeadStatus;
  qualificationScore: number;
  firstResponseAt?: string;
  convertedAt?: string;
  conversionValue?: number;
  networkAttribution: string;
  createdAt: string;
}

export interface AdLiquidityPool {
  id: string;
  orgId: string;
  totalLiquidity: number;
  availableLiquidity: number;
  committedLiquidity: number;
  currency: string;
  dailyLimit: number;
  weeklyLimit: number;
  currentWeekUsage: number;
  pendingRecoupments: number;
  totalRecouped: number;
  status: "ACTIVE" | "DEPLETED" | "FROZEN";
  lastUpdated: string;
}

export interface ZeroUpfrontCampaign {
  id: string;
  creatorId: string;
  propertyId: string;
  poolId: string;
  fundedAmount: number;
  campaignType: CampaignObjective;
  networks: string[];
  targetDemographics: string[];
  expectedLeads: number;
  actualLeads: number;
  expectedRevenue: number;
  actualRevenue: number;
  recoupmentStatus: RecoupmentStatus;
  escrowAccountId?: string;
  status: "PENDING_FUNDING" | "ACTIVE" | "RECOUPING" | "FULLY_RECOUPED" | "WRITTEN_OFF";
  createdAt: string;
}

export type CampaignObjective = "LEAD_GENERATION" | "VIEWING_DRIVEN" | "RENTAL_CONVERSION" | "SALE_CONVERSION" | "BRAND_AWARENESS";

export interface RecoupmentStatus {
  totalFunded: number;
  totalRecouped: number;
  recoupmentPercent: number;
  platformFeeDeducted: number;
  creatorShareDeducted: number;
  remainingBalance: number;
  nextRecoupmentTrigger: EscrowTrigger;
  history: RecoupmentEntry[];
}

export interface RecoupmentEntry {
  id: string;
  escrowAccountId: string;
  triggerEvent: EscrowTrigger;
  grossAmount: number;
  platformFee: number;
  creatorShare: number;
  netRecouped: number;
  timestamp: string;
}

export interface CreatorPayout {
  id: string;
  creatorId: string;
  amount: number;
  currency: string;
  status: PayoutStatus;
  period: string;
  breakdown: PayoutBreakdown;
  processedAt?: string;
  createdAt: string;
}

export interface PayoutBreakdown {
  leadCaptureEarnings: number;
  viewingCompletionEarnings: number;
  leaseSigningEarnings: number;
  saleClosingEarnings: number;
  flatBonuses: number;
  tierBonus: number;
  adjustments: number;
  taxWithheld: number;
  netPayout: number;
}

export interface ClosedLoopSettlement {
  id: string;
  reservationId: string;
  escrowAccountId: string;
  campaignIds: string[];
  totalTransactionValue: number;
  platformFee: number;
  adSpendRecouped: number;
  creatorSharesPaid: number;
  agentCommissions: number;
  insurancePremiumsCollected: number;
  netSettlement: number;
  settlementStatus: "PENDING" | "PROCESSING" | "COMPLETED" | "PARTIAL";
  processedAt?: string;
  createdAt: string;
}
