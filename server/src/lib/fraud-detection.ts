/**
 * Fraud Detection System
 * Detects suspicious activities and potential fraud patterns
 * Uses ML-like heuristics and anomaly detection
 */

import { cacheSet, cacheGet } from './cache';

export interface FraudDetectionResult {
  isSuspicious: boolean;
  riskScore: number; // 0-100, higher = more suspicious
  riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  indicators: string[];
  recommendedActions: string[];
}

export interface UserBehaviorProfile {
  userId: string;
  normalIPs: Set<string>;
  normalDevices: Set<string>;
  normalLocations: Set<string>;
  normalTimeRanges: Set<string>;
  averageRequestRate: number;
  lastUpdated: Date;
}

// Fraud indicators
const FRAUD_INDICATORS = {
  RAPID_ACCOUNT_CREATION: 'RAPID_ACCOUNT_CREATION',
  MULTIPLE_FAILED_LOGINS: 'MULTIPLE_FAILED_LOGINS',
  UNUSUAL_LOCATION: 'UNUSUAL_LOCATION',
  UNUSUAL_DEVICE: 'UNUSUAL_DEVICE',
  UNUSUAL_TIME: 'UNUSUAL_TIME',
  HIGH_VELOCITY_REQUESTS: 'HIGH_VELOCITY_REQUESTS',
  MULTIPLE_ACCOUNTS_SAME_IP: 'MULTIPLE_ACCOUNTS_SAME_IP',
  SUSPICIOUS_PATTERN: 'SUSPICIOUS_PATTERN',
  DATA_EXFILTRATION: 'DATA_EXFILTRATION',
  PRIVILEGE_ESCALATION_ATTEMPT: 'PRIVILEGE_ESCALATION_ATTEMPT',
};

/**
 * Detect fraud based on user behavior
 */
export async function detectFraud(
  userId: string,
  action: string,
  context: {
    ip: string;
    userAgent: string;
    location?: string;
    timestamp: Date;
  }
): Promise<FraudDetectionResult> {
  const indicators: string[] = [];
  let riskScore = 0;
  
  // Get user behavior profile
  const profile = await getUserBehaviorProfile(userId);
  
  // Check for unusual IP
  if (profile.normalIPs.size > 0 && !profile.normalIPs.has(context.ip)) {
    indicators.push(FRAUD_INDICATORS.UNUSUAL_LOCATION);
    riskScore += 30;
  }
  
  // Check for unusual device (user-agent)
  const deviceHash = hashDevice(context.userAgent);
  if (profile.normalDevices.size > 0 && !profile.normalDevices.has(deviceHash)) {
    indicators.push(FRAUD_INDICATORS.UNUSUAL_DEVICE);
    riskScore += 20;
  }
  
  // Check for unusual time
  const timeRange = getTimeRange(context.timestamp);
  if (profile.normalTimeRanges.size > 0 && !profile.normalTimeRanges.has(timeRange)) {
    indicators.push(FRAUD_INDICATORS.UNUSUAL_TIME);
    riskScore += 15;
  }
  
  // Check for high velocity requests
  const requestRate = await getRequestRate(userId);
  if (requestRate > profile.averageRequestRate * 5) {
    indicators.push(FRAUD_INDICATORS.HIGH_VELOCITY_REQUESTS);
    riskScore += 40;
  }
  
  // Check for multiple failed logins
  const failedLogins = await getFailedLoginCount(context.ip);
  if (failedLogins > 5) {
    indicators.push(FRAUD_INDICATORS.MULTIPLE_FAILED_LOGINS);
    riskScore += 35;
  }
  
  // Check for multiple accounts from same IP
  const accountCount = await getAccountCountFromIP(context.ip);
  if (accountCount > 3) {
    indicators.push(FRAUD_INDICATORS.MULTIPLE_ACCOUNTS_SAME_IP);
    riskScore += 25;
  }
  
  // Determine risk level
  let riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  if (riskScore >= 80) {
    riskLevel = 'CRITICAL';
  } else if (riskScore >= 60) {
    riskLevel = 'HIGH';
  } else if (riskScore >= 40) {
    riskLevel = 'MEDIUM';
  } else {
    riskLevel = 'LOW';
  }
  
  // Generate recommended actions
  const recommendedActions = generateRecommendedActions(riskLevel, indicators);
  
  // Update user profile if not suspicious
  if (riskLevel === 'LOW') {
    await updateUserBehaviorProfile(userId, context);
  }
  
  return {
    isSuspicious: riskScore >= 40,
    riskScore,
    riskLevel,
    indicators,
    recommendedActions,
  };
}

/**
 * Get user behavior profile
 */
async function getUserBehaviorProfile(userId: string): Promise<UserBehaviorProfile> {
  const cacheKey = `fraud:profile:${userId}`;
  const cached = await cacheGet<UserBehaviorProfile>(cacheKey);
  
  if (cached) {
    return cached;
  }
  
  // Default profile
  return {
    userId,
    normalIPs: new Set(),
    normalDevices: new Set(),
    normalLocations: new Set(),
    normalTimeRanges: new Set(),
    averageRequestRate: 10,
    lastUpdated: new Date(),
  };
}

