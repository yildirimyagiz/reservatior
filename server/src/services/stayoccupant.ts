import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class StayOccupantService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.stayOccupant, "stayOccupant");
  }
}

export const stayOccupantService = new StayOccupantService();
