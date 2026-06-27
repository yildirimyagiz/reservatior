import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class NeighborhoodService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.neighborhood, "neighborhood");
  }
}

export const neighborhoodService = new NeighborhoodService();
