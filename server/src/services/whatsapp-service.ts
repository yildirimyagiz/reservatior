import fetch from 'node-fetch';

interface WhatsAppMessage {
  to: string;
  body: string;
  mediaUrl?: string;
  mediaType?: 'image' | 'video' | 'document';
}

interface WhatsAppConfig {
  phoneNumberId: string;
  accessToken: string;
  webhookVerifyToken: string;
}

class WhatsAppService {
  private isConnected: boolean = false;
  private config: WhatsAppConfig;
  private readonly apiUrl: string;

  constructor(config: WhatsAppConfig = { 
    phoneNumberId: process.env.WHATSAPP_PHONE_NUMBER_ID || 'dummy_id',
    accessToken: process.env.WHATSAPP_ACCESS_TOKEN || 'dummy_token',
    webhookVerifyToken: process.env.WHATSAPP_WEBHOOK_VERIFY_TOKEN || 'reservatior_secure'
  }) {
    this.config = config;
    // Meta Cloud API v17.0
    this.apiUrl = `https://graph.facebook.com/v17.0/${this.config.phoneNumberId}/messages`;
  }

  async initialize(): Promise<void> {
    console.log('Initializing WhatsApp Cloud API Service...');
    
    // In Cloud API, initialization just means we have valid config.
    if (!this.config.phoneNumberId || !this.config.accessToken) {
      console.warn('⚠️ WhatsApp Cloud API credentials missing. Service will run in mock mode.');
      this.isConnected = false;
    } else {
      this.isConnected = true;
      console.log('✅ WhatsApp Cloud API Service ready.');
    }
  }

  /**
   * Handle incoming Webhook payload from Meta
   */
  async handleIncomingWebhook(payload: any): Promise<void> {
    console.log('[WhatsAppService] Received webhook payload');
    
    if (payload.object !== 'whatsapp_business_account') return;

    for (const entry of payload.entry) {
      const changes = entry.changes;
      for (const change of changes) {
        if (change.value && change.value.messages) {
          const messages = change.value.messages;
          for (const message of messages) {
            await this.processMessage(message, change.value.contacts?.[0]);
          }
        }
      }
    }
  }

  private async processMessage(message: any, contact: any): Promise<void> {
    const from = message.from;
    const body = message.text?.body || "";
    console.log(`[WhatsAppService] Message from ${from}: ${body}`);
    
    // Handle Ad Management Intent Routing
    const bodyLower = body.toLowerCase();
    if (bodyLower.includes('bütçe') || bodyLower.includes('reklam') || bodyLower.includes('boost') || bodyLower.includes('budget') || bodyLower.includes('ad')) {
      console.log(`[WhatsAppService] 🎯 Routing to Social Ads Manager for Intent: Ad Management`);
      // In production, we would inject or call the AdManager orchestrator here
      await this.sendMessage({
        to: from,
        body: `🤖 Reservatior AI Ad Manager:\nReklam yönetimi talebinizi aldım. Mevcut bakiyeniz kontrol ediliyor...`
      });
      return;
    }

    // Process Property related commands (Legacy parsing hook)
    const hasKeywords = bodyLower.includes('daire') || 
                        bodyLower.includes('villa') || 
                        bodyLower.includes('oda') || 
                        bodyLower.includes('fiyat') || 
                        bodyLower.includes('proje');

    if (message.type === 'image' || message.type === 'video') {
      console.log(`[WhatsAppService] 📥 Received Media Attachment (ID: ${message[message.type].id})`);
      // Here we would download the media using the Meta Graph API media endpoint
    } else if (hasKeywords) {
      console.log(`[WhatsAppService] 🔍 Found property keywords. Triggering AI Analysis.`);
    }
  }

  async sendMessage(message: WhatsAppMessage): Promise<void> {
    if (!this.isConnected) {
      console.log(`[MOCK WhatsApp] Sending to ${message.to}: ${message.body}`);
      return;
    }

    try {
      const payload: any = {
        messaging_product: "whatsapp",
        recipient_type: "individual",
        to: message.to.replace(/[^0-9]/g, ''),
      };

      if (message.mediaUrl) {
        payload.type = message.mediaType || "image";
        payload[payload.type] = { link: message.mediaUrl };
        if (message.body) {
           payload[payload.type].caption = message.body;
        }
      } else {
        payload.type = "text";
        payload.text = { preview_url: true, body: message.body };
      }

      const response = await fetch(this.apiUrl, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${this.config.accessToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload)
      });

      const result = await response.json();
      if (!response.ok) {
        throw new Error(`WhatsApp API Error: ${JSON.stringify(result)}`);
      }
      
      console.log(`✅ WhatsApp message sent to ${message.to}`);
    } catch (error) {
      console.error('❌ Failed to send WhatsApp message:', error);
      throw error;
    }
  }

  async sendBulkMessages(messages: WhatsAppMessage[]): Promise<void> {
    const results = await Promise.allSettled(
      messages.map(msg => this.sendMessage(msg))
    );

    const failed = results.filter(r => r.status === 'rejected');
    if (failed.length > 0) {
      console.error(`${failed.length} messages failed to send`);
      throw new Error(`${failed.length} messages failed`);
    }
  }

  async getStatus(): Promise<{ connected: boolean; phoneNumber?: string }> {
    return {
      connected: this.isConnected,
      phoneNumber: this.config.phoneNumberId
    };
  }

  verifyWebhook(mode: string, token: string, challenge: string): string | null {
    if (mode === 'subscribe' && token === this.config.webhookVerifyToken) {
      console.log('WEBHOOK_VERIFIED');
      return challenge;
    }
    return null;
  }

  async disconnect(): Promise<void> {
    this.isConnected = false;
    console.log('WhatsApp service disconnected');
  }
}

// Singleton instance
let whatsappService: WhatsAppService | null = null;

export function getWhatsAppService(config?: WhatsAppConfig): WhatsAppService {
  if (!whatsappService) {
    whatsappService = new WhatsAppService(config);
  }
  return whatsappService;
}

export default WhatsAppService;
