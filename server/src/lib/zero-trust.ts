/**
 * Zero Trust Architecture
 * Never Trust, Always Verify - Comprehensive verification for every request
 * Verifies User, Device, Location, Behavior, and Resource for each access attempt
 */

import { cacheSet, cacheGet } from './cache';

export interface ZeroTrustContext {
  userId: string;
  deviceId: string;
  ipAddress: string;
  location: {
    country: string;
    city: string;
    coordinates: { lat: number; lng: number };
  };
  userAgent: string;
  timestamp: Date;
  resource: string;
  action: string;
}

export interface ZeroTrustVerification {
  user: { verified: boolean; score: number; factors: string[] };
  device: { verified: boolean; score: number; factors: string[] };
  location: { verified: boolean; score: number; factors: string[] };
  behavior: { verified: boolean; score: number; factors: string[] };
  resource: { verified: boolean; score: number; factors: string[] };
  overall: { allowed: boolean; confidence: number; riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL' };
}

export interface DeviceFingerprint {
  deviceId: string;
  userAgent: string;
  screenResolution: string;
  timezone: string;
  language: string;
  platform: string;
  hardwareConcurrency: number;
  deviceMemory: number;
  firstSeen: Date;
  lastSeen: Date;
  trustScore: number;
}

export interface LocationContext {
  ip: string;
  country: string;
  city: string;
  region: string;
  coordinates: { lat: number; lng: number };
  isVPN: boolean;
  isProxy: boolean;
  isDataCenter: boolean;
  riskScore: number;
}

export interface BehaviorPattern {
  userId: string;
  normalIPs: Set<string>;
  normalDevices: Set<string>;
  normalLocations: Set<string>;
  normalTimeRanges: Set<string>;
  normalResources: Set<string>;
  requestPatterns: Map<string, number>;
  averageRequestRate: number;
  lastUpdated: Date;
  anomalyCount: number;
}

/**
 * Zero Trust Engine
 */
export class ZeroTrustEngine {
  /**
   * Verify all trust factors for a request
   */
  static async verifyRequest(context: ZeroTrustContext): Promise<ZeroTrustVerification> {
    const verification: ZeroTrustVerification = {
      user: await this.verifyUser(context),
      device: await this.verifyDevice(context),
      location: await this.verifyLocation(context),
      behavior: await this.verifyBehavior(context),
      resource: await this.verifyResource(context),
      overall: { allowed: false, confidence: 0, riskLevel: 'LOW' },
    };
    
    // Calculate overall score
    const totalScore = 
      verification.user.score +
      verification.device.score +
      verification.location.score +
      verification.behavior.score +
      verification.resource.score;
    
    const averageScore = totalScore / 5;
    
    // Determine risk level and access decision
    if (averageScore >= 80) {
      verification.overall = { allowed: true, confidence: averageScore, riskLevel: 'LOW' };
    } else if (averageScore >= 60) {
      verification.overall = { allowed: true, confidence: averageScore, riskLevel: 'MEDIUM' };
    } else if (averageScore >= 40) {
      verification.overall = { allowed: true, confidence: averageScore, riskLevel: 'HIGH' };
    } else {
      verification.overall = { allowed: false, confidence: averageScore, riskLevel: 'CRITICAL' };
    }
    
    // Log verification result
    await this.logVerification(context, verification);
    
    return verification;
  }
  
