import { z } from "zod";
import { GoalType } from "@reservatiorm/shared-types";

// Pagination schema
export const paginationSchema = z.object({
  page: z.string().regex(/^\d+$/).transform(Number).default("1"),
  limit: z.string().regex(/^\d+$/).transform(Number).default("20"),
  sortBy: z.string().default("createdAt"),
  sortOrder: z.enum(["asc", "desc"]).default("desc")
});

// Achievement filtering schema
export const achievementFilterSchema = z.object({
  userId: z.string().optional(),
  goalType: z.nativeEnum(GoalType).optional(),
  isCompleted: z.enum(["true", "false"]).optional().transform(val => val === "true"),
  organizationId: z.string().optional(),
  startDate: z.string().datetime().optional(),
  endDate: z.string().datetime().optional(),
  minPoints: z.string().regex(/^\d+$/).transform(Number).optional(),
  maxPoints: z.string().regex(/^\d+$/).transform(Number).optional()
});

// Achievement creation schema
export const achievementCreateSchema = z.object({
  userId: z.string().min(1, "User ID is required"),
  goalType: z.nativeEnum(GoalType),
  goalValue: z.number().min(0, "Goal value must be non-negative"),
  currentValue: z.number().min(0).optional(),
  isCompleted: z.boolean().optional(),
  completedAt: z.string().datetime().optional(),
  pointsReward: z.number().min(0).optional(),
  bonusReward: z.string().optional(),
  organizationId: z.string().optional(),
  description: z.string().optional(),
  badgeIcon: z.string().optional()
});

// Achievement update schema
export const achievementUpdateSchema = z.object({
  currentValue: z.number().min(0).optional(),
  isCompleted: z.boolean().optional(),
  completedAt: z.string().datetime().optional(),
  pointsReward: z.number().min(0).optional(),
  bonusReward: z.string().optional(),
  description: z.string().optional(),
  badgeIcon: z.string().optional()
});

// Progress update schema
export const progressUpdateSchema = z.object({
  currentValue: z.number().min(0, "Current value must be non-negative"),
  checkCompletion: z.boolean().default(true)
});

// Analytics query schema
export const analyticsQuerySchema = z.object({
  userId: z.string().optional(),
  organizationId: z.string().optional(),
  period: z.enum(["7d", "30d", "90d"]).default("30d"),
  groupBy: z.enum(["hour", "day"]).default("day")
});

// Leaderboard query schema
export const leaderboardQuerySchema = z.object({
  organizationId: z.string().optional(),
  period: z.enum(["7d", "30d", "90d", "all"]).default("all"),
  limit: z.string().regex(/^\d+$/).transform(Number).default("50"),
  goalType: z.string().optional()
});

// Export query schema
export const exportQuerySchema = z.object({
  userId: z.string().optional(),
  organizationId: z.string().optional(),
  goalType: z.nativeEnum(GoalType).optional(),
  isCompleted: z.enum(["true", "false"]).optional().transform(val => val === "true"),
  format: z.enum(["csv", "json"]).default("csv"),
  startDate: z.string().datetime().optional(),
  endDate: z.string().datetime().optional()
});

// Bulk creation schema
export const bulkCreateSchema = z.object({
  achievements: z.array(achievementCreateSchema).min(1, "At least one achievement is required")
});

// Combined schemas
export const getAchievementsSchema = paginationSchema.merge(achievementFilterSchema);
export const getUserAchievementsSchema = paginationSchema.pick({
  page: true, limit: true, sortBy: true, sortOrder: true
}).merge(z.object({
  goalType: z.nativeEnum(GoalType).optional(),
  isCompleted: z.enum(["true", "false"]).optional().transform(val => val === "true")
}));
