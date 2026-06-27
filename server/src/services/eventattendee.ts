import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class EventAttendeeService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.eventAttendee, "eventAttendee");
  }
}

export const eventAttendeeService = new EventAttendeeService();
