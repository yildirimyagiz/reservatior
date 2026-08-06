/**
 * Permission-Based API Access Control Matrix
 * Defines granular permissions for all API resources
 * Role-based access control with resource-level permissions
 */

export enum Resource {
  // Properties
  PROPERTY_VIEW = 'property:view',
  PROPERTY_CREATE = 'property:create',
  PROPERTY_UPDATE = 'property:update',
  PROPERTY_DELETE = 'property:delete',
  PROPERTY_CLAIM = 'property:claim',
  
  // Agents
  AGENT_VIEW = 'agent:view',
  AGENT_CREATE = 'agent:create',
  AGENT_UPDATE = 'agent:update',
  AGENT_DELETE = 'agent:delete',
  AGENT_ASSIGN = 'agent:assign',
  
  // Agencies
  AGENCY_VIEW = 'agency:view',
  AGENCY_CREATE = 'agency:create',
  AGENCY_UPDATE = 'agency:update',
  AGENCY_DELETE = 'agency:delete',
  AGENCY_MANAGE = 'agency:manage',
  
  // Leads
  LEAD_VIEW = 'lead:view',
  LEAD_CREATE = 'lead:create',
  LEAD_UPDATE = 'lead:update',
  LEAD_DELETE = 'lead:delete',
  LEAD_CONVERT = 'lead:convert',
  LEAD_ASSIGN = 'lead:assign',
  
  // Contracts
  CONTRACT_VIEW = 'contract:view',
  CONTRACT_CREATE = 'contract:create',
  CONTRACT_UPDATE = 'contract:update',
  CONTRACT_DELETE = 'contract:delete',
  CONTRACT_SIGN = 'contract:sign',
  
  // Documents
  DOCUMENT_VIEW = 'document:view',
  DOCUMENT_CREATE = 'document:create',
  DOCUMENT_UPDATE = 'document:update',
  DOCUMENT_DELETE = 'document:delete',
  DOCUMENT_UPLOAD = 'document:upload',
  
  // Financials
  FINANCIAL_VIEW = 'financial:view',
  FINANCIAL_CREATE = 'financial:create',
  FINANCIAL_UPDATE = 'financial:update',
  FINANCIAL_DELETE = 'financial:delete',
  FINANCIAL_APPROVE = 'financial:approve',
  
  // Users
  USER_VIEW = 'user:view',
  USER_CREATE = 'user:create',
  USER_UPDATE = 'user:update',
  USER_DELETE = 'user:delete',
  USER_MANAGE = 'user:manage',
  
  // Admin
  ADMIN_VIEW = 'admin:view',
  ADMIN_CONFIG = 'admin:config',
  ADMIN_AUDIT = 'admin:audit',
  ADMIN_SYSTEM = 'admin:system',
  
  // AI
  AI_VIEW = 'ai:view',
  AI_GENERATE = 'ai:generate',
  AI_TRAIN = 'ai:train',
  AI_DEPLOY = 'ai部署',
  
  // Analytics
  ANALYTICS_VIEW = 'analytics:view',
  ANALYTICS_EXPORT = 'analytics:export',
  ANALYTICS_ADVANCED = 'analytics:advanced',
}

