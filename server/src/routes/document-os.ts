import { Elysia, t } from "elysia";
import { documentLifecycleService } from "../services/document-lifecycle-service";

export const documentOSRoutes = new Elysia({ prefix: "/document-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await documentLifecycleService.getDashboard(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Document OS Dashboard", tags: ["Document OS"] },
  })

  .get("/documents", async ({ query, set }) => {
    try {
      const { orgId, page, limit, documentType } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await documentLifecycleService.getDocuments(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
        documentType: documentType as string,
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
      documentType: t.Optional(t.String()),
    }),
    detail: { summary: "List Documents", tags: ["Document OS"] },
  })

  .post("/documents", async ({ body, set }) => {
    try {
      const data = await documentLifecycleService.createDocument(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      documentType: t.String(),
      fileUrl: t.Optional(t.String()),
      name: t.Optional(t.String()),
      metadata: t.Optional(t.Any()),
    }),
    detail: { summary: "Create Document", tags: ["Document OS"] },
  })

  .get("/documents/stats", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await documentLifecycleService.getDocumentStats(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Document Statistics", tags: ["Document OS"] },
  })

  .get("/contracts", async ({ query, set }) => {
    try {
      const { orgId, page, limit, status } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await documentLifecycleService.getContracts(orgId, {
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
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      status: t.Optional(t.String()),
    }),
    detail: { summary: "List Contracts", tags: ["Document OS"] },
  })

  .get("/contracts/stats", async ({ set }) => {
    try {
      const data = await documentLifecycleService.getContractStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Contract Statistics", tags: ["Document OS"] },
  })

  .post("/contracts", async ({ body, set }) => {
    try {
      const data = await documentLifecycleService.createContract(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      type: t.String(),
      title: t.Optional(t.String()),
      documentUrl: t.Optional(t.String()),
    }),
    detail: { summary: "Create Contract", tags: ["Document OS"] },
  })

  .get("/contracts/:id/versions", async ({ params, set }) => {
    try {
      const data = await documentLifecycleService.getContractVersions(params.id);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Contract Versions", tags: ["Document OS"] },
  })

  .get("/signatures", async ({ query, set }) => {
    try {
      const { orgId } = query;
      const data = await documentLifecycleService.getSignatureRequests(orgId as string);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.Optional(t.String()) }),
    detail: { summary: "List Signature Requests", tags: ["Document OS"] },
  })

  .get("/signatures/stats", async ({ set }) => {
    try {
      const data = await documentLifecycleService.getSignatureStats();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Signature Statistics", tags: ["Document OS"] },
  })

  .get("/templates", async ({ set }) => {
    try {
      const data = await documentLifecycleService.getTemplates();
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "List Document Templates", tags: ["Document OS"] },
  });
