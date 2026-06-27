import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class EscrowStatusHistoryService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.escrowStatusHistory, "escrowStatusHistory");
  }
}

export const escrowStatusHistoryService = new EscrowStatusHistoryService();
