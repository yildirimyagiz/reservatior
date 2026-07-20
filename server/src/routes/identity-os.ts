import { Elysia, t } from "elysia";
import { identityAccessService } from "../services/identity-access-service";

export const identityOSRoutes = new Elysia({ prefix: "/identity-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await identityAccessService.getDashboard(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Identity OS Dashboard", tags: ["Identity OS"] },
  })

  .get("/users", async ({ query, set }) => {
    try {
      const { page, limit, search } = query;
      const data = await identityAccessService.getUsers({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        search: search as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      search: t.Optional(t.String()),
    }),
    detail: { summary: "List Users", tags: ["Identity OS"] },
  })

  .get("/users/stats", async ({ set }) => {
    try {
      const data = await identityAccessService.getUserStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "User Statistics", tags: ["Identity OS"] },
  })

  .get("/sessions", async ({ query, set }) => {
    try {
      const { page, limit, userId } = query;
      const data = await identityAccessService.getSessions({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 50),
        take: parseInt(limit as string) || 50,
        userId: userId as string,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      userId: t.Optional(t.String()),
    }),
    detail: { summary: "List Active Sessions", tags: ["Identity OS"] },
  })

  .delete("/sessions/:id", async ({ params, set }) => {
    try {
      await identityAccessService.revokeSession(params.id);
      return { success: true, message: "Session revoked" };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Revoke Session", tags: ["Identity OS"] },
  })

  .get("/roles", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await identityAccessService.getRoles(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Roles", tags: ["Identity OS"] },
  })

  .get("/permissions", async ({ set }) => {
    try {
      const data = await identityAccessService.getPermissions();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "List Permissions", tags: ["Identity OS"] },
  })

  .get("/accounts/:userId", async ({ params, set }) => {
    try {
      const data = await identityAccessService.getAccounts(params.userId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ userId: t.String() }),
    detail: { summary: "List User Accounts (SSO Providers)", tags: ["Identity OS"] },
  })

  .get("/members/:orgId", async ({ params, set }) => {
    try {
      const data = await identityAccessService.getMembersByOrg(params.orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "List Organization Members", tags: ["Identity OS"] },
  })

  .get("/api-keys", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await identityAccessService.getApiKeys(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List API Keys", tags: ["Identity OS"] },
  });
