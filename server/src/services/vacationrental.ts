import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VacationRentalService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.vacationRental, "vacationRental");
  }
}

export const vacationRentalService = new VacationRentalService();
