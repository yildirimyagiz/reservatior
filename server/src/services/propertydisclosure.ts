import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PropertyDisclosureService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.propertyDisclosure, "propertyDisclosure");
  }
}

export const propertyDisclosureService = new PropertyDisclosureService();