  /**
   * Verify user identity
   */
  private static async verifyUser(context: ZeroTrustContext): Promise<{ verified: boolean; score: number; factors: string[] }> {
    const factors: string[] = [];
    let score = 100;
    
    // Check if user exists and is active
    const userExists = await this.checkUserExists(context.userId);
    if (!userExists) {
      factors.push('User does not exist');
      score -= 100;
      return { verified: false, score: 0, factors };
    }
    
    // Check if user account is active
    const userActive = await this.checkUserActive(context.userId);
    if (!userActive) {
      factors.push('User account is inactive');
      score -= 50;
    }
    
    // Check if user has required permissions
    const hasPermissions = await this.checkUserPermissions(context.userId, context.resource, context.action);
    if (!hasPermissions) {
      factors.push('User lacks required permissions');
      score -= 40;
    }
    
    // Check if user is in a trusted role
    const isTrustedRole = await this.checkTrustedRole(context.userId);
    if (isTrustedRole) {
      factors.push('User has trusted role');
      score += 10;
    }
    
    // Check for recent suspicious activity
    const hasSuspiciousActivity = await this.checkSuspiciousActivity(context.userId);
    if (hasSuspiciousActivity) {
      factors.push('User has recent suspicious activity');
      score -= 30;
    }
    
    return {
      verified: score >= 60,
      score: Math.max(0, Math.min(100, score)),
      factors,
    };
  }
  
  /**
   * Verify device
   */
  private static async verifyDevice(context: ZeroTrustContext): Promise<{ verified: boolean; score: number; factors: string[] }> {
    const factors: string[] = [];
    let score = 100;
    
    // Get device fingerprint
    const deviceFingerprint = await this.getDeviceFingerprint(context.deviceId);
    
    if (!deviceFingerprint) {
      factors.push('Unknown device');
      score -= 40;
    } else {
      // Check if device is trusted
      if (deviceFingerprint.trustScore >= 80) {
        factors.push('Device is trusted');
        score += 10;
      } else {
        factors.push('Device has low trust score');
        score -= 20;
      }
      
      // Check if device was recently seen
      const daysSinceLastSeen = (Date.now() - deviceFingerprint.lastSeen.getTime()) / (1000 * 60 * 60 * 24);
      if (daysSinceLastSeen > 30) {
        factors.push('Device not seen recently');
        score -= 15;
      }
      
      // Check if user-agent matches
      if (deviceFingerprint.userAgent !== context.userAgent) {
        factors.push('User-agent mismatch');
        score -= 25;
      }
    }
    
    // Check for device anomalies
    const hasDeviceAnomalies = await this.checkDeviceAnomalies(context.deviceId);
    if (hasDeviceAnomalies) {
      factors.push('Device has security anomalies');
      score -= 30;
    }
    
    return {
      verified: score >= 60,
      score: Math.max(0, Math.min(100, score)),
      factors,
    };
  }
  
  /**
   * Verify location
   */
  private static async verifyLocation(context: ZeroTrustContext): Promise<{ verified: boolean; score: number; factors: string[] }> {
    const factors: string[] = [];
    let score = 100;
    
    // Get location context
    const locationContext = await this.getLocationContext(context.ipAddress);
    
    // Check if IP is from private network
    if (this.isPrivateIP(context.ipAddress)) {
      factors.push('Private IP address');
      score -= 20;
    }
    
    // Check if IP is from VPN/Proxy
    if (locationContext.isVPN || locationContext.isProxy) {
      factors.push('IP is from VPN/Proxy');
      score -= 25;
    }
    
    // Check if IP is from data center
    if (locationContext.isDataCenter) {
      factors.push('IP is from data center');
      score -= 30;
    }
    
    // Check location risk
    if (locationContext.riskScore > 50) {
      factors.push('High-risk location');
      score -= 40;
    }
    
    // Check if location matches user's normal locations
    const userNormalLocations = await this.getUserNormalLocations(context.userId);
    if (userNormalLocations.size > 0 && !userNormalLocations.has(locationContext.country)) {
      factors.push('Unusual location for user');
      score -= 35;
    }
    
    // Check for impossible travel (login from two distant locations in short time)
    const impossibleTravel = await this.checkImpossibleTravel(context.userId, locationContext);
    if (impossibleTravel) {
      factors.push('Impossible travel detected');
      score -= 60;
    }
    
    return {
      verified: score >= 60,
      score: Math.max(0, Math.min(100, score)),
      factors,
    };
  }
  
