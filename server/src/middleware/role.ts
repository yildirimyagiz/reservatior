import { Elysia } from "elysia";

const IS_DEV = process.env.NODE_ENV !== "production";

/**
 * Check if the user has one of the required roles.
 * Must be used AFTER authMiddleware (needs `role` in context).
 * Usage: .onBeforeHandle(hasRole(["OWNER", "ORG_ADMIN"]))
 */
export const hasRole = (roles: string[]) => {
  return ({ role, set, user }: any) => {
    const hasAccess = roles.includes("*") || roles.includes(role);
    if (!hasAccess) {
      if (IS_DEV) {
        console.log(`🚫 Role Denied for [${user?.email}]: Required [${roles.join(',')}] Got [${role}]`);
      }
      set.status = 403;
      return { error: `Forbidden: Required role ${roles.join(' or ')}` };
    }
  };
};

/**
 * Check if user has ANY of the required permissions.
 * Must be used AFTER authMiddleware (needs `permissions` in context).
 */
export const hasAnyRole = (roles: string[]) => {
  return ({ role, set, user }: any) => {
    const hasAccess = roles.includes("*") || roles.includes(role);
    if (!hasAccess) {
      if (IS_DEV) {
        console.log(`🚫 Role Denied for [${user?.email}]: Required any of [${roles.join(',')}] Got [${role}]`);
      }
      set.status = 403;
      return { error: "Forbidden: Insufficient role" };
    }
  };
};

/**
 * Role middleware plugin — derive hasRole into context.
 * Apply via .use(roleMiddlewarePlugin) after authMiddleware.
 */
export const roleMiddlewarePlugin = new Elysia({ name: "role-middleware" })
  .derive({ as: "scoped" }, async ({ role }: any) => {
    return {
      hasRole: (requiredRoles: string[]) => {
        return requiredRoles.includes("*") || requiredRoles.includes(role);
      }
    };
  });
