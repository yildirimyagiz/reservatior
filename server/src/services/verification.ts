import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VerificationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.verification, "verification");
  }
}

export const verificationService = new VerificationService();
