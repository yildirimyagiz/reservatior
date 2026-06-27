import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class SharedAmenityService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.sharedAmenity, "sharedAmenity");
  }
}

export const sharedAmenityService = new SharedAmenityService();
