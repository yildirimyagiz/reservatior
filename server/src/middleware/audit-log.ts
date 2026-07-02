import { Elysia } from "elysia";

// ── Immutable audit log for sensitive operations ──────────────────────────
// Logs are append-only, written to a dedicated file or DB table.
// ───────────────────────────────────────────────────────────────────────────

const SENSITIVE_PATTERNS = [
  "/auth/", "/login", "/signup", "/forgot-password",
  "/admin/", "/api/users", "/api/roles", "/api/permissions",
  "/api/payments", "/api/invoices", "/api/payouts",
  "/api/transactions", "/api/financial",
  "/api/security", "/api/api-keys",
  "/api/webhooks",
];

function isSensitive(path: string, method: string): boolean {
  if (method === "GET") return false;
  return SENSITIVE_PATTERNS.some(p => path.startsWith(p));
}

export const auditLogMiddleware = new Elysia({ name: "audit-log-middleware" })
  .onAfterHandle(async ({ request, set, body }) => {
    const url = new URL(request.url);
    if (!isSensitive(url.pathname, request.method)) return;

    const entry = {
      timestamp: new Date().toISOString(),
      method: request.method,
      path: url.pathname,
      query: url.search,
      status: set.status,
      ip: request.headers.get("x-forwarded-for")?.split(",")[0]?.trim() ||
          request.headers.get("x-real-ip") || "unknown",
      userAgent: request.headers.get("user-agent") || "",
    };

    // Write to immutable log file (append-only)
    try {
      const fs = await import("fs");
      const line = JSON.stringify(entry) + "\n";
      fs.appendFileSync("/var/log/reservatior/audit.log", line, "utf-8");
    } catch {
      // Fallback: if file write fails, log to console
      console.log("[AUDIT]", JSON.stringify(entry));
    }
  });
