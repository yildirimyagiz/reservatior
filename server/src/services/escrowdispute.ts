import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class EscrowDisputeService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.escrowDispute, "escrowDispute");
  }
}

export const escrowDisputeService = new EscrowDisputeService();
