import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MapDataService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mapData, "mapData");
  }
}

export const mapDataService = new MapDataService();
