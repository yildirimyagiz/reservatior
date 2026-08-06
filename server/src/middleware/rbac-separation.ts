/**
 * B2B/B2C Route Separation Middleware
 * Enforces role-based access control for agent (B2B) and property owner (B2C) separation
 * Prevents privilege escalation and unauthorized access
 */

// B2B Roles (Agent, Agency Manager, Agency Admin)
const B2B_ROLES = [
  'AGENT',
  'AGENCY_MGR',
  'AGENCY_ADMIN',
  'SUPER_ADMIN',
];

// B2C Roles (Property Owner, Investor, Tenant)
const B2C_ROLES = [
  'PROPERTY_OWNER',
  'INVESTOR',
  'TENANT',
  'TENANT_GUEST',
  'USER',
];

// Routes that are B2B ONLY
const B2B_ONLY_ROUTES = [
  '/admin/agencies',
  '/admin/agents',
  '/admin/mls-integration',
  '/client/ai/studio',
  '/client/agent-os/commission-split',
  '/client/agent-os/lead-management',
  '/client/agent-os/agency-dashboard',
];

// Routes that are B2C ONLY
const B2C_ONLY_ROUTES = [
  '/property',
  '/leases',
  '/financial-payouts',
  '/my-properties',
  '/ownership-verification',
];

/**
 * Check if role is B2B
 */
export function isB2BRole(role: string): boolean {
  return B2B_ROLES.includes(role);
}

/**
 * Check if role is B2C
 */
export function isB2CRole(role: string): boolean {
  return B2C_ROLES.includes(role);
}

/**
 * Check if route is B2B only
 */
export function isB2BRoute(path: string): boolean {
  return B2B_ONLY_ROUTES.some(route => path.startsWith(route));
}

/**
 * Check if route is B2C only
 */
export function isB2CRoute(path: string): boolean {
  return B2C_ONLY_ROUTES.some(route => path.startsWith(route));
}

/**
 * B2B Only Middleware
 * Blocks access to B2B routes for non-B2B users
 */
export const b2bOnlyMiddleware = async ({ role, path, set }: any) => {
  if (!role || !isB2BRole(role)) {
    set.status = 403;
    throw new Error('Forbidden: B2B access only. This feature is for real estate agents and agency staff.');
  }
  
  console.log(`[RBAC] B2B access granted for role [${role}] on path [${path}]`);
};

/**
 * B2C Only Middleware
 * Blocks access to B2C routes for non-B2C users
 */
export const b2cOnlyMiddleware = async ({ role, path, set }: any) => {
  if (!role || !isB2CRole(role)) {
    set.status = 403;
    throw new Error('Forbidden: B2C access only. This feature is for property owners and tenants.');
  }
  
  console.log(`[RBAC] B2C access granted for role [${role}] on path [${path}]`);
};

/**
 * Route Protection Middleware
 * Automatically checks route type and enforces role restrictions
 */
export const routeProtectionMiddleware = async ({ role, path, set }: any) => {
  if (isB2BRoute(path)) {
    if (!role || !isB2BRole(role)) {
      set.status = 403;
      throw new Error('Forbidden: This route requires agent-level access.');
    }
  }
  
  if (isB2CRoute(path)) {
    if (!role || !isB2CRole(role)) {
      set.status = 403;
      throw new Error('Forbidden: This route requires property owner access.');
    }
  }
  
  console.log(`[RBAC] Route protection passed for role [${role}] on path [${path}]`);
};

/**
 * Workspace Context Middleware
 * Validates that user has access to the requested workspace context
 */
export const workspaceContextMiddleware = async ({ 
  role, 
  query, 
  set, 
  orgId 
}: any) => {
  const requestedWorkspace = query.workspace as string;
  
  // If no workspace requested, allow
  if (!requestedWorkspace) return;
  
  // B2B users can only access B2B workspace
  if (isB2BRole(role) && requestedWorkspace !== 'b2b') {
    set.status = 403;
    throw new Error('Forbidden: Agents cannot access property owner workspace.');
  }
  
  // B2C users can only access B2C workspace
  if (isB2CRole(role) && requestedWorkspace !== 'b2c') {
    set.status = 403;
    throw new Error('Forbidden: Property owners cannot access agent workspace.');
  }
  
  console.log(`[RBAC] Workspace context validated: [${requestedWorkspace}] for role [${role}]`);
};

