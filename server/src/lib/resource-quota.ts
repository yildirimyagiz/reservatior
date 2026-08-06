/**
 * Resource Quota System
 * Per-tenant resource limits and usage tracking
 * Prevents resource abuse and ensures fair allocation
 */

import { cacheSet, cacheGet } from './cache';

export interface QuotaConfig {
  maxProperties: number;
  maxUsers: number;
  maxStorageGB: number;
  maxAPICallsPerDay: number;
  maxAIRequestsPerDay: number;
  maxEmailsPerDay: number;
  maxSMSPerDay: number;
}

export interface QuotaUsage {
  properties: number;
  users: number;
  storageGB: number;
  apiCalls: number;
  aiRequests: number;
  emails: number;
  sms: number;
}

export interface QuotaStatus {
  config: QuotaConfig;
  usage: QuotaUsage;
  remaining: QuotaUsage;
  exceeded: string[];
}

// Default quota configs per tier
const QUOTA_CONFIGS: Record<string, QuotaConfig> = {
  FREE: {
    maxProperties: 5,
    maxUsers: 2,
    maxStorageGB: 1,
    maxAPICallsPerDay: 1000,
    maxAIRequestsPerDay: 10,
    maxEmailsPerDay: 50,
    maxSMSPerDay: 20,
  },
  BASIC: {
    maxProperties: 25,
    maxUsers: 10,
    maxStorageGB: 10,
    maxAPICallsPerDay: 10000,
    maxAIRequestsPerDay: 100,
    maxEmailsPerDay: 500,
    maxSMSPerDay: 200,
  },
  PRO: {
    maxProperties: 100,
    maxUsers: 50,
    maxStorageGB: 50,
    maxAPICallsPerDay: 100000,
    maxAIRequestsPerDay: 1000,
    maxEmailsPerDay: 5000,
    maxSMSPerDay: 2000,
  },
  ENTERPRISE: {
    maxProperties: -1, // Unlimited
    maxUsers: -1,
    maxStorageGB: -1,
    maxAPICallsPerDay: -1,
    maxAIRequestsPerDay: -1,
    maxEmailsPerDay: -1,
    maxSMSPerDay: -1,
  },
};

/**
 * Get quota config for tier
 */
export function getQuotaConfig(tier: string): QuotaConfig {
  return QUOTA_CONFIGS[tier] || QUOTA_CONFIGS.FREE;
}

/**
 * Get current quota usage for organization
 */
export async function getQuotaUsage(orgId: string): Promise<QuotaUsage> {
  const cacheKey = `quota:usage:${orgId}`;
  const cached = await cacheGet<QuotaUsage>(cacheKey);
  
  if (cached) {
    return cached;
  }
  
  // Default usage (in production, query database)
  const usage: QuotaUsage = {
    properties: 0,
    users: 0,
    storageGB: 0,
    apiCalls: 0,
    aiRequests: 0,
    emails: 0,
    sms: 0,
  };
  
  await cacheSet(cacheKey, usage, 300); // Cache for 5 minutes
  
  return usage;
}

/**
 * Update quota usage
 */
export async function updateQuotaUsage(
  orgId: string,
  resource: keyof QuotaUsage,
  delta: number
): Promise<void> {
  const cacheKey = `quota:usage:${orgId}`;
  const usage = await getQuotaUsage(orgId);
  
  usage[resource] += delta;
  
  await cacheSet(cacheKey, usage, 300);
  
  console.log(`[Quota] Updated ${resource} for org ${orgId}: +${delta}`);
}

/**
 * Check quota status
 */
export async function getQuotaStatus(orgId: string, tier: string): Promise<QuotaStatus> {
  const config = getQuotaConfig(tier);
  const usage = await getQuotaUsage(orgId);
  
  const remaining: QuotaUsage = {
    properties: config.maxProperties === -1 ? -1 : Math.max(0, config.maxProperties - usage.properties),
    users: config.maxUsers === -1 ? -1 : Math.max(0, config.maxUsers - usage.users),
    storageGB: config.maxStorageGB === -1 ? -1 : Math.max(0, config.maxStorageGB - usage.storageGB),
    apiCalls: config.maxAPICallsPerDay === -1 ? -1 : Math.max(0, config.maxAPICallsPerDay - usage.apiCalls),
    aiRequests: config.maxAIRequestsPerDay === -1 ? -1 : Math.max(0, config.maxAIRequestsPerDay - usage.aiRequests),
    emails: config.maxEmailsPerDay === -1 ? -1 : Math.max(0, config.maxEmailsPerDay - usage.emails),
    sms: config.maxSMSPerDay === -1 ? -1 : Math.max(0, config.maxSMSPerDay - usage.sms),
  };
  
  const exceeded: string[] = [];
  
  if (config.maxProperties !== -1 && usage.properties >= config.maxProperties) {
    exceeded.push('properties');
  }
  if (config.maxUsers !== -1 && usage.users >= config.maxUsers) {
    exceeded.push('users');
  }
  if (config.maxStorageGB !== -1 && usage.storageGB >= config.maxStorageGB) {
    exceeded.push('storage');
  }
  if (config.maxAPICallsPerDay !== -1 && usage.apiCalls >= config.maxAPICallsPerDay) {
    exceeded.push('apiCalls');
  }
  if (config.maxAIRequestsPerDay !== -1 && usage.aiRequests >= config.maxAIRequestsPerDay) {
    exceeded.push('aiRequests');
  }
  if (config.maxEmailsPerDay !== -1 && usage.emails >= config.maxEmailsPerDay) {
    exceeded.push('emails');
  }
  if (config.maxSMSPerDay !== -1 && usage.sms >= config.maxSMSPerDay) {
    exceeded.push('sms');
  }
  
  return {
    config,
    usage,
    remaining,
    exceeded,
  };
}

