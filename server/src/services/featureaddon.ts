import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class FeatureAddOnService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.featureAddOn, "featureAddOn");
  }
}

export const featureAddOnService = new FeatureAddOnService();
