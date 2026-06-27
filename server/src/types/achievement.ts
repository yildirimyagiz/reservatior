import type { 
  Achievement, 
  AchievementWithRelations, 
  AchievementFilters, 
  PaginatedResponse, 
  ApiResponse 
} from "@reservatiorm/shared-types";

export interface AchievementAnalytics {
  period: string;
  created: number;
  completed: number;
  totalPoints: number;
  uniqueUsers: number;
  avgCompletionRate: number;
}

export interface LeaderboardEntry {
  rank: number;
  user: {
    id: string;
    name: string | null;
    email: string;
  };
  totalPoints: number;
  achievementsCount: number;
}

export interface AchievementStats {
  summary: {
    totalAchievements: number;
    completedAchievements: number;
    inProgressAchievements: number;
    totalPoints: number;
    completionRate: string;
  };
  byType: Array<{
    goalType: string;
    _count: { id: number };
    _sum: { pointsReward: number | null };
  }>;
}

export interface AchievementService {
  getAchievements(filters: AchievementFilters): Promise<PaginatedResponse<AchievementWithRelations>>;
  getAchievementById(id: string): Promise<AchievementWithRelations | null>;
  createAchievement(data: any): Promise<AchievementWithRelations>;
  updateAchievement(id: string, data: any): Promise<AchievementWithRelations>;
  deleteAchievement(id: string): Promise<void>;
  getAchievementAnalytics(query: any): Promise<AchievementAnalytics[]>;
  getLeaderboard(query: any): Promise<LeaderboardEntry[]>;
  getUserAchievements(userId: string, filters: any): Promise<PaginatedResponse<Achievement>>;
  updateAchievementProgress(id: string, currentValue: number, checkCompletion: boolean): Promise<AchievementWithRelations>;
  getAchievementStats(query: any): Promise<AchievementStats>;
  exportAchievements(query: any): Promise<any[]>;
  bulkCreateAchievements(achievements: any[]): Promise<{ count: number }>;
  getAchievementTypes(query: any): Promise<any[]>;
}
