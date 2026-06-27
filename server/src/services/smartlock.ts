import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SmartLockService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.smartLock, "smartLock");
  }
}

export const smartLockService = new SmartLockService();
