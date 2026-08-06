/**
 * Identity Security Layer
 * Enterprise-grade identity management with SSO, MFA, adaptive authentication, risk-based access, and PAM
 */

import { cacheSet, cacheGet, cacheDelete } from './cache';
import { randomBytes } from 'crypto';

export interface IdentityContext {
  userId: string;
  orgId: string;
  role: string;
  mfaEnabled: boolean;
  mfaVerified: boolean;
  riskScore: number;
  deviceTrusted: boolean;
  locationTrusted: boolean;
  sessionRisk: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
}

export interface MFAMethod {
  type: 'TOTP' | 'SMS' | 'EMAIL' | 'HARDWARE_TOKEN' | 'BIOMETRIC';
  enabled: boolean;
  verified: boolean;
  lastUsed?: Date;
}

export interface AdaptiveAuthDecision {
  requireMFA: boolean;
  requireReauth: boolean;
  requireDeviceVerification: boolean;
  requireLocationVerification: boolean;
  blockAccess: boolean;
  reason: string;
}

// SSO Providers
export enum SSOProvider {
  AZURE_AD = 'AZURE_AD',
  OKTA = 'OKTA',
  KEYCLOAK = 'KEYCLOAK',
  GOOGLE_WORKSPACE = 'GOOGLE_WORKSPACE',
  PING_IDENTITY = 'PING_IDENTITY',
  AUTH0 = 'AUTH0',
  SAML = 'SAML',
  OIDC = 'OIDC',
}

// Privileged Access Roles
export const PRIVILEGED_ROLES = [
  'SUPER_ADMIN',
  'SYSTEM_ADMIN',
  'AGENCY_ADMIN',
  'FINANCE_MANAGER',
  'PROPERTY_MANAGER',
  'COMPLIANCE_OFFICER',
];

/**
 * SSO Authentication
 */
export class SSOAuthentication {
  /**
   * Initiate SSO login flow
   */
  static async initiateSSO(provider: SSOProvider, orgId: string): Promise<string> {
    const ssoUrl = this.getSSOUrl(provider, orgId);
    
    // Generate state parameter for CSRF protection
    const state = crypto.randomUUID();
    await cacheSet(`sso:state:${state}`, { provider, orgId }, 600);
    
    console.log(`[SSO] Initiating ${provider} login for org ${orgId}`);
    
    return `${ssoUrl}?state=${state}`;
  }
  
  /**
   * Handle SSO callback
   */
  static async handleSSOCallback(
    provider: SSOProvider,
    code: string,
    state: string
  ): Promise<{ userId: string; orgId: string; email: string }> {
    // Verify state
    const stateData = await cacheGet(`sso:state:${state}`);
    if (!stateData) {
      throw new Error('Invalid or expired state parameter');
    }
    
    // Exchange code for tokens
    const tokens = await this.exchangeCodeForTokens(provider, code);
    
    // Get user info from ID token
    const userInfo = await this.getUserInfoFromToken(provider, tokens.id_token);
    
    // Sync or create user
    const user = await this.syncUserFromSSO(provider, userInfo, stateData.orgId);
    
    // Clean up state
    await cacheDelete(`sso:state:${state}`);
    
    console.log(`[SSO] Successfully authenticated ${user.email} via ${provider}`);
    
    return user;
  }
  
  /**
   * Get SSO provider URL
   */
  private static getSSOUrl(provider: SSOProvider, orgId: string): string {
    const urls: Record<SSOProvider, string> = {
      [SSOProvider.AZURE_AD]: `https://login.microsoftonline.com/${orgId}/oauth2/v2.0/authorize`,
      [SSOProvider.OKTA]: `https://${orgId}.okta.com/oauth2/v1/authorize`,
      [SSOProvider.KEYCLOAK]: `https://keycloak.${orgId}.com/auth`,
      [SSOProvider.GOOGLE_WORKSPACE]: 'https://accounts.google.com/o/oauth2/v2/auth',
      [SSOProvider.PING_IDENTITY]: `https://auth.pingone.com/${orgId}/as/authorize`,
      [SSOProvider.AUTH0]: `https://${orgId}.auth0.com/authorize`,
      [SSOProvider.SAML]: process.env.SAML_SSO_URL || '',
      [SSOProvider.OIDC]: process.env.OIDC_SSO_URL || '',
    };
    
    return urls[provider];
  }
  
