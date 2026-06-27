import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AvailabilityService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.availability, "availability");
  }
}

export const availabilityService = new AvailabilityService();