  /**
   * Verify behavior
   */
  private static async verifyBehavior(context: ZeroTrustContext): Promise<{ verified: boolean; score: number; factors: string[] }> {
    const factors: string[] = [];
    let score = 100;
    
    // Get user behavior pattern
    const behaviorPattern = await this.getBehaviorPattern(context.userId);
    
    // Check request rate
    const currentRequestRate = await this.getCurrentRequestRate(context.userId);
    if (currentRequestRate > behaviorPattern.averageRequestRate * 10) {
      factors.push('Unusually high request rate');
      score -= 40;
    }
    
    // Check if resource access is normal
    if (behaviorPattern.normalResources.size > 0 && !behaviorPattern.normalResources.has(context.resource)) {
      factors.push('Accessing unusual resource');
      score -= 20;
    }
    
    // Check time pattern
    const currentTimeRange = this.getTimeRange(context.timestamp);
    if (behaviorPattern.normalTimeRanges.size > 0 && !behaviorPattern.normalTimeRanges.has(currentTimeRange)) {
      factors.push('Unusual time for access');
      score -= 15;
    }
    
    // Check for anomalous patterns
    const isAnomalous = await this.detectAnomaly(context.userId, context);
    if (isAnomalous) {
      factors.push('Anomalous behavior detected');
      score -= 35;
    }
    
    // Update behavior pattern
    await this.updateBehaviorPattern(context.userId, context);
    
    return {
      verified: score >= 60,
      score: Math.max(0, Math.min(100, score)),
      factors,
    };
  }
  
  /**
   * Verify resource access
   */
  private static async verifyResource(context: ZeroTrustContext): Promise<{ verified: boolean; score: number; factors: string[] }> {
    const factors: string[] = [];
    let score = 100;
    
    // Get resource sensitivity
    const sensitivity = this.getResourceSensitivity(context.resource);
    
    // High sensitivity requires higher trust
    if (sensitivity === 'HIGH') {
      factors.push('High-sensitivity resource');
      score -= 10;
    }
    
    // Check if action is appropriate for resource
    const actionAppropriate = this.isActionAppropriate(context.resource, context.action);
    if (!actionAppropriate) {
      factors.push('Inappropriate action for resource');
      score -= 50;
    }
    
    // Check for data exfiltration risk
    const exfiltrationRisk = this.checkExfiltrationRisk(context.resource, context.action);
    if (exfiltrationRisk) {
      factors.push('Potential data exfiltration');
      score -= 40;
    }
    
    // Check resource access policies
    const policyCompliant = await this.checkResourcePolicy(context.userId, context.resource, context.action);
    if (!policyCompliant) {
      factors.push('Resource policy violation');
      score -= 60;
    }
    
    return {
      verified: score >= 60,
      score: Math.max(0, Math.min(100, score)),
      factors,
    };
  }
  
  /**
   * Check if user exists
   */
  private static async checkUserExists(userId: string): Promise<boolean> {
    // In production, query database
    return true;
  }
  
  /**
   * Check if user is active
   */
  private static async checkUserActive(userId: string): Promise<boolean> {
    // In production, query database
    return true;
  }
  
  /**
   * Check user permissions
   */
  private static async checkUserPermissions(userId: string, resource: string, action: string): Promise<boolean> {
    // In production, check permission matrix
    return true;
  }
  
  /**
   * Check if user has trusted role
   */
  private static async checkTrustedRole(userId: string): Promise<boolean> {
    // In production, query database
    return false;
  }
  
  /**
   * Check for suspicious activity
   */
  private static async checkSuspiciousActivity(userId: string): Promise<boolean> {
    const cacheKey = `zero-trust:suspicious:${userId}`;
    const cached = await cacheGet<boolean>(cacheKey);
    return cached === true;
  }
  
