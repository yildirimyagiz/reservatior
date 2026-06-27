import * as v from 'valibot';

// Pagination schema
export const paginationSchema = v.object({
  page: v.pipe(v.string(), v.transform(Number), v.minValue(1)),
  limit: v.pipe(v.string(), v.transform(Number), v.minValue(1), v.maxValue(100)),
  sortBy: v.optional(v.string()),
  sortOrder: v.optional(v.union([v.literal('asc'), v.literal('desc')]))
});

// Achievement filtering schema
export const achievementFilterSchema = v.object({
  userId: v.optional(v.string()),
  goalType: v.optional(v.union([
    v.literal('LISTINGS_CREATED'),
    v.literal('DEALS_CLOSED'),
    v.literal('REFERRALS_MADE'),
    v.literal('REVIEWS_RECEIVED'),
    v.literal('COMMISSION_EARNED')
  ])),
  isCompleted: v.optional(v.boolean()),
  organizationId: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  minPoints: v.optional(v.pipe(v.string(), v.transform(Number), v.minValue(0))),
  maxPoints: v.optional(v.pipe(v.string(), v.transform(Number), v.minValue(0)))
});

// Achievement creation schema
export const achievementCreateSchema = v.object({
  userId: v.pipe(v.string(), v.minLength(1, "User ID is required")),
  goalType: v.union([
    v.literal('LISTINGS_CREATED'),
    v.literal('DEALS_CLOSED'),
    v.literal('REFERRALS_MADE'),
    v.literal('REVIEWS_RECEIVED'),
    v.literal('COMMISSION_EARNED')
  ]),
  goalValue: v.pipe(v.number(), v.minValue(0, "Goal value must be non-negative")),
  currentValue: v.optional(v.pipe(v.number(), v.minValue(0))),
  isCompleted: v.optional(v.boolean()),
  completedAt: v.optional(v.string()),
  pointsReward: v.optional(v.pipe(v.number(), v.minValue(0))),
  bonusReward: v.optional(v.string()),
  organizationId: v.optional(v.string()),
  description: v.optional(v.string()),
  badgeIcon: v.optional(v.string())
});

// Achievement update schema
export const achievementUpdateSchema = v.partial(
  v.object({
    currentValue: v.pipe(v.number(), v.minValue(0)),
    isCompleted: v.boolean(),
    completedAt: v.string(),
    pointsReward: v.pipe(v.number(), v.minValue(0)),
    bonusReward: v.string(),
    description: v.string(),
    badgeIcon: v.string(),
  })
);

// Progress update schema
export const progressUpdateSchema = v.object({
  currentValue: v.pipe(v.number(), v.minValue(0, "Current value must be non-negative")),
  checkCompletion: v.optional(v.boolean()),
});

// Analytics query schema
export const analyticsQuerySchema = v.object({
  userId: v.optional(v.string()),
  organizationId: v.optional(v.string()),
  period: v.optional(v.union([v.literal('7d'), v.literal('30d'), v.literal('90d')])),
  groupBy: v.optional(v.union([v.literal('hour'), v.literal('day')]))
});

// Leaderboard query schema
export const leaderboardQuerySchema = v.object({
  organizationId: v.optional(v.string()),
  period: v.optional(v.union([v.literal('7d'), v.literal('30d'), v.literal('90d'), v.literal('all')])),
  limit: v.optional(v.pipe(v.string(), v.transform(Number), v.minValue(1), v.maxValue(100))),
  goalType: v.optional(v.string())
});

// Export query schema
export const exportQuerySchema = v.object({
  userId: v.optional(v.string()),
  organizationId: v.optional(v.string()),
  goalType: v.optional(v.string()),
  isCompleted: v.optional(v.boolean()),
  format: v.optional(v.union([v.literal('csv'), v.literal('json')])),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string())
});

// Bulk creation schema
export const bulkCreateSchema = v.object({
  achievements: v.pipe(
    v.array(achievementCreateSchema),
    v.minLength(1, "At least one achievement is required")
  )
});

// Combined schemas
export const getAchievementsSchema = v.object({
  ...paginationSchema.entries,
  ...achievementFilterSchema.entries
});

export const getUserAchievementsSchema = v.object({
  ...v.pick(paginationSchema, ['page', 'limit', 'sortBy', 'sortOrder']).entries,
  goalType: v.optional(v.string()),
  isCompleted: v.optional(v.boolean())
});

// Type inference helpers
export type AchievementCreateInput = v.InferOutput<typeof achievementCreateSchema>;
export type AchievementUpdateInput = v.InferOutput<typeof achievementUpdateSchema>;
export type AchievementFilters = v.InferOutput<typeof getAchievementsSchema>;
export type ProgressUpdateInput = v.InferOutput<typeof progressUpdateSchema>;
