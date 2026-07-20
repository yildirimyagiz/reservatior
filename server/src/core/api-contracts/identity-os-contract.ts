/**
 * Identity OS API Contract
 * Defines the API interface for Identity OS operations
 */

export interface IdentityOSAPIContract {
  // Organization Operations
  createOrganization(params: CreateOrganizationParams): Promise<OrganizationResponse>;
  getOrganization(organizationId: string): Promise<OrganizationResponse>;
  updateOrganization(organizationId: string, params: UpdateOrganizationParams): Promise<OrganizationResponse>;
  deleteOrganization(organizationId: string): Promise<void>;
  
  // Team Operations
  createTeam(params: CreateTeamParams): Promise<TeamResponse>;
  getTeam(teamId: string): Promise<TeamResponse>;
  updateTeam(teamId: string, params: UpdateTeamParams): Promise<TeamResponse>;
  deleteTeam(teamId: string): Promise<void>;
  addTeamMember(teamId: string, userId: string): Promise<void>;
  removeTeamMember(teamId: string, userId: string): Promise<void>;
  
  // Role Operations
  createRole(params: CreateRoleParams): Promise<RoleResponse>;
  getRole(roleId: string): Promise<RoleResponse>;
  updateRole(roleId: string, params: UpdateRoleParams): Promise<RoleResponse>;
  deleteRole(roleId: string): Promise<void>;
  assignRole(userId: string, roleId: string, organizationId: string): Promise<void>;
  removeRole(userId: string, roleId: string, organizationId: string): Promise<void>;
  
  // Permission Operations
  createPermission(params: CreatePermissionParams): Promise<PermissionResponse>;
  getPermission(permissionId: string): Promise<PermissionResponse>;
  updatePermission(permissionId: string, params: UpdatePermissionParams): Promise<PermissionResponse>;
  deletePermission(permissionId: string): Promise<void>;
  
  // User Operations
  createUser(params: CreateUserParams): Promise<UserResponse>;
  getUser(userId: string): Promise<UserResponse>;
  updateUser(userId: string, params: UpdateUserParams): Promise<UserResponse>;
  deleteUser(userId: string): Promise<void>;
  getUserPermissions(userId: string, organizationId?: string): Promise<PermissionResponse[]>;
  
  // Session Operations
  createSession(userId: string, deviceInfo?: DeviceInfo): Promise<SessionResponse>;
  getSession(sessionId: string): Promise<SessionResponse>;
  validateSession(token: string): Promise<SessionResponse>;
  revokeSession(sessionId: string): Promise<void>;
  getUserSessions(userId: string): Promise<SessionResponse[]>;
  
  // Device Operations
  registerDevice(userId: string, deviceInfo: DeviceInfo): Promise<DeviceResponse>;
  trustDevice(deviceId: string): Promise<DeviceResponse>;
  revokeDevice(deviceId: string): Promise<void>;
  getUserDevices(userId: string): Promise<DeviceResponse[]>;
  
  // API Key Operations
  createAPIKey(params: CreateAPIKeyParams): Promise<APIKeyResponse>;
  getAPIKey(keyId: string): Promise<APIKeyResponse>;
  validateAPIKey(key: string): Promise<APIKeyResponse>;
  revokeAPIKey(keyId: string): Promise<void>;
  getUserAPIKeys(userId: string): Promise<APIKeyResponse[]>;
  
  // SSO Operations
  enableSSO(organizationId: string, provider: string, config: Record<string, any>): Promise<SSOResponse>;
  disableSSO(organizationId: string, provider: string): Promise<void>;
  getSSOConfig(organizationId: string): Promise<SSOResponse>;
  
  // Audit Operations
  getAuditLogs(params: AuditLogParams): Promise<AuditLogResponse[]>;
  exportAuditLogs(params: AuditLogParams): Promise<ExportResponse>;
  
  // Identity Graph Operations
  getIdentityGraph(userId: string): Promise<IdentityGraphResponse>;
  analyzeIdentityGraph(userId: string): Promise<GraphAnalysisResponse>;
}

