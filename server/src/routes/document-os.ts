import { Elysia, t } from "elysia";
import { documentLifecycleService } from "../services/document-lifecycle-service";
import { ContractEngine, ContractType, ContractLanguage } from "../../config/contract-engine";
import { RegionCode } from "../../config/ai-yield-optimization";
import { COUNTRY_CONTRACT_PROFILES, SUPPORTED_COUNTRY_CODES, CONTRACT_LANGUAGE_NAMES, resolveCountryCode } from "../../config/country-contract-config";

const ML_SERVICE_URL = process.env.ML_SERVICE_URL || "http://localhost:8000";

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

  .get("/contract-templates", async ({ set }) => {
    try {
      const catalog = ContractEngine.getTemplateCatalog();
      const countries = SUPPORTED_COUNTRY_CODES.map((code) => {
        const profile = COUNTRY_CONTRACT_PROFILES[code];
        return {
          country: code,
          countryNameEn: profile?.countryNameEn ?? code,
          countryNameNative: profile?.countryNameNative ?? code,
          currency: profile?.currency ?? "USD",
          currencySymbol: profile?.currencySymbol ?? "$",
          officialLanguages: profile?.officialLanguages ?? [],
          defaultLanguage: profile?.defaultLanguage ?? ContractLanguage.EN,
          legalBasis: profile?.legalBasis ?? [],
          maxDepositMonths: profile?.maxDepositMonths ?? null,
          regulator: profile?.regulator ?? null,
        };
      });
      return {
        success: true,
        data: {
          generatedAt: new Date().toISOString(),
          languages: CONTRACT_LANGUAGE_NAMES,
          countries,
          templates: catalog,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    detail: { summary: "Contract Template Catalog (all countries)", tags: ["Document OS"] },
  })

  .get("/contract-templates/:country", async ({ params, set }) => {
    try {
      const resolved = resolveCountryCode(params.country);
      if (!resolved) {
        set.status = 404;
        return { success: false, error: `Unsupported country: ${params.country}` };
      }
      const profile = COUNTRY_CONTRACT_PROFILES[resolved]!;
      const templates = ContractEngine.listTemplatesForCountry(resolved);
      return {
        success: true,
        data: {
          country: resolved,
          profile,
          defaultLanguage: ContractEngine.getDefaultLanguage(resolved),
          templates,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ country: t.String() }),
    detail: { summary: "Contract Templates for a Country", tags: ["Document OS"] },
  })

  .get("/contract-templates/:country/:type", async ({ params, set }) => {
    try {
      const country = resolveCountryCode(params.country);
      if (!country) {
        set.status = 404;
        return { success: false, error: `Unsupported country: ${params.country}` };
      }
      const type = params.type.toUpperCase() as ContractType;
      const template = ContractEngine.getTemplate(country, type);
      if (!template) {
        set.status = 404;
        return { success: false, error: `No template for ${params.country}/${params.type}` };
      }
      return { success: true, data: template };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ country: t.String(), type: t.String() }),
    detail: { summary: "Contract Template Detail", tags: ["Document OS"] },
  })

  .post("/contracts/generate", async ({ body, set }) => {
    try {
      const { type, region, language, data, persist } = body;
      const html = ContractEngine.generateContract(type, region, data, language);
      const fileName = `${type}_${region}_${language ?? "default"}_${Date.now()}.html`;
      let saved = null;
      if (persist) {
        saved = await documentLifecycleService.createContract({
          orgId: data.orgId ?? "default",
          type,
          title: `${type} (${region})`,
          documentUrl: `contracts/${fileName}`,
          metadata: { region, language, generatedAt: new Date().toISOString() },
        } as any);
      }
      return {
        success: true,
        html,
        metadata: {
          type,
          region,
          language: language ?? ContractEngine.getDefaultLanguage(region),
          generatedAt: new Date().toISOString(),
          fileName,
          contractId: saved?.id ?? null,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      type: t.Enum(ContractType),
      region: t.Enum(RegionCode),
      language: t.Optional(t.Enum(ContractLanguage)),
      data: t.Any(),
      persist: t.Optional(t.Boolean()),
    }),
    detail: { summary: "Generate Contract", tags: ["Document OS"] },
  })

  .post("/contracts/ml/generate", async ({ body, set }) => {
    try {
      const { type, region, language, data } = body;
      const mlResponse = await fetch(`${ML_SERVICE_URL}/api/v1/contracts/generate`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ contract_type: type, country: region, language, data }),
      });
      if (!mlResponse.ok) {
        const errText = await mlResponse.text();
        set.status = 502;
        return { success: false, error: `ML service error (${mlResponse.status}): ${errText}` };
      }
      const payload = await mlResponse.json();
      return { success: true, ...payload };
    } catch (error: any) {
      set.status = 502;
      return { success: false, error: `ML service unreachable: ${error.message}` };
    }
  }, {
    body: t.Object({
      type: t.Enum(ContractType),
      region: t.Enum(RegionCode),
      language: t.Optional(t.Enum(ContractLanguage)),
      data: t.Any(),
    }),
    detail: { summary: "Generate Contract via ML Service", tags: ["Document OS"] },
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
