import { Elysia } from "elysia";

const SAFE_METHODS = new Set(["GET", "HEAD", "OPTIONS"]);

// Simple origin/referer check for CSRF protection
export const csrfMiddleware = new Elysia({ name: "csrf-middleware" })
  .derive({ as: "scoped" }, async ({ request, set }) => {
    if (SAFE_METHODS.has(request.method)) return {};

    const origin = request.headers.get("origin");
    const referer = request.headers.get("referer");

    if (!origin && !referer) {
      // API-to-API calls without origin are allowed
      const contentType = request.headers.get("content-type");
      if (contentType?.includes("application/json")) return {};
    }

    const ALLOWED_ORIGINS = (
      process.env.CORS_ORIGIN || "http://localhost:3000,http://localhost:3001,http://localhost:5173"
    ).split(",").map(o => o.trim()).filter(Boolean);

    const ALLOWED_DOMAINS = ALLOWED_ORIGINS.map(o => {
      try { return new URL(o).hostname; } catch { return null; }
    }).filter(Boolean) as string[];

    const checkOrigin = (url: string | null): boolean => {
      if (!url) return false;
      try {
        const hostname = new URL(url).hostname;
        return ALLOWED_DOMAINS.some(d => hostname === d || hostname.endsWith("." + d));
      } catch {
        return false;
      }
    };

    if (!checkOrigin(origin) && !checkOrigin(referer)) {
      set.status = 403;
      return { error: "CSRF validation failed" };
    }

    return {};
  });
