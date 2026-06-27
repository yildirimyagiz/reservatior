import { Elysia } from "elysia";
import { bearer } from "@elysiajs/bearer";
import { jwtVerify } from "jose";

import { ENCODED_SECRET } from "../lib/jwt";
import { prismaManager } from "../lib/prisma";

const prisma = prismaManager.getDefault();

export const authMiddleware = new Elysia({ name: "auth-middleware" })
  .use(bearer())
  .derive({ as: "scoped" }, async ({ bearer, set }) => {
    if (!bearer) {
      console.log("❌ No bearer token found in request headers");
      set.status = 401;
      throw new Error("Unauthorized");
    }
    
    try {
      console.log("🔍 Verifying bearer token with Jose:", bearer.substring(0, 15) + "...");
      const { payload } = await jwtVerify(bearer, ENCODED_SECRET);
      console.log(`👤 Jose Auth Payload Verified: User ID [${payload.sub}] Role [${payload.role}]`);
    
    // Fetch user information
    const user = await prisma.user.findUnique({
      where: { id: payload.sub as string },
      select: {
        id: true,
        email: true,
        name: true,
      }
    });

    // Get user's organization
    let userOrgId = payload.orgId as string | undefined;
    // For now, we'll use the orgId from JWT token
    // In a real implementation, you might want to fetch from user relationships

      return { 
        userId: payload.sub as string, 
        orgId: payload.orgId as string | undefined,
        user,
        role: payload.role as string,
        permissions: (payload.permissions as string[]) || []
      };
    } catch (e: any) {
      console.log("❌ JWT Verification Failed for bearer (Jose):", e.message);
      set.status = 401;
      throw new Error("Unauthorized");
    }
  });

export const hasPermission = (permission: string) => ({ permissions, set, user }: any) => {
  console.log(`🔍 Checking permission [${permission}] for [${user?.email}]. User has:`, permissions);
  const hasAccess = permissions?.includes("*") || 
                    permissions?.includes(permission) ||
                    permissions?.some((p: string) => p.endsWith('.*') && (permission === p.replace('.*', '') || permission.startsWith(p.replace('*', ''))));

  if (!hasAccess) {
    console.log(`🚫 Access Denied for [${user?.email}]: Missing permission [${permission}].`);
    set.status = 403;
    return { error: "Forbidden: Missing required permission " + permission };
  }
  console.log(`✅ Access Granted for [${user?.email}] for [${permission}]`);
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
