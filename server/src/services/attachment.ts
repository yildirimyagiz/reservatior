import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AttachmentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.attachment, "attachment");
  }
}

export const attachmentService = new AttachmentService();