  /**
   * Exchange authorization code for tokens
   */
  private static async exchangeCodeForTokens(
    provider: SSOProvider,
    code: string
  ): Promise<{ access_token: string; id_token: string; refresh_token: string }> {
    // In production, call provider's token endpoint
    // For now, return mock tokens
    return {
      access_token: 'mock_access_token',
      id_token: 'mock_id_token',
      refresh_token: 'mock_refresh_token',
    };
  }
  
  /**
   * Get user info from ID token
   */
  private static async getUserInfoFromToken(
    provider: SSOProvider,
    idToken: string
  ): Promise<{ email: string; name: string; groups: string[] }> {
    // In production, decode and verify JWT
    // For now, return mock user info
    return {
      email: 'user@example.com',
      name: 'John Doe',
      groups: ['users'],
    };
  }
  
  /**
   * Sync user from SSO
   */
  private static async syncUserFromSSO(
    provider: SSOProvider,
    userInfo: { email: string; name: string; groups: string[] },
    orgId: string
  ): Promise<{ userId: string; orgId: string; email: string }> {
    // In production, sync with database
    // For now, return mock user
    return {
      userId: crypto.randomUUID(),
      orgId,
      email: userInfo.email,
    };
  }
}

/**
 * Multi-Factor Authentication
 */
export class MFAService {
  /**
   * Generate TOTP secret
   */
  static async generateTOTPSecret(userId: string): Promise<{ secret: string; qrCode: string }> {
    const secret = this.generateSecret();
    const qrCode = this.generateQRCode(secret);
    
    // Store secret temporarily
    await cacheSet(`mfa:totp:setup:${userId}`, { secret }, 300);
    
    console.log(`[MFA] Generated TOTP secret for user ${userId}`);
    
    return { secret, qrCode };
  }
  
  /**
   * Verify TOTP code
   */
  static async verifyTOTP(userId: string, code: string): Promise<boolean> {
    const cached = await cacheGet(`mfa:totp:setup:${userId}`);
    if (!cached) {
      return false;
    }
    
    // In production, verify using TOTP library
    const isValid = this.validateTOTPCode(cached.secret, code);
    
    if (isValid) {
      // Mark MFA as enabled
      await cacheSet(`mfa:enabled:${userId}`, true, 86400);
      await cacheDelete(`mfa:totp:setup:${userId}`);
    }
    
    return isValid;
  }
  
  /**
   * Send SMS OTP
   */
  static async sendSMSOTP(userId: string, phone: string): Promise<void> {
    const otp = this.generateOTP();
    
    // Store OTP
    await cacheSet(`mfa:sms:${userId}`, { otp, phone }, 300);
    
    // In production, send via SMS queue
    console.log(`[MFA] SMS OTP sent to ${phone}: ${otp}`);
  }
  
  /**
   * Verify SMS OTP
   */
  static async verifySMSOTP(userId: string, code: string): Promise<boolean> {
    const cached = await cacheGet(`mfa:sms:${userId}`);
    if (!cached) {
      return false;
    }
    
    const isValid = cached.otp === code;
    
    if (isValid) {
      await cacheDelete(`mfa:sms:${userId}`);
    }
    
    return isValid;
  }
  
  /**
   * Check if MFA is enabled for user
   */
  static async isMFAEnabled(userId: string): Promise<boolean> {
    const cached = await cacheGet(`mfa:enabled:${userId}`);
    return cached === true;
  }
  