/**
 * Update user behavior profile
 */
async function updateUserBehaviorProfile(
  userId: string,
  context: {
    ip: string;
    userAgent: string;
    location?: string;
    timestamp: Date;
  }
): Promise<void> {
  const profile = await getUserBehaviorProfile(userId);
  
  profile.normalIPs.add(context.ip);
  profile.normalDevices.add(hashDevice(context.userAgent));
  if (context.location) {
    profile.normalLocations.add(context.location);
  }
  profile.normalTimeRanges.add(getTimeRange(context.timestamp));
  profile.lastUpdated = new Date();
  
  const cacheKey = `fraud:profile:${userId}`;
  await cacheSet(cacheKey, profile, 604800); // Cache for 7 days
}

/**
 * Hash device/user-agent for comparison
 */
function hashDevice(userAgent: string): string {
  // Simple hash - in production use proper hash function
  return userAgent
    .replace(/\d+/g, '') // Remove version numbers
    .replace(/\s+/g, '')
    .toLowerCase()
    .substring(0, 50);
}

/**
 * Get time range from timestamp
 */
function getTimeRange(timestamp: Date): string {
  const hour = timestamp.getHours();
  
  if (hour >= 6 && hour < 12) return 'MORNING';
  if (hour >= 12 && hour < 18) return 'AFTERNOON';
  if (hour >= 18 && hour < 24) return 'EVENING';
  return 'NIGHT';
}

/**
 * Get request rate for user
 */
async function getRequestRate(userId: string): Promise<number> {
  const cacheKey = `fraud:requests:${userId}`;
  const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);
  
  const now = Math.floor(Date.now() / 1000);
  const windowStart = now - 60; // 1 minute window
  
  if (cached && cached.windowStart > windowStart) {
    return cached.count;
  }
  
  return 0;
}

/**
 * Increment request rate
 */
export async function incrementRequestRate(userId: string): Promise<void> {
  const cacheKey = `fraud:requests:${userId}`;
  const now = Math.floor(Date.now() / 1000);
  const windowStart = now - 60;
  
  const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);
  
  if (cached && cached.windowStart > windowStart) {
    await cacheSet(cacheKey, { count: cached.count + 1, windowStart: cached.windowStart }, 60);
  } else {
    await cacheSet(cacheKey, { count: 1, windowStart: now }, 60);
  }
}

/**
 * Get failed login count for IP
 */
async function getFailedLoginCount(ip: string): Promise<number> {
  const cacheKey = `fraud:failed_logins:${ip}`;
  const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);
  
  const now = Math.floor(Date.now() / 1000);
  const windowStart = now - 300; // 5 minute window
  
  if (cached && cached.windowStart > windowStart) {
    return cached.count;
  }
  
  return 0;
}

/**
 * Increment failed login count
 */
export async function incrementFailedLogin(ip: string): Promise<void> {
  const cacheKey = `fraud:failed_logins:${ip}`;
  const now = Math.floor(Date.now() / 1000);
  const windowStart = now - 300;
  
  const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);
  
  if (cached && cached.windowStart > windowStart) {
    await cacheSet(cacheKey, { count: cached.count + 1, windowStart: cached.windowStart }, 300);
  } else {
    await cacheSet(cacheKey, { count: 1, windowStart: now }, 300);
  }
}

/**
 * Get account count from IP
 */
async function getAccountCountFromIP(ip: string): Promise<number> {
  const cacheKey = `fraud:accounts:${ip}`;
  const cached = await cacheGet<number>(cacheKey);
  
  return cached || 0;
}

/**
 * Increment account count from IP
 */
export async function incrementAccountCountFromIP(ip: string): Promise<void> {
  const cacheKey = `fraud:accounts:${ip}`;
  const cached = await cacheGet<number>(cacheKey);
  
  await cacheSet(cacheKey, (cached || 0) + 1, 86400); // Cache for 24 hours
}

/**
 * Generate recommended actions based on risk level
 */
function generateRecommendedActions(
  riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL',
  indicators: string[]
): string[] {
  const actions: string[] = [];
  
  if (riskLevel === 'CRITICAL') {
    actions.push('BLOCK_USER');
    actions.push('REQUIRE_ADDITIONAL_VERIFICATION');
    actions.push('NOTIFY_SECURITY_TEAM');
    actions.push('LOG_SECURITY_EVENT');
  } else if (riskLevel === 'HIGH') {
    actions.push('REQUIRE_MFA');
    actions.push('LIMIT_ACCESS');
    actions.push('NOTIFY_USER');
    actions.push('LOG_SECURITY_EVENT');
  } else if (riskLevel === 'MEDIUM') {
    actions.push('CHALLENGE_USER');
    actions.push('MONITOR_ACTIVITY');
    actions.push('LOG_SECURITY_EVENT');
  }
  
  // Specific actions based on indicators
  if (indicators.includes(FRAUD_INDICATORS.MULTIPLE_FAILED_LOGINS)) {
    actions.push('TEMPORARILY_BLOCK_IP');
  }
  
  if (indicators.includes(FRAUD_INDICATORS.HIGH_VELOCITY_REQUESTS)) {
    actions.push('RATE_LIMIT_USER');
  }
  
  if (indicators.includes(FRAUD_INDICATORS.UNUSUAL_LOCATION)) {
    actions.push('LOCATION_VERIFICATION');
  }
  
  return actions;
}

