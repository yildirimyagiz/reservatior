import { prismaManager } from "../lib/prisma";
import { twitterBot } from "./twitter-bot";
import { communicationLogService } from "./communicationlog";

const POLL_INTERVAL_MS = 60 * 60 * 1000;
const MAX_TWEETS_PER_RUN = 5;
const RATE_LIMIT_DELAY_MS = 2800;

export class TwitterAutoPosterService {
  private static instance: TwitterAutoPosterService;
  private isRunning = false;

  private constructor() {}

  public static getInstance(): TwitterAutoPosterService {
    if (!TwitterAutoPosterService.instance) {
      TwitterAutoPosterService.instance = new TwitterAutoPosterService();
    }
    return TwitterAutoPosterService.instance;
  }

  // ====================== KANAL YÖNETİMİ ======================
  private async getOrCreateChannel(channelName: string, category: string = "LISTING") {
    const db = prismaManager.getClient();
    
    let channel = await db.channel.findFirst({
      where: { name: channelName }
    });

    if (!channel) {
      channel = await db.channel.create({
        data: {
          name: channelName,
          type: "PUBLIC",
          category: category as any,
          description: `${channelName} otomatik paylaşımları`,
        }
      });
      console.log(`[ChannelManager] Yeni kanal oluşturuldu: ${channelName}`);
    }
    return channel;
  }

  // ====================== MENTION & HASHTAG ======================
  private async calculateMentionScore(mention: any, listing: any): Promise<number> {
    let score = 10;
    const city = (listing.property?.city || "").toLowerCase();
    const country = (listing.property?.country || "").toLowerCase();
    const type = (listing.property?.listingType || "").toLowerCase();

    if (mention.content?.toLowerCase().includes(city)) score += 45;
    if (mention.content?.toLowerCase().includes(country)) score += 30;
    if (mention.propertyId === listing.propertyId) score += 65;

    const daysOld = (Date.now() - new Date(mention.createdAt).getTime()) / 86400000;
    score += Math.max(0, 25 - daysOld);

    if (type.includes("villa") && mention.content?.toLowerCase().includes("villa")) score += 22;
    if (type.includes("luxury") && mention.content?.toLowerCase().includes("luxury")) score += 28;

    return Math.min(Math.round(score), 100);
  }

  private async getBestMentions(listing: any, limit = 2): Promise<string[]> {
    const db = prismaManager.getClient();
    const mentions = await db.mention.findMany({
      where: { type: "PROPERTY", deletedAt: null },
      select: { content: true, propertyId: true, createdAt: true },
      take: 30,
    });

    const scored = await Promise.all(
      mentions.map(async (m: any) => ({
        content: m.content,
        score: await this.calculateMentionScore(m, listing),
      }))
    );

    return scored
      .sort((a: any, b: any) => b.score - a.score)
      .filter((m: any) => m.score >= 18)
      .slice(0, limit)
      .map((m: any) => m.content);
  }

  private async getSmartHashtags(listing: any): Promise<string[]> {
    const db = prismaManager.getClient();
    const [propertyTags, popularTags] = await Promise.all([
      db.hashtag.findMany({
        where: { Property: { some: { id: listing.property?.id } }, deletedAt: null },
        select: { name: true },
      }),
      db.hashtag.findMany({
        where: { deletedAt: null },
        select: { name: true },
        orderBy: { usageCount: "desc" },
        take: 10,
      })
    ]);

    const tags = new Set(["#Reservatior", "#RealEstate", ...propertyTags.map((h: any) => h.name), ...popularTags.map((h: any) => h.name)]);

    if (listing.property?.city) tags.add(`#${listing.property.city.replace(/\s+/g, "")}`);
    if (listing.property?.country) tags.add(`#${listing.property.country.replace(/\s+/g, "")}`);

    return Array.from(tags).slice(0, 11);
  }

  // ====================== TWEET BUILDER ======================
  private async buildTweet(listing: any): Promise<string> {
    const title = listing.title || listing.property.name;
    const location = [listing.property.city, listing.property.country].filter(Boolean).join(", ");
    const rawPrice = listing.price ?? listing.property.listingPrice;
    const priceFormatted = rawPrice 
      ? `${listing.priceCurrency || listing.property.currency || "USD"} ${Number(rawPrice).toLocaleString()}` 
      : "";

    let desc = (listing.description || "").trim();
    if (desc.length > 135) desc = desc.slice(0, 132) + "…";

    const [hashtags, mentions] = await Promise.all([
      this.getSmartHashtags(listing),
      this.getBestMentions(listing, 2)
    ]);

    const mentionText = mentions.length ? mentions.join(" ") + " " : "";

    const templates = [
      `🏡 ${title}\n📍 ${location}\n💰 ${priceFormatted}\n\n${desc}\n\nBu listing ile yeni bir residential journey başlıyor.\n🌐 reservatior.com/listing/${listing.id}\n${mentionText}${hashtags.join(" ")}`,
      `✨ Yeni Fırsat: ${title}\n${location ? `📍 ${location}\n` : ""}${priceFormatted ? `💎 ${priceFormatted}\n\n` : ""}${desc}\n\nLong-term Residential Advisor’lar için güçlü bir varlık.\n🌐 reservatior.com/listing/${listing.id}\n${mentionText}${hashtags.join(" ")}`
    ];

    let tweet = templates[Math.floor(Math.random() * templates.length)];
    return tweet.length > 280 ? tweet.slice(0, 277) + "…" : tweet;
  }

