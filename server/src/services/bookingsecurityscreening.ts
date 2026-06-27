import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class BookingSecurityScreeningService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.bookingSecurityScreening, "bookingSecurityScreening");
  }
}

export const bookingSecurityScreeningService = new BookingSecurityScreeningService();
