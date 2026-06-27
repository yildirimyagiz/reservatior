import { Client, LocalAuth, MessageMedia } from 'whatsapp-web.js';
import qrcode from 'qrcode';

interface WhatsAppMessage {
  to: string;
  body: string;
  mediaUrl?: string;
}

interface WhatsAppConfig {
  sessionId: string;
  webhookUrl?: string;
}

class WhatsAppService {
  private client: Client | null = null;
  private isConnected: boolean = false;
  private config: WhatsAppConfig;

  constructor(config: WhatsAppConfig = { sessionId: 'reservatior-whatsapp' }) {
    this.config = config;
  }

  async initialize(): Promise<void> {
    if (this.client) {
      console.log('WhatsApp client already initialized');
      return;
    }

    this.client = new Client({
      authStrategy: new LocalAuth({ 
        clientId: this.config.sessionId,
        dataPath: './.wwebjs_auth'
      }),
      puppeteer: {
        headless: true,
        args: [
          '--no-sandbox',
          '--disable-setuid-sandbox',
          '--disable-dev-shm-usage',
          '--disable-accelerated-2d-canvas',
          '--no-first-run',
          '--no-zygote',
          '--single-process',
          '--disable-gpu'
        ]
      }
    });

    this.setupEventListeners();
    
    try {
      await this.client.initialize();
      console.log('WhatsApp service initialized');
    } catch (error) {
      console.error('Failed to initialize WhatsApp service:', error);
      throw error;
    }
  }

  private setupEventListeners(): void {
    if (!this.client) return;

    this.client.on('qr', async (qr) => {
      console.log('WhatsApp QR Code received');
      const qrCodeDataUrl = await qrcode.toDataURL(qr);
      console.log('QR Code Data URL:', qrCodeDataUrl.substring(0, 50) + '...');
      
      // Store QR code for frontend to display
      // This should be stored in Redis or database for retrieval
    });

    this.client.on('ready', () => {
      console.log('WhatsApp client is ready');
      this.isConnected = true;
    });

    this.client.on('authenticated', () => {
      console.log('WhatsApp client authenticated');
    });

    this.client.on('auth_failure', (msg) => {
      console.error('WhatsApp authentication failure:', msg);
      this.isConnected = false;
    });

    this.client.on('disconnected', (reason) => {
      console.log('WhatsApp client disconnected:', reason);
      this.isConnected = false;
    });

    this.client.on('message', async (message) => {
      console.log('Received WhatsApp message:', message.body);
      await this.handleIncomingMessage(message);
    });
  }

  private async handleIncomingMessage(message: any): Promise<void> {
    // Process incoming message
    // This should integrate with the communication system
    const from = message.from;
    const body = message.body;
    const timestamp = new Date();

    console.log(`Message from ${from}: ${body}`);

    // TODO: Integrate with communication system
    // await communicationService.createIncomingMessage({
    //   channel: 'WHATSAPP',
    //   from,
    //   body,
    //   timestamp
    // });
  }

  async sendMessage(message: WhatsAppMessage): Promise<void> {
    if (!this.client || !this.isConnected) {
      throw new Error('WhatsApp client not connected');
    }

    try {
      const chatId = message.to.includes('@c.us') ? message.to : `${message.to}@c.us`;
      
      if (message.mediaUrl) {
        const media = await MessageMedia.fromUrl(message.mediaUrl);
        await this.client.sendMessage(chatId, message.body, { media });
      } else {
        await this.client.sendMessage(chatId, message.body);
      }
      
      console.log(`WhatsApp message sent to ${message.to}`);
    } catch (error) {
      console.error('Failed to send WhatsApp message:', error);
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
      phoneNumber: this.client?.info?.wid?.user
    };
  }

  async getQRCode(): Promise<string> {
    return new Promise((resolve, reject) => {
      if (!this.client) {
        reject(new Error('WhatsApp client not initialized'));
        return;
      }

      const timeout = setTimeout(() => {
        reject(new Error('QR code generation timeout'));
      }, 30000);

      this.client.once('qr', async (qr) => {
        clearTimeout(timeout);
        try {
          const qrCodeDataUrl = await qrcode.toDataURL(qr);
          resolve(qrCodeDataUrl);
        } catch (error) {
          reject(error);
        }
      });
    });
  }

  async disconnect(): Promise<void> {
    if (this.client) {
      await this.client.destroy();
      this.client = null;
      this.isConnected = false;
      console.log('WhatsApp service disconnected');
    }
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
