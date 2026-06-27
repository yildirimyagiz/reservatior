import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RoleService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.role, "role");
  }
}

export const roleService = new RoleService();
