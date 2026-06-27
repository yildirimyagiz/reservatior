import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyOwnershipVerificationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyOwnershipVerification, "propertyOwnershipVerification");
  }
}

export const propertyOwnershipVerificationService = new PropertyOwnershipVerificationService();
