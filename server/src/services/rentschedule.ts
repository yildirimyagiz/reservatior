import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RentScheduleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.rentSchedule, "rentSchedule");
  }
}

export const rentScheduleService = new RentScheduleService();
