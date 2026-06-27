import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class IncreaseService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.increase, "increase");
  }
}

export const increaseService = new IncreaseService();
