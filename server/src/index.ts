import { Elysia } from "elysia";
import { swagger } from "@elysiajs/swagger";
import { staticPlugin } from "@elysiajs/static";
import { cors } from "@elysiajs/cors";
import { router } from "./router";
import { prisma } from "./lib/prisma";
import { SignJWT } from "jose";
import { ENCODED_SECRET } from "./lib/jwt";

const app = new Elysia()
  // Public health endpoint
  .get("/health", () => ({
    status: "ok",
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    version: "1.0.0"
  }))
  .onError(({ code, error }) => {
    const message = (error as any)?.message || String(error);
    console.error(`🔥 Server Error [${code}]:`, message);
    if (code === 'NOT_FOUND') return { error: "Route not found" };
    return { error: message };
  })
  .use(swagger({
    documentation: {
      info: {
        title: "Reservatior API",
        version: "1.0.0",
      },
    },
    path: "/docs",
  }))
  .use(cors({
    origin: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'x-region', 'x-platform', 'x-version'],
    credentials: true
  }))
  .use(staticPlugin({
    assets: process.cwd() + "/ml-services/comfysetup/backend/uploads",
    prefix: "/uploads",
    headers: {
      'Cache-Control': 'public, max-age=31536000'
    }
  }))
  .use(staticPlugin({
    assets: process.cwd() + "/data",
    prefix: "/data",
    headers: {
      'Cache-Control': 'public, max-age=31536000'
    }
  }))

  // GET /api/auth/google — exact match for the redirect path in the user's Google Console
  .get("/api/auth/google", ({ redirect }) => {
    const appUrl = process.env.APP_URL || "http://localhost:3000";
    const params = new URLSearchParams({
      client_id: process.env.AUTH_GOOGLE_ID || "",
      redirect_uri: `${appUrl}/api/auth/callback/google`,
      response_type: "code",
      scope: "email profile",
    });
    return redirect(`https://accounts.google.com/o/oauth2/v2/auth?${params.toString()}`);
  })

  // GET /api/auth/callback/google — exact match for the callback path in the user's Google Console
  .get("/api/auth/callback/google", async ({ query, redirect }) => {
    const appUrl = process.env.APP_URL || "http://localhost:3000";
    const clientUrl = process.env.CLIENT_URL || "http://localhost:3001";
    const code = query.code as string;
    if (!code) {
      return redirect(`${clientUrl}/auth/callback?error=NoCode`);
    }

    try {
      const clientId = process.env.AUTH_GOOGLE_ID!;
      const clientSecret = process.env.AUTH_GOOGLE_SECRET!;
      const redirectUri = `${appUrl}/api/auth/callback/google`;

      const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          client_id: clientId,
          client_secret: clientSecret,
          code,
          grant_type: "authorization_code",
          redirect_uri: redirectUri,
        }),
      });

      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) {
        console.error("Failed to fetch access token:", tokenData);
        throw new Error("No access token");
      }

      const userRes = await fetch("https://www.googleapis.com/oauth2/v2/userinfo", {
        headers: { Authorization: `Bearer ${tokenData.access_token}` },
      });
      const googleUser = await userRes.json();

      if (!googleUser.email) throw new Error("No email in google profile");

      let user = await prisma.user.findUnique({ where: { email: googleUser.email } });
      if (!user) {
        user = await prisma.user.create({
          data: {
            email: googleUser.email,
            name: googleUser.name || googleUser.given_name || "",
          },
        });
        
        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "google",
            accountId: googleUser.id || googleUser.sub,
            accessToken: tokenData.access_token,
          },
        });
      }

      // Check user permissions and role
      let role = "USER";
      let permissions = ["PROPERTIES_VIEW_ALL"];
      let orgId = null;

      const dbUser = await prisma.user.findUnique({
        where: { id: user.id },
        include: {
          memberships: {
            include: {
              role: { include: { permissions: { include: { permission: true } } } }
            }
          }
        }
      });

      if (dbUser?.memberships && dbUser.memberships.length > 0) {
        const primaryMember = dbUser.memberships[0];
        role = primaryMember.role.key;
        orgId = primaryMember.orgId;
        permissions = primaryMember.role.permissions.map(rp => rp.permission.key);
      }

      const superAdminEmails = ["yagizyildirim@icloud.com", "admin@propos.com", "info@reservatior.com", "admin@demorealty.com"];
      if (superAdminEmails.includes(user.email)) {
        role = "OWNER";
        permissions = ["*"];
      }

      const token = await new SignJWT({
        sub: user.id,
        email: user.email,
        role,
        permissions,
        orgId
      })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuedAt()
      .setExpirationTime('7d')
      .sign(ENCODED_SECRET);

      const session = await prisma.session.create({
        data: {
          userId: user.id,
          tokenHash: token.split(".").pop() ?? token,
          expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
        },
      });

      return redirect(`${clientUrl}/auth/callback?token=${token}&user=${encodeURIComponent(JSON.stringify({
        id: user.id,
        email: user.email,
        name: user.name,
        role,
        permissions,
        organizationId: orgId
      }))}`);
    } catch (e) {
      console.error("Google auth callback error:", e);
      return redirect(`${clientUrl}/auth/login?error=GoogleAuthFailed`);
    }
  })

  .use(router)
  .listen({ 
    port: Number(process.env.PORT) || 3000, 
    hostname: "0.0.0.0" 
  });

import { AIMailResponderService } from "./services/ai-mail-responder";

console.log("🦊 Elysia server is running at http://localhost:" + (process.env.PORT || 3000));
console.log("📚 Swagger docs available at http://localhost:" + (process.env.PORT || 3000) + "/docs");

// Initialize AI Mail Auto-Responder polling
AIMailResponderService.startPolling();


export type App = typeof app;
export default app;
