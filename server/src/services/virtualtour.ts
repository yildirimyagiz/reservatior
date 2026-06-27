import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VirtualTourService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.virtualTour, "virtualTour");
  }
}

export const virtualTourService = new VirtualTourService();
