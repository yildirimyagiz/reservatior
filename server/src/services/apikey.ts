import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ApiKeyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.apiKey, "apiKey");
  }
}

export const apiKeyService = new ApiKeyService();
