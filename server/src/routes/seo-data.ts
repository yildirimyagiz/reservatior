import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { seoGenerator } from "../services/seo-generator";

export const seoDataRoutes = new Elysia({ prefix: "/seo" })
  .use(authMiddleware)

  .get("/property/:propertyId", async ({ params, set }) => {
    try {
      const data = await seoGenerator.generatePropertySEO(params.propertyId);
      return { data };
    } catch (e: any) {
      set.status = 404;
      return { error: e.message || "Property not found" };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: {
      summary: "Generate Property SEO Data",
      description: "Generate structured data (JSON-LD) and metadata for a property",
      tags: ["SEO"]
    }
  })

  .get("/property/:propertyId/investment-score", async ({ params, set }) => {
    try {
      const data = await seoGenerator.calculateInvestmentScore(params.propertyId);
      return { data };
    } catch (e: any) {
      set.status = 404;
      return { error: e.message || "Property not found" };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: {
      summary: "Calculate Investment Score",
      description: "Calculate investment score and grade for a property",
      tags: ["SEO"]
    }
  })

  .get("/property/:propertyId/rental-yield", async ({ params, set }) => {
    try {
      const data = await seoGenerator.calculateRentalYield(params.propertyId);
      return { data };
    } catch (e: any) {
      set.status = 404;
      return { error: e.message || "Property not found" };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: {
      summary: "Calculate Rental Yield",
      description: "Calculate gross/net rental yield and cash-on-cash return",
      tags: ["SEO"]
    }
  })

  .post("/bulk", async ({ body }) => {
    const data = await seoGenerator.getBulkSEOData(body.propertyIds);
    return { data, total: data.length };
  }, {
    body: t.Object({
      propertyIds: t.Array(t.String())
    }),
    detail: {
      summary: "Bulk Generate SEO Data",
      description: "Generate SEO data for multiple properties at once",
      tags: ["SEO"]
    }
  });
