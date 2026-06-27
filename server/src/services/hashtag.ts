import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { twitterBot } from "./twitter-bot";

export class HashtagService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.hashtag, "hashtag");
  }

  async postWithHashtags(
    title: string,
    location: string,
    price: number,
    currency: string,
    imageUrl?: string,
    url?: string
  ): Promise<any> {
    try {
      // Get top hashtags from database by usage count
      const topHashtags = await prisma.hashtag.findMany({
        take: 5,
        orderBy: { usageCount: "desc" },
      });

      const defaultHashtags = [
        "#RentalProperty",
        "#Airbnb",
        "#Reservatior",
        "#PropertyManagement",
      ];

      const hashtags = topHashtags.length > 0
        ? topHashtags.map((h) => `#${h.name}`)
        : defaultHashtags;

      return twitterBot.postListing({
        title,
        location,
        price,
        currency,
        imageUrl,
        url: url || "https://reservatior.com",
        hashtags,
      });
    } catch (error) {
      console.error("Failed to post with hashtags:", error);
      throw error;
    }
  }

  async trackHashtagUsage(hashtag: string): Promise<any> {
    try {
      // Remove # if present
      const tagName = hashtag.replace("#", "");
      const existing = await prisma.hashtag.findFirst({
        where: { name: tagName },
      });

      if (existing) {
        await prisma.hashtag.update({
          where: { id: existing.id },
          data: {
            usageCount: { increment: 1 },
          },
        });
      } else {
        await this.create({
          name: tagName,
          usageCount: 1,
          description: `Hashtag for ${tagName}`,
          relatedTags: [],
        });
      }

      return { success: true };
    } catch (error) {
      console.error("Failed to track hashtag usage:", error);
      throw error;
    }
  }

  async getTrendingHashtags(): Promise<any> {
    try {
      return prisma.hashtag.findMany({
        orderBy: { usageCount: "desc" },
        take: 10,
      });
    } catch (error) {
      console.error("Failed to get trending hashtags:", error);
      throw error;
    }
  }
}

export const hashtagService = new HashtagService();
