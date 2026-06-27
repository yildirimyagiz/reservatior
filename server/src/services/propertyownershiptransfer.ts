import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyOwnershipTransferService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyOwnershipTransfer, "propertyOwnershipTransfer");
  }
}

export const propertyOwnershipTransferService = new PropertyOwnershipTransferService();
