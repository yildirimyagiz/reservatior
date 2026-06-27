import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LedgerEntryService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.ledgerEntry, "ledgerEntry");
  }
}

export const ledgerEntryService = new LedgerEntryService();
