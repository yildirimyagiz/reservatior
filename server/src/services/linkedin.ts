const LINKEDIN_API = "https://api.linkedin.com/v2";

export interface LinkedInShareResult {
  success: boolean;
  postId?: string;
  error?: string;
}

export async function shareToLinkedInPerson(
  accessToken: string,
  personUrn: string,
  text: string,
): Promise<LinkedInShareResult> {
  const urn = personUrn.startsWith("urn:li:person:") ? personUrn : `urn:li:person:${personUrn}`;

  const payload = {
    author: urn,
    lifecycleState: "PUBLISHED",
    specificContent: {
      "com.linkedin.ugc.ShareContent": {
        shareCommentary: { text },
        shareMediaCategory: "NONE",
      },
    },
    visibility: {
      "com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC",
    },
  };

  try {
    const response = await fetch(`${LINKEDIN_API}/ugcPosts`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json",
        "X-Restli-Protocol-Version": "2.0.0",
      },
      body: JSON.stringify(payload),
    });

    if (!response.ok) {
      const errorBody = await response.text();
      return { success: false, error: `LinkedIn Person API Error (${response.status}): ${errorBody}` };
    }

    const data = await response.json();
    return { success: true, postId: data.id };
  } catch (error) {
    return { success: false, error: (error as Error).message || "LinkedIn person share failed" };
  }
}

export async function shareToLinkedInCompany(
  accessToken: string,
  text: string,
): Promise<LinkedInShareResult> {
  const companyId = process.env.LINKEDIN_COMPANY_ID;
  if (!companyId) {
    return { success: false, error: "LINKEDIN_COMPANY_ID not configured" };
  }

  const author = `urn:li:organization:${companyId}`;
  const payload = {
    author,
    lifecycleState: "PUBLISHED",
    specificContent: {
      "com.linkedin.ugc.ShareContent": {
        shareCommentary: { text },
        shareMediaCategory: "NONE",
      },
    },
    visibility: {
      "com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC",
    },
  };

  try {
    const response = await fetch(`${LINKEDIN_API}/ugcPosts`, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json",
        "X-Restli-Protocol-Version": "2.0.0",
      },
      body: JSON.stringify(payload),
    });

    if (!response.ok) {
      const errorBody = await response.text();
      return { success: false, error: `LinkedIn Company API Error (${response.status}): ${errorBody}` };
    }

    const data = await response.json();
    return { success: true, postId: data.id };
  } catch (error) {
    return { success: false, error: (error as Error).message || "LinkedIn company share failed" };
  }
}

export async function refreshAccessToken(refreshToken: string): Promise<{
  accessToken: string;
  expiresIn: number;
} | null> {
  try {
    const clientId = process.env.AUTH_LINKEDIN_ID!;
    const clientSecret = process.env.AUTH_LINKEDIN_SECRET!;

    const res = await fetch("https://www.linkedin.com/oauth/v2/accessToken", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams({
        grant_type: "refresh_token",
        refresh_token: refreshToken,
        client_id: clientId,
        client_secret: clientSecret,
      }),
    });

    if (!res.ok) return null;

    const data = await res.json();
    return { accessToken: data.access_token, expiresIn: data.expires_in };
  } catch {
    return null;
  }
}
