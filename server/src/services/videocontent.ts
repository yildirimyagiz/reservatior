import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VideoContentService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.videoContent, "videoContent");
  }
}

export const videoContentService = new VideoContentService();
