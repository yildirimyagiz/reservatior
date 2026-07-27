import { getLocalizationHeaders } from './localization-helper';

export const identityOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/identity-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch identity OS dashboard stats');
    return res.json();
  },

  createOrganization: async (data: {
    name: string;
    type: 'agency' | 'property_management' | 'investment_firm' | 'individual';
    userId: string;
    parentId?: string;
  }) => {
    const res = await fetch('/api/v1/identity-os/organizations', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create organization');
    return res.json();
  },

  createTeam: async (data: {
    organizationId: string;
    name: string;
    description?: string;
    parentId?: string;
    permissions?: string[];
  }) => {
    const res = await fetch('/api/v1/identity-os/teams', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create team');
    return res.json();
  },

  createRole: async (data: {
    name: string;
    description?: string;
    permissions: string[];
    organizationId?: string;
    isSystem?: boolean;
  }) => {
    const res = await fetch('/api/v1/identity-os/roles', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create role');
    return res.json();
  },

  assignRoleToUser: async (userId: string, roleId: string, organizationId: string) => {
    const res = await fetch('/api/v1/identity-os/roles/assign', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ userId, roleId, organizationId }),
    });
    if (!res.ok) throw new Error('Failed to assign role to user');
    return res.json();
  },

  hasPermission: async (userId: string, resource: string, action: string, organizationId?: string) => {
    const params = new URLSearchParams({ userId, resource, action });
    if (organizationId) params.append('organizationId', organizationId);
    const res = await fetch(`/api/v1/identity-os/permissions/check?${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to check permission');
    return res.json();
  },

  createAPIKey: async (data: {
    name: string;
    userId: string;
    organizationId: string;
    scopes: string[];
    expiresAt?: string;
  }) => {
    const res = await fetch('/api/v1/identity-os/api-keys', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to create API key');
    return res.json();
  },

  validateAPIKey: async (key: string) => {
    const res = await fetch('/api/v1/identity-os/api-keys/validate', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ key }),
    });
    if (!res.ok) throw new Error('Failed to validate API key');
    return res.json();
  },

  createSession: async (userId: string, deviceInfo?: {
    userAgent: string;
    ip: string;
    deviceType: string;
  }) => {
    const res = await fetch('/api/v1/identity-os/sessions', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ userId, deviceInfo }),
    });
    if (!res.ok) throw new Error('Failed to create session');
    return res.json();
  },

  validateSession: async (token: string) => {
    const res = await fetch(`/api/v1/identity-os/sessions/validate?token=${token}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to validate session');
    return res.json();
  },

  revokeSession: async (sessionId: string) => {
    const res = await fetch(`/api/v1/identity-os/sessions/${sessionId}/revoke`, {
      method: 'POST',
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to revoke session');
    return res.json();
  },

  trustDevice: async (deviceId: string) => {
    const res = await fetch(`/api/v1/identity-os/devices/${deviceId}/trust`, {
      method: 'POST',
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to trust device');
    return res.json();
  },

  getUserPermissions: async (userId: string, organizationId?: string) => {
    const params = new URLSearchParams({ userId });
    if (organizationId) params.append('organizationId', organizationId);
    const res = await fetch(`/api/v1/identity-os/users/permissions?${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch user permissions');
    return res.json();
  },

  assessLoginRisk: async (userId: string, loginContext: {
    ip: string;
    userAgent: string;
    location?: string;
  }) => {
    const res = await fetch(`/api/v1/identity-os/users/${userId}/login-risk`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(loginContext),
    });
    if (!res.ok) throw new Error('Failed to assess login risk');
    return res.json();
  },

  enableSSO: async (organizationId: string, provider: string, config: Record<string, any>) => {
    const res = await fetch(`/api/v1/identity-os/organizations/${organizationId}/sso`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ provider, config }),
    });
    if (!res.ok) throw new Error('Failed to enable SSO');
    return res.json();
  },

  getIdentityGraph: async (userId: string) => {
    const res = await fetch(`/api/v1/identity-os/users/${userId}/identity-graph`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch identity graph');
    return res.json();
  },

  getVerificationTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/identity-os/verification-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch verification trends');
    return res.json();
  },

  getIdentityTypes: async (orgId: string) => {
    const res = await fetch(`/api/v1/identity-os/identity-types?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch identity types');
    return res.json();
  },
};
