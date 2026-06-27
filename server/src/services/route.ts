import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class RouteService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.route, "route");
  }
}

export const routeService = new RouteService();
