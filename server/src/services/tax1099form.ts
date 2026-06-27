import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class Tax1099FormService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.tax1099Form, "tax1099Form");
  }
}

export const tax1099FormService = new Tax1099FormService();
