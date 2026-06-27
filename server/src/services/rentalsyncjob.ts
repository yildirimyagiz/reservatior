import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RentalSyncJobService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.rentalSyncJob, "rentalSyncJob");
  }
}

export const rentalSyncJobService = new RentalSyncJobService();