// Role-based permission sets
export const ROLE_PERMISSIONS: Record<string, Resource[]> = {
  SUPER_ADMIN: [
    // All permissions
    ...Object.values(Resource),
  ],
  
  SYSTEM_ADMIN: [
    Resource.ADMIN_VIEW,
    Resource.ADMIN_CONFIG,
    Resource.ADMIN_AUDIT,
    Resource.ADMIN_SYSTEM,
    Resource.ANALYTICS_VIEW,
    Resource.ANALYTICS_EXPORT,
    Resource.ANALYTICS_ADVANCED,
  ],
  
  AGENCY_ADMIN: [
    // Agency management
    Resource.AGENCY_VIEW,
    Resource.AGENCY_UPDATE,
    Resource.AGENCY_MANAGE,
    
    // Agent management
    Resource.AGENT_VIEW,
    Resource.AGENT_CREATE,
    Resource.AGENT_UPDATE,
    Resource.AGENT_DELETE,
    Resource.AGENT_ASSIGN,
    
    // Leads
    Resource.LEAD_VIEW,
    Resource.LEAD_CREATE,
    Resource.LEAD_UPDATE,
    Resource.LEAD_DELETE,
    Resource.LEAD_CONVERT,
    Resource.LEAD_ASSIGN,
    
    // Properties
    Resource.PROPERTY_VIEW,
    Resource.PROPERTY_CREATE,
    Resource.PROPERTY_UPDATE,
    Resource.PROPERTY_DELETE,
    
    // Contracts
    Resource.CONTRACT_VIEW,
    Resource.CONTRACT_CREATE,
    Resource.CONTRACT_UPDATE,
    Resource.CONTRACT_DELETE,
    Resource.CONTRACT_SIGN,
    
    // Documents
    Resource.DOCUMENT_VIEW,
    Resource.DOCUMENT_CREATE,
    Resource.DOCUMENT_UPDATE,
    Resource.DOCUMENT_DELETE,
    Resource.DOCUMENT_UPLOAD,
    
    // Financials
    Resource.FINANCIAL_VIEW,
    Resource.FINANCIAL_CREATE,
    Resource.FINANCIAL_UPDATE,
    Resource.FINANCIAL_APPROVE,
    
    // Users
    Resource.USER_VIEW,
    Resource.USER_CREATE,
    Resource.USER_UPDATE,
    Resource.USER_MANAGE,
    
    // Analytics
    Resource.ANALYTICS_VIEW,
    Resource.ANALYTICS_EXPORT,
  ],
  
  AGENCY_MGR: [
    // Agency view only
    Resource.AGENCY_VIEW,
    
    // Agent management (view, assign)
    Resource.AGENT_VIEW,
    Resource.AGENT_ASSIGN,
    
    // Leads
    Resource.LEAD_VIEW,
    Resource.LEAD_UPDATE,
    Resource.LEAD_CONVERT,
    Resource.LEAD_ASSIGN,
    
    // Properties
    Resource.PROPERTY_VIEW,
    Resource.PROPERTY_UPDATE,
    
    // Contracts
    Resource.CONTRACT_VIEW,
    Resource.CONTRACT_UPDATE,
    Resource.CONTRACT_SIGN,
    
    // Documents
    Resource.DOCUMENT_VIEW,
    Resource.DOCUMENT_UPLOAD,
    
    // Financials (view only)
    Resource.FINANCIAL_VIEW,
    
    // Analytics
    Resource.ANALYTICS_VIEW,
  ],
  
  AGENT: [
    // Leads
    Resource.LEAD_VIEW,
    Resource.LEAD_CREATE,
    Resource.LEAD_UPDATE,
    Resource.LEAD_CONVERT,
    
    // Properties
    Resource.PROPERTY_VIEW,
    Resource.PROPERTY_CREATE,
    Resource.PROPERTY_UPDATE,
    
    // Contracts
    Resource.CONTRACT_VIEW,
    Resource.CONTRACT_UPDATE,
    
    // Documents
    Resource.DOCUMENT_VIEW,
    Resource.DOCUMENT_UPLOAD,
    
    // Analytics (basic)
    Resource.ANALYTICS_VIEW,
  ],
  
  PROPERTY_OWNER: [
    // Properties (own only)
    Resource.PROPERTY_VIEW,
    Resource.PROPERTY_CLAIM,
    
    // Contracts (own only)
    Resource.CONTRACT_VIEW,
    Resource.CONTRACT_SIGN,
    
    // Documents (own only)
    Resource.DOCUMENT_VIEW,
    Resource.DOCUMENT_UPLOAD,
    
    // Financials (own only)
    Resource.FINANCIAL_VIEW,
    
    // Users (self only)
    Resource.USER_VIEW,
    Resource.USER_UPDATE,
  ],
  
  INVESTOR: [
    // Properties (view only)
    Resource.PROPERTY_VIEW,
    
    // Financials (view only)
    Resource.FINANCIAL_VIEW,
    
    // Analytics (basic)
    Resource.ANALYTICS_VIEW,
  ],
  
  TENANT: [
    // Properties (rented only)
    Resource.PROPERTY_VIEW,
    
    // Contracts (rented only)
    Resource.CONTRACT_VIEW,
    
    // Documents (own only)
    Resource.DOCUMENT_VIEW,
    Resource.DOCUMENT_UPLOAD,
    
    // Users (self only)
    Resource.USER_VIEW,
    Resource.USER_UPDATE,
  ],
  
  USER: [
    // Users (self only)
    Resource.USER_VIEW,
    Resource.USER_UPDATE,
  ],
};

/**
 * Check if user has permission
 */
