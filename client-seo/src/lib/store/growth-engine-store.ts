import { create } from 'zustand';
import { devtools } from 'zustand/middleware';
import type {
  TelemetryEvent,
  TelemetryFeed,
  GamificationState,
  GrowthEngineSummary,
  ConversionFunnel,
} from '@/types/growth-engine';

interface GrowthEngineState {
  summary: GrowthEngineSummary | null;
  telemetryFeed: TelemetryFeed;
  gamification: GamificationState | null;
  conversionFunnel: ConversionFunnel | null;
  liveEvents: TelemetryEvent[];
  loading: boolean;
  error: string | null;

  setSummary: (summary: GrowthEngineSummary) => void;
  setTelemetryFeed: (feed: TelemetryFeed) => void;
  addTelemetryEvent: (event: TelemetryEvent) => void;
  acknowledgeEvent: (eventId: string) => void;
  setGamification: (gamification: GamificationState) => void;
  unlockAchievement: (achievementId: string) => void;
  setConversionFunnel: (funnel: ConversionFunnel) => void;
  appendLiveEvent: (event: TelemetryEvent) => void;
  trimLiveEvents: (maxSize?: number) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
  clearError: () => void;
  reset: () => void;
}

export const useGrowthEngineStore = create<GrowthEngineState>()(
  devtools(
    (set) => ({
      summary: null,
      telemetryFeed: { events: [], totalEvents: 0, unreadCount: 0, lastUpdated: '' },
      gamification: null,
      conversionFunnel: null,
      liveEvents: [],
      loading: false,
      error: null,

      setSummary: (summary) => set({ summary }),
      setTelemetryFeed: (telemetryFeed) => set({ telemetryFeed }),
      addTelemetryEvent: (event) =>
        set((state) => ({
          telemetryFeed: {
            ...state.telemetryFeed,
            events: [event, ...state.telemetryFeed.events].slice(0, 200),
            totalEvents: state.telemetryFeed.totalEvents + 1,
            unreadCount: state.telemetryFeed.unreadCount + 1,
            lastUpdated: event.timestamp,
          },
        })),
      acknowledgeEvent: (eventId) =>
        set((state) => ({
          telemetryFeed: {
            ...state.telemetryFeed,
            events: state.telemetryFeed.events.map((e) =>
              e.id === eventId ? { ...e, acknowledged: true } : e
            ),
            unreadCount: Math.max(0, state.telemetryFeed.unreadCount - 1),
          },
        })),
      setGamification: (gamification) => set({ gamification }),
      unlockAchievement: (achievementId) =>
        set((state) => {
          if (!state.gamification) return {};
          const achievements = state.gamification.achievements.map((a) =>
            a.id === achievementId
              ? { ...a, unlocked: true, unlockedAt: new Date().toISOString(), progress: a.target }
              : a
          );
          const unlockedCount = achievements.filter((a) => a.unlocked).length;
          return {
            gamification: {
              ...state.gamification,
              achievements,
              unlockedCount,
              totalPoints:
                state.gamification.totalPoints +
                (achievements.find((a) => a.id === achievementId)?.points || 0),
            },
          };
        }),
      setConversionFunnel: (conversionFunnel) => set({ conversionFunnel }),
      appendLiveEvent: (event) =>
        set((state) => ({
          liveEvents: [event, ...state.liveEvents].slice(0, 50),
        })),
      trimLiveEvents: (maxSize = 50) =>
        set((state) => ({
          liveEvents: state.liveEvents.slice(0, maxSize),
        })),
      setLoading: (loading) => set({ loading }),
      setError: (error) => set({ error }),
      clearError: () => set({ error: null }),
      reset: () =>
        set({
          summary: null,
          telemetryFeed: { events: [], totalEvents: 0, unreadCount: 0, lastUpdated: '' },
          gamification: null,
          conversionFunnel: null,
          liveEvents: [],
          loading: false,
          error: null,
        }),
    }),
    { name: 'growth-engine-store' }
  )
);