  /**
   * Get device fingerprint
   */
  private static async getDeviceFingerprint(deviceId: string): Promise<DeviceFingerprint | null> {
    const cacheKey = `zero-trust:device:${deviceId}`;
    return await cacheGet<DeviceFingerprint>(cacheKey);
  }
  
  /**
   * Create device fingerprint
   */
  static async createDeviceFingerprint(fingerprint: Partial<DeviceFingerprint>): Promise<string> {
    const deviceId = crypto.randomUUID();
    
    const fullFingerprint: DeviceFingerprint = {
      deviceId,
      userAgent: fingerprint.userAgent || '',
      screenResolution: fingerprint.screenResolution || '',
      timezone: fingerprint.timezone || '',
      language: fingerprint.language || '',
      platform: fingerprint.platform || '',
      hardwareConcurrency: fingerprint.hardwareConcurrency || 0,
      deviceMemory: fingerprint.deviceMemory || 0,
      firstSeen: new Date(),
      lastSeen: new Date(),
      trustScore: 50, // Start with neutral trust
    };
    
    const cacheKey = `zero-trust:device:${deviceId}`;
    await cacheSet(cacheKey, fullFingerprint, 2592000); // 30 days
    
    console.log(`[Zero Trust] Created device fingerprint: ${deviceId}`);
    
    return deviceId;
  }
  
  /**
   * Update device trust score
   */
  static async updateDeviceTrustScore(deviceId: string, delta: number): Promise<void> {
    const fingerprint = await this.getDeviceFingerprint(deviceId);
    if (!fingerprint) return;
    
    fingerprint.trustScore = Math.max(0, Math.min(100, fingerprint.trustScore + delta));
    fingerprint.lastSeen = new Date();
    
    const cacheKey = `zero-trust:device:${deviceId}`;
    await cacheSet(cacheKey, fingerprint, 2592000);
    
    console.log(`[Zero Trust] Updated device trust score: ${deviceId} -> ${fingerprint.trustScore}`);
  }
  
  /**
   * Check device anomalies
   */
  private static async checkDeviceAnomalies(deviceId: string): Promise<boolean> {
    const cacheKey = `zero-trust:device:anomalies:${deviceId}`;
    const cached = await cacheGet<number>(cacheKey);
    return (cached || 0) > 3;
  }
  
  /**
   * Get location context
   */
  private static async getLocationContext(ip: string): Promise<LocationContext> {
    const cacheKey = `zero-trust:location:${ip}`;
    const cached = await cacheGet<LocationContext>(cacheKey);
    
    if (cached) {
      return cached;
    }
    
    // In production, use IP geolocation service
    const context: LocationContext = {
      ip,
      country: 'US',
      city: 'Unknown',
      region: 'Unknown',
      coordinates: { lat: 0, lng: 0 },
      isVPN: false,
      isProxy: false,
      isDataCenter: false,
      riskScore: 0,
    };
    
    await cacheSet(cacheKey, context, 3600); // 1 hour
    
    return context;
  }
  
  /**
   * Check if IP is private
   */
  private static isPrivateIP(ip: string): boolean {
    const privateRanges = [
      /^10\./,
      /^172\.(1[6-9]|2[0-9]|3[01])\./,
      /^192\.168\./,
      /^127\./,
      /^::1$/,
      /^fc00:/i,
      /^fe80:/i,
    ];
    
    return privateRanges.some(range => range.test(ip));
  }
  
  /**
   * Get user's normal locations
   */
  private static async getUserNormalLocations(userId: string): Promise<Set<string>> {
    const behaviorPattern = await this.getBehaviorPattern(userId);
    return behaviorPattern.normalLocations;
  }
  
