/**
 * Identity OS Service
 * Enterprise Identity Platform
 */

import { prisma } from '../lib/prisma';
import { eventBus } from '../core/events/event-bus';
import { GeminiService } from './gemini';

export interface Organization {
  id: string;
  name: string;
  slug: string;
  type: 'agency' | 'property_management' | 'investment_firm' | 'individual';
  parentId?: string;
  settings: Record<string, any>;
  ssoEnabled: boolean;
  ssoProvider?: string;
  defaultCurrency?: string;
  defaultLocale?: string;
  timezone?: string;
  createdAt: Date;
  updatedAt: Date;
}

export interface Team {
  id: string;
  organizationId: string;
  name: string;
  description?: string;
  parentId?: string;
  permissions: string[];
  createdAt: Date;
}

export interface Role {
  id: string;
  name: string;
  description?: string;
  permissions: string[];
  isSystem: boolean;
  organizationId?: string;
}

export interface Permission {
  id: string;
  resource: string;
  action: string;
  conditions?: Record<string, any>;
  description?: string;
}

export interface APIKey {
  id: string;
  name: string;
  keyHash: string;
  userId: string;
  organizationId: string;
  scopes: string[];
  expiresAt?: Date;
  lastUsedAt?: Date;
  isActive: boolean;
  createdAt: Date;
}

export interface Session {
  id: string;
  userId: string;
  token: string;
  refreshToken?: string;
  deviceInfo?: {
    userAgent: string;
    ip: string;
    deviceType: string;
  };
  expiresAt: Date;
  createdAt: Date;
}

export interface Device {
  id: string;
  userId: string;
  deviceType: string;
  deviceName: string;
  deviceIdentifier: string;
  isTrusted: boolean;
  lastSeenAt: Date;
  createdAt: Date;
}

class IdentityOSService {
  /**
   * Create organization
   */
  async createOrganization(data: {
    name: string;
    type: 'agency' | 'property_management' | 'investment_firm' | 'individual';
    userId: string;
    parentId?: string;
  }) {
    const slug = this.generateSlug(data.name);
    
    const organization = await prisma.organization.create({
      data: {
        name: data.name,
        slug,
        type: data.type,
        parentId: data.parentId,
        settings: {},
        ssoEnabled: false
      }
    });

    // Add creator as admin
    await this.addUserToOrganization(data.userId, organization.id, 'admin');

    // Create default roles
    await this.createDefaultRoles(organization.id);

    await eventBus.publish('organization.created', organization, 'IdentityOS');

    return organization;
  }

  /**
   * Create team
   */
  async createTeam(data: {
    organizationId: string;
    name: string;
    description?: string;
    parentId?: string;
    permissions?: string[];
  }) {
    const team = await prisma.team.create({
      data: {
        organizationId: data.organizationId,
        name: data.name,
        description: data.description,
        parentId: data.parentId,
        permissions: data.permissions || []
      }
    });

    await eventBus.publish('team.created', team, 'IdentityOS');

    return team;
  }

  /**
   * Create role
   */
  async createRole(data: {
    name: string;
    description?: string;
    permissions: string[];
    organizationId?: string;
    isSystem?: boolean;
  }) {
    const role = await prisma.role.create({
      data: {
        name: data.name,
        description: data.description,
        permissions: data.permissions,
        isSystem: data.isSystem || false,
        organizationId: data.organizationId
      }
    });

    await eventBus.publish('role.created', role, 'IdentityOS');

    return role;
  }

  /**
   * Assign role to user
   */
  async assignRoleToUser(userId: string, roleId: string, organizationId: string) {
    const assignment = await prisma.userRole.create({
      data: {
        userId,
        roleId,
        organizationId
      }
    });

    await eventBus.publish('role.assigned', assignment, 'IdentityOS');

    return assignment;
  }

  /**
   * Check permission
   */
  async hasPermission(userId: string, resource: string, action: string, organizationId?: string): Promise<boolean> {
    // Get user roles
    const userRoles = await prisma.userRole.findMany({
      where: {
        userId,
        ...(organizationId && { organizationId })
      },
      include: {
        role: true
      }
    });

    // Check if any role has the permission
    for (const userRole of userRoles) {
      const permissions = userRole.role.permissions;
      const hasPermission = permissions.some((p: string) => {
        if (typeof p === 'string') {
          return p === `${resource}.${action}` || p === `${resource}.*` || p === '*';
        }
        return false;
      });

      if (hasPermission) return true;
    }

    return false;
  }

