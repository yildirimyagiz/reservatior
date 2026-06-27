import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { SignJWT, jwtVerify } from "jose";
import { ENCODED_SECRET } from "../lib/jwt";
import { authMiddleware } from "../middleware/auth";
import { userSyncService } from "../services/user-sync";
import { sendEmail } from "../lib/mail";
const CURRENT_REGION = process.env.REGION || "US";
const APP_URL = process.env.APP_URL || "http://localhost:3000";
const CLIENT_URL = process.env.CLIENT_URL || "http://localhost:3001";

function mapRegion(region: string): string {
  const map: Record<string, string> = {
    "US": "USA",
    "TR": "TR",
    "UK": "UK",
    "AE": "UAE",
    "DE": "DE",
    "FR": "FR",
    "ES": "ES",
    "IT": "IT",
    "JP": "JP",
    "KR": "KR",
    "CN": "CN",
    "RU": "RU",
    "SA": "SA",
    "CA": "CA",
    "SG": "SG",
    "AU": "AU",
    "NZ": "NZ",
    "NL": "NL",
    "MX": "MX",
    "BR": "BR",
    "IN": "IN",
    "TH": "TH",
    "MY": "MY",
    "AR": "AR",
  };
  return map[region] || "USA";
}
import crypto from "crypto";
import { writeFile, mkdir } from "fs/promises";
import { join } from "path";
import { v4 as uuidv4 } from "uuid";

const SALT_ROUNDS = 10;

async function hashPassword(password: string): Promise<string> {
  return Bun.password.hash(password, { algorithm: "bcrypt", cost: SALT_ROUNDS });
}

async function verifyPassword(password: string, hash: string): Promise<boolean> {
  return Bun.password.verify(password, hash);
}

