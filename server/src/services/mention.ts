import { prisma } from "../lib/prisma";
import { BaseService } from "./base";
import { twitterBot } from "./twitter-bot";

export class MentionService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.mention, "mention");
  }

  async syncTwitterMentions(): Promise<any> {
    try {
      const mentions = await twitterBot.monitorMentions();
      if (mentions.data) {
        for (const mention of mentions.data) {
          // Check if mention already exists
          const existing = await prisma.mention.findFirst({
            where: { content: mention.text },
          });

          if (!existing) {
            await this.create({
              content: mention.text,
              type: "MENTION",
              isRead: false,
            });
          }
        }
      }
      return { success: true, count: mentions.data?.length || 0 };
    } catch (error) {
      console.error("Failed to sync Twitter mentions:", error);
      throw error;
    }
  }

  async processMention(mentionId: string): Promise<any> {
    try {
      const mention = await prisma.mention.findUnique({
        where: { id: mentionId },
      });

      if (!mention) {
        throw new Error("Mention not found");
      }

      // Auto-reply logic based on mention content
      let replyText = "";
      const content = (mention.content || "").toLowerCase();
      if (content.includes("reservation") || content.includes("booking")) {
        replyText = "Hello! For reservations please visit https://reservatior.com";
      } else if (content.includes("rental") || content.includes("rent")) {
        replyText = "For rental properties please visit https://reservatior.com/properties";
      } else {
        replyText = "Hello! How can we help you? Visit https://reservatior.com";
      }

      // Store Twitter ID in content field for reply
      const reply = await twitterBot.replyToTweet(mention.content || "", replyText);

      await prisma.mention.update({
        where: { id: mentionId },
        data: {
          isRead: true,
          content: `${mention.content}\n\nReplied: ${reply.data?.id}`,
        },
      });

      return { success: true, reply };
    } catch (error) {
      console.error("Failed to process mention:", error);
      throw error;
    }
  }
}

export const mentionService = new MentionService();
