import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class VendorQualityReviewService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.vendorQualityReview, "vendorQualityReview");
  }
}

export const vendorQualityReviewService = new VendorQualityReviewService();
