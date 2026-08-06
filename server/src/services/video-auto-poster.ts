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

    console.log("[VideoAutoPoster] 🚀 Video auto poster service started (Queue Dispatcher Mode)");

    // Initial check on startup
    await this.queuePendingVideos();

    setInterval(async () => {
      try {
        await this.queuePendingVideos();
      } catch (e) {
        console.error("[VideoAutoPoster] Interval error:", e);
      }
    }, POLL_INTERVAL_MS);
  }

  private async queuePendingVideos(): Promise<number> {
    const { rabbitMQService } = require('./rabbitmq-service');
    const rabbitMQ = rabbitMQService;

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
      const platformsToPost: string[] = [];
      if (video.platform === "TIKTOK" || video.platform === "ALL_PLATFORMS") platformsToPost.push("TIKTOK");
      if (video.platform === "YOUTUBE_SHORTS" || video.platform === "ALL_PLATFORMS") platformsToPost.push("YOUTUBE");

      if (platformsToPost.length > 0) {
        try {
          // Push to GPU/Video Job Queue instead of processing synchronously
          await rabbitMQ.publish('video_posting_queue', {
            videoId: video.id,
            platforms: platformsToPost,
            orgId: video.orgId,
            listingId: video.listingId,
            tokens: config,
            queuedAt: new Date().toISOString()
          });

          // Mark as processing/queued to avoid duplicate queuing
          await prisma.videoContent.update({
            where: { id: video.id },
            data: { status: "GENERATING" },
          });

          console.log(`[VideoAutoPoster] 📥 Video ${video.id} queued for background processing.`);
          processed++;
        } catch (err: any) {
          console.error(`[VideoAutoPoster] Failed to queue video ${video.id}:`, err?.message);
        }
      }
    }

    return processed;
  }
}

export const videoAutoPosterService = VideoAutoPosterService.getInstance();

export async function startVideoAutoPoster(): Promise<void> {
  await videoAutoPosterService.start();
}
