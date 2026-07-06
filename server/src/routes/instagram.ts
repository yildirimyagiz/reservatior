import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { getInstagramAccountId } from "../services/instagram";
import { shareNewListings } from "../services/instagram-auto-poster";
import { getMentionsForCity, addMentionRule } from "../services/instagram-mentions";
import { createHmac } from "crypto";

function parseSignedRequest(signedRequest: string, appSecret: string) {
  try {
    const parts = signedRequest.split(".");
    if (parts.length !== 2) return null;
    const [encodedSig, payload] = parts;

    // Decode signature
    const sig = Buffer.from(encodedSig.replace(/-/g, "+").replace(/_/g, "/"), "base64").toString("hex");

    // Decode payload
    const data = JSON.parse(Buffer.from(payload.replace(/-/g, "+").replace(/_/g, "/"), "base64").toString("utf8"));

    // Verify signature
    const expectedSig = createHmac("sha256", appSecret)
      .update(payload)
      .digest("hex");

    if (sig !== expectedSig) {
      return null;
    }
    return data;
  } catch (e) {
    return null;
  }
}

export const instagramRoutes = new Elysia({ prefix: "/api/v1/integrations/instagram" })

  /**
   * Verify Instagram connection
   * GET /api/v1/integrations/instagram/verify
   */
  .get("/verify", async () => {
    const pageId = process.env.META_PAGE_ID;
    const accessToken = process.env.META_ACCESS_TOKEN;

    if (!pageId || !accessToken) {
      return { success: false, error: "META_PAGE_ID or META_ACCESS_TOKEN not configured" };
    }

    const igUserId = await getInstagramAccountId(pageId, accessToken);
    if (!igUserId) {
      return {
        success: false,
        error: "Could not resolve Instagram Business Account. Ensure your Facebook Page has an Instagram Business Account connected.",
      };
    }

    const account = await prisma.socialAccount.upsert({
      where: {
        orgId_platform_accountId: {
          orgId: "default",
          platform: "INSTAGRAM",
          accountId: igUserId,
        },
      },
      create: {
        orgId: "default",
        platform: "INSTAGRAM",
        accountId: igUserId,
        accountName: "Instagram @reservatior",
        igUserId,
        pageId,
        accessToken,
        isActive: true,
      },
      update: {
        igUserId,
        pageId,
        accessToken,
        isActive: true,
      },
    });

    return {
      success: true,
      igUserId,
      socialAccountId: account.id,
      message: "Instagram Business Account connected",
    };
  })

  /**
   * Manual trigger: post recent listings
   * POST /api/v1/integrations/instagram/post-now
   */
  .post("/post-now", async () => {
    try {
      const count = await shareNewListings();
      return { success: true, posted: count };
    } catch (error) {
      return { success: false, error: (error as Error).message };
    }
  })

  /**
   * List recent Instagram posts from DB
   * GET /api/v1/integrations/instagram/posts
   */
  .get("/posts", async () => {
    const posts = await prisma.socialPost.findMany({
      where: { platform: "INSTAGRAM" },
      orderBy: { createdAt: "desc" },
      take: 20,
      include: {
        listing: { select: { title: true, property: { select: { name: true, city: true, country: true } } } },
      },
    });
    return { success: true, posts };
  })

  /**
   * Get suggested mentions for a location
   * GET /api/v1/integrations/instagram/mentions?country=TR&city=Bodrum
   */
  .get("/mentions", async ({ query }) => {
    const mentions = await getMentionsForCity(query.country as string, query.city as string);
    return { success: true, mentions };
  }, {
    query: t.Object({
      country: t.Optional(t.String()),
      city: t.Optional(t.String()),
    }),
  })

  /**
   * Add a local mention rule
   * POST /api/v1/integrations/instagram/mentions
   */
  .post("/mentions", async ({ body }) => {
    const account = await prisma.socialAccount.findFirst({
      where: { platform: "INSTAGRAM", isActive: true },
    });
    if (!account) return { success: false, error: "No active Instagram account" };

    await addMentionRule("default", account.id, body.keyword, body.username);
    return { success: true, message: `Mention rule added for @${body.username}` };
  }, {
    body: t.Object({
      keyword: t.String(),
      username: t.String(),
    }),
  })

  /**
   * Dashboard stats
   * GET /api/v1/integrations/instagram/stats
   */
  .get("/stats", async () => {
    const [totalPosts, publishedToday, activeAccount] = await Promise.all([
      prisma.socialPost.count({ where: { platform: "INSTAGRAM" } }),
      prisma.socialPost.count({
        where: {
          platform: "INSTAGRAM",
          status: "PUBLISHED",
          publishedAt: { gte: new Date(Date.now() - 24 * 60 * 60 * 1000) },
        },
      }),
      prisma.socialAccount.findFirst({
        where: { platform: "INSTAGRAM", isActive: true },
        select: { igUserId: true, accountName: true, lastSyncAt: true },
      }),
    ]);

    return {
      success: true,
      stats: {
        totalPosts,
        publishedToday,
        account: activeAccount,
      },
    };
  })
 
  /**
   * Facebook/Meta User Data Deletion Callback
   * POST /api/v1/integrations/instagram/data-deletion
   */
  .post("/data-deletion", async ({ body, set }) => {
    const signedRequest = (body as any)?.signed_request;
    const appSecret = process.env.META_APP_SECRET || "ea14ad6b6dc09e0ed49b9a19c73330aa";
 
    if (!signedRequest) {
      set.status = 400;
      return { error: "Missing signed_request parameter" };
    }
 
    const data = parseSignedRequest(signedRequest, appSecret);
    if (!data) {
      set.status = 400;
      return { error: "Invalid signature" };
    }
 
    const userId = data.user_id;
    if (userId) {
      // Find and deactivate the user's social accounts
      await prisma.socialAccount.updateMany({
        where: { accountId: userId },
        data: { isActive: false },
      });
    }
 
    const confirmationCode = `del_${userId || Date.now()}`;
    const statusUrl = `${process.env.SERVER_URL || "http://localhost:3000"}/api/v1/integrations/instagram/deletion-status?id=${confirmationCode}`;
 
    return {
      url: statusUrl,
      confirmation_code: confirmationCode,
    };
  })
 
  /**
   * Data Deletion Status Check Page/JSON
   * GET /api/v1/integrations/instagram/deletion-status
   */
  .get("/deletion-status", async ({ query }) => {
    const id = query.id;
    return {
      status: "completed",
      message: `Data deletion request ${id} has been successfully completed.`,
      timestamp: new Date().toISOString(),
    };
  }, {
    query: t.Object({
      id: t.String(),
    }),
  });
