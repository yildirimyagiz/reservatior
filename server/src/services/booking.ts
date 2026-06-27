import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class BookingService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.booking, "booking");
  }
}

export const bookingService = new BookingService();
