import { apiClient } from "./client";
import type {
  CreatorProfile,
  CreatorContent,
  AdLiquidityPool,
  ZeroUpfrontCampaign,
  CreatorPayout,
  ClosedLoopSettlement,
  LeadRecord,
} from "@/types/creator-commerce";

export const creatorCommerceApi = {
  getCreators: (params?: any) =>
    apiClient.get<{ data: CreatorProfile[] }>("/creators", params),

  getCreatorById: (id: string) =>
    apiClient.get<{ data: CreatorProfile }>(`/creators/${id}`),

  createCreator: (data: Partial<CreatorProfile>) =>
    apiClient.post<{ data: CreatorProfile }>("/creators", data),

  updateCreator: (id: string, data: Partial<CreatorProfile>) =>
    apiClient.put<{ data: CreatorProfile }>(`/creators/${id}`, data),

  getCreatorContent: (creatorId: string) =>
    apiClient.get<{ data: CreatorContent[] }>(`/creators/${creatorId}/content`),

  createContent: (data: Partial<CreatorContent>) =>
    apiClient.post<{ data: CreatorContent }>("/creator-content", data),

  getCreatorLeads: (creatorId: string) =>
    apiClient.get<{ data: LeadRecord[] }>(`/creators/${creatorId}/leads`),

  getCreatorPayouts: (creatorId: string) =>
    apiClient.get<{ data: CreatorPayout[] }>(`/creators/${creatorId}/payouts`),

  processPayout: (payoutId: string) =>
    apiClient.post(`/creator-payouts/${payoutId}/process`),

  getLiquidityPool: () =>
    apiClient.get<{ data: AdLiquidityPool }>("/ad-liquidity-pool"),

  fundLiquidityPool: (amount: number) =>
    apiClient.post<{ data: AdLiquidityPool }>("/ad-liquidity-pool/fund", { amount }),

  getZeroUpfrontCampaigns: (params?: any) =>
    apiClient.get<{ data: ZeroUpfrontCampaign[] }>("/zero-upfront-campaigns", params),

  createZeroUpfrontCampaign: (data: {
    creatorId: string;
    propertyId: string;
    campaignType: string;
    networks: string[];
    targetDemographics: string[];
  }) =>
    apiClient.post<{ data: ZeroUpfrontCampaign }>("/zero-upfront-campaigns", data),

  getSettlements: (params?: any) =>
    apiClient.get<{ data: ClosedLoopSettlement[] }>("/closed-loop-settlements", params),

  processSettlement: (reservationId: string) =>
    apiClient.post<{ data: ClosedLoopSettlement }>(`/closed-loop-settlements/${reservationId}/process`),

  getCreatorLeaderboard: () =>
    apiClient.get<{ data: CreatorProfile[] }>("/creators/leaderboard"),
};