  /**
   * Check for impossible travel
   */
  private static async checkImpossibleTravel(userId: string, currentLocation: LocationContext): Promise<boolean> {
    const cacheKey = `zero-trust:travel:${userId}`;
    const cached = await cacheGet<{ location: LocationContext; timestamp: number }>(cacheKey);
    
    if (!cached) {
      await cacheSet(cacheKey, { location: currentLocation, timestamp: Date.now() }, 3600);
      return false;
    }
    
    // Calculate distance between locations
    const distance = this.calculateDistance(
      cached.location.coordinates,
      currentLocation.coordinates
    );
    
    // Calculate time elapsed
    const timeElapsed = (Date.now() - cached.timestamp) / 1000 / 60; // minutes
    
    // If distance > 1000km and time < 60 minutes, impossible travel
    if (distance > 1000 && timeElapsed < 60) {
      return true;
    }
    
    // Update cache
    await cacheSet(cacheKey, { location: currentLocation, timestamp: Date.now() }, 3600);
    
    return false;
  }
  
  /**
   * Calculate distance between coordinates
   */
  private static calculateDistance(
    coord1: { lat: number; lng: number },
    coord2: { lat: number; lng: number }
  ): number {
    const R = 6371; // Earth's radius in km
    const dLat = (coord2.lat - coord1.lat) * Math.PI / 180;
    const dLng = (coord2.lng - coord1.lng) * Math.PI / 180;
    
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(coord1.lat * Math.PI / 180) * Math.cos(coord2.lat * Math.PI / 180) *
              Math.sin(dLng / 2) * Math.sin(dLng / 2);
    
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    
    return R * c;
  }
  
  /**
   * Get behavior pattern
   */
  private static async getBehaviorPattern(userId: string): Promise<BehaviorPattern> {
    const cacheKey = `zero-trust:behavior:${userId}`;
    const cached = await cacheGet<BehaviorPattern>(cacheKey);
    
    if (cached) {
      return cached;
    }
    
    // Default pattern
    return {
      userId,
      normalIPs: new Set(),
      normalDevices: new Set(),
      normalLocations: new Set(),
      normalTimeRanges: new Set(),
      normalResources: new Set(),
      requestPatterns: new Map(),
      averageRequestRate: 10,
      lastUpdated: new Date(),
      anomalyCount: 0,
    };
  }
  
  /**
   * Get current request rate
   */
  private static async getCurrentRequestRate(userId: string): Promise<number> {
    const cacheKey = `zero-trust:rate:${userId}`;
    const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);
    
    const now = Math.floor(Date.now() / 1000);
    const windowStart = now - 60; // 1 minute window
    
    if (cached && cached.windowStart > windowStart) {
      return cached.count;
    }
    
    return 0;
  }
  
  /**
   * Get time range
   */
  private static getTimeRange(timestamp: Date): string {
    const hour = timestamp.getHours();
    
    if (hour >= 6 && hour < 12) return 'MORNING';
    if (hour >= 12 && hour < 18) return 'AFTERNOON';
    if (hour >= 18 && hour < 24) return 'EVENING';
    return 'NIGHT';
  }
  
  /**
   * Detect anomaly
   */
  private static async detectAnomaly(userId: string, context: ZeroTrustContext): Promise<boolean> {
    // In production, use ML model for anomaly detection
    return false;
  }
  
  /**
   * Update behavior pattern
   */
  private static async updateBehaviorPattern(userId: string, context: ZeroTrustContext): Promise<void> {
    const pattern = await this.getBehaviorPattern(userId);
    
    pattern.normalIPs.add(context.ipAddress);
    pattern.normalDevices.add(context.deviceId);
    pattern.normalLocations.add(context.location.country);
    pattern.normalTimeRanges.add(this.getTimeRange(context.timestamp));
    pattern.normalResources.add(context.resource);
    pattern.lastUpdated = new Date();
    
    const cacheKey = `zero-trust:behavior:${userId}`;
    await cacheSet(cacheKey, pattern, 604800); // 7 days
  }
  
