import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class GuestProfileService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.guestProfile, "guestProfile");
  }
}

export const guestProfileService = new GuestProfileService();
