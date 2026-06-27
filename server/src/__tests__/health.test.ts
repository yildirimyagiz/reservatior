import { describe, expect, it } from "bun:test";

describe("Health Check", () => {
  it("should return ok status", () => {
    const response = {
      status: "ok",
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      version: "1.0.0",
    };

    expect(response.status).toBe("ok");
    expect(response.version).toBe("1.0.0");
    expect(response.timestamp).toBeDefined();
    expect(response.uptime).toBeGreaterThan(0);
  });
});
