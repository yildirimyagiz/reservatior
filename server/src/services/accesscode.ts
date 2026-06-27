import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AccessCodeService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.accessCode, "accessCode");
  }
}

export const accessCodeService = new AccessCodeService();
