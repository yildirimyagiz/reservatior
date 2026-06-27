import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MLConfigurationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mLConfiguration, "mLConfiguration");
  }
}

export const mLConfigurationService = new MLConfigurationService();
