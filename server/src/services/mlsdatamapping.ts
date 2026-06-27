import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MlsDataMappingService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mlsDataMapping, "mlsDataMapping");
  }
}

export const mlsDataMappingService = new MlsDataMappingService();