export const authRoutes = new Elysia({ prefix: "/auth" })

  // POST /auth/register
  .post(
    "/register",
    async ({ body, set }) => {
      const { email, password, name, phone, organizationName, plan } = body;

      const existing = await prisma.user.findUnique({ where: { email } });
      if (existing) {
        set.status = 409;
        return { error: "Bu email zaten kayıtlı" };
      }

      const passwordHash = await hashPassword(password);

      const user = await prisma.user.create({
        data: { email, name, phone, originRegion: CURRENT_REGION },
      });

      await prisma.account.create({
        data: {
          userId: user.id,
          type: "CREDENTIALS",
          providerId: "credentials",
          accountId: email,
          accessToken: passwordHash,
        },
      });

      // --- SEND VERIFICATION EMAIL ---
      try {
        const verifyToken = crypto.randomBytes(32).toString("hex");
        await prisma.verification.create({
          data: {
            identifier: email,
            value: verifyToken,
            expiresAt: new Date(Date.now() + 24 * 60 * 60 * 1000),
          },
        });
        const verifyUrl = `${CLIENT_URL}/auth/verify-email?token=${verifyToken}`;
        await sendEmail({
          to: email,
          subject: "Reservatior - Email Doğrulama",
          html: `<p>Hoş geldiniz! Email adresinizi doğrulamak için <a href="${verifyUrl}">buraya tıklayın</a>.</p><p>Bu link 24 saat geçerlidir.</p>`,
        });
      } catch (err) {
        console.error("Failed to send verification email:", err);
      }

      // --- CREATE ORGANIZATION + MEMBERSHIP ---
      const orgName = organizationName || `${name || email}'s Organization`;
      
      const org = await prisma.organization.create({
        data: {
          name: orgName,
          type: "AGENCY",
          region: mapRegion(CURRENT_REGION) as any,
          defaultCurrency: "USD",
          defaultLocale: "en-US",
        },
      });

      // Create default OWNER role for the org
      const role = await prisma.role.findFirst({
        where: { orgId: org.id, key: "OWNER" },
      });

      let ownerRole = role;
      if (!ownerRole) {
        ownerRole = await prisma.role.create({
          data: {
            orgId: org.id,
            key: "OWNER",
            name: "Owner",
          },
        });
      }

      // Create membership linking user to org
      await prisma.organizationMember.create({
        data: {
          userId: user.id,
          orgId: org.id,
          roleId: ownerRole.id,
        },
      });

      // --- CREATE SUBSCRIPTION IF PLAN SELECTED ---
      if (plan) {
        const planDefs: Record<string, { name: string; priceMonthlyCents: number | null; limits: any }> = {
          "starter-10":       { name: "Starter",       priceMonthlyCents: 1900,  limits: { maxProperties: 10, maxUsers: 1, maxListings: 25, aiFeatures: false } },
          "growth-25":        { name: "Growth",        priceMonthlyCents: 4900,  limits: { maxProperties: 25, maxUsers: 3, maxListings: 100, aiFeatures: false } },
          "professional-50":  { name: "Professional",  priceMonthlyCents: 8000,  limits: { maxProperties: 50, maxUsers: 5, maxListings: 250, aiFeatures: true } },
          "agency-100":       { name: "Agency",         priceMonthlyCents: 15000, limits: { maxProperties: 100, maxUsers: 10, maxListings: 500, aiFeatures: true } },
          "enterprise":       { name: "Enterprise",     priceMonthlyCents: null,  limits: { maxProperties: 9999, maxUsers: 999, maxListings: 9999, aiFeatures: true } },
        };

        const pd = planDefs[plan];
        if (pd) {
          let planRecord = await prisma.plan.findUnique({ where: { key: plan } });
          if (!planRecord) {
            planRecord = await prisma.plan.create({
              data: {
                key: plan,
                name: pd.name,
                priceMonthlyCents: pd.priceMonthlyCents,
                limits: pd.limits,
              },
            });
          }

          await prisma.orgSubscription.create({
            data: {
              orgId: org.id,
              planId: planRecord.id,
              status: "ACTIVE",
              currentPeriodEnd: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
            },
          });

          // Also create a Subscription record to keep both plan systems in sync
          await prisma.subscription.create({
            data: {
              orgId: org.id,
              userId: user.id,
              name: pd.name,
              type: "PREMIUM",
              price: new (await import("@prisma/client")).Prisma.Decimal((pd.priceMonthlyCents || 0) / 100),
              currency: "USD",
              billingCycle: "MONTHLY",
              maxProperties: pd.limits.maxProperties || 1,
              maxListings: pd.limits.maxListings || 5,
              featuredListings: pd.limits.featuredListings || 0,
              prioritySupport: pd.limits.prioritySupport || false,
              apiAccess: pd.limits.apiAccess || false,
              commissionDiscount: pd.limits.commissionDiscount || 0,
              loyaltyMultiplier: pd.limits.loyaltyMultiplier || 1,
              isActive: true,
            },
          });
        }
      }

      // --- DYNAMIC RBAC LOGIC ---
      const dbUser = await prisma.user.findUnique({
        where: { id: user.id },
        include: {
          memberships: {
            include: {
              role: {
                include: {
                  permissions: {
                    include: { permission: true }
                  }
                }
              }
            }
          }
        }
      });

      let finalRole = "ORG_ADMIN";
      let permissions: string[] = ["PROPERTIES_VIEW_ALL"];
      let orgId = org.id;

      if (dbUser?.memberships && dbUser.memberships.length > 0) {
        const primaryMember = dbUser.memberships[0];
        finalRole = primaryMember.role.key;
        orgId = primaryMember.orgId;
        permissions = primaryMember.role.permissions.map(rp => rp.permission.key);
      }

      const superAdminEmails = [
        "yagizyildirim@icloud.com", 
        "admin@propos.com", 
        "info@reservatior.com",
        "admin@demorealty.com"
      ];
      if (superAdminEmails.includes(user.email)) {
        finalRole = "OWNER";
        permissions = ["*"];
      }

      const token = await new SignJWT({ 
        sub: user.id, 
        email: user.email,
        role: finalRole,
        permissions,
        orgId
      })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuedAt()
      .setExpirationTime('7d')
      .sign(ENCODED_SECRET);

      return {
        token,
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          role: finalRole,
          permissions,
          organizationId: orgId,
          locale: user.locale ?? "en-US",
          timezone: user.timezone ?? "UTC",
          createdAt: user.createdAt.toISOString(),
          updatedAt: user.updatedAt.toISOString(),
        }
      };
    },
    {
      body: t.Object({
        email: t.String({ format: "email" }),
        password: t.String({ minLength: 8 }),
        name: t.Optional(t.String()),
        phone: t.Optional(t.String()),
        organizationName: t.Optional(t.String()),
        plan: t.Optional(t.String()),
      }),
    }
  )

  // POST /auth/login
  .post(
    "/login",
    async ({ body, set }) => {
      const { email, password } = body;

      // On-Demand Cloning Check
      let user = await prisma.user.findUnique({ 
        where: { email },
        include: {
          preferences: true,
          agencies: {
            take: 1,
            include: { Organization: true }
          }
        }
      });

      if (!user) {
        // User not found locally, try to clone from other regions
        const cloned = await userSyncService.cloneUserIfNeeded(email, CURRENT_REGION);
        if (cloned) {
          // Re-fetch the newly cloned user
          user = await prisma.user.findUnique({ 
            where: { email },
            include: {
              preferences: true,
              agencies: {
                take: 1,
                include: { Organization: true }
              }
            }
          });
        }
      }
      console.log(`🔑 Login Attempt: [${email}]`);
      if (!user) {
        console.log(`❌ Login Failed: User [${email}] not found.`);
        set.status = 401;
        return { error: "Geçersiz email veya şifre" };
      }

      const account = await prisma.account.findFirst({
        where: { userId: user.id, providerId: "credentials" },
      });
      if (!account?.accessToken) {
        console.log(`❌ Login Failed: No credentials account for [${email}].`);
        set.status = 401;
        return { error: "Geçersiz email veya şifre" };
      }

      const valid = await verifyPassword(password, account.accessToken);
      if (!valid) {
        console.log(`❌ Login Failed: Invalid password for [${email}].`);
        set.status = 401;
        return { error: "Geçersiz email veya şifre" };
      }
      console.log(`✅ Login Success: [${email}]`);

      // --- DYNAMIC RBAC LOGIC ---
      let role = "USER";
      let permissions: string[] = ["PROPERTIES_VIEW_ALL"];
      let orgId = user.preferences?.orgId || (user.agencies[0]?.organizationId) || null;

      const dbUser = await prisma.user.findUnique({
        where: { id: user.id },
        include: {
          memberships: {
            include: {
              role: {
                include: {
                  permissions: {
                    include: { permission: true }
                  }
                }
              }
            }
          }
        }
      });

      if (dbUser?.memberships && dbUser.memberships.length > 0) {
        // If multiple orgs, we could filter by orgId if provided in body, but for now take first
        const primaryMember = dbUser.memberships[0];
        role = primaryMember.role.key;
        orgId = primaryMember.orgId;
        permissions = primaryMember.role.permissions.map(rp => rp.permission.key);
      }

      // Superadmin safety fallback
      const superAdminEmails = [
        "yagizyildirim@icloud.com", 
        "admin@propos.com", 
        "info@reservatior.com",
        "admin@demorealty.com"
      ];
      if (superAdminEmails.includes(user.email)) {
        role = "OWNER";
        permissions = ["*"];
      }

      const token = await new SignJWT({ 
        sub: user.id, 
        email: user.email,
        role,
        orgId,
        permissions
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

      return {
        token,
        sessionId: session.id,
        user: { 
          id: user.id, 
          email: user.email, 
          name: user.name,
          imageUrl: user.imageUrl,
          role,
          permissions,
          organizationId: orgId,
          originRegion: user.originRegion
        },
      };
    },
    {
      body: t.Object({
        email: t.String({ format: "email" }),
        password: t.String(),
      }),
    }
  )

  // POST /auth/logout
  .post(
    "/logout",
    async ({ headers, set }) => {
      const token = headers.authorization?.replace("Bearer ", "");
      if (token) {
        const tokenHash = token.split(".").pop() ?? token;
        await prisma.session.deleteMany({ where: { tokenHash } });
      }
      set.status = 204;
      return null;
    }
  )

  // GET /auth/facebook
  .get("/facebook", ({ redirect }) => {
    const params = new URLSearchParams({
      client_id: process.env.FACEBOOK_APP_ID || "",
      redirect_uri: `${APP_URL}/api/v1/auth/facebook/callback`,
      response_type: "code",
      scope: "email public_profile",
    });
    return redirect(`https://www.facebook.com/v18.0/dialog/oauth?${params.toString()}`);
  })

  // GET /auth/facebook/callback
  .get("/facebook/callback", async ({ query, redirect }) => {
    const code = query.code as string;
    if (!code) {
      return redirect(`${CLIENT_URL}/auth/callback?error=NoCode`);
    }

    try {
      const clientId = process.env.FACEBOOK_APP_ID!;
      const clientSecret = process.env.FACEBOOK_APP_SECRET!;
      const redirectUri = `${APP_URL}/api/v1/auth/facebook/callback`;

      const tokenRes = await fetch(`https://graph.facebook.com/v18.0/oauth/access_token?client_id=${clientId}&client_secret=${clientSecret}&code=${code}&redirect_uri=${redirectUri}`, {
        method: "GET",
      });

      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) throw new Error("No access token");

      const userRes = await fetch(`https://graph.facebook.com/v18.0/me?fields=id,name,email&access_token=${tokenData.access_token}`, {
        method: "GET",
      });
      const facebookUser = await userRes.json();

      if (!facebookUser.email) throw new Error("No email in facebook profile");

      let user = await prisma.user.findUnique({ where: { email: facebookUser.email } });
      if (!user) {
        const cloned = await userSyncService.cloneUserIfNeeded(facebookUser.email, CURRENT_REGION);
        if (cloned) user = await prisma.user.findUnique({ where: { email: facebookUser.email } });
      }
      if (!user) {
        user = await prisma.user.create({
          data: {
            email: facebookUser.email,
            name: facebookUser.name || "",
            originRegion: CURRENT_REGION
          },
        });

        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "facebook",
            accountId: facebookUser.id,
            accessToken: tokenData.access_token,
          },
        });
      }

      // --- RBAC: query memberships like in login/register ---
      const dbUser = await prisma.user.findUnique({
        where: { id: user.id },
        include: {
          memberships: {
            include: {
              role: {
                include: { permissions: { include: { permission: true } } }
              }
            }
          }
        }
      });

      let role = "USER";
      let permissions: string[] = ["PROPERTIES_VIEW_ALL"];
      let orgId: string | null = null;

      if (dbUser?.memberships && dbUser.memberships.length > 0) {
        const primaryMember = dbUser.memberships[0];
        role = primaryMember.role.key;
        orgId = primaryMember.orgId;
        permissions = primaryMember.role.permissions.map(rp => rp.permission.key);
      }

      const superAdminEmails = [
        "yagizyildirim@icloud.com", "admin@propos.com",
        "info@reservatior.com", "admin@demorealty.com"
      ];
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

      return redirect(`${CLIENT_URL}/auth/callback?token=${token}&user=${encodeURIComponent(JSON.stringify({
        id: user.id,
        email: user.email,
        name: user.name,
        imageUrl: user.imageUrl,
        role,
        permissions,
        organizationId: orgId,
        originRegion: user.originRegion
      }))}`);
    } catch (e) {
      console.error("Facebook auth callback error:", e);
      return redirect(`${CLIENT_URL}/auth/login?error=FacebookAuthFailed`);
    }
  })

  // GET /auth/twitter
  .get("/twitter", ({ redirect }) => {
    const params = new URLSearchParams({
      client_id: process.env.TWITTER_API_KEY || "",
      redirect_uri: `${APP_URL}/api/v1/auth/twitter/callback`,
      response_type: "code",
      scope: "tweet.read users.read email.read",
      state: Math.random().toString(36).substring(7),
    });
    return redirect(`https://twitter.com/i/oauth2/authorize?${params.toString()}`);
  })

  // GET /auth/twitter/callback
  .get("/twitter/callback", async ({ query, redirect }) => {
    const code = query.code as string;
    const state = query.state as string;
    if (!code) {
      return redirect(`${CLIENT_URL}/auth/callback?error=NoCode`);
    }

    try {
      const clientId = process.env.TWITTER_API_KEY!;
      const clientSecret = process.env.TWITTER_API_SECRET!;
      const redirectUri = `${APP_URL}/api/v1/auth/twitter/callback`;

      const tokenRes = await fetch("https://api.twitter.com/2/oauth2/token", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": `Basic ${Buffer.from(`${clientId}:${clientSecret}`).toString("base64")}`,
        },
        body: new URLSearchParams({
          code,
          grant_type: "authorization_code",
          redirect_uri: redirectUri,
        }),
      });

      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) throw new Error("No access token");

      const userRes = await fetch("https://api.twitter.com/2/users/me?user.fields=username,name,email", {
        headers: { Authorization: `Bearer ${tokenData.access_token}` },
      });
      const twitterUser = await userRes.json();

      if (!twitterUser.data) throw new Error("No user data from Twitter");

      // Twitter doesn't always provide email, need to request additional permission
      const emailRes = await fetch("https://api.twitter.com/2/users/me?user.fields=email", {
        headers: { Authorization: `Bearer ${tokenData.access_token}` },
      });
      const emailData = await emailRes.json();
      const email = emailData.data?.email || `${twitterUser.data.username}@twitter.com`;

      let user = await prisma.user.findUnique({ where: { email } });
      if (!user) {
        const cloned = await userSyncService.cloneUserIfNeeded(email, CURRENT_REGION);
        if (cloned) user = await prisma.user.findUnique({ where: { email } });
      }
      if (!user) {
        // Try on-demand sync
        const cloned = await userSyncService.cloneUserIfNeeded(email, CURRENT_REGION);
        if (cloned) {
          user = await prisma.user.findUnique({ where: { email } });
        }
      }
      if (!user) {
        user = await prisma.user.create({
          data: {
            email: email,
            name: twitterUser.data.name || twitterUser.data.username || "",
            originRegion: CURRENT_REGION
          },
        });

        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "twitter",
            accountId: twitterUser.data.id,
            accessToken: tokenData.access_token,
          },
        });
      }

      // --- RBAC: query memberships like in login/register ---
      const dbUser = await prisma.user.findUnique({
        where: { id: user.id },
        include: {
          memberships: {
            include: {
              role: {
                include: { permissions: { include: { permission: true } } }
              }
            }
          }
        }
      });

      let role = "USER";
      let permissions: string[] = ["PROPERTIES_VIEW_ALL"];
      let orgId: string | null = null;

      if (dbUser?.memberships && dbUser.memberships.length > 0) {
        const primaryMember = dbUser.memberships[0];
        role = primaryMember.role.key;
        orgId = primaryMember.orgId;
        permissions = primaryMember.role.permissions.map(rp => rp.permission.key);
      }

      const superAdminEmails = [
        "yagizyildirim@icloud.com", "admin@propos.com",
        "info@reservatior.com", "admin@demorealty.com"
      ];
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

      return redirect(`${CLIENT_URL}/auth/callback?token=${token}&user=${encodeURIComponent(JSON.stringify({
        id: user.id,
        email: user.email,
        name: user.name,
        imageUrl: user.imageUrl,
        role,
        permissions,
        organizationId: orgId,
        originRegion: user.originRegion
      }))}`);
    } catch (e) {
      console.error("Twitter auth callback error:", e);
      return redirect(`${CLIENT_URL}/auth/login?error=TwitterAuthFailed`);
    }
  })

  // GET /auth/google
  .get("/google", ({ redirect }) => {
    const params = new URLSearchParams({
      client_id: process.env.AUTH_GOOGLE_ID || "",
      redirect_uri: `${APP_URL}/api/v1/auth/google/callback`,
      response_type: "code",
      scope: "email profile",
    });
    return redirect(`https://accounts.google.com/o/oauth2/v2/auth?${params.toString()}`);
  })

  // GET /auth/google/callback
  .get("/google/callback", async ({ query, redirect }) => {
    const code = query.code as string;
    if (!code) {
      return redirect(`${CLIENT_URL}/auth/callback?error=NoCode`);
    }

    try {
      const clientId = process.env.AUTH_GOOGLE_ID!;
      const clientSecret = process.env.AUTH_GOOGLE_SECRET!;
      const redirectUri = `${APP_URL}/api/v1/auth/google/callback`;

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
      if (!tokenData.access_token) throw new Error("No access token");

      const userRes = await fetch("https://www.googleapis.com/oauth2/v2/userinfo", {
        headers: { Authorization: `Bearer ${tokenData.access_token}` },
      });
      const googleUser = await userRes.json();

      if (!googleUser.email) throw new Error("No email in google profile");

      let user = await prisma.user.findUnique({ where: { email: googleUser.email } });
      if (!user) {
        // Try on-demand sync before creating a brand new one
        const cloned = await userSyncService.cloneUserIfNeeded(googleUser.email, CURRENT_REGION);
        if (cloned) {
          user = await prisma.user.findUnique({ where: { email: googleUser.email } });
        }
      }
      if (!user) {
        user = await prisma.user.create({
          data: {
            email: googleUser.email,
            name: googleUser.name || googleUser.given_name || "",
            imageUrl: googleUser.picture || null,
            originRegion: CURRENT_REGION
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

      const role = "USER";
      const permissions = ["PROPERTIES_VIEW_ALL"];
      const token = await new SignJWT({
        sub: user.id,
        email: user.email,
        role,
        permissions,
        orgId: null
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

      return redirect(`${CLIENT_URL}/auth/callback?token=${token}&user=${encodeURIComponent(JSON.stringify({
        id: user.id,
        email: user.email,
        name: user.name,
        imageUrl: user.imageUrl,
        role,
        permissions,
        organizationId: null,
        originRegion: user.originRegion
      }))}`);
    } catch (e) {
      console.error("Google auth callback error:", e);
      return redirect(`${CLIENT_URL}/auth/login?error=GoogleAuthFailed`);
    }
  })

  // POST /auth/google — verify Google ID token from client-side GSI
  .post("/google", async ({ body, set }) => {
    const { credential } = body as { credential: string };
    if (!credential) {
      set.status = 400;
      return { error: "Missing Google credential" };
    }

    try {
      // Verify the Google ID token
      const clientId = process.env.AUTH_GOOGLE_ID!;
      const verifyRes = await fetch(`https://oauth2.googleapis.com/tokeninfo?id_token=${credential}`);
      const payload = await verifyRes.json();

      if (payload.error || payload.aud !== clientId) {
        set.status = 401;
        return { error: "Invalid Google token" };
      }

      const email = payload.email;
      const name = payload.name || payload.given_name || "";
      const googleId = payload.sub;

      if (!email) {
        set.status = 400;
        return { error: "No email in Google profile" };
      }

      // Find or create user
      let user = await prisma.user.findUnique({ where: { email } });
      if (!user) {
        const cloned = await userSyncService.cloneUserIfNeeded(email, CURRENT_REGION);
        if (cloned) user = await prisma.user.findUnique({ where: { email } });
      }
      if (!user) {
        user = await prisma.user.create({
          data: { email, name, imageUrl: payload.picture || null, originRegion: CURRENT_REGION },
        });

        await prisma.account.create({
          data: {
            userId: user.id,
            type: "OAUTH",
            providerId: "google",
            accountId: googleId,
            accessToken: credential,
          },
        });
      }

      // RBAC
      let role = "USER";
      let permissions: string[] = ["PROPERTIES_VIEW_ALL"];
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

      return {
        token,
        sessionId: session.id,
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          imageUrl: user.imageUrl,
          role,
          permissions,
          organizationId: orgId,
          originRegion: user.originRegion
        },
      };
    } catch (e: any) {
      console.error("Google auth error:", e);
      set.status = 500;
      return { error: "Google authentication failed" };
    }
  })

  // POST /auth/google/code — exchange code with postmessage (popup-based GSI flow)
  .post("/google/code", async ({ body, set }) => {
    const { code } = body as { code: string };
    if (!code) {
      set.status = 400;
      return { error: "Missing Google authorization code" };
    }

    try {
      const clientId = process.env.AUTH_GOOGLE_ID!;
      const clientSecret = process.env.AUTH_GOOGLE_SECRET!;
      
      const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          client_id: clientId,
          client_secret: clientSecret,
          code,
          grant_type: "authorization_code",
          redirect_uri: "postmessage",
        }),
      });

      const tokenData = await tokenRes.json();
      if (!tokenData.access_token) {
        console.error("Token exchange failed:", tokenData);
        set.status = 400;
        return { error: "Failed to exchange authorization code", details: tokenData };
      }

      const userRes = await fetch("https://www.googleapis.com/oauth2/v2/userinfo", {
        headers: { Authorization: `Bearer ${tokenData.access_token}` },
      });
      const googleUser = await userRes.json();

      if (!googleUser.email) {
        set.status = 400;
        return { error: "No email in Google profile" };
      }

      // Find or create user
      let user = await prisma.user.findUnique({ where: { email: googleUser.email } });
      if (!user) {
        user = await prisma.user.create({
          data: {
            email: googleUser.email,
            name: googleUser.name || googleUser.given_name || "",
            imageUrl: googleUser.picture || null,
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

      // RBAC
      let role = "USER";
      let permissions: string[] = ["PROPERTIES_VIEW_ALL"];
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

      return {
        token,
        sessionId: session.id,
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          imageUrl: user.imageUrl,
          role,
          permissions,
          organizationId: orgId,
          originRegion: user.originRegion
        },
      };
    } catch (e: any) {
      console.error("Google code login error:", e);
      set.status = 500;
      return { error: "Google authentication failed" };
    }
  })

  // GET /auth/me
  .get(
    "/me",
    async ({ headers, set }) => {
      const token = headers.authorization?.replace("Bearer ", "");
      if (!token) { set.status = 401; return { error: "Unauthorized" }; }

      try {
        const { payload } = await jwtVerify(token, ENCODED_SECRET);

      const user = await prisma.user.findUnique({
        where: { id: payload.sub as string },
        include: { 
          preferences: true,
          agencies: {
            take: 1,
            include: { Organization: true }
          }
        },
      });

      if (!user) { set.status = 404; return { error: "Kullanıcı bulunamadı" }; }

      // Re-determine role and orgId for consistency
      let role = (payload as any).role || "USER";
      let permissions = (payload as any).permissions || ["read:properties"];
      let orgId = (payload as any).orgId || user.preferences?.orgId || null;

      // Ensure superadmins get their rights even if token is old
      if (user.email === "yagizyildirim@icloud.com" || user.email === "admin@demorealty.com" || user.email === "admin@propos.com" || user.email === "info@reservatior.com") {
        role = "SUPER_ADMIN";
        permissions = ["*"];
      }

        return { 
          user: {
            ...user,
            role,
            permissions,
          organizationId: orgId,
          originRegion: user.originRegion
          } 
        };
      } catch (e: any) {
        set.status = 401;
        return { error: "Unauthorized" };
      }
    }
  )

  // POST /auth/change-password
  .post(
    "/change-password",
    async ({ body, headers, set }) => {
      const token = headers.authorization?.replace("Bearer ", "");
      if (!token) { set.status = 401; return { error: "Unauthorized" }; }

      try {
        const { payload } = await jwtVerify(token, ENCODED_SECRET);

      const { currentPassword, newPassword } = body;

      const account = await prisma.account.findFirst({
        where: { userId: payload.sub as string, providerId: "credentials" },
      });
      if (!account?.accessToken) { set.status = 400; return { error: "Şifre bulunamadı" }; }

      const valid = await verifyPassword(currentPassword, account.accessToken);
      if (!valid) { set.status = 401; return { error: "Mevcut şifre yanlış" }; }

      const newHash = await hashPassword(newPassword);
      await prisma.account.update({
        where: { id: account.id },
        data: { accessToken: newHash },
      });

      return { message: "Şifre güncellendi" };
      } catch (e: any) {
        set.status = 401;
        return { error: "Unauthorized" };
      }
    },
    {
      body: t.Object({
        currentPassword: t.String(),
        newPassword: t.String({ minLength: 8 }),
      }),
    }
  )

  // POST /auth/forgot-password
  .post(
    "/forgot-password",
    async ({ body, set }) => {
      const { email } = body;
      const user = await prisma.user.findUnique({ where: { email } });
      if (!user) {
        set.status = 404;
        return { error: "Bu email ile kayıtlı kullanıcı bulunamadı" };
      }

      const token = crypto.randomBytes(32).toString("hex");
      const expiresAt = new Date(Date.now() + 60 * 60 * 1000); // 1 hour

      await prisma.verification.create({
        data: {
          identifier: email,
          value: token,
          expiresAt,
        },
      });

      const resetUrl = `${CLIENT_URL}/auth/reset-password?token=${token}`;
      await sendEmail({
        to: email,
        subject: "Reservatior - Şifre Sıfırlama",
        html: `<p>Şifrenizi sıfırlamak için <a href="${resetUrl}">buraya tıklayın</a>.</p><p>Bu link 1 saat geçerlidir.</p>`,
      });

      return { message: "Şifre sıfırlama linki email adresinize gönderildi" };
    },
    {
      body: t.Object({
        email: t.String({ format: "email" }),
      }),
    }
  )

  // POST /auth/reset-password
  .post(
    "/reset-password",
    async ({ body, set }) => {
      const { token, newPassword } = body;

      const verification = await prisma.verification.findFirst({
        where: { value: token, expiresAt: { gte: new Date() } },
      });
      if (!verification) {
        set.status = 400;
        return { error: "Geçersiz veya süresi dolmuş token" };
      }

      const user = await prisma.user.findUnique({
        where: { email: verification.identifier },
      });
      if (!user) {
        set.status = 404;
        return { error: "Kullanıcı bulunamadı" };
      }

      const passwordHash = await hashPassword(newPassword);
      await prisma.account.updateMany({
        where: { userId: user.id, providerId: "credentials" },
        data: { accessToken: passwordHash },
      });

      await prisma.verification.delete({ where: { id: verification.id } });

      return { message: "Şifre başarıyla güncellendi" };
    },
    {
      body: t.Object({
        token: t.String(),
        newPassword: t.String({ minLength: 8 }),
      }),
    }
  )

  // POST /auth/verify-email
  .post(
    "/verify-email",
    async ({ body, set }) => {
      const { token } = body;
      const verification = await prisma.verification.findFirst({
        where: { value: token, expiresAt: { gte: new Date() } },
      });
      if (!verification) {
        set.status = 400;
        return { error: "Geçersiz veya süresi dolmuş token" };
      }

      await prisma.verification.delete({ where: { id: verification.id } });
      return { message: "Email başarıyla doğrulandı" };
    },
    {
      body: t.Object({
        token: t.String(),
      }),
    }
  )

  // POST /auth/resend-verification
  .post(
    "/resend-verification",
    async ({ body }) => {
      const { email } = body;
      const token = crypto.randomBytes(32).toString("hex");
      const expiresAt = new Date(Date.now() + 60 * 60 * 1000);

      await prisma.verification.create({
        data: {
          identifier: email,
          value: token,
          expiresAt,
        },
      });

      const verifyUrl = `${CLIENT_URL}/auth/verify-email?token=${token}`;
      await sendEmail({
        to: email,
        subject: "Reservatior - Email Doğrulama",
        html: `<p>Email adresinizi doğrulamak için <a href="${verifyUrl}">buraya tıklayın</a>.</p>`,
      });

      return { message: "Doğrulama emaili gönderildi" };
    },
    {
      body: t.Object({
        email: t.String({ format: "email" }),
      }),
    }
  )

  // POST /auth/refresh
  .post(
    "/refresh",
    async ({ body, set }) => {
      const { refreshToken } = body as { refreshToken: string };
      if (!refreshToken) {
        set.status = 400;
        return { error: "Refresh token gerekli" };
      }

      try {
        const { payload } = await jwtVerify(refreshToken, ENCODED_SECRET);
        const user = await prisma.user.findUnique({
          where: { id: payload.sub as string },
        });
        if (!user) {
          set.status = 404;
          return { error: "Kullanıcı bulunamadı" };
        }

        const token = await new SignJWT({
          sub: user.id,
          email: user.email,
          role: (payload as any).role || "USER",
          permissions: (payload as any).permissions || ["PROPERTIES_VIEW_ALL"],
          orgId: (payload as any).orgId || null,
        })
          .setProtectedHeader({ alg: "HS256" })
          .setIssuedAt()
          .setExpirationTime("7d")
          .sign(ENCODED_SECRET);

        return { token, refreshToken: token };
      } catch {
        set.status = 401;
        return { error: "Geçersiz refresh token" };
      }
    }
  )

  // ─── API TOKENS ──────────────────────────────────────────────────────────────

  .get("/tokens", async ({ query }) => {
    const { userId } = query as any;
    const where: any = { deletedAt: null };
    if (userId) where.userId = userId;
    const data = await prisma.apiToken.findMany({
      where, orderBy: { createdAt: "desc" },
      select: {
        id: true, userId: true, name: true, scopes: true,
        lastUsedAt: true, createdAt: true, updatedAt: true,
      },
    });
    return { data };
  })

  .post("/tokens", async ({ body, set }) => {
    const rawToken = crypto.randomBytes(32).toString("hex");
    const tokenHash = crypto.createHash("sha256").update(rawToken).digest("hex");
    const token = await prisma.apiToken.create({
      data: { ...(body as any), tokenHash },
    });
    set.status = 201;
    return { data: { ...token, token: rawToken } };
  }, {
    body: t.Object({
      userId: t.String(), name: t.String(),
      scopes: t.Optional(t.Array(t.String())),
    }),
  })

  .get("/tokens/:id", async ({ params, set }) => {
    const token = await prisma.apiToken.findFirst({
      where: { id: params.id, deletedAt: null },
      select: {
        id: true, userId: true, name: true, scopes: true,
        lastUsedAt: true, createdAt: true, updatedAt: true,
      },
    });
    if (!token) { set.status = 404; return { error: "Token not found" }; }
    return { data: token };
  })

  .patch("/tokens/:id", async ({ params, body }) => {
    const token = await prisma.apiToken.update({
      where: { id: params.id }, data: body as any,
    });
    return { data: token };
  }, {
    body: t.Partial(t.Object({ name: t.String(), scopes: t.Array(t.String()) })),
  })

  .delete("/tokens/:id", async ({ params }) => {
    await prisma.apiToken.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
    return { message: "Token revoked" };
  })

  // ─── VERIFICATIONS ─────────────────────────────────────────────────────────--

  .get("/verifications", async ({ query }) => {
    const { identifier } = query as any;
    const where: any = {};
    if (identifier) where.identifier = identifier;
    const data = await prisma.verification.findMany({ where, orderBy: { createdAt: "desc" } });
    return { data };
  })

  .post("/verifications", async ({ body, set }) => {
    const v = await prisma.verification.create({ data: body as any });
    set.status = 201;
    return { data: v };
  }, {
    body: t.Object({
      identifier: t.String(), value: t.String(), expiresAt: t.String(),
    }),
  })

  .get("/verifications/:id", async ({ params, set }) => {
    const v = await prisma.verification.findUnique({ where: { id: params.id } });
    if (!v) { set.status = 404; return { error: "Verification not found" }; }
    return { data: v };
  })

  .delete("/verifications/:id", async ({ params }) => {
    await prisma.verification.delete({ where: { id: params.id } });
    return { message: "Verification deleted" };
  })

  // ─── ATTACHMENTS ─────────────────────────────────────────────────────────────

  .get("/attachments", async ({ query }) => {
    const { orgId, entityType, entityId, propertyId } = query as any;
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (entityType) where.entityType = entityType;
    if (entityId) where.entityId = entityId;
    if (propertyId) where.propertyId = propertyId;
    const data = await prisma.attachment.findMany({
      where, orderBy: { createdAt: "desc" },
    });
    return { data };
  })

  .post("/attachments", async ({ body, set }) => {
    const att = await prisma.attachment.create({ data: body as any });
    set.status = 201;
    return { data: att };
  }, {
    body: t.Object({
      orgId: t.String(), entityType: t.String(), entityId: t.String(),
      fileName: t.String(), mimeType: t.String(), sizeBytes: t.Number(), storageKey: t.String(),
      propertyId: t.Optional(t.String()), url: t.Optional(t.String()),
      checksum: t.Optional(t.String()), createdBy: t.Optional(t.String()),
      taskId: t.Optional(t.String()), messageId: t.Optional(t.String()),
    }),
  })

  .get("/attachments/:id", async ({ params, set }) => {
    const att = await prisma.attachment.findFirst({
      where: { id: params.id, deletedAt: null },
    });
    if (!att) { set.status = 404; return { error: "Attachment not found" }; }
    return { data: att };
  })

  .delete("/attachments/:id", async ({ params }) => {
    await prisma.attachment.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
    return { message: "Attachment deleted" };
  })

  // POST /auth/avatar — Upload user avatar
  .post("/avatar", async ({ body, set, request }) => {
    const { file } = body;
    if (!file) {
      set.status = 400;
      return { error: "No file provided" };
    }
    const uploadsDir = join(process.cwd(), "ml-services", "comfysetup", "backend", "uploads", "avatars");
    await mkdir(uploadsDir, { recursive: true });
    const ext = file.name.split(".").pop() || "png";
    const fileName = `${uuidv4()}.${ext}`;
    const filePath = join(uploadsDir, fileName);
    const buffer = await file.arrayBuffer();
    await writeFile(filePath, Buffer.from(buffer));
    const url = `/uploads/avatars/${fileName}`;
    return { data: { url, fileName, size: file.size, mimeType: file.type } };
  }, {
    body: t.Object({ file: t.File() }),
  });
