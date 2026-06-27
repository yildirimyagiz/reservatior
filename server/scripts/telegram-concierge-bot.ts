import 'dotenv/config';
import axios from 'axios';
import { BotController } from '../src/services/bot/bot-controller';
import { getRegionFromTelegramLang } from '../src/lib/country-detector';
import { ChatRelay } from '../src/services/bot/chat-relay';

// VIP CONCIERGE BOTU
const botToken = process.env.TELEGRAM_CONCIERGE_TOKEN;

if (!botToken) {
  console.error('❌ TELEGRAM_CONCIERGE_TOKEN is missing in your .env file! Lütfen BotFather\'dan yeni token alıp ekleyin.');
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
    console.error('Concierge Bot Message Error:', (error as Error).message);
  }
}

async function handleMessage(update: any) {
  if (update.callback_query) {
    const callbackData = update.callback_query.data;
    const chatId = update.callback_query.message.chat.id;
    const userId = update.callback_query.from.id.toString();

    let responseText = "";
    if (callbackData.startsWith('escrow_')) {
      const response = await BotController.processMessage(`/pay ${callbackData.replace('escrow_', '')}`, 'telegram', userId);
      responseText = response.text;
    } else if (callbackData.startsWith('meet_')) {
      const response = await BotController.processMessage(`/book ${callbackData.replace('meet_', '')}`, 'telegram', userId);
      responseText = response.text;
    }

    if (responseText) await sendTelegramMessage(chatId, responseText);
    try { await axios.post(`https://api.telegram.org/bot${botToken}/answerCallbackQuery`, { callback_query_id: update.callback_query.id }); } catch(e) {}
    return;
  }

  if (!update.message || !update.message.text) return;

  const chatId = update.message.chat.id;
  const userId = update.message.from.id.toString();
  const rawLangCode = update.message.from.language_code || 'tr';
  let text = update.message.text.trim();
  
  // Telegram dil kodundan tüm veritabanı bölgelerini otomatik tespit et
  const { lang: langCode, region } = getRegionFromTelegramLang(rawLangCode);

  // Grupta veya sohbette etiketlenirse etiketi temizle
  text = text.replace(/@ReservatiorConciergeBot/ig, '').trim();

  if (text.startsWith('/start')) {
    await sendTelegramMessage(
      chatId,
      `🛎️ *Reservatior VIP Concierge Hizmetine Hoş Geldiniz*\n\nSistemde devam eden işlemleriniz, toplantı planlamalarınız ve güvenli Escrow ödemeleriniz için buradayım. Size nasıl yardımcı olabilirim? (Örn: Toplantı ayarla, Escrow başlat)`
    );
    return;
  }

  // Eğer kullanıcı Bot'un attığı bir mesaja yanıt (Reply) veriyorsa, bu bir Proxy Sohbet mesajıdır
  if (update.message.reply_to_message) {
      // Aktif proxy oturumunu bul (Bu örnekte Seller->Buyer veya tam tersi)
      // Normalde mesaj içinde gizli bir Session ID veya kullanıcının son aktif session'ı alınır.
      // Basitlik adına son aktif session'ı veritabanından bulabiliriz, ancak ChatRelay.relayMessageFromSeller istiyor.
      // Burada BotController'a yönlendiriyoruz ki, ChatRelay ile çözsün
      const replyResult = await ChatRelay.relayMessageFromSeller("active_session_mock", text, region);
      await sendTelegramMessage(chatId, `✅ Yanıtınız iletildi.`);
      return;
  }

  // VIP Komutlar
  try {
    const aiResponse = await BotController.processMessage(text, 'telegram', userId, langCode, region);
    await sendTelegramMessage(chatId, aiResponse.text, { inline_keyboard: aiResponse.inline_keyboard }, aiResponse.mediaUrl);
  } catch (err) {
    await sendTelegramMessage(chatId, "İsteğinizi şu an işleyemiyorum.");
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

console.log('🛎️ Reservatior VIP CONCIERGE Bot Başlatılıyor...');
poll();
