import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ScrapingJobService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.scrapingJob, "scrapingJob");
  }
}

export const scrapingJobService = new ScrapingJobService();
