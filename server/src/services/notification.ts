import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class NotificationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.notification, "notification");
  }
}

export const notificationService = new NotificationService();
