import { Elysia, t } from "elysia";
import { neuralImporterService } from "../services/neural-importer";
import { regionMiddleware } from "../middleware/region";

export const externalImportRoutes = new Elysia({ prefix: "/importer" })
  .use(regionMiddleware)
  .get("/platforms", () => {
    return {
      platforms: [
        { name: "sahibinden.com", country: "TR", requiresAuth: true },
        { name: "hurriyetemlak.com", country: "TR", requiresAuth: false },
        { name: "zillow.com", country: "US", requiresAuth: false },
        { name: "redfin.com", country: "US", requiresAuth: false },
        { name: "rightmove.co.uk", country: "UK", requiresAuth: false },
        { name: "immoweb.be", country: "BE", requiresAuth: false }
      ]
    };
  })

  .post("/scrape", async ({ orgId, db, body, set }) => {
    const { url, userId } = body;

    if (!url) {
      set.status = 400;
      return { error: "URL is required" };
    }

    try {
      const result = await neuralImporterService.withDB(db as any).importFromUrl(url);
      
      // Log the import for analytics
      console.log(`[IMPORT] User ${userId} imported from ${result.platform}`);
      
      return {
        success: true,
        data: result.data,
        platform: result.platform,
        confidence: result.confidence,
        msg: result.msg
      };
    } catch (e) {
      set.status = 500;
      return {
        success: false,
        error: (e as any).message,
        msg: "Import failed - please check the URL and try again"
      };
    }
  }, {
    body: t.Object({
      url: t.String(),
      userId: t.String()
    })
  })

  .post("/bulk-import", async ({ orgId, db, body, set }) => {
    const { urls, userId } = body;

    if (!urls || !Array.isArray(urls) || urls.length === 0) {
      set.status = 400;
      return { error: "URLs array is required" };
    }

    if (urls.length > 10) {
      set.status = 400;
      return { error: "Maximum 10 URLs allowed per bulk import" };
    }

    try {
      const results = [];
      
      for (const url of urls) {
        try {
          const result = await neuralImporterService.withDB(db as any).importFromUrl(url);
          results.push({
            url,
            success: true,
            data: result.data,
            platform: result.platform,
            confidence: result.confidence
          });
        } catch (e) {
          results.push({
            url,
            success: false,
            error: (e as any).message
          });
        }
      }

      const successful = results.filter(r => r.success).length;
      
      return {
        success: true,
        results,
        summary: {
          total: urls.length,
          successful,
          failed: urls.length - successful,
          successRate: Math.round((successful / urls.length) * 100)
        },
        msg: `Bulk import completed: ${successful}/${urls.length} successful`
      };
    } catch (e) {
      set.status = 500;
      return {
        success: false,
        error: (e as any).message,
        msg: "Bulk import failed"
      };
    }
  }, {
    body: t.Object({
      urls: t.Array(t.String()),
      userId: t.String()
    })
  })

  .post("/validate-url", ({ orgId, db, body, set }) => {
    const { url } = body;
    
    if (!url) {
      set.status = 400;
      return { valid: false, error: "URL is required" };
    }

    // Basic URL validation and platform detection
    const supportedPlatforms = ['sahibinden.com', 'hurriyetemlak.com', 'zillow.com', 'redfin.com', 'rightmove.co.uk', 'immoweb.be'];
    const platform = supportedPlatforms.find(p => url.includes(p));
    
    if (!platform) {
      return {
        valid: false,
        error: "Unsupported platform",
        supportedPlatforms
      };
    }

    return {
      valid: true,
      platform,
      supported: true
    };
  }, {
    body: t.Object({
      url: t.String()
    })
  });