/**
 * Check for data exfiltration pattern
 */
export async function checkDataExfiltration(
  userId: string,
  dataSize: number,
  requestCount: number
): Promise<FraudDetectionResult> {
  const indicators: string[] = [];
  let riskScore = 0;
  
  // Check if downloading large amounts of data
  if (dataSize > 100 * 1024 * 1024) { // 100MB
    indicators.push(FRAUD_INDICATORS.DATA_EXFILTRATION);
    riskScore += 50;
  }
  
  // Check for high request rate
  if (requestCount > 1000) {
    indicators.push(FRAUD_INDICATORS.HIGH_VELOCITY_REQUESTS);
    riskScore += 40;
  }
  
  let riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  if (riskScore >= 80) {
    riskLevel = 'CRITICAL';
  } else if (riskScore >= 60) {
    riskLevel = 'HIGH';
  } else if (riskScore >= 40) {
    riskLevel = 'MEDIUM';
  } else {
    riskLevel = 'LOW';
  }
  
  return {
    isSuspicious: riskScore >= 40,
    riskScore,
    riskLevel,
    indicators,
    recommendedActions: generateRecommendedActions(riskLevel, indicators),
  };
}

/**
 * Check for privilege escalation attempt
 */
export async function checkPrivilegeEscalation(
  userId: string,
  requestedRole: string,
  currentRole: string
): Promise<FraudDetectionResult> {
  const indicators: string[] = [];
  let riskScore = 0;
  
  // Check if trying to escalate to admin role
  if (requestedRole.includes('ADMIN') && !currentRole.includes('ADMIN')) {
    indicators.push(FRAUD_INDICATORS.PRIVILEGE_ESCALATION_ATTEMPT);
    riskScore += 70;
  }
  
  // Check if trying to escalate to higher role
  const roleHierarchy = ['USER', 'AGENT', 'AGENCY_MGR', 'AGENCY_ADMIN', 'SUPER_ADMIN'];
  const currentIndex = roleHierarchy.indexOf(currentRole);
  const requestedIndex = roleHierarchy.indexOf(requestedRole);
  
  if (requestedIndex > currentIndex) {
    indicators.push(FRAUD_INDICATORS.PRIVILEGE_ESCALATION_ATTEMPT);
    riskScore += 50;
  }
  
  let riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  if (riskScore >= 80) {
    riskLevel = 'CRITICAL';
  } else if (riskScore >= 60) {
    riskLevel = 'HIGH';
  } else if (riskScore >= 40) {
    riskLevel = 'MEDIUM';
  } else {
    riskLevel = 'LOW';
  }
  
  return {
    isSuspicious: riskScore >= 40,
    riskScore,
    riskLevel,
    indicators,
    recommendedActions: generateRecommendedActions(riskLevel, indicators),
  };
}

/**
 * Get fraud statistics for user
 */
export async function getUserFraudStats(userId: string): Promise<{
  totalChecks: number;
  suspiciousCount: number;
  averageRiskScore: number;
  lastCheck: Date;
}> {
  const cacheKey = `fraud:stats:${userId}`;
  const cached = await cacheGet<{
    totalChecks: number;
    suspiciousCount: number;
    totalRiskScore: number;
    lastCheck: number;
  }>(cacheKey);
  
  if (cached) {
    return {
      totalChecks: cached.totalChecks,
      suspiciousCount: cached.suspiciousCount,
      averageRiskScore: cached.totalRiskScore / cached.totalChecks,
      lastCheck: new Date(cached.lastCheck),
    };
  }
  
  return {
    totalChecks: 0,
    suspiciousCount: 0,
    averageRiskScore: 0,
    lastCheck: new Date(),
  };
}

/**
 * Update fraud statistics
 */
export async function updateFraudStats(
  userId: string,
  riskScore: number,
  isSuspicious: boolean
): Promise<void> {
  const cacheKey = `fraud:stats:${userId}`;
  const cached = await cacheGet<{
    totalChecks: number;
    suspiciousCount: number;
    totalRiskScore: number;
    lastCheck: number;
  }>(cacheKey);
  
  await cacheSet(cacheKey, {
    totalChecks: (cached?.totalChecks || 0) + 1,
    suspiciousCount: (cached?.suspiciousCount || 0) + (isSuspicious ? 1 : 0),
    totalRiskScore: (cached?.totalRiskScore || 0) + riskScore,
    lastCheck: Date.now(),
  }, 604800);
}
