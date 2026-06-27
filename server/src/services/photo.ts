import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class PhotoService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.photo, "photo");
  }
}

export const photoService = new PhotoService();
