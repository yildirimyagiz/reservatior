import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MLSSyncJobService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mLSSyncJob, "mLSSyncJob");
  }
}

export const mLSSyncJobService = new MLSSyncJobService();
