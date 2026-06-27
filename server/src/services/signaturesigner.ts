import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SignatureSignerService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.signatureSigner, "signatureSigner");
  }
}

export const signatureSignerService = new SignatureSignerService();
