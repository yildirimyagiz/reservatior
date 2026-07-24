import { Elysia } from "elysia";
import { swagger } from "@elysiajs/swagger";

process.on('unhandledRejection', (reason, promise) => {
  console.error('[Process] Unhandled Rejection at:', promise, 'reason:', reason);
});
process.on('uncaughtException', (error) => {
  console.error('[Process] Uncaught Exception:', error);
});
import { staticPlugin } from "@elysiajs/static";
import { cors } from "@elysiajs/cors";

import { prismaManager, prisma } from "./lib/prisma";

import { adsWebhookPlugin } from "./routes/webhooks/ads-webhook";

import { router } from "./router";
import { SignJWT, jwtVerify } from "jose";
import { ENCODED_SECRET } from "./lib/jwt";
import { cronScheduler } from "./cron/cron-scheduler";
import { rateLimitMiddleware } from "./middleware/rate-limit";
import { csrfMiddleware } from "./middleware/csrf";
import { auditLogMiddleware } from "./middleware/audit-log";
import { shareToLinkedInCompany } from "./services/linkedin";
import { fintechRoutes } from "./routes/fintech";
import { aiPricingIntelligenceRoutes } from "./routes/ai-pricing-intelligence";
import { commissionRuleEngineRoutes } from "./routes/commission-rule-engine";
import { priceOptimizationDashboardRoutes } from "./routes/price-optimization-dashboard";
import { runEarlyCaptureScheduler } from "./services/fintech/early-capture-scheduler";
import { RegionManager } from "./lib/config/RegionManager";

// ── Environment-based configuration ─────────────────────────────────────────
const SERVER_URL = process.env.SERVER_URL || "http://localhost:3000";
const CLIENT_URL = process.env.CLIENT_URL || "http://localhost:3001";
const CORS_ORIGINS = (process.env.CORS_ORIGIN || `${SERVER_URL},${CLIENT_URL},http://localhost:5173`)
  .split(",")
  .map(o => o.trim())
  .filter(Boolean);
const SUPER_ADMIN_EMAILS = (process.env.SUPER_ADMIN_EMAILS || "")
  .split(",")
  .map(e => e.trim())
  .filter(Boolean);

// ── Shared Auth Session Creator (eliminates code duplication) ────────────────
async function createAuthSessionAndRedirect(
  user: { id: string; email: string; name: string | null; imageUrl?: string | null },
  provider: string
) {
  let role = "TENANT_GUEST";
  let permissions = ["PROPERTIES_VIEW_ALL"];
  let orgId: string | null = null;

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

  if (SUPER_ADMIN_EMAILS.includes(user.email)) {
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

  await prisma.session.create({
    data: {
      userId: user.id,
      tokenHash: token.split(".").pop() ?? token,
      expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
    },
  });

  const userData = JSON.stringify({
    id: user.id,
    email: user.email,
    name: user.name,
    imageUrl: user.imageUrl || undefined,
    role,
    permissions,
    organizationId: orgId
  });

  return { token, userData };
}

const appBase = new Elysia()
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
        title: "Reservatior Platform API",
        version: "2.0.0",
        description: "AI-native Residential Infrastructure Platform — 21 OS Modules + 7 Core Intelligence Layers",
      },
      servers: [{ url: "/api/v1", description: "Production" }],
      tags: [
        { name: "FinanceOS", description: "Escrow, payments, financial records" },
        { name: "GovernanceOS", description: "Compliance, rules, audit trail" },
        { name: "PartnerOS", description: "Partners, agreements, suppliers" },
        { name: "DeveloperOS", description: "API keys, webhooks, integrations" },
        { name: "AnalyticsOS", description: "Reports, dashboards, metrics" },
        { name: "DocumentOS", description: "Documents, contracts, signatures" },
        { name: "NotificationOS", description: "Notifications, messages, channels" },
        { name: "IdentityOS", description: "Users, sessions, roles, SSO" },
        { name: "LocalizationOS", description: "Countries, currencies, languages" },
        { name: "InvestmentOS", description: "Deals, projections, analysis" },
        { name: "OperationsOS", description: "Maintenance, inspections, vendors" },
        { name: "SecurityOS", description: "KYC, fraud detection, access audit" },
        { name: "UserOS", description: "User profiles, preferences, journey" },
        { name: "AdsOS", description: "Campaigns, creatives, audiences" },
        { name: "BookingOS", description: "Bookings, reservations" },
        { name: "ListingOS", description: "Property listings" },
        { name: "AgentOS", description: "Agent registration, status" },
      ],
    },
    path: "/docs",
  }))
  .use(rateLimitMiddleware)
  .use(csrfMiddleware)
  .use(auditLogMiddleware)
  .use(cors({
    origin: CORS_ORIGINS,
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
  })) as unknown as Elysia;

