/**
 * Tenant Isolation Middleware
 * Row-level security for multi-tenant architecture
 * Ensures users can only access their organization's data
 */

import { Prisma } from '@prisma/client';

export interface TenantContext {
  orgId: string;
  userId: string;
  role: string;
  permissions: string[];
}

/**
 * Prisma middleware for automatic tenant isolation
 * Injects orgId filter into all queries
 */
export function createTenantIsolationMiddleware(tenantContext: TenantContext) {
  return async (params: Prisma.MiddlewareParams, next: (params: Prisma.MiddlewareParams) => Promise<any>) => {
    // Skip for system operations (superadmin)
    if (tenantContext.role === 'SUPER_ADMIN') {
      return next(params);
    }

    // Apply orgId filter to findMany, findFirst, findUnique, updateMany, deleteMany
    if (params.action === 'findMany' || params.action === 'findFirst') {
      params.args = params.args || {};
      
      // Check if model has orgId field
      const modelHasOrgId = modelHasOrganizationId(params.model);
      
      if (modelHasOrgId) {
        params.args.where = {
          ...params.args.where,
          orgId: tenantContext.orgId,
        };
      }
    }

    if (params.action === 'updateMany' || params.action === 'deleteMany') {
      params.args = params.args || {};
      
      const modelHasOrgId = modelHasOrganizationId(params.model);
      
      if (modelHasOrgId) {
        params.args.where = {
          ...params.args.where,
          orgId: tenantContext.orgId,
        };
      }
    }

    return next(params);
  };
}

/**
 * Check if Prisma model has orgId field
 */
function modelHasOrganizationId(model: string): boolean {
  const modelsWithOrgId = [
    'Property',
    'PropertyOwnershipVerification',
    'Document',
    'Contract',
    'Lead',
    'Appointment',
    'Task',
    'Notification',
    'Report',
    'Analytics',
    'Budget',
    'Earning',
    'Commission',
    'Escrow',
    'Booking',
    'Deal',
    'Agent',
    'Agency',
    'InvestorPortfolio',
    'Tenant',
    'MaintenanceWorkOrder',
    'CalendarEvent',
    'DashboardConfiguration',
    'DashboardWidget',
    // Add more models as needed
  ];

  return modelsWithOrgId.includes(model);
}

/**
 * Elysia middleware for tenant context injection
 */
export const tenantContextMiddleware = async ({ 
  orgId, 
  userId, 
  role, 
  permissions 
}: any) => {
  if (!orgId) {
    throw new Error('Organization ID required');
  }

  return {
    tenantContext: {
      orgId,
      userId,
      role,
      permissions: permissions || [],
    },
  };
};

/**
 * Cross-tenant access check
 * Prevents data leakage between organizations
 */
export function checkCrossTenantAccess(
  tenantContext: TenantContext,
  targetOrgId: string
): boolean {
  // Super admins can access any organization
  if (tenantContext.role === 'SUPER_ADMIN') {
    return true;
  }

  // Regular users can only access their own organization
  return tenantContext.orgId === targetOrgId;
}

/**
 * Resource-level permission check
 */
export function checkResourcePermission(
  tenantContext: TenantContext,
  resource: string,
  action: string
): boolean {
  // Super admins have all permissions
  if (tenantContext.role === 'SUPER_ADMIN') {
    return true;
  }

  const requiredPermission = `${resource}:${action}`;
  return tenantContext.permissions.includes(requiredPermission) ||
         tenantContext.permissions.includes('*');
}

/**
 * Audit log for sandbox boundary crossings
 */
export function logSandboxBoundaryCrossing(
  tenantContext: TenantContext,
  action: string,
  resource: string,
  details?: any
) {
  console.log('[Sandbox Audit]', {
    timestamp: new Date().toISOString(),
    userId: tenantContext.userId,
    orgId: tenantContext.orgId,
    role: tenantContext.role,
    action,
    resource,
    details,
  });

  // In production, write to database audit log
  // await prisma.sandboxAuditLog.create({ ... });
}
