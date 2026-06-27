import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VideoEarningService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.videoEarning, "videoEarning");
  }
}

export const videoEarningService = new VideoEarningService();
