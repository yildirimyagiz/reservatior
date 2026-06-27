import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AIPropertyDescriptionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.aIPropertyDescription, "aIPropertyDescription");
  }
}

export const aIPropertyDescriptionService = new AIPropertyDescriptionService();
