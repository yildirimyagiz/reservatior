import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MobileDeviceService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mobileDevice, "mobileDevice");
  }
}

export const mobileDeviceService = new MobileDeviceService();
