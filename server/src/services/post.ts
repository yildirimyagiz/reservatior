import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PostService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.post, "post");
  }
}

export const postService = new PostService();
