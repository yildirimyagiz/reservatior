import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyInventoryService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyInventory, "propertyInventory");
  }
}

export const propertyInventoryService = new PropertyInventoryService();