const appCore = appBase
  // GET /api/auth/google — redirect to Google OAuth
  .get("/api/auth/google", ({ redirect }) => {
    const params = new URLSearchParams({
      client_id: process.env.AUTH_GOOGLE_ID || "",
      redirect_uri: `${SERVER_URL}/api/auth/callback/google`,
      response_type: "code",
      scope: "email profile",
    });
    return redirect(`https://accounts.google.com/o/oauth2/v2/auth?${params.toString()}`);
  })

  // GET /api/auth/callback/google — handle Google OAuth callback
  .get("/api/auth/callback/google", async ({ query, redirect }) => {
    const code = query.code as string;
    if (!code) return redirect(`${CLIENT_URL}/auth/callback?error=NoCode`);

    try {
      const clientId = process.env.AUTH_GOOGLE_ID!;
      const clientSecret = process.env.AUTH_GOOGLE_SECRET!;
      const redirectUri = `${SERVER_URL}/api/auth/callback/google`;

      const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          client_id: clientId, client_secret: clientSecret, code,
          grant_type: "authorization_code", redirect_uri: redirectUri,
        }),
      });
      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) throw new Error("No access token");

      const userRes = await fetch("https://www.googleapis.com/oauth2/v2/userinfo", {
        headers: { Authorization: `Bearer ${tokenData.access_token}` },
      });
      const googleUser = await userRes.json();
      if (!googleUser.email) throw new Error("No email in google profile");

      let user = await prisma.user.findUnique({ where: { email: googleUser.email } });
      if (!user) {
        user = await prisma.user.create({ data: { email: googleUser.email, name: googleUser.name || googleUser.given_name || "" } });
        await prisma.account.create({ data: { userId: user.id, type: "OAUTH", providerId: "google", accountId: googleUser.id || googleUser.sub, accessToken: tokenData.access_token } });
      }

      const { token, userData } = await createAuthSessionAndRedirect(user, "google");
      return redirect(`${CLIENT_URL}/auth/callback?token=${token}&user=${encodeURIComponent(userData)}`);
    } catch (e) {
      console.error("Google auth callback error:", e);
      return redirect(`${CLIENT_URL}/auth/login?error=GoogleAuthFailed`);
    }
  })

  // GET /api/auth/facebook — redirect to Facebook OAuth
  .get("/api/auth/facebook", ({ redirect }) => {
    const params = new URLSearchParams({
      client_id: process.env.FACEBOOK_APP_ID || "",
      redirect_uri: `${SERVER_URL}/api/auth/facebook/callback`,
      response_type: "code",
      scope: "email public_profile",
    });
    return redirect(`https://www.facebook.com/v20.0/dialog/oauth?${params.toString()}`);
  })

  // GET /api/auth/facebook/callback — handle Facebook OAuth callback
  .get("/api/auth/facebook/callback", async ({ query, redirect }) => {
    const code = query.code as string;
    if (!code) return redirect(`${CLIENT_URL}/auth/callback?error=NoCode`);

    try {
      const clientId = process.env.FACEBOOK_APP_ID!;
      const clientSecret = process.env.FACEBOOK_APP_SECRET!;
      const redirectUri = `${SERVER_URL}/api/auth/facebook/callback`;

      const tokenRes = await fetch(`https://graph.facebook.com/v20.0/oauth/access_token?client_id=${clientId}&client_secret=${clientSecret}&code=${code}&redirect_uri=${redirectUri}`);
      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) throw new Error("No access token");

      const userRes = await fetch(`https://graph.facebook.com/v20.0/me?fields=id,name,email,picture&access_token=${tokenData.access_token}`);
      const facebookUser = await userRes.json();
      if (!facebookUser.email) throw new Error("No email in facebook profile");

      let user = await prisma.user.findUnique({ where: { email: facebookUser.email } });
      if (!user) {
        user = await prisma.user.create({ data: { email: facebookUser.email, name: facebookUser.name || "", imageUrl: facebookUser.picture?.data?.url || null } });
        await prisma.account.create({ data: { userId: user.id, type: "OAUTH", providerId: "facebook", accountId: facebookUser.id, accessToken: tokenData.access_token } });
      }

      const { token, userData } = await createAuthSessionAndRedirect(user, "facebook");
      return redirect(`${CLIENT_URL}/auth/callback?token=${token}&user=${encodeURIComponent(userData)}`);
    } catch (e) {
      console.error("Facebook auth callback error:", e);
      return redirect(`${CLIENT_URL}/auth/login?error=FacebookAuthFailed`);
    }
  })

  // GET /api/auth/twitter — redirect to Twitter OAuth
  .get("/api/auth/twitter", ({ redirect }) => {
    const params = new URLSearchParams({
      response_type: "code",
      client_id: process.env.TWITTER_API_KEY || "",
      redirect_uri: `${SERVER_URL}/api/auth/twitter/callback`,
      scope: "users.read tweet.read offline.access",
      state: "state-reservatior",
      code_challenge: "challenge",
      code_challenge_method: "plain"
    });
    return redirect(`https://twitter.com/i/oauth2/authorize?${params.toString()}`);
  })

  // GET /api/auth/twitter/callback — handle Twitter OAuth callback
  .get("/api/auth/twitter/callback", async ({ query, redirect }) => {
    const code = query.code as string;
    if (!code) return redirect(`${CLIENT_URL}/auth/callback?error=NoCode`);

    try {
      const clientId = process.env.TWITTER_API_KEY!;
      const clientSecret = process.env.TWITTER_API_SECRET!;
      const redirectUri = `${SERVER_URL}/api/auth/twitter/callback`;
      const credentials = btoa(`${clientId}:${clientSecret}`);

      const tokenRes = await fetch(`https://api.twitter.com/2/oauth2/token`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded", "Authorization": `Basic ${credentials}` },
        body: new URLSearchParams({ code, grant_type: "authorization_code", client_id: clientId, redirect_uri: redirectUri, code_verifier: "challenge" })
      });
      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) throw new Error("No access token");

      const userRes = await fetch(`https://api.twitter.com/2/users/me?user.fields=profile_image_url`, {
        headers: { "Authorization": `Bearer ${tokenData.access_token}` }
      });
      const twitterUserRaw = await userRes.json();
      if (!twitterUserRaw.data) throw new Error("No user data returned from Twitter");
      const twitterUser = twitterUserRaw.data;
      const userEmail = `${twitterUser.username}@twitter.reservatior.com`;

      let user = await prisma.user.findUnique({ where: { email: userEmail } });
      if (!user) {
        user = await prisma.user.create({ data: { email: userEmail, name: twitterUser.name || twitterUser.username || "", imageUrl: twitterUser.profile_image_url || null } });
        await prisma.account.create({ data: { userId: user.id, type: "OAUTH", providerId: "twitter", accountId: twitterUser.id, accessToken: tokenData.access_token } });
      }

      const { token, userData } = await createAuthSessionAndRedirect(user, "twitter");
      return redirect(`${CLIENT_URL}/auth/callback?token=${token}&user=${encodeURIComponent(userData)}`);
    } catch (e) {
      console.error("Twitter auth callback error:", e);
      return redirect(`${CLIENT_URL}/auth/login?error=TwitterAuthFailed`);
    }
  })
  // POST /api/auth/facebook/native — For Mobile native SDK login
  .post("/api/auth/facebook/native", async ({ body, set }) => {
    try {
      const { accessToken } = body as { accessToken: string };
      if (!accessToken) throw new Error("Missing access token");

      const fbRes = await fetch(`https://graph.facebook.com/me?fields=id,name,email,picture.type(large)&access_token=${accessToken}`);
      const fbUser = await fbRes.json();
      
      if (fbUser.error) throw new Error(fbUser.error.message);
      
      const email = fbUser.email || `${fbUser.id}@facebook.reservatior.com`;
      let user = await prisma.user.findUnique({ where: { email } });
      if (!user) {
        user = await prisma.user.create({
          data: {
            email,
            name: fbUser.name,
            imageUrl: fbUser.picture?.data?.url || null,
          },
        });
        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "facebook",
            accountId: fbUser.id,
            accessToken: accessToken,
          },
        });
      }

      let role = "USER";
      let permissions = ["PROPERTIES_VIEW_ALL"];
      let orgId = null;

      const token = await new SignJWT({ sub: user.id, email: user.email, role, permissions, orgId })
        .setProtectedHeader({ alg: 'HS256' })
        .setIssuedAt()
        .setExpirationTime('7d')
        .sign(ENCODED_SECRET);

      return { accessToken: token, user };
    } catch (e: any) {
      set.status = 401;
      return { error: e.message || "Facebook native auth failed" };
    }
  })

  // POST /api/auth/twitter/native — For Mobile native SDK login
  .post("/api/auth/twitter/native", async ({ body, set }) => {
    try {
      const { email, name, twitterId, photoUrl, accessToken } = body as any;
      if (!twitterId) throw new Error("Missing Twitter ID");

      const finalEmail = email || `${twitterId}@twitter.reservatior.com`;
      let user = await prisma.user.findUnique({ where: { email: finalEmail } });
      if (!user) {
        user = await prisma.user.create({
          data: {
            email: finalEmail,
            name: name || "Twitter User",
            imageUrl: photoUrl || null,
          },
        });
        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "twitter",
            accountId: twitterId,
            accessToken: accessToken || "native_token",
          },
        });
      }

      let role = "USER";
      let permissions = ["PROPERTIES_VIEW_ALL"];
      let orgId = null;

      const token = await new SignJWT({ sub: user.id, email: user.email, role, permissions, orgId })
        .setProtectedHeader({ alg: 'HS256' })
        .setIssuedAt()
        .setExpirationTime('7d')
        .sign(ENCODED_SECRET);

      return { accessToken: token, user };
    } catch (e: any) {
      set.status = 401;
      return { error: e.message || "Twitter native auth failed" };
    }
  })

  // GET /api/auth/linkedin — redirect to LinkedIn OAuth
  .get("/api/auth/linkedin", ({ redirect, cookie: { state } }) => {
    const csrfState = Math.random().toString(36).substring(7);
    state?.set({ value: csrfState, path: "/api/auth/linkedin/callback", httpOnly: true, sameSite: "lax", maxAge: 300 });

    const params = new URLSearchParams({
      client_id: process.env.AUTH_LINKEDIN_ID || "",
      redirect_uri: `${SERVER_URL}/api/auth/linkedin/callback`,
      response_type: "code",
      scope: "openid profile email w_member_social w_organization_social rw_organization_admin",
      state: csrfState,
    });
    return redirect(`https://www.linkedin.com/oauth/v2/authorization?${params.toString()}`);
  })

  // GET /api/auth/linkedin/callback — handle LinkedIn OAuth callback
  .get("/api/auth/linkedin/callback", async ({ query, redirect, cookie: { state: storedState } }) => {
    const code = query.code as string;
    const returnedState = query.state as string;
    if (!code) return redirect(`${CLIENT_URL}/auth/callback?error=NoCode`);

    if (returnedState && storedState?.value && returnedState !== storedState.value) {
      return redirect(`${CLIENT_URL}/auth/login?error=StateMismatch`);
    }

    try {
      const clientId = process.env.AUTH_LINKEDIN_ID!;
      const clientSecret = process.env.AUTH_LINKEDIN_SECRET!;
      const redirectUri = `${SERVER_URL}/api/auth/linkedin/callback`;

      const tokenRes = await fetch("https://www.linkedin.com/oauth/v2/accessToken", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          client_id: clientId, client_secret: clientSecret, code,
          grant_type: "authorization_code", redirect_uri: redirectUri,
        }),
      });
      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) throw new Error("No access token");

      const userRes = await fetch("https://api.linkedin.com/v2/userinfo", {
        headers: { Authorization: `Bearer ${tokenData.access_token}` },
      });
      const linkedinUser = await userRes.json();
      if (!linkedinUser.email) throw new Error("No email in linkedin profile");

      const userEmail = linkedinUser.email;
      let user = await prisma.user.findUnique({ where: { email: userEmail } });
      if (!user) {
        user = await prisma.user.create({
          data: {
            email: userEmail,
            name: linkedinUser.name || linkedinUser.given_name || "",
            imageUrl: linkedinUser.picture || null,
          },
        });
        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "linkedin",
            accountId: linkedinUser.sub,
            accessToken: tokenData.access_token,
            refreshToken: tokenData.refresh_token || null,
          },
        });
      }

      console.log("[LinkedIn Auth] Person URN: urn:li:person:" + linkedinUser.sub);

      const { token, userData } = await createAuthSessionAndRedirect(user, "linkedin");
      return redirect(`${CLIENT_URL}/auth/callback?token=${token}&user=${encodeURIComponent(userData)}`);
    } catch (e) {
      console.error("LinkedIn auth callback error:", e);
      return redirect(`${CLIENT_URL}/auth/login?error=LinkedInAuthFailed`);
    }
  })

  // POST /api/auth/linkedin/native — For Mobile native SDK login
  .post("/api/auth/linkedin/native", async ({ body, set }) => {
    try {
      const { accessToken } = body as { accessToken: string };
      if (!accessToken) throw new Error("Missing access token");

      const userRes = await fetch("https://api.linkedin.com/v2/userinfo", {
        headers: { Authorization: `Bearer ${accessToken}` },
      });
      const linkedinUser = await userRes.json();
      if (!linkedinUser.email) throw new Error("No email in linkedin profile");

      const email = linkedinUser.email;
      let user = await prisma.user.findUnique({ where: { email } });
      if (!user) {
        user = await prisma.user.create({
          data: {
            email,
            name: linkedinUser.name || linkedinUser.given_name || "",
            imageUrl: linkedinUser.picture || null,
          },
        });
        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "linkedin",
            accountId: linkedinUser.sub,
            accessToken: accessToken,
          },
        });
      }

      let role = "USER";
      let permissions = ["PROPERTIES_VIEW_ALL"];
      let orgId = null;

      const token = await new SignJWT({ sub: user.id, email: user.email, role, permissions, orgId })
        .setProtectedHeader({ alg: 'HS256' })
        .setIssuedAt()
        .setExpirationTime('7d')
        .sign(ENCODED_SECRET);

      return { accessToken: token, user };
    } catch (e: any) {
      set.status = 401;
      return { error: e.message || "LinkedIn native auth failed" };
    }
  })

  // POST /api/linkedin/share — Share a post to LinkedIn
  .post("/api/linkedin/share", async ({ body, set }) => {
    try {
      const { accessToken, companyId, text } = body as { accessToken: string; companyId?: string; text: string };
      if (!accessToken || !text) {
        set.status = 400;
        return { error: "Missing required fields: accessToken, text" };
      }

      const result = await shareToLinkedInCompany(accessToken, text);
      if (!result.success) {
        set.status = 400;
        return { error: result.error };
      }

      return { success: true, postId: result.postId };
    } catch (e: any) {
      set.status = 500;
      return { error: e.message || "LinkedIn share failed" };
    }
  })

  // GET /api/auth/linkedin/account — Get LinkedIn account info for the authenticated user
  .get("/api/auth/linkedin/account", async ({ headers, set }) => {
    try {
      const authHeader = headers.authorization;
      if (!authHeader?.startsWith("Bearer ")) {
        set.status = 401;
        return { error: "Unauthorized" };
      }

      const token = authHeader.slice(7);
      const { payload } = await jwtVerify(token, ENCODED_SECRET) as any;

      const account = await prisma.account.findFirst({
        where: { userId: payload.sub, providerId: "linkedin" },
        select: { accountId: true, accessToken: true },
      });

      if (!account) {
        set.status = 404;
        return { error: "No LinkedIn account linked" };
      }

      return { authorId: account.accountId, accessToken: account.accessToken };
    } catch (e: any) {
      set.status = 401;
      return { error: "Invalid token" };
    }
  })

  .use(router)
  .use(fintechRoutes)
  .use(aiPricingIntelligenceRoutes)
  .use(commissionRuleEngineRoutes)
  .use(priceOptimizationDashboardRoutes)
  .use(cronScheduler) as unknown as Elysia;

