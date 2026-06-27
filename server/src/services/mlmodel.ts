import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class MLModelService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mLModel, "mLModel");
  }
}

export const mLModelService = new MLModelService();
