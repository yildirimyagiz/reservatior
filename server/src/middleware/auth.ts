import { Elysia } from "elysia";
import { bearer } from "@elysiajs/bearer";
import { jwtVerify } from "jose";

import { ENCODED_SECRET } from "../lib/jwt";
import { prisma } from "../lib/prisma";

const IS_DEV = process.env.NODE_ENV !== "production";

export const authMiddleware = new Elysia({ name: "auth-middleware" })
  .use(bearer())
  .derive({ as: "scoped" }, async ({ bearer, set }) => {
    if (!bearer) {
      set.status = 401;
      throw new Error("Unauthorized");
    }
    
    try {
      const { payload } = await jwtVerify(bearer, ENCODED_SECRET);
      if (IS_DEV) {
        console.log(`👤 Auth: User [${payload.sub}] Role [${payload.role}]`);
      }
    
    const user = await prisma.user.findUnique({
      where: { id: payload.sub as string },
      select: {
        id: true,
        email: true,
        name: true,
      }
    });

    let userOrgId = payload.orgId as string | undefined;

      return { 
        userId: payload.sub as string, 
        orgId: payload.orgId as string | undefined,
        user,
        role: payload.role as string,
        permissions: (payload.permissions as string[]) || []
      };
    } catch (e: any) {
      if (IS_DEV) {
        console.log("❌ JWT Verification Failed:", e.message);
      }
      set.status = 401;
      throw new Error("Unauthorized");
    }
  });

export const hasPermission = (permission: string) => ({ permissions, set, user }: any) => {
  const hasAccess = permissions?.includes("*") || 
                    permissions?.includes(permission) ||
                    permissions?.some((p: string) => p.endsWith('.*') && (permission === p.replace('.*', '') || permission.startsWith(p.replace('*', ''))));

  if (!hasAccess) {
    if (IS_DEV) {
      console.log(`🚫 Access Denied for [${user?.email}]: Missing [${permission}]`);
    }
    set.status = 403;
    return { error: "Forbidden: Missing required permission " + permission };
  }
};

export const hasAnyPermission = (perms: string[]) => ({ permissions, set }: any) => {
  const hasAny = permissions.includes("*") || 
                 perms.some(req => 
                   permissions.includes(req) || 
                   permissions.some((p: string) => p.endsWith('.*') && (req === p.replace('.*', '') || req.startsWith(p.replace('*', ''))))
                 );
  if (!hasAny) {
    set.status = 403;
    return { error: "Forbidden: Missing required permissions" };
  }
};