// ── Additional route group (split to prevent TS type-depth overflow) ─────────
const app = (appBase as unknown as Elysia)
  // GET /api/plan and /api/v1/plan — public pricing plans
  .get("/api/plan", async ({ query }) => {
    const { planService } = await import("./services/plan");
    const { page = "1", limit = "20" } = query as any;
    return planService.getAll({
      skip: (parseInt(page as string) - 1) * parseInt(limit as string),
      take: parseInt(limit as string),
      orderBy: { createdAt: "desc" }
    });
  })
  .get("/api/v1/plan", async ({ query }) => {
    const { planService } = await import("./services/plan");
    const { page = "1", limit = "20" } = query as any;
    return planService.getAll({
      skip: (parseInt(page as string) - 1) * parseInt(limit as string),
      take: parseInt(limit as string),
      orderBy: { createdAt: "desc" }
    });
  })

  // GET /api/country-context — detect user's country/region from CDN headers
  .get("/api/country-context", ({ headers }) => {
    const cfCountry = headers['cf-ipcountry'] as string | undefined;
    const vercelCountry = headers['x-vercel-ip-country'] as string | undefined;
    const cloudfrontCountry = headers['cloudfront-viewer-country'] as string | undefined;
    const acceptLanguage = headers['accept-language'] as string | undefined;

    let country = (cfCountry || vercelCountry || cloudfrontCountry || '').toUpperCase();
    let detectionMethod = 'CDN-header';

    if (!country && acceptLanguage) {
      const parts = acceptLanguage.split(',');
      for (const part of parts) {
        const lang = part.split(';')[0].trim().split('-')[0].toLowerCase();
        const langToCountry: Record<string, string> = {
          tr: 'TR', en: 'US', ar: 'AE', es: 'ES',
          fr: 'FR', de: 'DE', ru: 'RU', pt: 'PT',
          zh: 'CN', ja: 'JP', ko: 'KR', it: 'IT',
          nl: 'NL', pl: 'PL', sv: 'SE', da: 'DK',
          fi: 'FI', el: 'GR', hi: 'IN', id: 'ID'
        };
        if (langToCountry[lang]) {
          country = langToCountry[lang];
          detectionMethod = 'Accept-Language';
          break;
        }
      }
    }

    if (!country) {
      country = 'US';
      detectionMethod = 'default';
    }

    const region = RegionManager.getRegion(country);
    if (!region) {
      const fallback = RegionManager.getRegion('US');
      return {
        region: 'US',
        currency: fallback?.currency || 'USD',
        locale: 'en-US',
        isRTL: false,
        detectionMethod: 'fallback-US'
      };
    }

    const rtlLangs: Record<string, boolean> = { ar: true };
    const localeMap: Record<string, string> = {
      TR: 'tr-TR', AE: 'ar-AE', US: 'en-US', UK: 'en-GB',
      ES: 'es-ES', FR: 'fr-FR', DE: 'de-DE',
      IT: 'it-IT', NL: 'nl-NL', PL: 'pl-PL',
      RU: 'ru-RU', PT: 'pt-PT', SE: 'sv-SE',
      DK: 'da-DK', FI: 'fi-FI', EL: 'el-GR',
      HI: 'hi-IN', ID: 'id-ID', CN: 'zh-CN',
      JP: 'ja-JP', KR: 'ko-KR'
    };

    return {
      region: region.countryCode,
      currency: region.currency,
      locale: localeMap[region.countryCode] || `${region.languageCode}-${region.countryCode}`,
      isRTL: !!rtlLangs[region.languageCode],
      detectionMethod
    };
  })

  // Webhooks
  .use(adsWebhookPlugin)

  .listen({ 
    port: Number(process.env.PORT) || 3000, 
    hostname: "0.0.0.0" 
  });

