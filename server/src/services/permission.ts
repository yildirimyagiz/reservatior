import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PermissionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.permission, "permission");
  }
}

export const permissionService = new PermissionService();
