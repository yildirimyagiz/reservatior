import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class GuestReviewService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.guestReview, "guestReview");
  }
}

export const guestReviewService = new GuestReviewService();
