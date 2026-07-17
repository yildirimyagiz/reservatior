/**
 * Minimal file logger shim.
 * Elysia's @elysiajs/logger is not available in this setup;
 * this module exports a compatible no-op middleware so the import resolves.
 */

export const fileLogger = (_opts?: any) => ({
  // Elysia plugin shape — no-op
  name: 'file-logger',
  setup() {},
});
