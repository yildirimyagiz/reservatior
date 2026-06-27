import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class ReviewService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.review, "review");
  }
}

export const reviewService = new ReviewService();
