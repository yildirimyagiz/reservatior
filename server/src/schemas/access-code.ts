import * as v from 'valibot';

// Pagination schema
export const paginationSchema = v.object({
  page: v.pipe(v.string(), v.transform(Number), v.minValue(1)),
  limit: v.pipe(v.string(), v.transform(Number), v.minValue(1), v.maxValue(100)),
  sortBy: v.optional(v.string()),
  sortOrder: v.optional(v.union([v.literal('asc'), v.literal('desc')]))
});

// Access code filtering schema
export const accessCodeFilterSchema = v.object({
  smartLockId: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  propertyId: v.optional(v.string()),
  userId: v.optional(v.string()),
  expiresAfter: v.optional(v.string()),
  expiresBefore: v.optional(v.string())
});

// Access code creation schema
export const accessCodeCreateSchema = v.object({
  smartLockId: v.pipe(v.string(), v.minLength(1, "Smart Lock ID is required")),
  code: v.pipe(v.string(), v.minLength(1, "Access code is required")),
  name: v.pipe(v.string(), v.minLength(1, "Name is required")),
  isActive: v.boolean(),
  expiresAt: v.optional(v.string()),
  maxUses: v.optional(v.pipe(v.number(), v.minValue(0))),
  currentUses: v.optional(v.pipe(v.number(), v.minValue(0)))
});

// Access code update schema
export const accessCodeUpdateSchema = v.partial(
  v.object({
    code: v.string(),
    name: v.string(),
    isActive: v.boolean(),
    expiresAt: v.string(),
    maxUses: v.pipe(v.number(), v.minValue(0)),
    currentUses: v.pipe(v.number(), v.minValue(0))
  })
);

// Analytics query schema
export const analyticsQuerySchema = v.object({
  propertyId: v.optional(v.string()),
  period: v.optional(v.union([v.literal('1d'), v.literal('7d'), v.literal('30d'), v.literal('90d')])),
  groupBy: v.optional(v.union([v.literal('hour'), v.literal('day')]))
});

// Export query schema
export const exportQuerySchema = v.object({
  smartLockId: v.optional(v.string()),
  isActive: v.optional(v.boolean()),
  format: v.optional(v.union([v.literal('csv'), v.literal('json')]))
});

// Bulk creation schema
export const bulkCreateSchema = v.object({
  smartLockId: v.pipe(v.string(), v.minLength(1, "Smart Lock ID is required")),
  codes: v.pipe(
    v.array(v.string()),
    v.minLength(1, "At least one code is required"),
    v.maxLength(100, "Maximum 100 codes allowed")
  ),
  namePrefix: v.pipe(v.string(), v.minLength(1, "Name prefix is required")),
  expiresAt: v.optional(v.string())
});

// Combined schemas
export const getAccessCodesSchema = v.object({
  ...paginationSchema.entries,
  ...accessCodeFilterSchema.entries
});

// Type inference helpers
export type AccessCodeCreateInput = v.InferOutput<typeof accessCodeCreateSchema>;
export type AccessCodeUpdateInput = v.InferOutput<typeof accessCodeUpdateSchema>;
export type AccessCodeFilters = v.InferOutput<typeof getAccessCodesSchema>;
export type AnalyticsQuery = v.InferOutput<typeof analyticsQuerySchema>;
export type BulkCreateInput = v.InferOutput<typeof bulkCreateSchema>;
