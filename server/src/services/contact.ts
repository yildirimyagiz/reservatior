import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ContactService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.contact, "contact");
  }
}

export const contactService = new ContactService();
