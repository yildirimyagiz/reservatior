import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RolePermissionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.rolePermission, "rolePermission");
  }
}

export const rolePermissionService = new RolePermissionService();
