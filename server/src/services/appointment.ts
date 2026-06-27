import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class AppointmentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.appointment, "appointment");
  }
}

export const appointmentService = new AppointmentService();