export function hasPermission(
  userPermissions: string[],
  requiredPermission: Resource
): boolean {
  // Wildcard permission
  if (userPermissions.includes('*')) {
    return true;
  }
  
  // Exact match
  if (userPermissions.includes(requiredPermission)) {
    return true;
  }
  
  // Wildcard suffix match (e.g., 'property:*' matches 'property:view')
  return userPermissions.some(perm => {
    if (perm.endsWith(':*')) {
      const prefix = perm.replace(':*', '');
      return requiredPermission.startsWith(prefix);
    }
    return false;
  });
}

/**
 * Check if user has any of the required permissions
 */
export function hasAnyPermission(
  userPermissions: string[],
  requiredPermissions: Resource[]
): boolean {
  return requiredPermissions.some(perm => 
    hasPermission(userPermissions, perm)
  );
}

/**
 * Check if user has all required permissions
 */
export function hasAllPermissions(
  userPermissions: string[],
  requiredPermissions: Resource[]
): boolean {
  return requiredPermissions.every(perm => 
    hasPermission(userPermissions, perm)
  );
}

/**
 * Get permissions for role
 */
export function getRolePermissions(role: string): Resource[] {
  return ROLE_PERMISSIONS[role] || [];
}

/**
 * Check resource ownership
 */
export function checkResourceOwnership(
  userId: string,
  resourceOwnerId: string,
  role: string
): boolean {
  // Super admins can access any resource
  if (role === 'SUPER_ADMIN') {
    return true;
  }
  
  // Users can access their own resources
  return userId === resourceOwnerId;
}

/**
 * Permission check middleware
 */
export function requirePermission(requiredPermission: Resource) {
  return (userPermissions: string[], role: string) => {
    if (role === 'SUPER_ADMIN') {
      return true;
    }
    
    if (!hasPermission(userPermissions, requiredPermission)) {
      throw new Error(`Forbidden: Missing required permission [${requiredPermission}]`);
    }
    
    return true;
  };
}

/**
 * Any permission check middleware
 */
export function requireAnyPermission(requiredPermissions: Resource[]) {
  return (userPermissions: string[], role: string) => {
    if (role === 'SUPER_ADMIN') {
      return true;
    }
    
    if (!hasAnyPermission(userPermissions, requiredPermissions)) {
      throw new Error(`Forbidden: Missing one of required permissions [${requiredPermissions.join(', ')}]`);
    }
    
    return true;
  };
}

/**
 * Permission matrix for API endpoints
 */
export const API_PERMISSION_MATRIX: Record<string, Resource> = {
  'GET /property': Resource.PROPERTY_VIEW,
  'POST /property': Resource.PROPERTY_CREATE,
  'PATCH /property': Resource.PROPERTY_UPDATE,
  'DELETE /property': Resource.PROPERTY_DELETE,
  
  'GET /agents': Resource.AGENT_VIEW,
  'POST /agents': Resource.AGENT_CREATE,
  'PATCH /agents': Resource.AGENT_UPDATE,
  'DELETE /agents': Resource.AGENT_DELETE,
  
  'GET /leads': Resource.LEAD_VIEW,
  'POST /leads': Resource.LEAD_CREATE,
  'PATCH /leads': Resource.LEAD_UPDATE,
  'DELETE /leads': Resource.LEAD_DELETE,
  
  'GET /contracts': Resource.CONTRACT_VIEW,
  'POST /contracts': Resource.CONTRACT_CREATE,
  'PATCH /contracts': Resource.CONTRACT_UPDATE,
  'DELETE /contracts': Resource.CONTRACT_DELETE,
  
  'GET /documents': Resource.DOCUMENT_VIEW,
  'POST /documents': Resource.DOCUMENT_CREATE,
  'PATCH /documents': Resource.DOCUMENT_UPDATE,
  'DELETE /documents': Resource.DOCUMENT_DELETE,
  
  'GET /financials': Resource.FINANCIAL_VIEW,
  'POST /financials': Resource.FINANCIAL_CREATE,
  'PATCH /financials': Resource.FINANCIAL_UPDATE,
  'DELETE /financials': Resource.FINANCIAL_DELETE,
  
  'GET /admin/config': Resource.ADMIN_CONFIG,
  'POST /admin/config': Resource.ADMIN_CONFIG,
  
  'GET /analytics': Resource.ANALYTICS_VIEW,
  'POST /analytics/export': Resource.ANALYTICS_EXPORT,
};

/**
 * Get required permission for API endpoint
 */
export function getAPIPermission(method: string, path: string): Resource | null {
  const key = `${method.toUpperCase()} ${path}`;
  return API_PERMISSION_MATRIX[key] || null;
}
