import { Elysia, t } from "elysia";
import { AIAdsSEOEngine } from "../services/ai/ai-ads-seo-engine";

export const aiAdsSeoRoutes = new Elysia({ prefix: "/ai/marketing" })
  .get("/ads/:propertyId", async ({ params, set }) => {
    try {
      const { propertyId } = params;
      const adsContent = await AIAdsSEOEngine.generateGoogleAds(propertyId);
      return { success: true, data: adsContent };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({
      propertyId: t.String()
    })
  })
  .get("/seo/:propertyId", async ({ params, set }) => {
    try {
      const { propertyId } = params;
      const seoContent = await AIAdsSEOEngine.generateSEOContent(propertyId);
      return { success: true, data: seoContent };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({
      propertyId: t.String()
    })
  });
