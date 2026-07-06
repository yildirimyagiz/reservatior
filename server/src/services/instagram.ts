const META_GRAPH_API = "https://graph.facebook.com/v21.0";

export interface InstagramShareResult {
  success: boolean;
  mediaId?: string;
  error?: string;
}

export interface MediaContainer {
  id: string;
  type: "IMAGE" | "VIDEO";
}

// ── Token Management ───────────────────────────────────────────────────────────

async function getLongLivedToken(shortLivedToken: string): Promise<string | null> {
  const appId = process.env.META_APP_ID;
  const appSecret = process.env.META_APP_SECRET;
  if (!appId || !appSecret) return null;

  const res = await fetch(
    `${META_GRAPH_API}/oauth/access_token?grant_type=fb_exchange_token&client_id=${appId}&client_secret=${appSecret}&fb_exchange_token=${shortLivedToken}`,
  );
  if (!res.ok) return null;
  const data = await res.json();
  return data.access_token;
}

// ── Account Resolution ─────────────────────────────────────────────────────────

export async function getInstagramAccountId(
  pageId: string,
  accessToken: string,
): Promise<string | null> {
  const res = await fetch(
    `${META_GRAPH_API}/${pageId}?fields=instagram_business_account&access_token=${accessToken}`,
  );
  if (!res.ok) return null;
  const data = await res.json();
  return data.instagram_business_account?.id || null;
}

// ── Single Image Post ──────────────────────────────────────────────────────────

export async function createImageMediaContainer(
  igUserId: string,
  imageUrl: string,
  caption: string,
  accessToken: string,
): Promise<InstagramShareResult> {
  return createContainer(igUserId, imageUrl, caption, "IMAGE", accessToken);
}

// ── Single Video Post (Reel) ───────────────────────────────────────────────────

export async function createVideoMediaContainer(
  igUserId: string,
  videoUrl: string,
  caption: string,
  accessToken: string,
  thumbOffset?: number,
): Promise<InstagramShareResult> {
  const url = `${META_GRAPH_API}/${igUserId}/media`;
  const params: Record<string, string> = {
    media_type: "VIDEO",
    video_url: videoUrl,
    caption,
    access_token: accessToken,
  };
  if (thumbOffset !== undefined) {
    params.thumb_offset = String(thumbOffset);
  }

  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams(params),
    });
    const data = await res.json();
    if (!res.ok) {
      return { success: false, error: `Meta API Error (${res.status}): ${data.error?.message || res.statusText}` };
    }
    return { success: true, mediaId: data.id };
  } catch (error) {
    return { success: false, error: (error as Error).message || "Instagram video container creation failed" };
  }
}

// ── Carousel Container (mixed image/video) ─────────────────────────────────────

async function createContainer(
  igUserId: string,
  mediaUrl: string,
  caption: string,
  mediaType: "IMAGE" | "VIDEO",
  accessToken: string,
): Promise<InstagramShareResult> {
  const url = `${META_GRAPH_API}/${igUserId}/media`;
  const params: Record<string, string> = {
    access_token: accessToken,
  };

  if (mediaType === "IMAGE") {
    params.image_url = mediaUrl;
  } else {
    params.media_type = "VIDEO";
    params.video_url = mediaUrl;
  }

  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams(params),
    });
    const data = await res.json();
    if (!res.ok) {
      return { success: false, error: `Meta API Error (${res.status}): ${data.error?.message || res.statusText}` };
    }
    return { success: true, mediaId: data.id };
  } catch (error) {
    return { success: false, error: (error as Error).message || "Instagram container creation failed" };
  }
}

export async function createCarouselContainer(
  igUserId: string,
  mediaUrls: string[],
  caption: string,
  accessToken: string,
): Promise<InstagramShareResult> {
  const children: string[] = [];

  for (let i = 0; i < mediaUrls.length; i++) {
    const isVideo = await isVideoUrl(mediaUrls[i]);
    const container = await createContainer(
      igUserId,
      mediaUrls[i],
      "",
      isVideo ? "VIDEO" : "IMAGE",
      accessToken,
    );
    if (!container.success) {
      return { success: false, error: `Carousel item ${i} failed: ${container.error}` };
    }
    children.push(container.mediaId!);
  }

  const url = `${META_GRAPH_API}/${igUserId}/media`;
  const body = new URLSearchParams({
    media_type: "CAROUSEL",
    children: children.join(","),
    caption,
    access_token: accessToken,
  });

  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body,
    });
    const data = await res.json();
    if (!res.ok) {
      return { success: false, error: `Carousel creation failed: ${data.error?.message}` };
    }
    return publishMediaContainer(igUserId, data.id, accessToken);
  } catch (error) {
    return { success: false, error: (error as Error).message || "Carousel publish failed" };
  }
}

// ── Publish ────────────────────────────────────────────────────────────────────

export async function publishMediaContainer(
  igUserId: string,
  creationId: string,
  accessToken: string,
): Promise<InstagramShareResult> {
  const url = `${META_GRAPH_API}/${igUserId}/media_publish`;
  const body = new URLSearchParams({ creation_id: creationId, access_token: accessToken });

  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body,
    });
    const data = await res.json();
    if (!res.ok) {
      return { success: false, error: `Meta API Error (${res.status}): ${data.error?.message || res.statusText}` };
    }
    return { success: true, mediaId: data.id };
  } catch (error) {
    return { success: false, error: (error as Error).message || "Instagram media publish failed" };
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────────

async function isVideoUrl(url: string): Promise<boolean> {
  const videoExts = [".mp4", ".mov", ".avi", ".webm", ".mkv"];
  const lower = url.toLowerCase();
  if (videoExts.some((ext) => lower.endsWith(ext) || lower.includes(`%2E${ext.slice(1)}`))) {
    return true;
  }
  return false;
}

export async function refreshAccessToken(): Promise<string | null> {
  const token = process.env.META_ACCESS_TOKEN;
  if (!token) return null;
  return getLongLivedToken(token);
}
