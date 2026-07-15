import { prisma } from "../lib/prisma";
import { shareToTikTok } from "./tiktok";
import { uploadToYouTube } from "./youtube";

const POLL_INTERVAL_MS = 60 * 60 * 1000; // Check every 60 minutes
const MAX_VIDEOS_PER_RUN = 3;

interface VideoPosterConfig {
  tiktokToken?: string;
  youtubeToken?: string;
}

async function getTokens(): Promise<VideoPosterConfig> {
  // Try resolving tokens from database SocialAccount configurations
  const [tiktokAccount, googleAccount] = await Promise.all([
    prisma.socialAccount.findFirst({
      where: { platform: "TIKTOK", isActive: true },
      orderBy: { createdAt: "desc" },
    }),
    prisma.socialAccount.findFirst({
      where: { platform: "YOUTUBE", isActive: true },
      orderBy: { createdAt: "desc" },
    }),
  ]);

  return {
    tiktokToken: tiktokAccount?.accessToken || process.env.TIKTOK_ACCESS_TOKEN || "mock_token",
    youtubeToken: googleAccount?.accessToken || process.env.YOUTUBE_ACCESS_TOKEN || "mock_token",
  };
}

export class VideoAutoPosterService {
  private static instance: VideoAutoPosterService;
  private isRunning = false;

  private constructor() {}

  public static getInstance(): VideoAutoPosterService {
    if (!VideoAutoPosterService.instance) {
      VideoAutoPosterService.instance = new VideoAutoPosterService();
    }
    return VideoAutoPosterService.instance;
  }

  public async start(): Promise<void> {
    if (this.isRunning) return;
    this.isRunning = true;

    console.log("[VideoAutoPoster] 🚀 Video auto poster service started (TikTok & YouTube Shorts)");

    await this.postPendingVideos();

    setInterval(async () => {
      try {
        await this.postPendingVideos();
      } catch (e) {
        console.error("[VideoAutoPoster] Interval error:", e);
      }
    }, POLL_INTERVAL_MS);
  }

  private async postPendingVideos(): Promise<number> {
    const config = await getTokens();
    const videos = await prisma.videoContent.findMany({
      where: {
        status: "READY",
        url: { not: null },
        deletedAt: null,
      },
      include: { listing: true, property: true },
      take: MAX_VIDEOS_PER_RUN,
      orderBy: { createdAt: "desc" },
    });

    let processed = 0;
    for (const video of videos) {
      const title = video.title || video.listing?.title || video.property?.name || "Reservatior Property Video";
      const desc = video.listing?.description || video.property?.description || "Check out this beautiful property listed on Reservatior.";

      const platformsToPost: string[] = [];
      if (video.platform === "TIKTOK" || video.platform === "ALL_PLATFORMS") {
        platformsToPost.push("TIKTOK");
      }
      if (video.platform === "YOUTUBE_SHORTS" || video.platform === "ALL_PLATFORMS") {
        platformsToPost.push("YOUTUBE");
      }

      let successCount = 0;

      for (const platform of platformsToPost) {
        // Check if we already posted this video to this platform
        const alreadyPosted = await prisma.socialPost.findFirst({
          where: {
            platform: platform as any,
            listingId: video.listingId || undefined,
            content: { contains: video.id },
          },
        });

        if (alreadyPosted) {
          successCount++;
          continue;
        }

        try {
          if (platform === "TIKTOK" && config.tiktokToken) {
            console.log(`[VideoAutoPoster] Posting video ${video.id} to TikTok...`);
            const res = await shareToTikTok(config.tiktokToken, video.url!, title);
            if (res.success) {
              await prisma.socialPost.create({
                data: {
                  orgId: video.orgId,
                  platform: "TIKTOK",
                  listingId: video.listingId,
                  content: `Video ID: ${video.id} - ${title}\n${desc}`,
                  externalPostId: res.postId,
                  status: "PUBLISHED",
                },
              });
              successCount++;
              console.log(`[VideoAutoPoster] ✅ Video ${video.id} successfully posted to TikTok.`);
            } else {
              console.error(`[VideoAutoPoster] ❌ TikTok posting failed for video ${video.id}:`, res.error);
            }
          }

          if (platform === "YOUTUBE" && config.youtubeToken) {
            console.log(`[VideoAutoPoster] Uploading video ${video.id} to YouTube...`);
            const res = await uploadToYouTube(config.youtubeToken, video.url!, title, desc);
            if (res.success) {
              await prisma.socialPost.create({
                data: {
                  orgId: video.orgId,
                  platform: "YOUTUBE",
                  listingId: video.listingId,
                  content: `Video ID: ${video.id} - ${title}\n${desc}`,
                  externalPostId: res.videoId,
                  status: "PUBLISHED",
                },
              });
              successCount++;
              console.log(`[VideoAutoPoster] ✅ Video ${video.id} successfully uploaded to YouTube.`);
            } else {
              console.error(`[VideoAutoPoster] ❌ YouTube upload failed for video ${video.id}:`, res.error);
            }
          }
        } catch (err: any) {
          console.error(`[VideoAutoPoster] Exception while posting video ${video.id} to ${platform}:`, err?.message);
        }
      }

      // If successfully posted to all targeted platforms, mark video status as PUBLISHED
      if (successCount === platformsToPost.length && platformsToPost.length > 0) {
        await prisma.videoContent.update({
          where: { id: video.id },
          data: { status: "PUBLISHED", publishedAt: new Date() },
        });
        processed++;
      }
    }

    return processed;
  }
}

export const videoAutoPosterService = VideoAutoPosterService.getInstance();

export async function startVideoAutoPoster(): Promise<void> {
  await videoAutoPosterService.start();
}
