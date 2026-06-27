import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class LocationService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.location, "location");
  }
}

export const locationService = new LocationService();
