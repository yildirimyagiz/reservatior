import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ApiTokenService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.apiToken, "apiToken");
  }
}

export const apiTokenService = new ApiTokenService();
