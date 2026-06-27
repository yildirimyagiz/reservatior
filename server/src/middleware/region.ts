import { Elysia } from "elysia";
import { prismaManager } from "../lib/prisma";

/**
 * Region Middleware
 * 
 * Extracts the X-Region header from incoming requests and derives
 * a specific regional database client for the context.
 * 
 * If no header is provided, it falls back to the default client.
 */
export const regionMiddleware = new Elysia({ name: "region-middleware" })
  .derive({ as: "scoped" }, ({ headers, request }) => {
    // 1. Check for X-Region header
    const regionHeader = headers["x-region"];
    
    // 2. Check for region query parameter (optional, useful for testing or simple links)
    const url = new URL(request.url);
    const regionQuery = url.searchParams.get("region");

    const region = regionHeader || regionQuery || undefined;

    // Debug: log region resolution
    const path = url.pathname;
    if (path.includes('/property') || path.includes('/config')) {
      console.log(`🌐 [Region] ${request.method} ${path} → X-Region: "${regionHeader}" | query: "${regionQuery}" | resolved: "${region || 'DEFAULT'}"`);
    }

    // 3. Get the appropriate PrismaClient
    const db = prismaManager.getClient(region);

    return {
      region: region?.toUpperCase() || "DEFAULT",
      db
    };
  });
