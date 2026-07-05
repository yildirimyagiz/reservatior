import { prismaManager } from "../lib/prisma";
import { isExecutionLocked } from "../lib/config/execution-lock";
import { EventDispatcher } from "../core/events/event-dispatcher";

export type ContractState = "DRAFT" | "REVIEW" | "APPROVED" | "SIGNING" | "ACTIVE" | "EXPIRING" | "RENEWED" | "TERMINATED" | "ARCHIVED";

const ALLOWED_TRANSITIONS: Record<ContractState, ContractState[]> = {
  DRAFT: ["REVIEW", "ARCHIVED"],
  REVIEW: ["APPROVED", "DRAFT", "ARCHIVED"],
  APPROVED: ["SIGNING", "DRAFT", "ARCHIVED"],
  SIGNING: ["ACTIVE", "DRAFT", "ARCHIVED"],
  ACTIVE: ["EXPIRING", "TERMINATED", "RENEWED"],
  EXPIRING: ["ACTIVE", "TERMINATED", "ARCHIVED", "RENEWED"],
  RENEWED: ["ACTIVE", "EXPIRING"],
  TERMINATED: ["ARCHIVED"],
  ARCHIVED: [],
};

interface TransitionPrecondition {
  check: (contractId: string, region: string) => Promise<boolean>;
  errorMessage: string;
}

const TRANSITION_PRECONDITIONS: Partial<Record<string, TransitionPrecondition[]>> = {
  ACTIVE: [
    {
      check: async (contractId, region) => {
        const prisma = prismaManager.getClient(region);
        const contract = await prisma.contract.findUnique({
          where: { id: contractId },
          include: { signatureRequests: { include: { signers: true } } },
        });
        if (!contract) return false;

        // Escrow check: look up via leaseId or bookingId
        if (isExecutionLocked(region, "forceEscrow")) {
          const reservationId = contract.leaseId || contract.bookingId || null;
          if (!reservationId) return false; // no linked reservation = no escrow possible
          const escrow = await prisma.escrowAccount.findFirst({
            where: { reservationId, status: "HOLDING" },
          });
          if (!escrow) return false;
        }

        // Signature check
        if (isExecutionLocked(region, "requireSignatureBeforeActive")) {
          if (!contract.signatureRequests || contract.signatureRequests.length === 0) return false;
          const allSigned = contract.signatureRequests.every(
            (sr: any) => sr.signers?.every((s: any) => s.status === "SIGNED")
          );
          if (!allSigned) return false;
        }
        return true;
      },
      errorMessage: "Contract cannot become ACTIVE: escrow must be HOLDING and all signatures required",
    },
  ],
  TERMINATED: [
    {
      check: async (contractId, region) => {
        const prisma = prismaManager.getClient(region);
        const contract = await prisma.contract.findUnique({ where: { id: contractId } });
        if (!contract) return false;
        const reservationId = contract.leaseId || contract.bookingId || null;
        if (!reservationId) return true; // no linked escrow, allow termination
        const escrow = await prisma.escrowAccount.findFirst({
          where: { reservationId },
          orderBy: { createdAt: "desc" },
        });
        if (!escrow) return true;
        return ["FULLY_RELEASED", "CANCELLED", "REFUNDED"].includes(escrow.status);
      },
      errorMessage: "Contract cannot be TERMINATED: escrow must be settled first",
    },
  ],
};

export class ContractMutator {
  private region: string;

  constructor(region: string = "US") {
    this.region = region;
  }

  withRegion(region: string): ContractMutator {
    this.region = region;
    return this;
  }

  async transition(contractId: string, toState: ContractState, triggerEvent: string, metadata?: Record<string, any>): Promise<any> {
    const prisma = prismaManager.getClient(this.region);
    const contract = await prisma.contract.findUnique({ where: { id: contractId } });
    if (!contract) throw new Error(`Contract ${contractId} not found`);

    const currentState = contract.status as ContractState;
    const allowed = ALLOWED_TRANSITIONS[currentState];
    if (!allowed || !allowed.includes(toState)) {
      throw new Error(`Transition ${currentState} → ${toState} is not allowed. Allowed: ${allowed?.join(", ") || "none"}`);
    }

    const preconditions = TRANSITION_PRECONDITIONS[toState];
    if (preconditions) {
      for (const pc of preconditions) {
        const passed = await pc.check(contractId, this.region);
        if (!passed) {
          throw new Error(pc.errorMessage);
        }
      }
    }

    const updated = await prisma.contract.update({
      where: { id: contractId },
      data: {
        status: toState as any,
        ...(toState === "ACTIVE" ? { effectiveFrom: new Date() } : {}),
        ...(toState === "TERMINATED" || toState === "ARCHIVED" ? { effectiveTo: new Date() } : {}),
      },
    });

    await prisma.contractTransition.create({
      data: {
        contractId,
        fromState: currentState,
        toState,
        triggerEvent,
        metadata: metadata || {},
        region: this.region,
        transitionedAt: new Date(),
      },
    });

    EventDispatcher.emit("CONTRACT_STATE_CHANGED" as any, {
      contractId,
      fromState: currentState,
      toState,
      triggerEvent,
      region: this.region,
    });

    return updated;
  }

  async canTransition(contractId: string, toState: ContractState): Promise<{ allowed: boolean; reason?: string }> {
    const prisma = prismaManager.getClient(this.region);
    const contract = await prisma.contract.findUnique({ where: { id: contractId } });
    if (!contract) return { allowed: false, reason: "Contract not found" };

    const currentState = contract.status as ContractState;
    const allowed = ALLOWED_TRANSITIONS[currentState];
    if (!allowed || !allowed.includes(toState)) {
      return { allowed: false, reason: `Transition ${currentState} → ${toState} not allowed` };
    }

    const preconditions = TRANSITION_PRECONDITIONS[toState];
    if (preconditions) {
      for (const pc of preconditions) {
        const passed = await pc.check(contractId, this.region);
        if (!passed) return { allowed: false, reason: pc.errorMessage };
      }
    }

    return { allowed: true };
  }

  async getTransitionHistory(contractId: string): Promise<any[]> {
    const prisma = prismaManager.getClient(this.region);
    return prisma.contractTransition.findMany({
      where: { contractId },
      orderBy: { transitionedAt: "asc" },
    });
  }
}

export const contractMutator = new ContractMutator();
