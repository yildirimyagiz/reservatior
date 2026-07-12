const TIKTOK_API_BASE = "https://open.tiktokapis.com/v2";

export interface TikTokShareResult {
  success: boolean;
  postId?: string;
  error?: string;
}

export async function shareToTikTok(
  accessToken: string,
  videoUrl: string,
  title: string,
): Promise<TikTokShareResult> {
  // If we are in development or if a mock flag/empty token is passed, log and mock
  if (!accessToken || accessToken === "mock_token") {
    console.log(`[TikTokMock] Mock uploading video to TikTok: ${videoUrl} with title: ${title}`);
    return { success: true, postId: "mock_tiktok_post_" + Math.random().toString(36).substr(2, 9) };
  }

  try {
    // 1. Initialize Video Post
    const initResponse = await fetch(`${TIKTOK_API_BASE}/post/publish/video/init/`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify({
        post_info: {
          title,
          privacy_level: "PUBLIC_TO_EVERYONE",
          disable_duet: false,
          disable_stitch: false,
          disable_comment: false,
          video_cover_timestamp_ms: 1000
        },
        source_info: {
          source: "PULL_FROM_URL",
          video_url: videoUrl
        }
      }),
    });

    if (!initResponse.ok) {
      const errorBody = await initResponse.text();
      return { success: false, error: `TikTok Init API Error (${initResponse.status}): ${errorBody}` };
    }

    const initData = await initResponse.json();
    if (initData.error && initData.error.code !== "ok") {
      return { success: false, error: `TikTok Init Business Error: ${initData.error.message}` };
    }

    return { 
      success: true, 
      postId: initData.data?.publish_id || "tiktok_pub_id_" + Math.random().toString(36).substr(2, 9)
    };
  } catch (error) {
    return { success: false, error: (error as Error).message || "TikTok share failed" };
  }
}
