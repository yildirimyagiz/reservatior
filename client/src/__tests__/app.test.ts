import { describe, expect, it } from "bun:test";

describe("App", () => {
  it("should be in test mode", () => {
    expect(import.meta.env).toBeDefined();
  });

  it("should have bun test runtime", () => {
    expect(typeof Bun).toBe("object");
  });
});
