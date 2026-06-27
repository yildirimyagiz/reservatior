import axios from 'axios';
import { prisma } from '../../lib/prisma';

export class OmniChannelBroadcaster {
  static async broadcastNewListingToTelegram(propertyId: string) {
    const marketingBotToken = process.env.TELEGRAM_BOT_TOKEN;
    if (!marketingBotToken) return;

    // Telegram'da yayın yapılacak grupların ID'leri (Örnek veya veritabanından çekilebilir)
    // Şimdilik demo amaçlı -100... gibi bir kanal ID'si formatı
    const targetGroups = [process.env.TELEGRAM_MARKETING_GROUP_ID].filter(Boolean);

    if (targetGroups.length === 0) {
      console.log('No Telegram marketing groups configured for broadcasting.');
      return;
    }

    try {
      const property = await prisma.property.findUnique({
        where: { id: propertyId }
      });

      if (!property) return;

      const priceStr = property.listingPrice ? `${property.currency} ${property.listingPrice.toLocaleString()}` : 'Fiyat Sorunuz';
      
      const message = `🌟 *YENİ PORTFÖY EKLENDİ!* 🌟\n\n` +
                      `🏢 *${property.name}*\n` +
                      `📍 ${property.city}, ${property.country}\n` +
                      `💰 *${priceStr}*\n` +
                      `🛏️ Oda: ${property.bedrooms || '-'}\n\n` +
                      `🔍 *Detaylar ve Rezervasyon:* https://reservatior.com/listing/${property.id}\n\n` +
                      `Bu portföy için detaylı bilgi almak veya randevu talep etmek için @ReservatiorBot üzerinden bana ulaşabilirsiniz!`;

      for (const groupId of targetGroups) {
        await axios.post(`https://api.telegram.org/bot${marketingBotToken}/sendMessage`, {
          chat_id: groupId,
          text: message,
          parse_mode: 'Markdown'
        });
      }
      
      console.log(`📣 Yeni ilan ${property.id} Telegram gruplarına duyuruldu!`);
    } catch (error) {
      console.error('Broadcasting error:', error);
    }
  }

  static async broadcastNewListingToWhatsAppStatus(propertyId: string) {
    // Note: WhatsApp Cloud API requires specific templates or manual status updates for Businesses.
    // However, sending a message with a link automatically generates a link preview (using the SEO meta tags).
    try {
      const property = await prisma.property.findUnique({
        where: { id: propertyId }
      });
      if (!property) return;

      const link = `https://reservatior.com/listing/${property.id}`;
      console.log(`📣 (MOCK) Yeni ilan WhatsApp Durumlarına / Kataloglarına aktarıldı. Link: ${link}`);
      console.log(`ℹ️ WhatsApp bu linki otomatik okuyup sitemizdeki Meta Title ve Meta Description (SEO Engine) verisini çekecektir.`);
      
    } catch (error) {
      console.error('WA Status Broadcasting error:', error);
    }
  }
}
