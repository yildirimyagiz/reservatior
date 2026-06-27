import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VideoCaptionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.videoCaption, "videoCaption");
  }
}

export const videoCaptionService = new VideoCaptionService();
