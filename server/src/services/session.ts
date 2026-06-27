import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SessionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.session, "session");
  }
}

export const sessionService = new SessionService();
