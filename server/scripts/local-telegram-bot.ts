import 'dotenv/config';
import axios from 'axios';
import { BotController } from '../src/services/bot/bot-controller';

const botToken = process.env.TELEGRAM_BOT_TOKEN;

if (!botToken || botToken === 'MOCK_TOKEN') {
  console.error('❌ TELEGRAM_BOT_TOKEN is missing in your .env file!');
  process.exit(1);
}

let lastUpdateId = 0;

async function sendTelegramMessage(chatId: number, text: string, replyMarkup?: any) {
  try {
    await axios.post(`https://api.telegram.org/bot${botToken}/sendMessage`, {
      chat_id: chatId,
      text: text,
      parse_mode: 'Markdown',
      reply_markup: replyMarkup
    });
  } catch (error) {
    const errorData = axios.isAxiosError(error) ? error.response?.data : null;
    console.error('Failed to send message:', errorData || (error as Error).message);
  }
}

async function handleMessage(update: any) {
  // --- 💡 DÜĞMELERE TIKLANINCA ÇALIŞAN CALLBACK'LER ---
  if (update.callback_query) {
    const callbackData = update.callback_query.data;
    const chatId = update.callback_query.message.chat.id;
    const userId = update.callback_query.from.id.toString();

    let responseText = "";

    if (callbackData.startsWith('escrow_')) {
      const propertyId = callbackData.replace('escrow_', '');
      const response = await BotController.processMessage(`/pay ${propertyId}`, 'telegram', userId);
      responseText = response.text;
    } else if (callbackData.startsWith('meet_')) {
      const propertyId = callbackData.replace('meet_', '');
      const response = await BotController.processMessage(`/book ${propertyId}`, 'telegram', userId);
      responseText = response.text;
    }

    if (responseText) {
      await sendTelegramMessage(chatId, responseText);
    }
    
    // Yükleniyor ibaresini kaldır
    try {
      await axios.post(`https://api.telegram.org/bot${botToken}/answerCallbackQuery`, {
        callback_query_id: update.callback_query.id
      });
    } catch(e) {}
    
    return;
  }

  // --- 📩 NORMAL MESAJLARI İŞLEME ---
  if (!update.message || !update.message.text) return;

  const chatId = update.message.chat.id;
  const userId = update.message.from.id.toString();
  const langCode = update.message.from.language_code || 'tr';
  let text = update.message.text.trim();
  text = text.replace(/@ReservatiorBot/ig, '');

  console.log(`📩 [Telegram] [Chat: ${chatId}] Gelen: ${text}`);

  if (text.startsWith('/start') || text.startsWith('/help')) {
    await sendTelegramMessage(
      chatId,
      `🏨 *Reservatior Omnichannel AI Bot'a Hoş Geldiniz!*\n\n` +
      `Ben gelişmiş bir yapay zeka asistanıyım. Dünyanın her yerinden gayrimenkul projelerini saniyeler içinde sizin için bulabilir, görüşme ayarlayabilir ve TrustLink altyapısı ile kripto veya IBAN üzerinden güvenle ödeme yapmanızı sağlayabilirim.\n\n` +
      `*🌟 GAYRİMENKUL ARAMA:*\n` +
      `🔍 \`/search [şehir]\` - Kriterlerinize uygun emlak bulun (Örn: /search Dubai 3 oda)\n` +
      `🏢 \`/projects\` - Yeni portföylere ve projelere göz atın\n\n` +
      `*🛡️ FİNANS VE GÜVENLİK:*\n` +
      `💼 \`/escrow\` - TrustLink Sıfır-Risk Ödeme/Emanet sistemi hakkında bilgi\n\n` +
      `*🛎️ VIP DANIŞMANLIK:*\n` +
      `🚁 \`/concierge\` - Helikopter turu, Özel Jet transferi talepleri\n` +
      `📅 \`/book\` - Satış danışmanlarıyla toplantı planlama\n\n` +
      `Ayrıca bana serbestçe yazabilirsiniz (Örn: "Bodrum'da deniz manzaralı ev satıyorum, fiyatı 2M Euro").`
    );
    return;
  }

  if (text.startsWith('/escrow')) {
    await sendTelegramMessage(
      chatId,
      `🛡️ *TrustLink Sovereign Escrow*\n\n` +
      `Emlak alım-satım süreçlerinde paranızı banka seviyesinde güvenle koruyan 0-Risk sistemimizdir.\n\n` +
      `Süreç: Siz parayı TrustLink emanet hesabına atarsınız, tapu/kontrat güvenli şekilde devredilene kadar para satıcıya geçmez. Hem kripto hem IBAN destekliyoruz.`,
      { inline_keyboard: [[{ text: '🌐 Daha Fazla Bilgi', url: 'https://trustlink.global/escrow' }]] }
    );
    return;
  }

  if (text.startsWith('/concierge')) {
    await sendTelegramMessage(
      chatId,
      `🛎️ *VIP Concierge Services*\n\nÖzel müşteri temsilcinizden hangi hizmeti talep etmek istersiniz?`,
      { inline_keyboard: [
          [{ text: '✈️ Özel Jet Kiralama', url: 'https://reservatior.com/jet' }],
          [{ text: '🚁 Helikopter İle Emlak Turu', url: 'https://reservatior.com/heli' }]
        ]}
    );
    return;
  }

  // Geri kalan tüm komutları (Search, doğal dil vs.) BotController & AI'a yönlendiriyoruz!
  try {
    const aiResponse = await BotController.processMessage(text, 'telegram', userId, langCode);
    
    let replyMarkup = undefined;
    if (aiResponse.inline_keyboard) {
      replyMarkup = { inline_keyboard: aiResponse.inline_keyboard };
    }

    await sendTelegramMessage(chatId, aiResponse.text, replyMarkup);
  } catch (err) {
    console.error('AI Processing Error:', err);
    await sendTelegramMessage(chatId, "❌ İsteğinizi şu an işleyemedim. Lütfen tekrar deneyin.");
  }
}

async function poll() {
  try {
    const res = await axios.get(`https://api.telegram.org/bot${botToken}/getUpdates`, {
      params: { offset: lastUpdateId + 1, timeout: 30 }
    });

    if (res.data.ok) {
      for (const update of res.data.result) {
        lastUpdateId = update.update_id;
        await handleMessage(update);
      }
    }
  } catch (error) {
    const errorData = axios.isAxiosError(error) ? error.response?.data : null;
    if (errorData?.error_code === 409) {
      console.error('⚠️ Çakışma: Webhook aktif! Long-polling için Webhook silinmeli.');
    } else {
      console.error('Polling error:', (error as Error).message);
    }
  } finally {
    setTimeout(poll, 1000);
  }
}

console.log('🤖 Reservatior Omnichannel Telegram Bot Başlatılıyor...');
poll();
