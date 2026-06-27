import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class TagService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.tag, "tag");
  }
}

export const tagService = new TagService();
