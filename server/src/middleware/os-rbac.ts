/**
 * OS-Level RBAC Permission Model
 *
 * Maps each of the 17 OS modules to required permissions and role-based
 * access control. Works with the existing JWT-based auth system.
 *
 * Pattern: Each OS module defines READ and WRITE permission requirements.
 * Admin-only operations require elevated permissions.
 */

import { Context } from "elysia";

// ─── OS Module Permission Definitions ─────────────────────────────────────────

export interface OSModulePermission {
  module: string;
  read: string[];      // Permissions required for read access
  write: string[];     // Permissions required for write access
  admin: string[];     // Permissions required for admin operations
  description: string;
}

export const OS_MODULES: Record<string, OSModulePermission> = {
  "finance-os": {
    module: "finance-os",
    read: ["FINANCE_MANAGE", "REPORTS_VIEW"],
    write: ["FINANCE_MANAGE"],
    admin: ["ORG_MANAGE", "FINANCE_MANAGE"],
    description: "Escrow, payments, financial records",
  },
  "booking-os": {
    module: "booking-os",
    read: ["BOOKINGS_VIEW_ALL", "BOOKINGS_VIEW_OWN"],
    write: ["BOOKINGS_MANAGE_ALL", "BOOKINGS_MANAGE_OWN"],
    admin: ["ORG_MANAGE"],
    description: "Bookings, reservations",
  },
  "listing-os": {
    module: "listing-os",
    read: ["LISTINGS_VIEW_ALL"],
    write: ["LISTINGS_MANAGE_ALL", "LISTINGS_MANAGE_OWN"],
    admin: ["ORG_MANAGE"],
    description: "Property listings",
  },
  "agent-os": {
    module: "agent-os",
    read: ["PROPERTIES_VIEW_ALL", "USERS_MANAGE"],
    write: ["USERS_MANAGE", "PROPERTIES_MANAGE_ALL"],
    admin: ["ORG_MANAGE"],
    description: "Agent registration, status",
  },
  "investment-os": {
    module: "investment-os",
    read: ["REPORTS_VIEW", "FINANCE_MANAGE"],
    write: ["FINANCE_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Deals, projections, analysis",
  },
  "operations-os": {
    module: "operations-os",
    read: ["TASKS_VIEW_ALL", "TASKS_VIEW_OWN"],
    write: ["TASKS_MANAGE_ALL", "TASKS_MANAGE_OWN", "VENDORS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Maintenance, inspections, vendors",
  },
  "security-os": {
    module: "security-os",
    read: ["AUDIT_LOGS_VIEW", "TRUST_SCORE_VIEW"],
    write: ["TRUST_SCORE_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "KYC, fraud detection, access audit",
  },
  "governance-os": {
    module: "governance-os",
    read: ["REPORTS_VIEW", "AUDIT_LOGS_VIEW"],
    write: ["GOV_INTEGRATIONS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Compliance, rules, audit trail",
  },
  "partner-os": {
    module: "partner-os",
    read: ["REPORTS_VIEW"],
    write: ["VENDORS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Partners, agreements, suppliers",
  },
  "developer-os": {
    module: "developer-os",
    read: ["API_KEYS_MANAGE"],
    write: ["API_KEYS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "API keys, webhooks, integrations",
  },
  "analytics-os": {
    module: "analytics-os",
    read: ["REPORTS_VIEW"],
    write: ["REPORTS_VIEW"],
    admin: ["ORG_MANAGE"],
    description: "Reports, dashboards, metrics",
  },
  "document-os": {
    module: "document-os",
    read: ["DOCUMENTS_MANAGE"],
    write: ["DOCUMENTS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Documents, contracts, signatures",
  },
  "notification-os": {
    module: "notification-os",
    read: ["NOTIFICATIONS_MANAGE", "MESSAGES_READ_ALL"],
    write: ["NOTIFICATIONS_MANAGE", "MESSAGES_MANAGE_ALL"],
    admin: ["ORG_MANAGE"],
    description: "Notifications, messages, channels",
  },
  "user-os": {
    module: "user-os",
    read: ["USERS_MANAGE", "PROPERTIES_VIEW_ALL"],
    write: ["USERS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "User profiles, preferences, journey",
  },
  "ads-os": {
    module: "ads-os",
    read: ["REPORTS_VIEW", "MARKETING_CAMPAIGNS_MANAGE"],
    write: ["MARKETING_CAMPAIGNS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Campaigns, creatives, audiences",
  },
  "identity-os": {
    module: "identity-os",
    read: ["USERS_MANAGE", "AUDIT_LOGS_VIEW"],
    write: ["USERS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Users, sessions, roles, SSO",
  },
  "localization-os": {
    module: "localization-os",
    read: ["REPORTS_VIEW"],
    write: ["SETTINGS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Countries, currencies, languages",
  },
  "commerce-os": {
    module: "commerce-os",
    read: ["COMMERCE_MANAGE", "REPORTS_VIEW"],
    write: ["COMMERCE_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Products, orders, bundles, campaigns",
  },
  "crm-os": {
    module: "crm-os",
    read: ["REPORTS_VIEW", "USERS_MANAGE"],
    write: ["USERS_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Contacts, leads, client relationships",
  },
  "portfolio-os": {
    module: "portfolio-os",
    read: ["REPORTS_VIEW", "FINANCE_MANAGE"],
    write: ["FINANCE_MANAGE"],
    admin: ["ORG_MANAGE"],
    description: "Investor portfolio, REO, valuations",
  },
  "platform-os": {
    module: "platform-os",
    read: ["SETTINGS_MANAGE", "REPORTS_VIEW"],
    write: ["SETTINGS_MANAGE"],
    admin: ["ORG_MANAGE", "SETTINGS_MANAGE"],
    description: "Config, tenants, feature flags, system health",
  },
};

// ─── Role Hierarchy ───────────────────────────────────────────────────────────

export const ROLE_HIERARCHY: Record<string, number> = {
  "OWNER": 100,
  "ORG_ADMIN": 90,
  "AGENCY_ADMIN": 70,
  "VENDOR_MANAGER": 60,
  "ACCOUNTANT": 50,
  "AGENT": 40,
  "MAINTENANCE": 30,
  "TENANT_GUEST": 20,
  "READ_ONLY": 10,
};

// ─── Permission Check Helpers ─────────────────────────────────────────────────

/**
 * Check if user has any of the required permissions for an OS module.
 * Uses wildcard matching: "*" matches all, "DOMAIN.*" matches all in domain.
 */
function hasAnyPermission(userPermissions: string[], required: string[]): boolean {
  if (!userPermissions || !required) return false;

  // Wildcard check
  if (userPermissions.includes("*")) return true;

  return required.some(req => {
    // Direct match
    if (userPermissions.includes(req)) return true;

    // Prefix wildcard: "FINANCE_MANAGE" matches "FINANCE.*"
    const domain = req.split("_")[0];
    if (userPermissions.includes(`${domain}.*`)) return true;

    // Full domain wildcard
    const parts = req.split("_");
    if (parts.length >= 2) {
      const prefix = parts.slice(0, -1).join("_");
      if (userPermissions.includes(`${prefix}_*`)) return true;
    }

    return false;
  });
}

/**
 * Check if user's role level is sufficient for the required level.
 */
function hasRoleLevel(userRole: string, requiredLevel: number): boolean {
  const userLevel = ROLE_HIERARCHY[userRole] || 0;
  return userLevel >= requiredLevel;
}

// ─── Middleware Types ──────────────────────────────────────────────────────────

export interface RBACContext {
  userId?: string;
  orgId?: string;
  role?: string;
  permissions?: string[];
}

export type RBACDecision = {
  allowed: boolean;
  reason?: string;
  required?: string[];
  actual?: string[];
};

/**
 * Check if a user has access to an OS module for a given operation type.
 *
 * @param moduleName - The OS module name (e.g., "finance-os")
 * @param operation - "read" | "write" | "admin"
 * @param userRole - The user's role key
 * @param userPermissions - The user's permission array from JWT
 * @returns RBACDecision with allowed flag and details
 */
export function checkOSAccess(
  moduleName: string,
  operation: "read" | "write" | "admin",
  userRole: string,
  userPermissions: string[]
): RBACDecision {
  const moduleConfig = OS_MODULES[moduleName];
  if (!moduleConfig) {
    return { allowed: false, reason: `Unknown OS module: ${moduleName}` };
  }

  const requiredPerms = moduleConfig[operation] || [];

  // Owner and ORG_ADMIN bypass all checks
  if (userRole === "OWNER" || userRole === "ORG_ADMIN") {
    return { allowed: true };
  }

  // Admin operations require ORG_ADMIN or OWNER role
  if (operation === "admin") {
    if (!hasRoleLevel(userRole, ROLE_HIERARCHY["ORG_ADMIN"])) {
      return {
        allowed: false,
        reason: `Admin access requires ORG_ADMIN or higher role`,
        required: moduleConfig.admin,
        actual: userPermissions,
      };
    }
  }

  // Check permissions
  const allowed = hasAnyPermission(userPermissions, requiredPerms);
  if (!allowed) {
    return {
      allowed: false,
      reason: `Missing required permissions for ${moduleName} ${operation}`,
      required: requiredPerms,
      actual: userPermissions,
    };
  }

  return { allowed: true };
}

/**
 * Elysia-style middleware for OS module access control.
 * Usage: .use(osRBAC("finance-os", "read"))
 */
export function osRBACMiddleware(moduleName: string, operation: "read" | "write" | "admin") {
  return {
    derive: (context: any) => {
      const userId = context.userId;
      const orgId = context.orgId;
      const role = context.role;
      const permissions = context.permissions;

      if (!userId) {
        return { osRBAC: { allowed: false, reason: "Authentication required" } };
      }

      const decision = checkOSAccess(moduleName, operation, role || "", permissions || []);
      return { osRBAC: decision };
    },
    resolve: (context: any) => {
      if (!context.osRBAC?.allowed) {
        return {
          status: 403,
          body: {
            error: "Forbidden",
            message: context.osRBAC?.reason || "Access denied",
            required: context.osRBAC?.required,
          },
        };
      }
    },
  };
}

/**
 * Simple function to check OS access and throw/return if denied.
 * Use in route handlers after authMiddleware.
 */
export function requireOSAccess(
  moduleName: string,
  operation: "read" | "write" | "admin",
  ctx: RBACContext
): void {
  const decision = checkOSAccess(
    moduleName,
    operation,
    ctx.role || "",
    ctx.permissions || []
  );

  if (!decision.allowed) {
    throw new Error(`Access denied: ${decision.reason}`);
  }
}

/**
 * Get all permissions required for a given OS module.
 */
export function getOSModulePermissions(moduleName: string): OSModulePermission | undefined {
  return OS_MODULES[moduleName];
}

/**
 * Get all OS modules a user can access (for UI rendering, etc.).
 */
export function getAccessibleModules(userRole: string, userPermissions: string[]): string[] {
  return Object.entries(OS_MODULES)
    .filter(([name, config]) => {
      const readDecision = checkOSAccess(name, "read", userRole, userPermissions);
      return readDecision.allowed;
    })
    .map(([name]) => name);
}

/**
 * Get a summary of the entire RBAC permission model.
 */
export function getRBACSummary() {
  return {
    totalModules: Object.keys(OS_MODULES).length,
    modules: Object.values(OS_MODULES).map(m => ({
      module: m.module,
      description: m.description,
      readPermissions: m.read,
      writePermissions: m.write,
      adminPermissions: m.admin,
    })),
    roles: Object.entries(ROLE_HIERARCHY).map(([role, level]) => ({
      role,
      level,
      isSuperadmin: level >= 90,
    })),
    totalPermissions: 42,
    permissionPattern: "DOMAIN_ACTION (e.g., PROPERTIES_VIEW_ALL, FINANCE_MANAGE)",
  };
}
