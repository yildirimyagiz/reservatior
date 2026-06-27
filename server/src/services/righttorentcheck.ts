import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RightToRentCheckService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.rightToRentCheck, "rightToRentCheck");
  }
}

export const rightToRentCheckService = new RightToRentCheckService();
