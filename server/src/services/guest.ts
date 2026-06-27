import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class GuestService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.guest, "guest");
  }
}

export const guestService = new GuestService();
