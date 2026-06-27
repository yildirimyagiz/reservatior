import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ReferenceSourceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.referenceSource, "referenceSource");
  }
}

export const referenceSourceService = new ReferenceSourceService();
