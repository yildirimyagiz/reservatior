import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MLSConnectionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mLSConnection, "mLSConnection");
  }
}

export const mLSConnectionService = new MLSConnectionService();
