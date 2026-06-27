import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class EscrowReleaseService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.escrowRelease, "escrowRelease");
  }
}

export const escrowReleaseService = new EscrowReleaseService();
