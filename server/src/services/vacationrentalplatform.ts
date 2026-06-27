import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VacationRentalPlatformService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.vacationRentalPlatform, "vacationRentalPlatform");
  }
}

export const vacationRentalPlatformService = new VacationRentalPlatformService();
