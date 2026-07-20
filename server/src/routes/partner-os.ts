import { Elysia, t } from "elysia";
import { partnerEcosystemService } from "../services/partner-ecosystem-service";

export const partnerOSRoutes = new Elysia({ prefix: "/partner-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await partnerEcosystemService.getDashboard(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Partner OS Dashboard", tags: ["Partner OS"] },
  })

  .get("/partners", async ({ query, set }) => {
    try {
      const { orgId, page, limit } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await partnerEcosystemService.getPartnersByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List Partners", tags: ["Partner OS"] },
  })

  .post("/partners", async ({ body, set }) => {
    try {
      const data = await partnerEcosystemService.createPartner(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      legalName: t.String(),
      serviceAreas: t.Optional(t.String()),
      defaultCommissionBps: t.Optional(t.Number()),
    }),
    detail: { summary: "Create Partner", tags: ["Partner OS"] },
  })

  .get("/agreements", async ({ query, set }) => {
    try {
      const { page, limit, status } = query;
      const data = await partnerEcosystemService.getAgreements({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        status: status as string,
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
      status: t.Optional(t.String()),
    }),
    detail: { summary: "List Agreements", tags: ["Partner OS"] },
  })

  .get("/agreements/stats", async ({ set }) => {
    try {
      const data = await partnerEcosystemService.getAgreementStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Agreement Statistics", tags: ["Partner OS"] },
  })

  .post("/agreements", async ({ body, set }) => {
    try {
      const data = await partnerEcosystemService.createAgreement(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      partnerId: t.String(),
      type: t.String(),
      terms: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Agreement", tags: ["Partner OS"] },
  })

  .get("/suppliers", async ({ query, set }) => {
    try {
      const { page, limit } = query;
      const data = await partnerEcosystemService.getSuppliers({
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
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
    }),
    detail: { summary: "List Suppliers", tags: ["Partner OS"] },
  })

  .get("/reviews/:orgId", async ({ params, set }) => {
    try {
      const data = await partnerEcosystemService.getVendorReviews(params.orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Vendor Reviews", tags: ["Partner OS"] },
  });
