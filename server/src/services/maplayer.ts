import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MapLayerService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mapLayer, "mapLayer");
  }
}

export const mapLayerService = new MapLayerService();