  // ====================== ANA PAYLAŞIM + KANAL ENTEGRASYONU ======================
  private async shareListing(listingId: string): Promise<boolean> {
    const db = prismaManager.getClient();

    try {
      const listing = await db.listing.findUnique({
        where: { id: listingId },
        include: {
          property: {
            include: {
              propertyPhotos: { where: { deletedAt: null, isPrimary: true }, take: 1 }
            }
          }
        }
      });

      if (!listing) return false;

      const text = await this.buildTweet(listing);
      const media = listing.property.propertyPhotos[0]?.url 
        ? [listing.property.propertyPhotos[0].url] 
        : undefined;

      const tweetResult = await twitterBot.postTweet({ text, media });

      // Kanal Belirleme (Villa, Kiralama, Satış, Booking)
      const listingType = listing.property.listingType?.toLowerCase() || "general";
      let channelName = "TWITTER_GENERAL";

      if (listingType.includes("villa") || listingType.includes("luxury")) {
        channelName = "TWITTER_VILLA";
      } else if (listingType.includes("sale") || listingType.includes("satılık")) {
        channelName = "TWITTER_SALES";
      } else if (listingType.includes("rent") || listingType.includes("kiralık")) {
        channelName = "TWITTER_RENTAL";
      } else if (listingType.includes("booking")) {
        channelName = "TWITTER_BOOKING";
      }

      const channel = await this.getOrCreateChannel(channelName, "PROPERTY");

      // CommunicationLog Kaydı
      await communicationLogService.create({
        senderId: "SYSTEM_TWITTER_BOT",
        receiverId: "TEAM",
        type: "INFORMATION",
        content: text,
        entityId: listing.id,
        entityType: "LISTING",
        channelId: channel.id,
        metadata: {
          twitterPostId: tweetResult?.data?.id,
          hashtags: text.match(/#\w+/g) || [],
          mentions: text.match(/@\w+/g) || [],
          mediaCount: media?.length || 0,
          listingType: listingType,
          channelName: channel.name,
        },
        timestamp: new Date(),
      });

      // Hashtag Güncelle
      const usedHashtags = text.match(/#\w+/g) || [];
      if (usedHashtags.length > 0) {
        await db.hashtag.updateMany({
          where: { name: { in: usedHashtags } },
          data: { usageCount: { increment: 1 } }
        });
      }

      console.log(`[TwitterAutoPoster] ✅ ${channel.name} kanalına paylaşıldı: ${listingId}`);
      return true;

    } catch (error: any) {
      console.error(`[TwitterAutoPoster] ❌ Hata ${listingId}:`, error?.message);
      return false;
    }
  }

  // ====================== ANA ÇALIŞTIRICI ======================
  public async start(): Promise<void> {
    if (this.isRunning) return;
    this.isRunning = true;

    if (!process.env.TWITTER_BOT_ACCESS_TOKEN) {
      console.log("[TwitterAutoPoster] ❌ Token eksik.");
      return;
    }

    console.log("[TwitterAutoPoster] 🚀 Servis başlatıldı → Channel & CommunicationLog entegrasyonu aktif");

    await this.shareNewListings();

    setInterval(async () => {
      try {
        await this.shareNewListings();
      } catch (e) {
        console.error("[TwitterAutoPoster] Interval hatası:", e);
      }
    }, POLL_INTERVAL_MS);
  }

  private async shareNewListings(): Promise<number> {
    const db = prismaManager.getClient();
    const since = new Date(Date.now() - POLL_INTERVAL_MS);

    const alreadyPosted = await db.communicationLog.findMany({
      where: { senderId: "SYSTEM_TWITTER_BOT", entityType: "LISTING", entityId: { not: null } },
      select: { entityId: true }
    });

    const postedSet = new Set(alreadyPosted.map((p: any) => p.entityId));

    const listings = await db.listing.findMany({
      where: {
        status: { in: ["AVAILABLE", "BOOKED"] },
        createdAt: { gte: since },
        property: { listingStatus: { not: "DRAFT" } },
      },
      include: { property: true },
      take: MAX_TWEETS_PER_RUN,
      orderBy: { createdAt: "desc" },
    });

    let shared = 0;
    for (const listing of listings) {
      if (postedSet.has(listing.id)) continue;

      const success = await this.shareListing(listing.id);
      if (success) {
        shared++;
        if (shared < listings.length) await new Promise(r => setTimeout(r, RATE_LIMIT_DELAY_MS));
      }
    }

    return shared;
  }
}

export const twitterAutoPosterService = TwitterAutoPosterService.getInstance();

export async function startTwitterAutoPoster(): Promise<void> {
  await twitterAutoPosterService.start();
}