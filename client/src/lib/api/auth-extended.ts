import { apiClient } from "./client";

export interface AuthExtended {
  id: string;
  orgId: string;
  userId: string;
  sessionId: string;
  loginType: "PASSWORD" | "SSO" | "OAUTH" | "API_KEY" | "SOCIAL" | "TWO_FACTOR" | "BIOMETRIC" | "MAGIC_LINK";
  authProvider?: string;
  ipAddress: string;
  userAgent: string;
  device?: {
    type: "DESKTOP" | "MOBILE" | "TABLET" | "UNKNOWN";
    os?: string;
    browser?: string;
    version?: string;
    fingerprint?: string;
  };
  location?: {
    country?: string;
    region?: string;
    city?: string;
    latitude?: number;
    longitude?: number;
    timezone?: string;
  };
  security: {
    twoFactorEnabled: boolean;
    twoFactorMethod?: "SMS" | "EMAIL" | "TOTP" | "PUSH" | "HARDWARE";
    passwordStrength?: "WEAK" | "FAIR" | "GOOD" | "STRONG";
    lastPasswordChange?: string;
    failedAttempts: number;
    lockedUntil?: string;
    riskScore: number;
    riskFactors?: Array<{
      type: string;
      severity: "LOW" | "MEDIUM" | "HIGH";
      description: string;
    }>;
  };
  permissions: Array<{
    id: string;
    name: string;
    resource: string;
    actions: Array<string>;
    grantedAt: string;
    expiresAt?: string;
  }>;
  tokens: Array<{
    type: "ACCESS" | "REFRESH" | "SESSION" | "API_KEY" | "MAGIC_LINK";
    value: string;
    expiresAt: string;
    scopes: Array<string>;
    lastUsedAt?: string;
    isActive: boolean;
    device?: string;
    ipAddress?: string;
  }>;
  createdAt: string;
  updatedAt: string;
  lastActivityAt?: string;
  expiresAt?: string;
  isActive: boolean;
  user?: {
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    avatar?: string;
  };
}

