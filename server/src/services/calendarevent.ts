import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class CalendarEventService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.calendarEvent, "calendarEvent");
  }
}

export const calendarEventService = new CalendarEventService();
