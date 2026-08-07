import { Elysia } from "elysia";
import { authMiddleware } from "../middleware/auth";

export const securityRoutes = new Elysia({ prefix: "/security" })
  .use(authMiddleware)

  // FAIL-CLOSED (audit §6.A.2): 2FA/biometric "security controls" were stubs
  // that always returned fake success. Until a real TOTP/WebAuthn flow exists,
  // these endpoints report the feature as unavailable instead of faking security.

  .get("/2fa/setup", async ({ set }) => {
    set.status = 501;
    return {
      data: null,
      success: false,
      simulated: true,
      error: "2FA is not implemented. Refusing to return a fake secret — this control is not active.",
    };
  })
  .post("/2fa/verify", async ({ set }) => {
    set.status = 501;
    return {
      data: null,
      success: false,
      simulated: true,
      error: "2FA verification is not implemented. No code was accepted — this control is not active.",
    };
  })
  .post("/2fa/disable", async ({ set }) => {
    set.status = 501;
    return {
      data: null,
      success: false,
      simulated: true,
      error: "2FA is not implemented. There is nothing to disable — this control is not active.",
    };
  })

  .post("/biometric/enable", async ({ set }) => {
    set.status = 501;
    return {
      data: null,
      success: false,
      simulated: true,
      error: "Biometric enrollment is not implemented. Refusing to record a fake enrollment — this control is not active.",
    };
  })

  .get("/sessions", async () => {
    return { data: [], success: true, simulated: true, note: "Session management is not implemented." };
  })
  .delete("/sessions/:id", async ({ set }) => {
    set.status = 501;
    return {
      data: null,
      success: false,
      simulated: true,
      error: "Session revocation is not implemented. No session was revoked.",
    };
  });
