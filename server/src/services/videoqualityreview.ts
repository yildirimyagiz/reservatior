import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VideoQualityReviewService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.videoQualityReview, "videoQualityReview");
  }
}

export const videoQualityReviewService = new VideoQualityReviewService();