  /**
   * Create API key
   */
  async createAPIKey(data: {
    name: string;
    userId: string;
    organizationId: string;
    scopes: string[];
    expiresAt?: Date;
  }) {
    const key = this.generateAPIKey();
    const keyHash = await this.hashAPIKey(key);

    const apiKey = await prisma.apiKey.create({
      data: {
        name: data.name,
        keyHash,
        userId: data.userId,
        organizationId: data.organizationId,
        scopes: data.scopes,
        expiresAt: data.expiresAt,
        isActive: true
      }
    });

    await eventBus.publish('apikey.created', { id: apiKey.id, name: data.name }, 'IdentityOS');

    return { apiKey, key };
  }

  /**
   * Validate API key
   */
  async validateAPIKey(key: string): Promise<{ valid: boolean; apiKey?: APIKey }> {
    const keyHash = await this.hashAPIKey(key);
    
    const apiKey = await prisma.apiKey.findUnique({
      where: { keyHash },
      include: {
        user: true,
        organization: true
      }
    });

    if (!apiKey || !apiKey.isActive) {
      return { valid: false };
    }

    if (apiKey.expiresAt && apiKey.expiresAt < new Date()) {
      return { valid: false };
    }

    // Update last used
    await prisma.apiKey.update({
      where: { id: apiKey.id },
      data: { lastUsedAt: new Date() }
    });

    return { valid: true, apiKey };
  }

  /**
   * Create session
   */
  async createSession(userId: string, deviceInfo?: {
    userAgent: string;
    ip: string;
    deviceType: string;
  }) {
    const token = this.generateToken();
    const refreshToken = this.generateToken();
    
    const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours

    const session = await prisma.session.create({
      data: {
        userId,
        token,
        refreshToken,
        deviceInfo,
        expiresAt
      }
    });

    // Register device if new
    if (deviceInfo) {
      await this.registerDevice(userId, deviceInfo);
    }

    await eventBus.publish('session.created', { userId, sessionId: session.id }, 'IdentityOS');

    return session;
  }

  /**
   * Validate session
   */
  async validateSession(token: string): Promise<{ valid: boolean; session?: Session; user?: any }> {
    const session = await prisma.session.findUnique({
      where: { token },
      include: {
        user: true
      }
    });

    if (!session || session.expiresAt < new Date()) {
      return { valid: false };
    }

    return { valid: true, session, user: session.user };
  }

  /**
   * Revoke session
   */
  async revokeSession(sessionId: string) {
    await prisma.session.update({
      where: { id: sessionId },
      data: { expiresAt: new Date() }
    });

    await eventBus.publish('session.revoked', { sessionId }, 'IdentityOS');
  }

  /**
   * Register device
   */
  async registerDevice(userId: string, deviceInfo: {
    userAgent: string;
    ip: string;
    deviceType: string;
  }) {
    const deviceIdentifier = await this.generateDeviceIdentifier(deviceInfo);

    const existing = await prisma.device.findFirst({
      where: {
        userId,
        deviceIdentifier
      }
    });

    if (existing) {
      return prisma.device.update({
        where: { id: existing.id },
        data: {
          lastSeenAt: new Date(),
          deviceName: deviceInfo.userAgent
        }
      });
    }

    return prisma.device.create({
      data: {
        userId,
        deviceType: deviceInfo.deviceType,
        deviceName: deviceInfo.userAgent,
        deviceIdentifier,
        isTrusted: false,
        lastSeenAt: new Date()
      }
    });
  }

  /**
   * Trust device
   */
  async trustDevice(deviceId: string) {
    return prisma.device.update({
      where: { id: deviceId },
      data: { isTrusted: true }
    });
  }

  /**
   * Get user permissions
   */
  async getUserPermissions(userId: string, organizationId?: string): Promise<string[]> {
    const userRoles = await prisma.userRole.findMany({
      where: {
        userId,
        ...(organizationId && { organizationId })
      },
      include: {
        role: true
      }
    });

    const permissions = new Set<string>();
    userRoles.forEach((userRole: any) => {
      userRole.role.permissions.forEach((p: string) => permissions.add(p));
    });

    return Array.from(permissions);
  }

  /**
   * RBAC check with conditions
   */
  async checkAccess(userId: string, resource: string, action: string, context?: Record<string, any>): Promise<boolean> {
    const hasPermission = await this.hasPermission(userId, resource, action);
    if (!hasPermission) return false;

    TODO: // Implement ABAC (Attribute-Based Access Control) conditions
    // Check additional conditions based on context
    // e.g., user can only access resources they own
    
    return true;
  }

