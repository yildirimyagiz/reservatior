import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class EventService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.event, "event");
  }
}

export const eventService = new EventService();
