import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VideoVendorPartnershipService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.videoVendorPartnership, "videoVendorPartnership");
  }
}

export const videoVendorPartnershipService = new VideoVendorPartnershipService();
