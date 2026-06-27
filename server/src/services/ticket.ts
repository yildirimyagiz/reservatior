import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class TicketService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.ticket, "ticket");
  }
}

export const ticketService = new TicketService();
