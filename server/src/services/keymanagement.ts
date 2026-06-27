import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class KeyManagementService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.keyManagement, "keyManagement");
  }
}

export const keyManagementService = new KeyManagementService();