  /**
   * Get MFA methods for user
   */
  static async getMFAMethods(userId: string): Promise<MFAMethod[]> {
    const methods: MFAMethod[] = [
      {
        type: 'TOTP',
        enabled: await this.isMFAEnabled(userId),
        verified: await this.isMFAEnabled(userId),
      },
      {
        type: 'SMS',
        enabled: true,
        verified: false,
      },
      {
        type: 'EMAIL',
        enabled: true,
        verified: false,
      },
    ];
    
    return methods;
  }
  
  /**
   * Generate random secret
   */
  private static generateSecret(): string {
    return randomBytes(32).toString('base64');
  }
  
  /**
   * Generate QR code
   */
  private static generateQRCode(secret: string): string {
    // In production, use QR code library
    return `otpauth://totp/Reservatior:${secret}?secret=${secret}&issuer=Reservatior`;
  }
  
  /**
   * Generate OTP
   */
  private static generateOTP(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }
  
  /**
   * Validate TOTP code
   */
  private static validateTOTPCode(secret: string, code: string): boolean {
    // In production, use TOTP library
    return code.length === 6 && /^\d+$/.test(code);
  }
}

/**
 * Adaptive Authentication
 */
export class AdaptiveAuthentication {
  /**
   * Make authentication decision based on risk factors
   */
  static async makeAuthDecision(
    userId: string,
    context: {
      ip: string;
      userAgent: string;
      location?: string;
      deviceId?: string;
    }
  ): Promise<AdaptiveAuthDecision> {
    const riskFactors = await this.evaluateRiskFactors(userId, context);
    const riskScore = this.calculateRiskScore(riskFactors);
    
    const decision: AdaptiveAuthDecision = {
      requireMFA: false,
      requireReauth: false,
      requireDeviceVerification: false,
      requireLocationVerification: false,
      blockAccess: false,
      reason: '',
    };
    
    // Low risk - standard authentication
    if (riskScore < 30) {
      decision.reason = 'Low risk - standard authentication';
    }
    // Medium risk - require MFA
    else if (riskScore < 60) {
      decision.requireMFA = true;
      decision.reason = 'Medium risk - MFA required';
    }
    // High risk - require re-authentication + MFA
    else if (riskScore < 80) {
      decision.requireMFA = true;
      decision.requireReauth = true;
      decision.reason = 'High risk - re-authentication + MFA required';
    }
    // Critical risk - block access
    else {
      decision.blockAccess = true;
      decision.reason = 'Critical risk - access blocked';
    }
    
    // Additional checks for privileged roles
    const userRole = await this.getUserRole(userId);
    if (PRIVILEGED_ROLES.includes(userRole)) {
      decision.requireMFA = true;
      decision.requireDeviceVerification = true;
    }
    
    console.log(`[Adaptive Auth] Decision for ${userId}: ${decision.reason} (Risk: ${riskScore})`);
    
    return decision;
  }
  
  /**
   * Evaluate risk factors
   */
  private static async evaluateRiskFactors(
    userId: string,
    context: { ip: string; userAgent: string; location?: string; deviceId?: string }
  ): Promise<Record<string, number>> {
    const factors: Record<string, number> = {};
    
    // IP location risk
    factors.ipLocation = await this.evaluateIPRisk(context.ip);
    
    // Device risk
    factors.device = await this.evaluateDeviceRisk(userId, context.deviceId);
    
    // User agent risk
    factors.userAgent = this.evaluateUserAgentRisk(context.userAgent);
    
    // Time-based risk
    factors.time = this.evaluateTimeRisk();
    
    // Behavior risk
    factors.behavior = await this.evaluateBehaviorRisk(userId);
    
    return factors;
  }
  
  /**
   * Calculate overall risk score
   */
  private static calculateRiskScore(factors: Record<string, number>): number {
    let score = 0;
    for (const [key, value] of Object.entries(factors)) {
      score += value;
    }
    return Math.min(100, score);
  }
  
