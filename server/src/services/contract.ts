import { prismaManager } from "../lib/prisma";
import { BaseService } from "./base";
import { contractMutator, ContractState } from "./contract-mutator";
import { prisma } from "../lib/prisma";
import { isExecutionLocked } from "../lib/config/execution-lock";

export class ContractService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.contract, "contract");
  }

  async createWithLifecycle(data: any, region: string = "US") {
    const prisma = prismaManager.getClient(region);
    const contract = await prisma.contract.create({
      data: {
        ...data,
        status: "DRAFT",
      },
    });

    await prisma.contractTransition.create({
      data: {
        contractId: contract.id,
        fromState: "NONE",
        toState: "DRAFT",
        triggerEvent: "CONTRACT_CREATED",
        metadata: { createdBy: data.createdBy },
        region,
        transitionedAt: new Date(),
      },
    });

    return contract;
  }

  async transitionToReview(contractId: string, region: string = "US") {
    return contractMutator.withRegion(region).transition(contractId, "REVIEW", "CONTRACT_SUBMITTED_FOR_REVIEW");
  }

  async transitionToApproved(contractId: string, region: string = "US") {
    return contractMutator.withRegion(region).transition(contractId, "APPROVED", "CONTRACT_APPROVED");
  }

  async transitionToSigning(contractId: string, region: string = "US") {
    return contractMutator.withRegion(region).transition(contractId, "SIGNING", "CONTRACT_SENT_FOR_SIGNING");
  }

  async transitionToActive(contractId: string, region: string = "US") {
    return contractMutator.withRegion(region).transition(contractId, "ACTIVE", "ALL_CONDITIONS_MET");
  }

  async transitionToExpiring(contractId: string, region: string = "US") {
    return contractMutator.withRegion(region).transition(contractId, "EXPIRING", "CONTRACT_EXPIRING");
  }

  async transitionToTerminated(contractId: string, region: string = "US", reason?: string) {
    return contractMutator.withRegion(region).transition(contractId, "TERMINATED", "CONTRACT_TERMINATED", { reason });
  }

  async transitionToArchive(contractId: string, region: string = "US") {
    return contractMutator.withRegion(region).transition(contractId, "ARCHIVED", "CONTRACT_ARCHIVED");
  }

  async getContractWithLifecycle(contractId: string, region: string = "US") {
    const prisma = prismaManager.getClient(region);
    const contract = await prisma.contract.findUnique({
      where: { id: contractId },
      include: {
        versions: { orderBy: { version: "desc" } },
        signatureRequests: { include: { signers: true } },
        escrowAccount: true,
        tasks: true,
        increases: true,
        tenants: true,
      },
    });
    if (!contract) return null;
    const history = await contractMutator.withRegion(region).getTransitionHistory(contractId);
    return { ...contract, transitionHistory: history };
  }
}

export const contractService = new ContractService();
