import { Elysia, t } from "elysia";
import { ecosystemDeveloperPortalService, IntegrationStatus, APIAccessLevel } from "../services/ecosystem/developer-portal.service";

/**
 * Ecosystem OS - Developer portal and API economy
 * Manages third-party developer integrations, API key management, and developer marketplace
 * Extends Devapi and Developer OS
 */
export const ecosystemOSRoutes = new Elysia({
  prefix: "/api/v1/ecosystem-os",
})
  // Register developer
  .post("/developer/register", async ({ body }) => {
    try {
      const developer = await ecosystemDeveloperPortalService.registerDeveloper(
        body.userId,
        body.organizationName,
        body.email
      );
      return { success: true, developer };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      organizationName: t.String(),
      email: t.String(),
    }),
    detail: { summary: "Register Developer", tags: ["Ecosystem OS"] },
  })

  // Create API key
  .post("/api-key", async ({ body }) => {
    try {
      const apiKey = await ecosystemDeveloperPortalService.createAPIKey(
        body.developerId,
        body.name,
        body.accessLevel as APIAccessLevel,
        body.scopes,
        body.rateLimit
      );
      return { success: true, apiKey };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      developerId: t.String(),
      name: t.String(),
      accessLevel: t.String(),
      scopes: t.Array(t.String()),
      rateLimit: t.Number(),
    }),
    detail: { summary: "Create API Key", tags: ["Ecosystem OS"] },
  })

  // Validate API key
  .get("/api-key/validate/:key", async ({ params }) => {
    try {
      const valid = await ecosystemDeveloperPortalService.validateAPIKey(params.key);
      return { success: true, valid };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ key: t.String() }),
    detail: { summary: "Validate API Key", tags: ["Ecosystem OS"] },
  })

  // Revoke API key
  .delete("/api-key/:keyId", async ({ params }) => {
    try {
      const revoked = await ecosystemDeveloperPortalService.revokeAPIKey(params.keyId);
      return { success: true, revoked };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ keyId: t.String() }),
    detail: { summary: "Revoke API Key", tags: ["Ecosystem OS"] },
  })

  // Create integration
  .post("/integration", async ({ body }) => {
    try {
      const integration = await ecosystemDeveloperPortalService.createIntegration(
        body.developerId,
        body.name,
        body.description,
        body.category,
        body.pricingModel
      );
      return { success: true, integration };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      developerId: t.String(),
      name: t.String(),
      description: t.String(),
      category: t.String(),
      pricingModel: t.String(),
    }),
    detail: { summary: "Create Integration", tags: ["Ecosystem OS"] },
  })

  // Submit integration for review
  .post("/integration/:integrationId/submit", async ({ params }) => {
    try {
      const integration = await ecosystemDeveloperPortalService.submitIntegrationForReview(params.integrationId);
      return { success: true, integration };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ integrationId: t.String() }),
    detail: { summary: "Submit Integration for Review", tags: ["Ecosystem OS"] },
  })

  // Approve integration
  .post("/integration/:integrationId/approve", async ({ params }) => {
    try {
      const integration = await ecosystemDeveloperPortalService.approveIntegration(params.integrationId);
      return { success: true, integration };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ integrationId: t.String() }),
    detail: { summary: "Approve Integration", tags: ["Ecosystem OS"] },
  })

  // Get integration marketplace
  .get("/marketplace", async ({ query }) => {
    try {
      const integrations = await ecosystemDeveloperPortalService.getIntegrationMarketplace(query.category);
      return { success: true, integrations };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ category: t.Optional(t.String()) }),
    detail: { summary: "Get Integration Marketplace", tags: ["Ecosystem OS"] },
  })

  // Record API usage
  .post("/usage", async ({ body }) => {
    try {
      await ecosystemDeveloperPortalService.recordAPIUsage(body);
      return { success: true };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      integrationId: t.String(),
      endpoint: t.String(),
      method: t.String(),
      responseTime: t.Number(),
      statusCode: t.Number(),
      success: t.Boolean(),
    }),
    detail: { summary: "Record API Usage", tags: ["Ecosystem OS"] },
  })

  // Get API analytics
  .get("/analytics/:integrationId", async ({ params, query }) => {
    try {
      const analytics = await ecosystemDeveloperPortalService.getAPIAnalytics(
        params.integrationId,
        query.period
      );
      return { success: true, analytics };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ integrationId: t.String() }),
    query: t.Object({ period: t.Optional(t.String()) }),
    detail: { summary: "Get API Analytics", tags: ["Ecosystem OS"] },
  })

  // Get developer dashboard
  .get("/dashboard/:developerId", async ({ params }) => {
    try {
      const dashboard = await ecosystemDeveloperPortalService.getDeveloperDashboard(params.developerId);
      return { success: true, dashboard };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ developerId: t.String() }),
    detail: { summary: "Developer Dashboard", tags: ["Ecosystem OS"] },
  })

  // Get ecosystem overview
  .get("/overview", async () => {
    try {
      const overview = await ecosystemDeveloperPortalService.getEcosystemOverview();
      return { success: true, overview };
    } catch (error: any) {
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Ecosystem Overview", tags: ["Ecosystem OS"] },
  });