  /**
   * Evaluate IP risk
   */
  private static async evaluateIPRisk(ip: string): Promise<number> {
    // Check if IP is from known malicious range
    if (await this.isMaliciousIP(ip)) return 50;
    
    // Check if IP is from VPN/Proxy
    if (await this.isVPNOrProxy(ip)) return 20;
    
    // Check if IP is from unusual location
    if (await this.isUnusualLocation(ip)) return 15;
    
    return 0;
  }
  
  /**
   * Evaluate device risk
   */
  private static async evaluateDeviceRisk(userId: string, deviceId?: string): Promise<number> {
    if (!deviceId) return 30; // Unknown device
    
    const isTrusted = await this.isTrustedDevice(userId, deviceId);
    return isTrusted ? 0 : 20;
  }
  
  /**
   * Evaluate user agent risk
   */
  private static evaluateUserAgentRisk(userAgent: string): number {
    // Check for suspicious patterns
    if (/bot|crawler|spider/i.test(userAgent)) return 40;
    if (/curl|wget|python/i.test(userAgent)) return 30;
    
    return 0;
  }
  
  /**
   * Evaluate time risk
   */
  private static evaluateTimeRisk(): number {
    const hour = new Date().getHours();
    
    // Unusual hours (midnight to 6 AM)
    if (hour >= 0 && hour < 6) return 10;
    
    return 0;
  }
  
  /**
   * Evaluate behavior risk
   */
  private static async evaluateBehaviorRisk(userId: string): Promise<number> {
    // Check for rapid authentication attempts
    const recentAttempts = await this.getRecentAuthAttempts(userId);
    if (recentAttempts > 5) return 30;
    
    // Check for failed attempts
    const failedAttempts = await this.getFailedAuthAttempts(userId);
    if (failedAttempts > 3) return 25;
    
    return 0;
  }
  
  /**
   * Get user role
   */
  private static async getUserRole(userId: string): Promise<string> {
    // In production, query database
    return 'USER';
  }
  
  /**
   * Check if IP is malicious
   */
  private static async isMaliciousIP(ip: string): Promise<boolean> {
    // In production, check threat intelligence
    return false;
  }
  
  /**
   * Check if IP is VPN/Proxy
   */
  private static async isVPNOrProxy(ip: string): Promise<boolean> {
    // In production, use VPN detection service
    return false;
  }
  
  /**
   * Check if IP is unusual location
   */
  private static async isUnusualLocation(ip: string): Promise<boolean> {
    // In production, compare with user's normal locations
    return false;
  }
  
  /**
   * Check if device is trusted
   */
  private static async isTrustedDevice(userId: string, deviceId: string): Promise<boolean> {
    const cacheKey = `device:trusted:${userId}:${deviceId}`;
    const cached = await cacheGet(cacheKey);
    return cached === true;
  }
  
  /**
   * Trust device
   */
  static async trustDevice(userId: string, deviceId: string): Promise<void> {
    const cacheKey = `device:trusted:${userId}:${deviceId}`;
    await cacheSet(cacheKey, true, 2592000); // 30 days
    console.log(`[Adaptive Auth] Device ${deviceId} trusted for user ${userId}`);
  }
  
  /**
   * Get recent authentication attempts
   */
  private static async getRecentAuthAttempts(userId: string): Promise<number> {
    const cacheKey = `auth:attempts:${userId}`;
    const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);
    
    const now = Math.floor(Date.now() / 1000);
    const windowStart = now - 300; // 5 minutes
    
    if (cached && cached.windowStart > windowStart) {
      return cached.count;
    }
    
    return 0;
  }
  
  /**
   * Get failed authentication attempts
   */
  private static async getFailedAuthAttempts(userId: string): Promise<number> {
    const cacheKey = `auth:failed:${userId}`;
    const cached = await cacheGet<{ count: number; windowStart: number }>(cacheKey);
    
    const now = Math.floor(Date.now() / 1000);
    const windowStart = now - 3600; // 1 hour
    
    if (cached && cached.windowStart > windowStart) {
      return cached.count;
    }
    
    return 0;
  }
}

