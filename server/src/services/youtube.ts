export interface YouTubeShareResult {
  success: boolean;
  videoId?: string;
  error?: string;
}

export async function uploadToYouTube(
  accessToken: string,
  videoUrl: string,
  title: string,
  description: string,
): Promise<YouTubeShareResult> {
  // Mock fallback if no access token or mock token is provided
  if (!accessToken || accessToken === "mock_token") {
    console.log(`[YouTubeMock] Mock uploading video to YouTube: ${videoUrl} with title: ${title}`);
    return { success: true, videoId: "mock_youtube_" + Math.random().toString(36).substr(2, 9) };
  }

  try {
    // YouTube API v3 Video Insert Endpoint
    // In practice, we upload the video binary, or we can use the resumable upload flow.
    // For this implementation, since it pulls from videoUrl, we download the video chunk first
    // or perform a multipart upload. Here is a standard multipart upload structure:
    const videoFetch = await fetch(videoUrl);
    if (!videoFetch.ok) {
      return { success: false, error: `Failed to download source video from url: ${videoUrl}` };
    }
    const videoBlob = await videoFetch.blob();

    const metadata = {
      snippet: {
        title: title.slice(0, 100),
        description: description.slice(0, 5000),
        categoryId: "22", // People & Blogs
      },
      status: {
        privacyStatus: "public",
        selfDeclaredMadeForKids: false,
      },
    };

    const formData = new FormData();
    formData.append(
      "metadata",
      new Blob([JSON.stringify(metadata)], { type: "application/json" })
    );
    formData.append("media", videoBlob);

    const response = await fetch(
      "https://www.googleapis.com/upload/youtube/v3/videos?uploadType=multipart&part=snippet,status",
      {
        method: "POST",
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
        body: formData,
      }
    );

    if (!response.ok) {
      const errorBody = await response.text();
      return { success: false, error: `YouTube API Error (${response.status}): ${errorBody}` };
    }

    const data = await response.json();
    return { success: true, videoId: data.id };
  } catch (error) {
    return { success: false, error: (error as Error).message || "YouTube upload failed" };
  }
}
