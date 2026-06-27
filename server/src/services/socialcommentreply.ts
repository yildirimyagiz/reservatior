import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SocialCommentReplyService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.socialCommentReply, "socialCommentReply");
  }
}

export const socialCommentReplyService = new SocialCommentReplyService();