/**
 * Organization Access Middleware
 * Ensures user belongs to the organization they're trying to access
 */
export const organizationAccessMiddleware = async ({ 
  role, 
  params, 
  set, 
  orgId 
}: any) => {
  const requestedOrgId = params.orgId || params.organizationId;
  
  // Super admins can access any organization
  if (role === 'SUPER_ADMIN') return;
  
  // B2B users must belong to the organization
  if (isB2BRole(role)) {
    if (!requestedOrgId || requestedOrgId !== orgId) {
      set.status = 403;
      throw new Error('Forbidden: You do not have access to this organization.');
    }
  }
  
  console.log(`[RBAC] Organization access validated for role [${role}]`);
};

/**
 * Permission Check Helper
 * Checks if user has specific permission
 */
export function hasPermission(permissions: string[], requiredPermission: string): boolean {
  if (!permissions) return false;
  
  // Wildcard permission
  if (permissions.includes('*')) return true;
  
  // Exact match
  if (permissions.includes(requiredPermission)) return true;
  
  // Wildcard suffix match (e.g., 'properties.*' matches 'properties.view')
  return permissions.some(perm => {
    if (perm.endsWith('.*')) {
      const prefix = perm.replace('.*', '');
      return requiredPermission.startsWith(prefix);
    }
    return false;
  });
}

/**
 * Permission Middleware
 * Blocks access if user lacks required permission
 */
export const requirePermission = (requiredPermission: string) => {
  return async ({ permissions, role, set }: any) => {
    // Super admins have all permissions
    if (role === 'SUPER_ADMIN') return;
    
    if (!hasPermission(permissions, requiredPermission)) {
      set.status = 403;
      throw new Error(`Forbidden: Missing required permission [${requiredPermission}]`);
    }
    
    console.log(`[RBAC] Permission check passed: [${requiredPermission}]`);
  };
};

/**
 * Any Permission Middleware
 * Blocks access if user lacks any of the required permissions
 */
export const requireAnyPermission = (requiredPermissions: string[]) => {
  return async ({ permissions, role, set }: any) => {
    // Super admins have all permissions
    if (role === 'SUPER_ADMIN') return;
    
    const hasAny = requiredPermissions.some(perm => 
      hasPermission(permissions, perm)
    );
    
    if (!hasAny) {
      set.status = 403;
      throw new Error(`Forbidden: Missing one of required permissions [${requiredPermissions.join(', ')}]`);
    }
    
    console.log(`[RBAC] Any permission check passed: [${requiredPermissions.join(', ')}]`);
  };
};

/**
 * Role Transition Middleware
 * Validates role transitions (e.g., B2C -> B2B upgrade)
 */
export const roleTransitionMiddleware = async ({ 
  role, 
  body, 
  set 
}: any) => {
  const newRole = body.role;
  
  // Prevent self-promotion to admin roles
  if (newRole === 'SUPER_ADMIN' || newRole === 'AGENCY_ADMIN') {
    set.status = 403;
    throw new Error('Forbidden: Cannot promote to admin roles.');
  }
  
  // B2C to B2B transitions require approval
  if (isB2CRole(role) && isB2BRole(newRole)) {
    // This should trigger an approval workflow
    console.log(`[RBAC] B2C to B2B transition requested for role [${role}] -> [${newRole}]`);
    // For now, block it - implement approval workflow separately
    set.status = 403;
    throw new Error('Forbidden: B2C to B2B role transitions require approval.');
  }
  
  console.log(`[RBAC] Role transition validated: [${role}] -> [${newRole}]`);
};
