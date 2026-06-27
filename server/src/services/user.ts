import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class UserService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.user, "user");
  }
}

export const userService = new UserService();
