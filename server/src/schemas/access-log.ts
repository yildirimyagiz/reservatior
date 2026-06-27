import * as v from 'valibot';

// Pagination schema
export const paginationSchema = v.object({
  page: v.pipe(v.string(), v.transform(Number), v.minValue(1)),
  limit: v.pipe(v.string(), v.transform(Number), v.minValue(1), v.maxValue(100)),
  sortBy: v.optional(v.string()),
  sortOrder: v.optional(v.union([v.literal('asc'), v.literal('desc')]))
});

// Access log filtering schema
export const accessLogFilterSchema = v.object({
  orgId: v.optional(v.string()),
  smartLockId: v.optional(v.string()),
  accessCodeId: v.optional(v.string()),
  method: v.optional(v.union([
    v.literal('PIN_CODE'),
    v.literal('FINGERPRINT'),
    v.literal('FACE_ID'),
    v.literal('KEY_CARD'),
    v.literal('MOBILE_APP'),
    v.literal('MANUAL'),
    v.literal('EMERGENCY')
  ])),
  event: v.optional(v.union([
    v.literal('UNLOCK'),
    v.literal('LOCK'),
    v.literal('ACCESS_DENIED'),
    v.literal('LOW_BATTERY'),
    v.literal('DOOR_FORCED'),
    v.literal('MAINTENANCE')
  ])),
  success: v.optional(v.boolean()),
  actorName: v.optional(v.string()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string())
});

// Access log creation schema
export const accessLogCreateSchema = v.object({
  orgId: v.pipe(v.string(), v.minLength(1, "Organization ID is required")),
  smartLockId: v.pipe(v.string(), v.minLength(1, "Smart Lock ID is required")),
  accessCodeId: v.optional(v.string()),
  method: v.union([
    v.literal('PIN_CODE'),
    v.literal('FINGERPRINT'),
    v.literal('FACE_ID'),
    v.literal('KEY_CARD'),
    v.literal('MOBILE_APP'),
    v.literal('MANUAL'),
    v.literal('EMERGENCY')
  ]),
  event: v.union([
    v.literal('UNLOCK'),
    v.literal('LOCK'),
    v.literal('ACCESS_DENIED'),
    v.literal('LOW_BATTERY'),
    v.literal('DOOR_FORCED'),
    v.literal('MAINTENANCE')
  ]),
  actorName: v.optional(v.string()),
  success: v.boolean(),
  failureReason: v.optional(v.string()),
  timestamp: v.optional(v.string())
});

// Analytics query schema
export const analyticsQuerySchema = v.object({
  orgId: v.optional(v.string()),
  smartLockId: v.optional(v.string()),
  period: v.optional(v.union([v.literal('1h'), v.literal('24h'), v.literal('7d'), v.literal('30d')])),
  groupBy: v.optional(v.union([v.literal('hour'), v.literal('day'), v.literal('week')])),
  eventType: v.optional(v.union([
    v.literal('UNLOCK'),
    v.literal('LOCK'),
    v.literal('ACCESS_DENIED')
  ]))
});

// Export query schema
export const exportQuerySchema = v.object({
  orgId: v.optional(v.string()),
  smartLockId: v.optional(v.string()),
  method: v.optional(v.string()),
  event: v.optional(v.string()),
  success: v.optional(v.boolean()),
  startDate: v.optional(v.string()),
  endDate: v.optional(v.string()),
  format: v.optional(v.union([v.literal('csv'), v.literal('json')]))
});

// Security analysis schema
export const securityAnalysisSchema = v.object({
  orgId: v.pipe(v.string(), v.minLength(1, "Organization ID is required")),
  smartLockId: v.optional(v.string()),
  period: v.optional(v.union([v.literal('24h'), v.literal('7d'), v.literal('30d')])),
  includeFailedAttempts: v.optional(v.boolean())
});

// Combined schemas
export const getAccessLogsSchema = v.object({
  ...paginationSchema.entries,
  ...accessLogFilterSchema.entries
});

// Type inference helpers
export type AccessLogCreateInput = v.InferOutput<typeof accessLogCreateSchema>;
export type AccessLogFilters = v.InferOutput<typeof getAccessLogsSchema>;
export type AnalyticsQuery = v.InferOutput<typeof analyticsQuerySchema>;
export type SecurityAnalysisQuery = v.InferOutput<typeof securityAnalysisSchema>;