import { AIMailResponderService } from "./services/ai-mail-responder";

console.log("🦊 Elysia server is running at http://localhost:" + (process.env.PORT || 3000));
console.log("📚 Swagger docs available at http://localhost:" + (process.env.PORT || 3000) + "/docs");

// Initialize AI Mail Auto-Responder polling
// AIMailResponderService.startPolling();

// Initialize MLS RabbitMQ Consumer
import { initMlsConsumer } from "./services/mls-sync-consumer";
initMlsConsumer().catch(console.error);

// Initialize Autonomous Event-Driven Worker Pool
import { startWorkerPool } from "./workers/worker-pool";
startWorkerPool().catch(console.error);

// ─── Initialize Event Bus Outbox & Sagas ────────────────────────────────────
import { OutboxWorker } from "./core/events/outbox-worker";
import { initWebSocketGateway } from "./core/events/websocket-gateway";

initWebSocketGateway(); // Default port 3002

import { registerAgentOnboardingListeners } from "./core/workflows/agent-onboarding.saga";
import { registerListingPipelineListeners } from "./core/workflows/listing-pipeline.saga";
import { registerCommissionPaymentListeners } from "./core/workflows/commission-payment.saga";
import { registerAiMarketingListeners } from "./core/workflows/listeners/ai-marketing.listener";
import { registerInvestmentAnalysisListeners } from "./core/workflows/investment-analysis.saga";
import { registerMaintenanceOrchestrationListeners } from "./core/workflows/maintenance-orchestration.saga";
import { registerSecurityScreeningListeners } from "./core/workflows/security-screening.saga";

