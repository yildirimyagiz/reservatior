import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SignatureRequestService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.signatureRequest, "signatureRequest");
  }
}

export const signatureRequestService = new SignatureRequestService();