/**
 * Check if resource quota is available
 */
export async function checkQuotaAvailable(
  orgId: string,
  tier: string,
  resource: keyof QuotaUsage,
  amount: number = 1
): Promise<boolean> {
  const status = await getQuotaStatus(orgId, tier);
  const config = status.config;
  const usage = status.usage;
  
  const limit = config[resource] as number;
  
  // Unlimited
  if (limit === -1) {
    return true;
  }
  
  return usage[resource] + amount <= limit;
}

/**
 * Consume quota
 */
export async function consumeQuota(
  orgId: string,
  tier: string,
  resource: keyof QuotaUsage,
  amount: number = 1
): Promise<boolean> {
  const available = await checkQuotaAvailable(orgId, tier, resource, amount);
  
  if (!available) {
    console.log(`[Quota] Exceeded for org ${orgId}: ${resource}`);
    return false;
  }
  
  await updateQuotaUsage(orgId, resource, amount);
  return true;
}

/**
 * Reset daily quotas (run via cron)
 */
export async function resetDailyQuotas(orgId: string): Promise<void> {
  const cacheKey = `quota:usage:${orgId}`;
  const usage = await getQuotaUsage(orgId);
  
  usage.apiCalls = 0;
  usage.aiRequests = 0;
  usage.emails = 0;
  usage.sms = 0;
  
  await cacheSet(cacheKey, usage, 300);
  
  console.log(`[Quota] Reset daily quotas for org ${orgId}`);
}

/**
 * Get quota percentage used
 */
export async function getQuotaPercentage(orgId: string, tier: string): Promise<{
  properties: number;
  users: number;
  storage: number;
  apiCalls: number;
  aiRequests: number;
  emails: number;
  sms: number;
}> {
  const status = await getQuotaStatus(orgId, tier);
  const config = status.config;
  const usage = status.usage;
  
  return {
    properties: config.maxProperties === -1 ? 0 : (usage.properties / config.maxProperties) * 100,
    users: config.maxUsers === -1 ? 0 : (usage.users / config.maxUsers) * 100,
    storage: config.maxStorageGB === -1 ? 0 : (usage.storageGB / config.maxStorageGB) * 100,
    apiCalls: config.maxAPICallsPerDay === -1 ? 0 : (usage.apiCalls / config.maxAPICallsPerDay) * 100,
    aiRequests: config.maxAIRequestsPerDay === -1 ? 0 : (usage.aiRequests / config.maxAIRequestsPerDay) * 100,
    emails: config.maxEmailsPerDay === -1 ? 0 : (usage.emails / config.maxEmailsPerDay) * 100,
    sms: config.maxSMSPerDay === -1 ? 0 : (usage.sms / config.maxSMSPerDay) * 100,
  };
}

/**
 * Elysia middleware for quota checking
 */
export const quotaCheckMiddleware = async ({ 
  orgId, 
  path, 
  set 
}: any) => {
  // Get tier from organization (simplified - in production query DB)
  const tier = 'FREE';
  
  // Determine resource type from path
  let resource: keyof QuotaUsage;
  
  if (path.startsWith('/api/ai')) {
    resource = 'aiRequests';
  } else if (path.startsWith('/property')) {
    resource = 'properties';
  } else {
    resource = 'apiCalls';
  }
  
  // Check quota
  const available = await checkQuotaAvailable(orgId, tier, resource);
  
  if (!available) {
    set.status = 429;
    set.headers['X-Quota-Exceeded'] = resource;
    throw new Error(`Quota exceeded for ${resource}. Please upgrade your plan.`);
  }
  
  // Consume quota
  await consumeQuota(orgId, tier, resource);
  
  // Set quota headers
  const status = await getQuotaStatus(orgId, tier);
  set.headers = {
    ...set.headers,
    'X-Quota-Limit': status.config[resource].toString(),
    'X-Quota-Remaining': status.remaining[resource].toString(),
    'X-Quota-Used': status.usage[resource].toString(),
  };
  
  console.log(`[Quota] Consumed ${resource} for org ${orgId}`);
};
