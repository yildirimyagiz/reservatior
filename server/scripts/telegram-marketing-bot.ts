import 'dotenv/config';
import axios from 'axios';
import { BotController } from '../src/services/bot/bot-controller';
import { getRegionFromTelegramLang } from '../src/lib/country-detector';

// PAZARLAMA VE REKLAM BOTU
const botToken = process.env.TELEGRAM_BOT_TOKEN;

if (!botToken || botToken === 'MOCK_TOKEN') {
  console.error('❌ TELEGRAM_BOT_TOKEN is missing in your .env file!');
  process.exit(1);
}

let lastUpdateId = 0;

async function sendTelegramMessage(chatId: number, text: string, replyMarkup?: any, mediaUrl?: string) {
  try {
    if (mediaUrl) {
      await axios.post(`https://api.telegram.org/bot${botToken}/sendPhoto`, {
        chat_id: chatId,
        photo: mediaUrl,
        caption: text,
        parse_mode: 'Markdown',
        reply_markup: replyMarkup
      });
    } else {
      await axios.post(`https://api.telegram.org/bot${botToken}/sendMessage`, {
        chat_id: chatId,
        text: text,
        parse_mode: 'Markdown',
        reply_markup: replyMarkup
      });
    }
  } catch (error) {
    console.error('Marketing Bot Message Error:', (error as Error).message);
  }
}

async function handleMessage(update: any) {
  if (!update.message || !update.message.text) return;

  const chatId = update.message.chat.id;
  const userId = update.message.from.id.toString();
  const rawLangCode = update.message.from.language_code || 'tr';
  let text = update.message.text.trim();
  
  // Telegram dil kodundan tüm veritabanı bölgelerini otomatik tespit et
  const { lang: langCode, region } = getRegionFromTelegramLang(rawLangCode);

  // Grupta etiketlenirse etiketi temizle
  text = text.replace(/@ReservatiorBot/ig, '').trim();

  // Pazarlama botu gruplardaki mesajları yakalayıp ilan üretebilir
  if (text.toLowerCase().includes('satılık') || text.toLowerCase().includes('kiralık')) {
    const aiResponse = await BotController.processMessage(text, 'telegram', userId, langCode, region);
    // Eğer başarılı bir ilan oluşturulduysa gruba veya kişiye cevap dön
    if (aiResponse.text.includes('Taslağınız Oluşturuldu')) {
       await sendTelegramMessage(chatId, aiResponse.text);
    }
    return;
  }

  if (text.startsWith('/start')) {
    await sendTelegramMessage(
      chatId,
      `🌟 *Reservatior Emlak Ağına Hoş Geldiniz!*\n\nEn güncel satılık ve kiralık lüks portföyleri keşfetmek için doğru yerdesiniz. Projeleri görmek için /projects, arama yapmak için /search komutlarını kullanabilirsiniz.`
    );
    return;
  }

  // Arama isteklerini işle
  if (text.startsWith('/search') || text.startsWith('/projects')) {
    const aiResponse = await BotController.processMessage(text, 'telegram', userId, langCode, region);
    await sendTelegramMessage(chatId, aiResponse.text, { inline_keyboard: aiResponse.inline_keyboard }, aiResponse.mediaUrl);
  }
}

async function poll() {
  try {
    const res = await axios.get(`https://api.telegram.org/bot${botToken}/getUpdates`, { params: { offset: lastUpdateId + 1, timeout: 30 } });
    if (res.data.ok) {
      for (const update of res.data.result) {
        lastUpdateId = update.update_id;
        await handleMessage(update);
      }
    }
  } catch (error) {} finally {
    setTimeout(poll, 1000);
  }
}

console.log('📈 Reservatior MARKETING Bot Başlatılıyor...');
poll();