export const authExtendedApi = {
  // Get all auth sessions
  getAll: async (orgId: string): Promise<AuthExtended[]> => {
    const response = await apiClient.get<AuthExtended[]>(`/organizations/${orgId}/auth-extended`);
    return response;
  },

  // Get auth session by ID
  getById: async (orgId: string, id: string): Promise<AuthExtended> => {
    const response = await apiClient.get<AuthExtended>(`/organizations/${orgId}/auth-extended/${id}`);
    return response;
  },

  // Get auth sessions by user
  getByUser: async (orgId: string, userId: string): Promise<AuthExtended[]> => {
    const response = await apiClient.get<AuthExtended[]>(`/organizations/${orgId}/users/${userId}/auth-extended`);
    return response;
  },

  // Terminate auth session
  terminate: async (orgId: string, id: string, data?: {
    reason: string;
    notifyUser?: boolean;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/auth-extended/${id}/terminate`, data);
  },

  // Terminate all user sessions
  terminateAllUserSessions: async (orgId: string, userId: string, data?: {
    reason: string;
    notifyUser?: boolean;
    excludeCurrent?: boolean;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/users/${userId}/auth-extended/terminate-all`, data);
  },

  // Get active sessions
  getActiveSessions: async (orgId: string, userId?: string): Promise<AuthExtended[]> => {
    const response = await apiClient.get<AuthExtended[]>(`/organizations/${orgId}/auth-extended/active`, {
      params: { userId }
    });
    return response;
  },

  // Get session analytics
  getAnalytics: async (orgId: string, filters?: {
    userId?: string;
    loginType?: AuthExtended['loginType'];
    startDate?: string;
    endDate?: string;
    deviceType?: "DESKTOP" | "MOBILE" | "TABLET" | "UNKNOWN";
  }): Promise<{
    totalSessions: number;
    uniqueUsers: number;
    averageSessionDuration: number;
    successRate: number;
    byLoginType: Record<string, number>;
    byDeviceType: Record<string, number>;
    byLocation: Array<{
      country: string;
      city: string;
      sessions: number;
      users: number;
    }>;
    securityEvents: Array<{
      type: string;
      count: number;
      severity: string;
    }>;
    trends: Array<{
      date: string;
      sessions: number;
      users: number;
      successRate: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    totalSessions: number;
    uniqueUsers: number;
    averageSessionDuration: number;
    successRate: number;
    byLoginType: Record<string, number>;
    byDeviceType: Record<string, number>;
    byLocation: Array<{
      country: string;
      city: string;
      sessions: number;
      users: number;
    }>;
    securityEvents: Array<{
      type: string;
      count: number;
      severity: string;
    }>;
    trends: Array<{
      date: string;
      sessions: number;
      users: number;
      successRate: number;
    }>;
  }>(`/organizations/${orgId}/auth-extended/analytics`, {
      params: { ...filters }
    });
    return response;
  },

  // Update session security
  updateSecurity: async (orgId: string, id: string, data: {
    twoFactorEnabled?: boolean;
    twoFactorMethod?: AuthExtended['security']['twoFactorMethod'];
    riskScore?: number;
    notes?: string;
  }): Promise<AuthExtended> => {
    const response = await apiClient.patch<AuthExtended>(`/organizations/${orgId}/auth-extended/${id}/security`, data);
    return response;
  },

  // Force password change
  forcePasswordChange: async (orgId: string, userId: string, data: {
    reason: string;
    temporaryPassword?: string;
    requireChangeOnNextLogin: boolean;
    notifyUser?: boolean;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/users/${userId}/auth-extended/force-password-change`, data);
  },

  // Get security events
  getSecurityEvents: async (orgId: string, filters?: {
    userId?: string;
    type?: string;
    severity?: string;
    startDate?: string;
    endDate?: string;
  }): Promise<Array<{
    id: string;
    userId: string;
    type: string;
    severity: "INFO" | "WARNING" | "ERROR" | "CRITICAL";
    description: string;
    details?: Record<string, any>;
    ipAddress: string;
    userAgent: string;
    timestamp: string;
    resolved?: boolean;
    resolvedAt?: string;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    userId: string;
    type: string;
    severity: "INFO" | "WARNING" | "ERROR" | "CRITICAL";
    description: string;
    details?: Record<string, any>;
    ipAddress: string;
    userAgent: string;
    timestamp: string;
    resolved?: boolean;
    resolvedAt?: string;
  }>>(`/organizations/${orgId}/auth-extended/security-events`, {
      params: { ...filters }
    });
    return response;
  },

  // Create security event
  createSecurityEvent: async (orgId: string, data: {
    userId: string;
    type: string;
    severity: "INFO" | "WARNING" | "ERROR" | "CRITICAL";
    description: string;
    details?: Record<string, any>;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/auth-extended/security-events`, data);
  },

  // Get device management
  getDeviceManagement: async (orgId: string, userId?: string): Promise<{
    registeredDevices: Array<{
      id: string;
      userId?: string;
      name: string;
      type: "DESKTOP" | "MOBILE" | "TABLET" | "UNKNOWN";
      os?: string;
      browser?: string;
      fingerprint: string;
      lastSeenAt: string;
      isActive: boolean;
      trusted: boolean;
      notifications: boolean;
    }>;
    deviceLimits: {
      maxDevices: number;
      currentDevices: number;
      allowMultiple: boolean;
    };
    securityPolicies: {
      requireTrustedDevice: boolean;
      autoCleanupDays: number;
      blockUnrecognizedDevices: boolean;
    };
  }> => {
    const response = await apiClient.get<{
    registeredDevices: Array<{
      id: string;
      userId?: string;
      name: string;
      type: "DESKTOP" | "MOBILE" | "TABLET" | "UNKNOWN";
      os?: string;
      browser?: string;
      fingerprint: string;
      lastSeenAt: string;
      isActive: boolean;
      trusted: boolean;
      notifications: boolean;
    }>;
    deviceLimits: {
      maxDevices: number;
      currentDevices: number;
      allowMultiple: boolean;
    };
    securityPolicies: {
      requireTrustedDevice: boolean;
      autoCleanupDays: number;
      blockUnrecognizedDevices: boolean;
    };
  }>(`/organizations/${orgId}/auth-extended/device-management`, {
      params: { userId }
    });
    return response;
  },

  // Register device
  registerDevice: async (orgId: string, data: {
    name: string;
    type: "DESKTOP" | "MOBILE" | "TABLET" | "UNKNOWN";
    os?: string;
    browser?: string;
    fingerprint: string;
    trusted?: boolean;
    notifications?: boolean;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/auth-extended/register-device`, data);
  },

  // Update device
  updateDevice: async (orgId: string, deviceId: string, data: {
    name?: string;
    trusted?: boolean;
    notifications?: boolean;
    isActive?: boolean;
  }): Promise<void> => {
    await apiClient.put(`/organizations/${orgId}/auth-extended/devices/${deviceId}`, data);
  },

  // Remove device
  removeDevice: async (orgId: string, deviceId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/auth-extended/devices/${deviceId}`);
  },

  // Get token management
  getTokenManagement: async (orgId: string, userId?: string): Promise<{
    activeTokens: Array<{
      id: string;
      type: "ACCESS" | "REFRESH" | "SESSION" | "API_KEY" | "MAGIC_LINK";
      scopes: Array<string>;
      expiresAt: string;
      lastUsedAt?: string;
      device?: string;
      ipAddress?: string;
    }>;
    revokedTokens: Array<{
      id: string;
      type: "ACCESS" | "REFRESH" | "SESSION" | "API_KEY" | "MAGIC_LINK";
      revokedAt: string;
      reason?: string;
      revokedBy?: string;
    }>;
    tokenPolicies: {
      maxTokens: number;
      tokenLifetime: number;
      refreshTokenLifetime: number;
      allowMultipleSessions: boolean;
      requireDeviceVerification: boolean;
    };
  }> => {
    const response = await apiClient.get<{
    activeTokens: Array<{
      id: string;
      type: "ACCESS" | "REFRESH" | "SESSION" | "API_KEY" | "MAGIC_LINK";
      scopes: Array<string>;
      expiresAt: string;
      lastUsedAt?: string;
      device?: string;
      ipAddress?: string;
    }>;
    revokedTokens: Array<{
      id: string;
      type: "ACCESS" | "REFRESH" | "SESSION" | "API_KEY" | "MAGIC_LINK";
      revokedAt: string;
      reason?: string;
      revokedBy?: string;
    }>;
    tokenPolicies: {
      maxTokens: number;
      tokenLifetime: number;
      refreshTokenLifetime: number;
      allowMultipleSessions: boolean;
      requireDeviceVerification: boolean;
    };
  }>(`/organizations/${orgId}/auth-extended/token-management`, {
      params: { userId }
    });
    return response;
  },

  // Revoke token
  revokeToken: async (orgId: string, tokenId: string, data: {
    reason: string;
    notifyUser?: boolean;
  }): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/auth-extended/tokens/${tokenId}/revoke`, data);
  },

  // Refresh token
  refreshToken: async (orgId: string, refreshToken: string): Promise<{
    accessToken: string;
    refreshToken: string;
    expiresAt: string;
    scopes: Array<string>;
  }> => {
    const response = await apiClient.post<{
    accessToken: string;
    refreshToken: string;
    expiresAt: string;
    scopes: Array<string>;
  }>(`/organizations/${orgId}/auth-extended/refresh-token`, { refreshToken });
    return response;
  },

  // Get auth settings
  getSettings: async (orgId: string): Promise<{
    passwordPolicy: {
      minLength: number;
      requireUppercase: boolean;
      requireLowercase: boolean;
      requireNumbers: boolean;
      requireSpecialChars: boolean;
      preventReuse: number;
      expireDays: number;
    };
    twoFactorPolicy: {
      required: boolean;
      methods: Array<"SMS" | "EMAIL" | "TOTP" | "PUSH" | "HARDWARE">;
      gracePeriod: number;
      backupCodes: boolean;
    };
    sessionPolicy: {
      maxSessions: number;
      sessionTimeout: number;
      idleTimeout: number;
      requireReauth: boolean;
    };
    devicePolicy: {
      requireTrusted: boolean;
      maxDevices: number;
      autoCleanup: number;
    };
    securityPolicy: {
      lockoutAttempts: number;
      lockoutDuration: number;
      riskThreshold: number;
      requireLocation: boolean;
      requireDeviceVerification: boolean;
    };
  }> => {
    const response = await apiClient.get<{
    passwordPolicy: {
      minLength: number;
      requireUppercase: boolean;
      requireLowercase: boolean;
      requireNumbers: boolean;
      requireSpecialChars: boolean;
      preventReuse: number;
      expireDays: number;
    };
    twoFactorPolicy: {
      required: boolean;
      methods: Array<"SMS" | "EMAIL" | "TOTP" | "PUSH" | "HARDWARE">;
      gracePeriod: number;
      backupCodes: boolean;
    };
    sessionPolicy: {
      maxSessions: number;
      sessionTimeout: number;
      idleTimeout: number;
      requireReauth: boolean;
    };
    devicePolicy: {
      requireTrusted: boolean;
      maxDevices: number;
      autoCleanup: number;
    };
    securityPolicy: {
      lockoutAttempts: number;
      lockoutDuration: number;
      riskThreshold: number;
      requireLocation: boolean;
      requireDeviceVerification: boolean;
    };
  }>(`/organizations/${orgId}/auth-extended/settings`);
    return response;
  },

  // Update auth settings
  updateSettings: async (orgId: string, data: {
    passwordPolicy?: any;
    twoFactorPolicy?: any;
    sessionPolicy?: any;
    devicePolicy?: any;
    securityPolicy?: any;
  }): Promise<void> => {
    await apiClient.put(`/organizations/${orgId}/auth-extended/settings`, data);
  },
};
