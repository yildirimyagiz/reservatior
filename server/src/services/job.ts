import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class JobService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.job, "job");
  }
}

export const jobService = new JobService();
