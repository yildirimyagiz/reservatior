import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RentArrearsService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.rentArrears, "rentArrears");
  }
}

export const rentArrearsService = new RentArrearsService();