/**
 * Risk-Based Access Control
 */
export class RiskBasedAccessControl {
  /**
   * Check if user can access resource based on risk
   */
  static async checkAccess(
    userId: string,
    resource: string,
    action: string,
    context: {
      ip: string;
      location?: string;
      deviceId?: string;
    }
  ): Promise<{ allowed: boolean; reason: string; requirements: string[] }> {
    const riskScore = await this.calculateUserRisk(userId, context);
    const resourceSensitivity = this.getResourceSensitivity(resource);
    
    const requirements: string[] = [];
    
    // High sensitivity resources require low risk
    if (resourceSensitivity === 'HIGH' && riskScore > 30) {
      return {
        allowed: false,
        reason: 'Risk too high for high-sensitivity resource',
        requirements: ['Reduce risk factors', 'Use trusted device', 'Enable MFA'],
      };
    }
    
    // Medium sensitivity resources require medium risk or lower
    if (resourceSensitivity === 'MEDIUM' && riskScore > 60) {
      return {
        allowed: false,
        reason: 'Risk too high for medium-sensitivity resource',
        requirements: ['Reduce risk factors', 'Enable MFA'],
      };
    }
    
    // Privileged actions require additional verification
    if (this.isPrivilegedAction(action)) {
      requirements.push('MFA required');
      requirements.push('Device verification required');
      
      const mfaEnabled = await MFAService.isMFAEnabled(userId);
      if (!mfaEnabled) {
        return {
          allowed: false,
          reason: 'MFA required for privileged action',
          requirements: ['Enable MFA'],
        };
      }
    }
    
    return {
      allowed: true,
      reason: 'Access granted',
      requirements,
    };
  }
  
  /**
   * Calculate user risk score
   */
  private static async calculateUserRisk(
    userId: string,
    context: { ip: string; userAgent?: string; location?: string; deviceId?: string }
  ): Promise<number> {
    // Reuse adaptive authentication risk evaluation
    const decision = await AdaptiveAuthentication.makeAuthDecision(userId, {
      ip: context.ip,
      userAgent: context.userAgent || 'unknown',
      location: context.location,
      deviceId: context.deviceId,
    });
    
    // Convert decision to risk score
    if (decision.blockAccess) return 90;
    if (decision.requireReauth) return 70;
    if (decision.requireMFA) return 50;
    return 20;
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
    ];
    
    const mediumSensitivityResources = [
      'property',
      'lead',
      'document',
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
   * Check if action is privileged
   */
  private static isPrivilegedAction(action: string): boolean {
    const privilegedActions = [
      'delete',
      'admin',
      'configure',
      'export',
      'bulk',
      'approve',
      'reject',
    ];
    
    return privilegedActions.some(a => action.includes(a));
  }
}

/**
 * Privileged Access Management (PAM)
 */
export class PrivilegedAccessManagement {
  /**
   * Request privileged access
   */
  static async requestPrivilegedAccess(
    userId: string,
    resource: string,
    reason: string,
    duration: number
  ): Promise<{ requestId: string; approved: boolean; message: string }> {
    const userRole = await this.getUserRole(userId);
    
    // Check if user has privileged role
    if (!PRIVILEGED_ROLES.includes(userRole)) {
      return {
        requestId: crypto.randomUUID(),
        approved: false,
        message: 'User does not have privileged role',
      };
    }
    
    // Check if approval is required
    const requiresApproval = this.requiresApproval(resource, userRole);
    
    if (requiresApproval) {
      // Create approval request
      const requestId = crypto.randomUUID();
      await this.createApprovalRequest(requestId, userId, resource, reason, duration);
      
      return {
        requestId,
        approved: false,
        message: 'Approval request submitted for review',
      };
    }
    
    // Grant access immediately
    const requestId = crypto.randomUUID();
    await this.grantPrivilegedAccess(requestId, userId, resource, duration);
    
    return {
      requestId,
      approved: true,
      message: 'Privileged access granted',
    };
  }
  
