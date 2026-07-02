import { Elysia } from "elysia";
import { isExecutionLocked } from "../lib/config/execution-lock";
import { prismaManager } from "../lib/prisma";

export type GuardTarget = "payment" | "contract_activation" | "dispute_resolution";

export const escrowGuardMiddleware = new Elysia({ name: "escrow-guard-middleware" })
  .derive({ as: "scoped" }, async ({ headers, request }) => {
    const region = (headers["x-region"] || headers["X-Region"] || "US") as string;
    const url = new URL(request.url);
    const path = url.pathname;
    const method = request.method;

    const guards: { passed: boolean; reason?: string }[] = [];

    if (["POST", "PUT", "PATCH"].includes(method)) {
      if (path.startsWith("/api/v1/payment") && !path.includes("/webhook")) {
        const forceEscrow = isExecutionLocked(region, "forcePaymentThroughEscrow");
        if (forceEscrow) {
          guards.push({
            passed: method === "GET" || path.includes("/escrow"),
            reason: `ESCROW_REQUIRED: Payments in ${region} must go through escrow`,
          });
        }
      }

      if (path.startsWith("/api/v1/contract") && path.includes("/activate")) {
        const forceSMM = isExecutionLocked(region, "forceContractStateMachine");
        if (forceSMM) {
          guards.push({
            passed: false,
            reason: `CONTRACT_STATE_MACHINE_REQUIRED: Use /contract/{id}/transition endpoint in ${region}`,
          });
        }
      }

      if (path.startsWith("/api/v1/dispute") && path.includes("/auto-resolve")) {
        const forceDR = isExecutionLocked(region, "forceDisputeResolution");
        if (forceDR) {
          const unresolved = await checkActiveDisputes(region, path);
          guards.push({
            passed: !unresolved,
            reason: `DISPUTE_EXISTS: Active disputes must be resolved via platform dispute resolution in ${region}`,
          });
        }
      }
    }

    const anyFailed = guards.filter(g => !g.passed);
    return {
      executionLockRegion: region,
      executionLockGuards: guards,
      executionLockBlocked: anyFailed.length > 0,
      executionLockReason: anyFailed[0]?.reason,
    };
  })
  .onBeforeHandle({ as: "global" }, async ({ executionLockBlocked, executionLockReason, set }) => {
    if (executionLockBlocked) {
      set.status = 403;
      return {
        error: executionLockReason,
        code: "EXECUTION_LOCK_ACTIVE",
      };
    }
  });

async function checkActiveDisputes(region: string, path: string): Promise<boolean> {
  const prisma = prismaManager.getClient(region);
  const escrowId = path.split("/").pop();
  if (!escrowId) return false;
  const dispute = await prisma.escrowDispute.findFirst({
    where: {
      escrowAccountId: escrowId,
      status: { in: ["OPEN", "EVIDENCE_COLLECTION", "UNDER_REVIEW"] },
    },
  });
  return !!dispute;
}
