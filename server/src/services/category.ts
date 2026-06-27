import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CategoryService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.category, "category");
  }
}

export const categoryService = new CategoryService();