  /**
   * Approve privileged access request
   */
  static async approvePrivilegedAccess(
    requestId: string,
    approverId: string
  ): Promise<void> {
    const request = await this.getApprovalRequest(requestId);
    
    if (!request) {
      throw new Error('Request not found');
    }
    
    // Grant access
    await this.grantPrivilegedAccess(
      requestId,
      request.userId,
      request.resource,
      request.duration
    );
    
    // Log approval
    console.log(`[PAM] Request ${requestId} approved by ${approverId}`);
  }
  
  /**
   * Revoke privileged access
   */
  static async revokePrivilegedAccess(
    requestId: string,
    reason: string
  ): Promise<void> {
    await cacheDelete(`pam:access:${requestId}`);
    console.log(`[PAM] Request ${requestId} revoked: ${reason}`);
  }
  
  /**
   * Check if user has active privileged access
   */
  static async hasPrivilegedAccess(
    userId: string,
    resource: string
  ): Promise<boolean> {
    const cacheKey = `pam:access:${userId}:${resource}`;
    const cached = await cacheGet(cacheKey);
    return cached !== null;
  }
  
  /**
   * Get user role
   */
  private static async getUserRole(userId: string): Promise<string> {
    // In production, query database
    return 'USER';
  }
  
  /**
   * Check if approval is required
   */
  private static requiresApproval(resource: string, role: string): boolean {
    // Super admins don't need approval
    if (role === 'SUPER_ADMIN') return false;
    
    // High-sensitivity resources require approval
    const highSensitivityResources = [
      'financial',
      'admin',
      'compliance',
    ];
    
    return highSensitivityResources.some(r => resource.includes(r));
  }
  
  /**
   * Create approval request
   */
  private static async createApprovalRequest(
    requestId: string,
    userId: string,
    resource: string,
    reason: string,
    duration: number
  ): Promise<void> {
    const cacheKey = `pam:request:${requestId}`;
    await cacheSet(cacheKey, {
      userId,
      resource,
      reason,
      duration,
      createdAt: Date.now(),
      status: 'PENDING',
    }, 3600);
  }
  
  /**
   * Get approval request
   */
  private static async getApprovalRequest(requestId: string): Promise<any> {
    const cacheKey = `pam:request:${requestId}`;
    return await cacheGet(cacheKey);
  }
  
  /**
   * Grant privileged access
   */
  private static async grantPrivilegedAccess(
    requestId: string,
    userId: string,
    resource: string,
    duration: number
  ): Promise<void> {
    const cacheKey = `pam:access:${userId}:${resource}`;
    await cacheSet(cacheKey, {
      requestId,
      grantedAt: Date.now(),
      expiresAt: Date.now() + duration * 1000,
    }, duration);
    
    console.log(`[PAM] Privileged access granted to ${userId} for ${resource} (${duration}s)`);
  }
}

/**
 * Identity Security Middleware
 */
export const identitySecurityMiddleware = async ({ 
  userId, 
  headers, 
  set 
}: any) => {
  const ip = headers.get('x-forwarded-for') || 
             headers.get('cf-connecting-ip') || 
             'unknown';
  const userAgent = headers.get('user-agent') || 'unknown';
  
  // Adaptive authentication check
  const decision = await AdaptiveAuthentication.makeAuthDecision(userId, {
    ip,
    userAgent,
  });
  
  if (decision.blockAccess) {
    set.status = 403;
    throw new Error(`Access blocked: ${decision.reason}`);
  }
  
  if (decision.requireMFA) {
    const mfaEnabled = await MFAService.isMFAEnabled(userId);
    if (!mfaEnabled) {
      set.status = 403;
      throw new Error('MFA required for this session');
    }
  }
  
  set.headers = {
    ...set.headers,
    'X-Identity-Risk': decision.reason,
    'X-MFA-Required': decision.requireMFA.toString(),
  };
  
  console.log(`[Identity Security] Auth decision for ${userId}: ${decision.reason}`);
};
