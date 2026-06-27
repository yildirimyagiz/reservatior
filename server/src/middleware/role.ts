import { Elysia } from "elysia";

export const requireRole = (...roles: string[]) => ({ role, set }: any) => {
  if (!roles.includes(role)) {
    set.status = 403;
    return { error: `Forbidden: Requires one of roles [${roles.join(", ")}]` };
  }
};

export const roleMiddlewarePlugin = new Elysia({ name: "role-middleware" })
  .derive({ as: "scoped" }, async ({ role }) => {
    return {
      hasRole: (required: string) => role === required,
      hasAnyRole: (required: string[]) => required.includes(role),
    };
  });
