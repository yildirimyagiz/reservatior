import 'dotenv/config';
import axios from 'axios';
import { prisma } from '../src/lib/prisma';
import { GoogleGenerativeAI } from '@google/generative-ai';

// --- TYPES & INTERFACES ---
interface TelegramUpdate {
  update_id: number;
  message?: {
    chat: { id: number };
    text?: string;
  };
  callback_query?: {
    id: string;
    data: string;
    message: { chat: { id: number } };
  };
}

interface InlineKeyboardButton {
  text: string;
  url?: string;
  callback_data?: string;
}

interface ReplyMarkup {
  inline_keyboard: InlineKeyboardButton[][];
}


const botToken = process.env.TELEGRAM_BOT_TOKEN;

if (!botToken || botToken === 'MOCK_TOKEN') {
  console.error('❌ TELEGRAM_BOT_TOKEN is missing in your .env file!');
  process.exit(1);
}

let lastUpdateId = 0;

async function sendTelegramMessage(chatId: number, text: string, replyMarkup?: ReplyMarkup) {
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

async function handleMessage(update: TelegramUpdate) {
  // --- 💡 HANDLE INLINE BUTTON CLICKS (CALLBACK QUERIES) ---
  if (update.callback_query) {
    const callbackData = update.callback_query.data;
    const chatId = update.callback_query.message.chat.id;

    if (callbackData.startsWith('escrow_')) {
      const propertyId = callbackData.replace('escrow_', '');
      
      // Simulate TrustLink Native Escrow Creation
      const mockEscrowId = `ESC-${Math.floor(100000 + Math.random() * 900000)}`;
      
      // We edit the original message to show the Escrow details instead of buttons
      const escrowMessage = `🛡️ *TRUSTLINK SOVEREIGN ESCROW INITIATED*\n\n` +
                            `Property ID: \`${propertyId}\`\n` +
                            `Escrow ID: \`${mockEscrowId}\`\n` +
                            `Status: 🟡 AWAITING DEPOSIT\n\n` +
                            `Please deposit the reservation fee to your unique TrustLink Vault:\n\n` +
                            `🏛️ *Bank Wire (Virtual IBAN):*\n` +
                            `Bank: QNB Finansbank / YKB\n` +
                            `IBAN: \`TR88 0001 1000 0000 0000 0000 01\`\n` +
                            `Ref: \`${mockEscrowId}\`\n\n` +
                            `💎 *Crypto (USDT / USDC - TRC20):*\n` +
                            `Address: \`TThisIsAMockTrustLinkWalletAddress99\`\n\n` +
                            `_Once funds are received, the property will be locked and status will change to HOLDING._`;

      await sendTelegramMessage(chatId, escrowMessage);
      
      // Optionally answer the callback query to remove loading state
      try {
        await axios.post(`https://api.telegram.org/bot${botToken}/answerCallbackQuery`, {
          callback_query_id: update.callback_query.id,
          text: 'Escrow Initiated Successfully!',
          show_alert: false
        });
      } catch(e) {
        console.debug('Failed to answer callback query:', (e as Error).message);
      }
    }
    return;
  }

  if (!update.message || !update.message.text) return;

  const chatId = update.message.chat.id;
  let text = update.message.text.trim();

  // Handle group tags (e.g. /search@ReservatiorBot)
  text = text.replace(/@ReservatiorBot/ig, '');

  console.log(`📩 [Chat: ${chatId}] Received: ${text}`);

  if (text.startsWith('/start') || text.startsWith('/help')) {
    await sendTelegramMessage(
      chatId,
      `🏨 *Welcome to TrustLink / Reservatior Bot!*\n\n` +
      `I am your personal AI concierge for luxury real estate, secure escrow, and global investments.\n\n` +
      `*🌟 GLOBAL REAL ESTATE:*\n` +
      `🔍 \`/search [city]\` - Discover premium properties (e.g., /search Dubai)\n` +
      `🏠 \`/property [id]\` - View extensive details for a specific listing\n` +
      `📈 \`/invest\` - Show off-market & high-yield opportunities\n\n` +
      `*🛡️ FINANCIAL & ESCROW:*\n` +
      `💼 \`/escrow\` - How TrustLink 0-Risk Settlement works\n` +
      `📊 \`/valuation [city]\` - Get AI-driven market valuation\n\n` +
      `*🛎️ VIP CONCIERGE:*\n` +
      `🚁 \`/concierge\` - Book private jet, helicopter viewings, or luxury transfers\n` +
      `📞 \`/contact\` - Speak to a human wealth advisor`
    );
  } 
  else if (text.startsWith('/escrow')) {
    await sendTelegramMessage(
      chatId,
      `🛡️ *TrustLink Sovereign Escrow*\n\n` +
      `TrustLink offers a bank-grade, zero-risk settlement layer for international real estate.\n\n` +
      `✅ *1. Hold:* Funds are held securely in QNB/YKB escrow.\n` +
      `✅ *2. Verify:* Legal transfer is completed via Tapu/Land Registry.\n` +
      `✅ *3. Release:* Funds are released instantly to the seller.\n\n` +
      `You can purchase any property directly through Telegram with 1-Click via TrustLink!`,
      { inline_keyboard: [[{ text: '🌐 Learn More', url: 'https://trustlink.global/escrow' }]] }
    );
  }
  else if (text.startsWith('/concierge')) {
    await sendTelegramMessage(
      chatId,
      `🛎️ *VIP Concierge Services*\n\n` +
      `How can we elevate your property viewing experience today?`,
      {
        inline_keyboard: [
          [{ text: '✈️ Private Jet Charter', url: 'https://reservatior.com/jet' }],
          [{ text: '🚁 Helicopter Property Tour', url: 'https://reservatior.com/heli' }],
          [{ text: '🚘 VIP Airport Transfer', url: 'https://reservatior.com/transfer' }],
        ]
      }
    );
  }
  else if (text.startsWith('/valuation')) {
    const query = text.replace('/valuation', '').trim();
    if (!query) {
      await sendTelegramMessage(chatId, 'Please specify a location! Example: `/valuation Miami`');
      return;
    }
    await sendTelegramMessage(
      chatId,
      `🤖 *SpaceAI Market Valuation: ${query}*\n\n` +
      `Analyzing billions of data points...\n` +
      `📈 *Market Trend:* +14.2% YoY\n` +
      `💰 *Avg Price/Sqm:* $12,450\n` +
      `⚖️ *Rental Yield:* 6.8%\n\n` +
      `_Status: High Demand. Recommended for Sovereign Capital Injection._`
    );
  }
  else if (text.startsWith('/invest')) {
    await sendTelegramMessage(chatId, `📈 *Curating Top Off-Market Deals...*`);
    const properties = await prisma.property.findMany({ take: 2, orderBy: { listingPrice: 'desc' } });
    if (properties.length === 0) {
      await sendTelegramMessage(chatId, `No high-yield properties available right now.`);
      return;
    }
    for (const prop of properties) {
      const priceStr = (prop.listingPrice && Number(prop.listingPrice) > 0) ? `${prop.propertyCurrency} ${prop.listingPrice.toLocaleString()}` : 'Price on Request';
      const msg = `🔥 *HIGH-YIELD OPPORTUNITY*\n` +
                  `🏙️ *${prop.name}*\n` +
                  `📍 ${prop.city}, ${prop.country}\n` +
                  `💰 *${priceStr}*\n` +
                  `ID: \`${prop.id}\``;
      await sendTelegramMessage(chatId, msg, {
        inline_keyboard: [[{ text: '🛡️ Initiate TrustLink Escrow', callback_data: `escrow_${prop.id}` }]]
      });
    }
  }
  else if (text.startsWith('/property')) {
    const queryId = text.replace('/property', '').trim();
    if (!queryId) {
      await sendTelegramMessage(chatId, 'Please specify a property ID! Example: `/property harvest-US-12345`');
      return;
    }
    const prop = await prisma.property.findUnique({ where: { id: queryId } });
    if (!prop) {
      await sendTelegramMessage(chatId, `❌ Property not found: ${queryId}`);
      return;
    }

    const notesStr = prop.notes || '{}';
    let parsedNotes: Record<string, any> = {};
    try { parsedNotes = JSON.parse(notesStr); } catch (e) {
      console.debug('Failed to parse property notes:', (e as Error).message);
    }
    const priceStr = (prop.listingPrice && Number(prop.listingPrice) > 0) ? `${prop.propertyCurrency} ${prop.listingPrice.toLocaleString()}` : 'Price on Request';
    const agentPhone = parsedNotes.agentPhone || '';
    
    let keyboard: any[] = [];
    if (agentPhone) {
      const cleanPhone = agentPhone.replace(/\D/g, '');
      keyboard.push([{ text: '🟢 WhatsApp Agent', url: `https://wa.me/${cleanPhone}?text=Hello, I am interested in property ${prop.id}` }]);
    }
    keyboard.push([{ text: '🛡️ Initiate TrustLink Escrow', callback_data: `escrow_${prop.id}` }]);

    const msg = `🏠 *PROPERTY DETAILS*\n\n` +
                `🏙️ *${prop.name}*\n` +
                `📍 ${prop.addressLine1 || prop.city}, ${prop.country}\n` +
                `💰 *${priceStr}*\n` +
                `🛏️ Beds: ${prop.bedrooms || 'N/A'} | 🛁 Baths: ${prop.bathrooms || 'N/A'} | 📏 ${prop.areaSqm || 'N/A'} sqm\n\n` +
                `📝 ${parsedNotes.description ? parsedNotes.description.substring(0, 300) + '...' : 'Premium asset.'}\n\n` +
                `ID: \`${prop.id}\``;
    await sendTelegramMessage(chatId, msg, { inline_keyboard: keyboard });
  }
  else if (text.startsWith('/search')) {
    const query = text.replace('/search', '').trim().toLowerCase();
    if (!query) {
      await sendTelegramMessage(chatId, 'Please specify what you are looking for! Example: `/search Miami 4 beds under 5000000`');
      return;
    }

    await sendTelegramMessage(chatId, `🔍 Analyzing your request: *${query}*...`);

    // --- 🧠 SMART AI-LIKE PARSER ---
    let cityQuery = query;
    let minBeds = 0;
    let maxPrice = 999999999;
    
    // Extract beds (e.g., "3 beds", "4 bedroom")
    const bedMatch = query.match(/(\d+)\s*(bed|bedroom|bd)/i);
    if (bedMatch) {
      minBeds = parseInt(bedMatch[1]);
      cityQuery = cityQuery.replace(bedMatch[0], '');
    }

    // Extract max price (e.g., "under 5m", "< 2000000")
    const priceMatch = query.match(/(under|<|max)\s*(\d+)(m|k)?/i);
    if (priceMatch) {
      let val = parseInt(priceMatch[2]);
      if (priceMatch[3] === 'm') val *= 1000000;
      if (priceMatch[3] === 'k') val *= 1000;
      maxPrice = val;
      cityQuery = cityQuery.replace(priceMatch[0], '');
    }

    // Clean up city string (taking the first main word as city)
    cityQuery = cityQuery.trim().split(' ')[0] || '';

    // --- 🗄️ DATABASE QUERY ---
    const properties = await prisma.property.findMany({
      where: { 
        ...(cityQuery ? { city: { contains: cityQuery, mode: 'insensitive' } } : {}),
        ...(minBeds > 0 ? { bedrooms: { gte: minBeds } } : {}),
        listingPrice: { lte: maxPrice }
      },
      take: 3,
      orderBy: { listingPrice: 'desc' }
    });

    if (properties.length === 0) {
      await sendTelegramMessage(chatId, `❌ No exact matches found for your specific criteria. Try broadening your search.`);
      return;
    }

    await sendTelegramMessage(chatId, `🎯 Found ${properties.length} premium properties matching your criteria!`);

    for (const prop of properties) {
      const notesStr = prop.notes || '{}';
      let parsedNotes: Record<string, any> = {};
      try { parsedNotes = JSON.parse(notesStr); } catch (e) {
        console.debug('Failed to parse search result notes:', (e as Error).message);
      }

      const priceStr = (prop.listingPrice && Number(prop.listingPrice) > 0) ? `${prop.propertyCurrency} ${prop.listingPrice.toLocaleString()}` : 'Price on Request';
      const agentPhone = parsedNotes.agentPhone || '';
      
      const keyboard: InlineKeyboardButton[][] = [];
      if (agentPhone) {
        const cleanPhone = agentPhone.replace(/\D/g, '');
        keyboard.push([{ text: '🟢 Contact via WhatsApp', url: `https://wa.me/${cleanPhone}?text=Hello, I am interested in property ${prop.id}` }]);
      }
      keyboard.push([{ text: '💳 Buy / Reserve via TrustLink', url: `https://app.trustlink.global/checkout/${prop.id}` }]);

      const msg = `🏙️ *${prop.name}*\n` +
                  `📍 ${prop.city}, ${prop.country}\n` +
                  `💰 *${priceStr}*\n` +
                  `🛏️ Beds: ${prop.bedrooms || 0} | 🛁 Baths: ${prop.bathrooms || 0}\n\n` +
                  `ID: \`${prop.id}\``;

      await sendTelegramMessage(chatId, msg, { inline_keyboard: keyboard });
    }
  }
  else {
    // --- 🤖 GEMINI AI FALLBACK ---
    try {
      const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
      const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
      
      const prompt = `You are a highly professional luxury real estate and concierge AI named "Reservatior AI". 
      Your company is TrustLink Escrow. You sell premium properties. You are currently chatting with a VIP user on Telegram.
      They just sent a message that is not a standard command. Answer their question or request in an elite, concise manner in their own language.
      Mention that they can type /help to see available property search commands or use TrustLink Escrow for safe payments.
      
      User Message: "${text}"`;

      const result = await model.generateContent(prompt);
      const aiResponse = result.response.text();
      
      await sendTelegramMessage(chatId, aiResponse);
    } catch (e) {
      console.error('Gemini AI Fallback Error:', (e as Error).message);
      await sendTelegramMessage(chatId, 'I did not understand that command. Type /help to see available commands.');
    }
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
      console.error('⚠️ Conflict: Webhook is active! You must delete the webhook to use long-polling.');
      console.error(`Run this URL in your browser to delete the webhook: https://api.telegram.org/bot${botToken}/deleteWebhook`);
    } else {
      console.error('Polling error:', (error as Error).message);
    }
  } finally {
    setTimeout(poll, 1000); // Loop again
  }
}

console.log('🤖 Reservatior Telegram Bot is starting locally...');
poll();