  /**
   * Risk-based login check
   */
  async assessLoginRisk(userId: string, loginContext: {
    ip: string;
    userAgent: string;
    location?: string;
  }): Promise<{ risk: 'low' | 'medium' | 'high'; requireMFA: boolean }> {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: {
        devices: true,
        sessions: {
          where: {
            createdAt: { gte: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000) }
          }
        }
      }
    });

    if (!user) {
      return { risk: 'high', requireMFA: true };
    }

    let riskScore = 0;

    // Check if device is trusted
    const deviceIdentifier = await this.generateDeviceIdentifier(loginContext);
    const trustedDevice = user.devices.find((d: any) => d.deviceIdentifier === deviceIdentifier && d.isTrusted);
    if (!trustedDevice) {
      riskScore += 30;
    }

    // Check for unusual location (would use IP geolocation in production)
    if (loginContext.location) {
      // Compare with recent sessions
      const recentLocations = new Set(user.sessions.map((s: any) => s.deviceInfo?.ip));
      if (!recentLocations.has(loginContext.ip)) {
        riskScore += 20;
      }
    }

    // Determine risk level
    if (riskScore >= 50) {
      return { risk: 'high', requireMFA: true };
    } else if (riskScore >= 20) {
      return { risk: 'medium', requireMFA: true };
    }

    return { risk: 'low', requireMFA: false };
  }

  /**
   * Enable SSO for organization
   */
  async enableSSO(organizationId: string, provider: string, config: Record<string, any>) {
    return prisma.organization.update({
      where: { id: organizationId },
      data: {
        ssoEnabled: true,
        ssoProvider: provider,
        settings: {
          ...config,
          ssoConfig: config
        }
      }
    });
  }

  /**
   * Get identity graph
   */
  async getIdentityGraph(userId: string) {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: {
        organizations: {
          include: {
            organization: true
          }
        },
        roles: {
          include: {
            role: true
          }
        },
        teams: true,
        devices: true,
        sessions: {
          where: {
            expiresAt: { gte: new Date() }
          },
          take: 10
        }
      }
    });

    return user;
  }

  /**
   * Audit identity events
   */
  async logIdentityEvent(event: {
    userId: string;
    eventType: string;
    details: Record<string, any>;
    ipAddress?: string;
    userAgent?: string;
  }) {
    await prisma.auditLog.create({
      data: {
        userId: event.userId,
        action: event.eventType,
        details: event.details,
        ipAddress: event.ipAddress,
        userAgent: event.userAgent,
        timestamp: new Date()
      }
    });

    await eventBus.publish('identity.event_logged', event, 'IdentityOS');
  }

  /**
   * Add user to organization
   */
  private async addUserToOrganization(userId: string, organizationId: string, role: string) {
    return prisma.userOrganization.create({
      data: {
        userId,
        organizationId,
        role
      }
    });
  }

  /**
   * Create default roles for organization
   */
  private async createDefaultRoles(organizationId: string) {
    const defaultRoles = [
      {
        name: 'Admin',
        description: 'Full access to all resources',
        permissions: ['*'],
        organizationId,
        isSystem: false
      },
      {
        name: 'Agent',
        description: 'Agent access to listings and deals',
        permissions: [
          'listing.read',
          'listing.write',
          'deal.read',
          'deal.write',
          'property.read'
        ],
        organizationId,
        isSystem: false
      },
      {
        name: 'Viewer',
        description: 'Read-only access',
        permissions: [
          'listing.read',
          'deal.read',
          'property.read'
        ],
        organizationId,
        isSystem: false
      }
    ];

    await Promise.all(
      defaultRoles.map(role => this.createRole(role))
    );
  }

  /**
   * Generate slug from name
   */
  private generateSlug(name: string): string {
    return name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/(^-|-$)/g, '');
  }

  /**
   * Generate API key
   */
  private generateAPIKey(): string {
    const prefix = 'res_';
    const random = Array.from(crypto.getRandomValues(new Uint8Array(32))).map(b => b.toString(16).padStart(2, '0')).join('');
    return `${prefix}${random}`;
  }

  /**
   * Hash API key
   */
  private async hashAPIKey(key: string): Promise<string> {
    // In production, use proper hashing (bcrypt, argon2)
    const encoder = new TextEncoder();
    const data = encoder.encode(key);
    const hash = await crypto.subtle.digest('SHA-256', data);
    return Array.from(new Uint8Array(hash)).map(b => b.toString(16).padStart(2, '0')).join('');
  }

  /**
   * Generate token
   */
  private generateToken(): string {
    return Array.from(crypto.getRandomValues(new Uint8Array(32))).map(b => b.toString(16).padStart(2, '0')).join('');
  }

  /**
   * Generate device identifier
   */
  private async generateDeviceIdentifier(deviceInfo: { userAgent: string; ip: string }): Promise<string> {
    const encoder = new TextEncoder();
    const data = encoder.encode(`${deviceInfo.userAgent}|${deviceInfo.ip}`);
    const hash = await crypto.subtle.digest('SHA-256', data);
    return Array.from(new Uint8Array(hash)).map(b => b.toString(16).padStart(2, '0')).join('');
  }
}

export const identityOSService = new IdentityOSService();
