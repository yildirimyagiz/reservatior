import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CategoryTranslationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.categoryTranslation, "categoryTranslation");
  }
}

export const categoryTranslationService = new CategoryTranslationService();