// Request/Response Types
export interface CreateOrganizationParams {
  name: string;
  type: 'agency' | 'property_management' | 'investment_firm' | 'individual';
  userId: string;
  parentId?: string;
  settings?: Record<string, any>;
}

export interface UpdateOrganizationParams {
  name?: string;
  settings?: Record<string, any>;
}

export interface OrganizationResponse {
  id: string;
  name: string;
  type: string;
  parentId?: string;
  settings: Record<string, any>;
  status: 'active' | 'suspended' | 'deleted';
  createdAt: string;
  updatedAt: string;
}

export interface CreateTeamParams {
  organizationId: string;
  name: string;
  description?: string;
  parentId?: string;
  permissions?: string[];
}

export interface UpdateTeamParams {
  name?: string;
  description?: string;
  permissions?: string[];
}

export interface TeamResponse {
  id: string;
  organizationId: string;
  name: string;
  description?: string;
  parentId?: string;
  permissions: string[];
  memberCount: number;
  createdAt: string;
  updatedAt: string;
}

export interface CreateRoleParams {
  name: string;
  description?: string;
  permissions: string[];
  organizationId?: string;
  isSystem?: boolean;
}

export interface UpdateRoleParams {
  name?: string;
  description?: string;
  permissions?: string[];
}

export interface RoleResponse {
  id: string;
  name: string;
  description?: string;
  permissions: string[];
  organizationId?: string;
  isSystem: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface CreatePermissionParams {
  name: string;
  description?: string;
  resource: string;
  action: string;
}

export interface UpdatePermissionParams {
  name?: string;
  description?: string;
}

export interface PermissionResponse {
  id: string;
  name: string;
  description?: string;
  resource: string;
  action: string;
  createdAt: string;
  updatedAt: string;
}

export interface CreateUserParams {
  email: string;
  name: string;
  organizationId: string;
  roleIds?: string[];
}

export interface UpdateUserParams {
  name?: string;
  email?: string;
  status?: string;
}

export interface UserResponse {
  id: string;
  email: string;
  name: string;
  organizationId: string;
  roles: RoleResponse[];
  status: 'active' | 'suspended' | 'deleted';
  createdAt: string;
  updatedAt: string;
}

export interface DeviceInfo {
  userAgent: string;
  ip: string;
  deviceType: string;
  location?: string;
}

export interface SessionResponse {
  id: string;
  userId: string;
  deviceInfo: DeviceInfo;
  createdAt: string;
  expiresAt: string;
  lastActivity: string;
  status: 'active' | 'expired' | 'revoked';
}

export interface DeviceResponse {
  id: string;
  userId: string;
  deviceInfo: DeviceInfo;
  trusted: boolean;
  lastUsed: string;
  createdAt: string;
}

export interface CreateAPIKeyParams {
  name: string;
  userId: string;
  organizationId: string;
  scopes: string[];
  expiresAt?: string;
}

export interface APIKeyResponse {
  id: string;
  name: string;
  userId: string;
  organizationId: string;
  scopes: string[];
  key: string;
  expiresAt?: string;
  createdAt: string;
  status: 'active' | 'revoked' | 'expired';
}

export interface SSOResponse {
  organizationId: string;
  provider: string;
  config: Record<string, any>;
  enabled: boolean;
  configuredAt: string;
}

export interface AuditLogParams {
  organizationId?: string;
  userId?: string;
  action?: string;
  resource?: string;
  startDate?: string;
  endDate?: string;
  limit?: number;
}

export interface AuditLogResponse {
  id: string;
  userId: string;
  action: string;
  resource: string;
  details: Record<string, any>;
  timestamp: string;
  ipAddress: string;
}

export interface ExportResponse {
  exportId: string;
  status: 'processing' | 'completed' | 'failed';
  downloadUrl?: string;
  format: string;
  recordCount?: number;
}

export interface IdentityGraphResponse {
  userId: string;
  connections: Array<{
    userId: string;
    relationship: string;
    strength: number;
  }>;
  organizations: Array<{
    organizationId: string;
    role: string;
  }>;
}

export interface GraphAnalysisResponse {
  centralityScore: number;
  influenceScore: number;
  clusterMembership: string;
  recommendations: string[];
}