  /**
   * Get resource sensitivity
   */
  private static getResourceSensitivity(resource: string): 'LOW' | 'MEDIUM' | 'HIGH' {
    const highSensitivityResources = [
      'financial',
      'contract',
      'identity',
      'admin',
      'compliance',
      'escrow',
    ];
    
    const mediumSensitivityResources = [
      'property',
      'lead',
      'document',
      'booking',
    ];
    
    if (highSensitivityResources.some(r => resource.includes(r))) {
      return 'HIGH';
    }
    
    if (mediumSensitivityResources.some(r => resource.includes(r))) {
      return 'MEDIUM';
    }
    
    return 'LOW';
  }
  
  /**
   * Check if action is appropriate
   */
  private static isActionAppropriate(resource: string, action: string): boolean {
    // In production, check resource-action matrix
    return true;
  }
  
  /**
   * Check exfiltration risk
   */
  private static checkExfiltrationRisk(resource: string, action: string): boolean {
    const exfiltrationActions = ['export', 'download', 'bulk', 'dump'];
    const sensitiveResources = ['financial', 'contract', 'identity', 'lead'];
    
    return exfiltrationActions.some(a => action.includes(a)) &&
           sensitiveResources.some(r => resource.includes(r));
  }
  
  /**
   * Check resource policy
   */
  private static async checkResourcePolicy(userId: string, resource: string, action: string): Promise<boolean> {
    // In production, check resource access policies
    return true;
  }
  
  /**
   * Log verification result
   */
  private static async logVerification(context: ZeroTrustContext, verification: ZeroTrustVerification): Promise<void> {
    const logEntry = {
      timestamp: context.timestamp,
      userId: context.userId,
      deviceId: context.deviceId,
      ipAddress: context.ipAddress,
      resource: context.resource,
      action: context.action,
      allowed: verification.overall.allowed,
      confidence: verification.overall.confidence,
      riskLevel: verification.overall.riskLevel,
      factors: verification,
    };
    
    console.log('[Zero Trust] Verification:', logEntry);
    
    // In production, write to audit log
    // await prisma.zeroTrustAuditLog.create({ ... });
  }
}

/**
 * Zero Trust Middleware
 */
export const zeroTrustMiddleware = async ({ 
  userId, 
  headers, 
  path, 
  method,
  set 
}: any) => {
  const ip = headers.get('x-forwarded-for') || 
             headers.get('cf-connecting-ip') || 
             'unknown';
  const userAgent = headers.get('user-agent') || 'unknown';
  
  // Get or create device ID
  const deviceId = headers.get('x-device-id') || crypto.randomUUID();
  
  // Get location context
  const locationContext = await ZeroTrustEngine['getLocationContext'](ip);
  
  const context: ZeroTrustContext = {
    userId,
    deviceId,
    ipAddress: ip,
    location: {
      country: locationContext.country,
      city: locationContext.city,
      coordinates: locationContext.coordinates,
    },
    userAgent,
    timestamp: new Date(),
    resource: path,
    action: method.toLowerCase(),
  };
  
  // Verify all trust factors
  const verification = await ZeroTrustEngine.verifyRequest(context);
  
  if (!verification.overall.allowed) {
    set.status = 403;
    set.headers = {
      ...set.headers,
      'X-Zero-Trust-Allowed': 'false',
      'X-Zero-Trust-Risk-Level': verification.overall.riskLevel,
      'X-Zero-Trust-Confidence': verification.overall.confidence.toString(),
    };
    throw new Error(`Zero Trust: Access denied - ${verification.overall.riskLevel} risk`);
  }
  
  set.headers = {
    ...set.headers,
    'X-Zero-Trust-Allowed': 'true',
    'X-Zero-Trust-Risk-Level': verification.overall.riskLevel,
    'X-Zero-Trust-Confidence': verification.overall.confidence.toString(),
  };
  
  console.log(`[Zero Trust] Access granted for ${userId}: ${verification.overall.riskLevel} risk (${verification.overall.confidence}% confidence)`);
};
