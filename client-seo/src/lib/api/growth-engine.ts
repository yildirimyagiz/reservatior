import { apiClient } from "./client";
import type {
  TelemetryEvent,
  TelemetryFeed,
  GamificationState,
  GrowthEngineSummary,
  ConversionFunnel,
} from "@/types/growth-engine";

export const growthEngineApi = {
  getDashboardSummary: (orgId: string) =>
    apiClient.get<{ data: GrowthEngineSummary }>(`/growth-engine/summary`, { orgId }),

  getTelemetryFeed: (params?: { limit?: number; offset?: number; type?: string }) =>
    apiClient.get<{ data: TelemetryFeed }>("/telemetry/feed", params),

  acknowledgeEvent: (eventId: string) =>
    apiClient.post(`/telemetry/events/${eventId}/acknowledge`),

  getGamificationState: (orgId: string) =>
    apiClient.get<{ data: GamificationState }>(`/gamification/state`, { orgId }),

  getAchievements: (orgId: string) =>
    apiClient.get(`/gamification/achievements`, { orgId }),

  getConversionFunnel: (params?: { startDate?: string; endDate?: string }) =>
    apiClient.get<{ data: ConversionFunnel }>("/growth-engine/funnel", params),

  getWidgets: (orgId: string) =>
    apiClient.get<{ data: any[] }>(`/growth-engine/widgets`, { orgId }),

  updateWidgetConfig: (widgetId: string, config: any) =>
    apiClient.put(`/growth-engine/widgets/${widgetId}`, config),
};
