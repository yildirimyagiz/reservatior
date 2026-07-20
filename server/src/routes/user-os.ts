import { Elysia, t } from "elysia";
import { userProfileService } from "../services/user-profile-service";
import { userIdentityService } from "../services/user-identity-service";
import { userSessionService, userDeviceService } from "../services/user-session-service";
import { userConsentService } from "../services/user-consent-service";
import { userJourneyService, userActivityService } from "../services/user-journey-service";
import { userInterestService, userCategoryPreferenceService } from "../services/user-interest-service";
import { userSavedSearchService } from "../services/user-saved-search-service";
import { userRecommendationService } from "../services/user-recommendation-service";
import { userRelationshipService } from "../services/user-relationship-service";
import { userNotificationService } from "../services/user-notification-service";

export const userOSRoutes = new Elysia({ prefix: "/user-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }

      const [profile, journey, unreadCount, recentActivity, recommendations] = await Promise.all([
        userProfileService.getByUser(userId).catch(() => null),
        userJourneyService.getStats(userId).catch(() => ({ currentStage: "NEW", daysSinceCreation: 0 })),
        userNotificationService.getUnreadCount(userId).catch(() => 0),
        userActivityService.getByUser(userId, 5).catch(() => []),
        userRecommendationService.getByUser(userId, 5).catch(() => []),
      ]);

      return { success: true, data: { profile, journey, unreadCount, recentActivity, recommendations } };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "User OS Dashboard", tags: ["User OS"] } })

  .get("/profile", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userProfileService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get User Profile", tags: ["User OS"] } })

  .put("/profile", async ({ body, set }) => {
    try {
      const { userId, ...data } = body as any;
      const result = await userProfileService.upsertProfile(userId, data);
      return { success: true, data: result };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String() }), detail: { summary: "Upsert User Profile", tags: ["User OS"] } })

  .get("/identity", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userIdentityService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get Identity Providers", tags: ["User OS"] } })

  .post("/identity/link", async ({ body, set }) => {
    try {
      const { userId, provider, providerId, ...data } = body as any;
      const result = await userIdentityService.linkProvider(userId, provider, providerId, data);
      set.status = 201;
      return { success: true, data: result };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), provider: t.String(), providerId: t.String() }), detail: { summary: "Link Identity Provider", tags: ["User OS"] } })

  .delete("/identity/:id", async ({ params, set }) => {
    try {
      await userIdentityService.unlinkProvider(params.id);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Unlink Identity Provider", tags: ["User OS"] } })

  .get("/sessions", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userSessionService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get User Sessions", tags: ["User OS"] } })

  .post("/sessions/revoke-all", async ({ body, set }) => {
    try {
      const { userId } = body as any;
      await userSessionService.revokeAllSessions(userId);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String() }), detail: { summary: "Revoke All Sessions", tags: ["User OS"] } })

  .get("/consent", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userConsentService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get User Consents", tags: ["User OS"] } })

  .post("/consent/grant", async ({ body, set }) => {
    try {
      const { userId, consentType, granted } = body as any;
      const data = await userConsentService.grantConsent(userId, consentType, granted);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), consentType: t.String(), granted: t.Boolean() }), detail: { summary: "Grant Consent", tags: ["User OS"] } })

  .post("/consent/withdraw", async ({ body, set }) => {
    try {
      const { userId, consentType } = body as any;
      await userConsentService.withdrawConsent(userId, consentType);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), consentType: t.String() }), detail: { summary: "Withdraw Consent", tags: ["User OS"] } })

  .post("/consent/bulk", async ({ body, set }) => {
    try {
      const { userId, consents } = body as any;
      const data = await userConsentService.bulkGrant(userId, consents);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), consents: t.Array(t.Object({ consentType: t.String(), granted: t.Boolean() })) }), detail: { summary: "Bulk Grant Consents", tags: ["User OS"] } })

  .get("/journey", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userJourneyService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get User Journey", tags: ["User OS"] } })

  .post("/journey/advance", async ({ body, set }) => {
    try {
      const { userId, stage } = body as any;
      const data = await userJourneyService.advanceStage(userId, stage);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), stage: t.String() }), detail: { summary: "Advance Journey Stage", tags: ["User OS"] } })

  .get("/journey/stats", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userJourneyService.getStats(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get Journey Stats", tags: ["User OS"] } })

  .get("/activity", async ({ query, set }) => {
    try {
      const { userId, limit } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userActivityService.getByUser(userId, parseInt(limit as string) || 50);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String(), limit: t.Optional(t.String()) }), detail: { summary: "Get User Activity", tags: ["User OS"] } })

  .post("/activity/log", async ({ body, set }) => {
    try {
      const { userId, action, metadata } = body as any;
      const data = await userActivityService.logActivity(userId, action, metadata);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), action: t.String(), metadata: t.Optional(t.Any()) }), detail: { summary: "Log Activity", tags: ["User OS"] } })

  .get("/interests", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userInterestService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get User Interests", tags: ["User OS"] } })

  .post("/interests", async ({ body, set }) => {
    try {
      const { userId, category, subcategory, priority } = body as any;
      const data = await userInterestService.addInterest(userId, { category, subcategory, priority });
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), category: t.String(), subcategory: t.Optional(t.String()), priority: t.Optional(t.Number()) }), detail: { summary: "Add Interest", tags: ["User OS"] } })

  .delete("/interests/:id", async ({ params, set }) => {
    try {
      await userInterestService.removeInterest(params.id);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Remove Interest", tags: ["User OS"] } })

  .get("/preferences", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userCategoryPreferenceService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get Category Preferences", tags: ["User OS"] } })

  .post("/preferences", async ({ body, set }) => {
    try {
      const { userId, category, weight } = body as any;
      const data = await userCategoryPreferenceService.setPreference(userId, category, weight);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), category: t.String(), weight: t.Number() }), detail: { summary: "Set Category Preference", tags: ["User OS"] } })

  .get("/saved-searches", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userSavedSearchService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get Saved Searches", tags: ["User OS"] } })

  .post("/saved-searches", async ({ body, set }) => {
    try {
      const { userId, name, filters, alertEnabled } = body as any;
      const data = await userSavedSearchService.createSearch(userId, { name, filters, alertEnabled });
      set.status = 201;
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String(), name: t.String(), filters: t.Any(), alertEnabled: t.Optional(t.Boolean()) }), detail: { summary: "Create Saved Search", tags: ["User OS"] } })

  .delete("/saved-searches/:id", async ({ params, set }) => {
    try {
      await userSavedSearchService.deleteSearch(params.id);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Delete Saved Search", tags: ["User OS"] } })

  .get("/recommendations", async ({ query, set }) => {
    try {
      const { userId, limit } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userRecommendationService.getByUser(userId, parseInt(limit as string) || 10);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String(), limit: t.Optional(t.String()) }), detail: { summary: "Get Recommendations", tags: ["User OS"] } })

  .post("/recommendations/track", async ({ body, set }) => {
    try {
      const { id } = body as any;
      await userRecommendationService.trackInteraction(id);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ id: t.String() }), detail: { summary: "Track Recommendation Interaction", tags: ["User OS"] } })

  .get("/relationships", async ({ query, set }) => {
    try {
      const { userId } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userRelationshipService.getByUser(userId);
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String() }), detail: { summary: "Get User Relationships", tags: ["User OS"] } })

  .get("/notifications", async ({ query, set }) => {
    try {
      const { userId, unreadOnly, limit } = query;
      if (!userId) { set.status = 400; return { error: "userId is required" }; }
      const data = await userNotificationService.getByUser(userId, { unreadOnly: unreadOnly === "true", limit: parseInt(limit as string) || 20 });
      return { success: true, data };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { query: t.Object({ userId: t.String(), unreadOnly: t.Optional(t.String()), limit: t.Optional(t.String()) }), detail: { summary: "Get Notifications", tags: ["User OS"] } })

  .post("/notifications/read", async ({ body, set }) => {
    try {
      const { userId } = body as any;
      await userNotificationService.markAllRead(userId);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { body: t.Object({ userId: t.String() }), detail: { summary: "Mark All Notifications Read", tags: ["User OS"] } })

  .post("/notifications/:id/read", async ({ params, set }) => {
    try {
      await userNotificationService.markRead(params.id);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Mark Notification Read", tags: ["User OS"] } })

  .post("/notifications/:id/dismiss", async ({ params, set }) => {
    try {
      await userNotificationService.dismiss(params.id);
      return { success: true };
    } catch (error: any) { set.status = 500; return { success: false, error: error.message }; }
  }, { params: t.Object({ id: t.String() }), detail: { summary: "Dismiss Notification", tags: ["User OS"] } });
