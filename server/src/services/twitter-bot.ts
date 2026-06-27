interface TwitterPost {
  text: string;
  media?: string[];
}

interface TwitterListingPost {
  title: string;
  location: string;
  price: number;
  currency: string;
  imageUrl?: string;
  url: string;
  hashtags?: string[];
}

class TwitterBotService {
  private accessToken: string;
  private refreshToken: string;
  private baseUrl = "https://api.twitter.com/2";

  constructor() {
    this.accessToken = process.env.TWITTER_BOT_ACCESS_TOKEN || "";
    this.refreshToken = process.env.TWITTER_BOT_REFRESH_TOKEN || "";
  }

  private async refreshAccessToken(): Promise<void> {
    try {
      const response = await fetch(`${this.baseUrl}/oauth2/token`, {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": `Basic ${Buffer.from(
            `${process.env.TWITTER_API_KEY}:${process.env.TWITTER_API_SECRET}`
          ).toString("base64")}`,
        },
        body: new URLSearchParams({
          grant_type: "refresh_token",
          refresh_token: this.refreshToken,
        }),
      });

      const data = await response.json();
      if (data.access_token) {
        this.accessToken = data.access_token;
        // Update refresh token if provided
        if (data.refresh_token) {
          this.refreshToken = data.refresh_token;
        }
      }
    } catch (error) {
      console.error("Failed to refresh Twitter access token:", error);
    }
  }

  async postTweet(post: TwitterPost): Promise<any> {
    try {
      const response = await fetch(`${this.baseUrl}/tweets`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${this.accessToken}`,
        },
        body: JSON.stringify({
          text: post.text,
          media: post.media ? {
            media_ids: post.media,
          } : undefined,
        }),
      });

      if (response.status === 401) {
        await this.refreshAccessToken();
        return this.postTweet(post);
      }

      return await response.json();
    } catch (error) {
      console.error("Failed to post tweet:", error);
      throw error;
    }
  }

  async postListing(listing: TwitterListingPost): Promise<any> {
    const hashtags = listing.hashtags || [
      "#KiralıkEv",
      "#AirbnbTurkey",
      "#Rezervasyon",
      "#Reservatior",
    ];

    const text = `🏠 ${listing.title}

📍 ${listing.location}
💰 ${listing.price} ${listing.currency}

🔗 ${listing.url}

${hashtags.join(" ")}`;

    return this.postTweet({
      text,
      media: listing.imageUrl ? [listing.imageUrl] : undefined,
    });
  }

  async postAvailabilityUpdate(
    title: string,
    location: string,
    availableDates: string
  ): Promise<any> {
    const text = `📅 YENİ MÜSAİT TARİHLER!

🏠 ${title}
📍 ${location}

🗓️ ${availableDates}

Hemen rezervasyon yapın: https://reservatior.com

#KiralıkEv #AirbnbTurkey #Rezervasyon`;

    return this.postTweet({ text });
  }

  async postPromotion(
    title: string,
    discount: number,
    listingUrl: string
  ): Promise<any> {
    const text = `🔥 ÖZEL KAMPANYA! 🔥

${title}
%${discount} indirim!

🔗 ${listingUrl}

Fırsatı kaçırma! #KiralıkEv #İndirim #Reservatior`;

    return this.postTweet({ text });
  }

  async postSuccessStory(
    agentName: string,
    bookings: number,
    revenue: string
  ): Promise<any> {
    const text = `🎉 BAŞARI HİKAYESİ! 🎉

${agentName} bu ay ${bookings} rezervasyon yaptı!
💰 Gelir: ${revenue}

Reservatior ile başarıya ulaşın! #Agent #Emlak #Rezervatior`;

    return this.postTweet({ text });
  }

  async postTip(tip: string, category: string): Promise<any> {
    const text = `💡 ${category.toUpperCase()} İPUCU

${tip}

#Rezervasyon #PropertyManagement #Reservatior`;

    return this.postTweet({ text });
  }

  async monitorMentions(): Promise<any> {
    try {
      const response = await fetch(
        `${this.baseUrl}/users/me/mentions?expansions=author_id&tweet.fields=created_at`,
        {
          headers: {
            "Authorization": `Bearer ${this.accessToken}`,
          },
        }
      );

      if (response.status === 401) {
        await this.refreshAccessToken();
        return this.monitorMentions();
      }

      return await response.json();
    } catch (error) {
      console.error("Failed to monitor mentions:", error);
      throw error;
    }
  }

  async replyToTweet(tweetId: string, text: string): Promise<any> {
    try {
      const response = await fetch(`${this.baseUrl}/tweets`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${this.accessToken}`,
        },
        body: JSON.stringify({
          text,
          reply: {
            in_reply_to_tweet_id: tweetId,
          },
        }),
      });

      if (response.status === 401) {
        await this.refreshAccessToken();
        return this.replyToTweet(tweetId, text);
      }

      return await response.json();
    } catch (error) {
      console.error("Failed to reply to tweet:", error);
      throw error;
    }
  }
}

export const twitterBot = new TwitterBotService();
