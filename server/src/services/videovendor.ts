import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VideoVendorService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.videoVendor, "videoVendor");
  }
}

export const videoVendorService = new VideoVendorService();
