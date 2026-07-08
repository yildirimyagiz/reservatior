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
    const from = message.from;
    const body = message.body || "";
    const timestamp = new Date();

    console.log(`[WhatsAppService] Message from ${from}: ${body}`);

    if (message.hasMedia) {
      try {
        const media = await message.downloadMedia();
        if (media && media.data) {
          const filename = media.filename || `file_${Date.now()}`;
          const tempDir = './temp_whatsapp';
          
          const fs = require('fs');
          const path = require('path');
          const { execSync } = require('child_process');

          if (!fs.existsSync(tempDir)) {
            fs.mkdirSync(tempDir, { recursive: true });
          }

          const tempFilePath = path.join(tempDir, filename);
          fs.writeFileSync(tempFilePath, Buffer.from(media.data, 'base64'));
          console.log(`[WhatsAppService] Saved temp attachment to: ${tempFilePath}`);

          // Execute python parser script
          const pythonScript = path.resolve(__dirname, '../scripts/process_whatsapp_media.py');
          const cmd = `python3 "${pythonScript}" --file-path "${tempFilePath}" --filename "${filename}" --message-body "${body.replace(/"/g, '\\"')}" --mimetype "${media.mimetype}"`;
          
          console.log(`[WhatsAppService] Running command: ${cmd}`);
          const output = execSync(cmd).toString();
          console.log(`[WhatsAppService] Parser output:`, output);

          // Clean up temp file
          if (fs.existsSync(tempFilePath)) {
            fs.unlinkSync(tempFilePath);
          }
        }
      } catch (err) {
        console.error('[WhatsAppService] Failed to process incoming media:', err);
      }
    } else {
      const bodyLower = body.toLowerCase();
      const hasKeywords = bodyLower.includes('daire') || 
                          bodyLower.includes('villa') || 
                          bodyLower.includes('oda') || 
                          bodyLower.includes('fiyat') || 
                          bodyLower.includes('proje') || 
                          bodyLower.includes('blok') || 
                          bodyLower.includes('özak') ||
                          bodyLower.includes('ozak');
      
      if (hasKeywords) {
        try {
          const path = require('path');
          const { execSync } = require('child_process');

          // Execute python parser script for text-only message
          const pythonScript = path.resolve(__dirname, '../scripts/process_whatsapp_media.py');
          const cmd = `python3 "${pythonScript}" --message-body "${body.replace(/"/g, '\\"')}"`;
          
          console.log(`[WhatsAppService] Running text-only command: ${cmd}`);
          const output = execSync(cmd).toString();
          console.log(`[WhatsAppService] Text-only parser output:`, output);
        } catch (err) {
          console.error('[WhatsAppService] Failed to process incoming text project:', err);
        }
      }
    }
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

  async syncChatProjects(chatNameQuery: string): Promise<{ success: boolean; processed: number; message?: string }> {
    if (!this.client || !this.isConnected) {
      throw new Error('WhatsApp client not connected');
    }

    try {
      const chats = await this.client.getChats();
      const targetChat = chats.find(c => c.name && c.name.toLowerCase().includes(chatNameQuery.toLowerCase()));
      
      if (!targetChat) {
        return { success: false, processed: 0, message: `Chat with name containing "${chatNameQuery}" not found` };
      }

      console.log(`[WhatsAppService] Syncing projects from chat: ${targetChat.name}`);
      const messages = await targetChat.fetchMessages({ limit: 1000 });
      let processed = 0;

      for (const message of messages) {
        const bodyLower = (message.body || '').toLowerCase();
        const hasKeywords = bodyLower.includes('daire') || 
                            bodyLower.includes('villa') || 
                            bodyLower.includes('oda') || 
                            bodyLower.includes('fiyat') || 
                            bodyLower.includes('proje') || 
                            bodyLower.includes('blok') ||
                            bodyLower.includes('özak') ||
                            bodyLower.includes('ozak');
                            
        if (message.hasMedia || hasKeywords) {
          await this.handleIncomingMessage(message);
          processed++;
        }
      }

      return { success: true, processed, message: `Successfully processed ${processed} messages from chat "${targetChat.name}"` };
    } catch (error) {
      console.error('[WhatsAppService] Failed to sync chat projects:', error);
      throw error;
    }
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