registerAgentOnboardingListeners();
registerListingPipelineListeners();
registerCommissionPaymentListeners();
registerAiMarketingListeners();
registerInvestmentAnalysisListeners();
registerMaintenanceOrchestrationListeners();
registerSecurityScreeningListeners();

import { registerGovernanceComplianceListeners } from "./core/workflows/governance-compliance.saga";
import { registerPartnerOnboardingListeners } from "./core/workflows/partner-onboarding.saga";
import { registerDeveloperApiLifecycleListeners } from "./core/workflows/developer-api-lifecycle.saga";
import { registerAnalyticsInsightListeners } from "./core/workflows/analytics-insight.saga";
import { registerDocumentComplianceListeners } from "./core/workflows/document-compliance.saga";
import { registerNotificationOrchestrationListeners } from "./core/workflows/notification-orchestration.saga";
import { registerIdentitySecurityListeners } from "./core/workflows/identity-security.saga";
import { registerLocalizationSyncListeners } from "./core/workflows/localization-sync.saga";

registerGovernanceComplianceListeners();
registerPartnerOnboardingListeners();
registerDeveloperApiLifecycleListeners();
registerAnalyticsInsightListeners();
registerDocumentComplianceListeners();
registerNotificationOrchestrationListeners();
registerIdentitySecurityListeners();
registerLocalizationSyncListeners();

// Initialize AI Intelligence Graph (subscribes to all domain events)
import { intelligenceGraph } from "./core/ai/intelligence-graph";

const outboxWorker = new OutboxWorker(5000); // Poll every 5s
outboxWorker.start();

// Initialize LinkedIn Auto-Poster
import { startLinkedInAutoPoster } from "./services/linkedin-auto-poster";
startLinkedInAutoPoster();

// Initialize Instagram Auto-Poster
import { startInstagramAutoPoster } from "./services/instagram-auto-poster";
startInstagramAutoPoster();

// Initialize Twitter/X Auto-Poster
import { startTwitterAutoPoster } from "./services/twitter-auto-poster";
startTwitterAutoPoster();

// Initialize Facebook Auto-Poster
import { startFacebookAutoPoster } from "./services/facebook-auto-poster";
startFacebookAutoPoster();

// Initialize Video Auto-Poster (TikTok & YouTube Shorts)
import { startVideoAutoPoster } from "./services/video-auto-poster";
startVideoAutoPoster();

export type App = typeof app;
export default app;
