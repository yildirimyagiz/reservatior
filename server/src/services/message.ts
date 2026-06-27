import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MessageService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.message, "message");
  }
}

export const messageService = new MessageService();
