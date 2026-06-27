import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LanguageService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.language, "language");
  }
}

export const languageService = new LanguageService();
