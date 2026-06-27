import { Client, LocalAuth, MessageMedia } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';

const TIMEOUT_MS = 120_000;
const OZAK_KEYWORDS = ['ozak', 'özak', 'gyo', 'acente'];

let resolved = false;

const client = new Client({
    authStrategy: new LocalAuth({ clientId: "ozak-gyo-reader" }),
    puppeteer: {
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-gpu'],
        executablePath: '/root/.cache/puppeteer/chrome/linux-149.0.7827.22/chrome-linux64/chrome',
    }
});

client.on('qr', (qr) => {
    console.log("\n=== WHATSAPP QR KODU ===\n");
    qrcode.generate(qr, { small: false });
    console.log("\nTelefonundan WhatsApp > Bağlı Cihazlar > Cihaz Bağla ile okut.\n");
});

client.on('ready', async () => {
    if (resolved) return;
    resolved = true;
    console.log("✅ WhatsApp bağlandı, mesajlar okunuyor...\n");

    const chats = await client.getChats();
    const ozakChats = chats.filter(c => {
        const name = (c.name || '').toLowerCase();
        return OZAK_KEYWORDS.some(k => name.includes(k));
    });

    console.log(`🔍 Özak GYO ile ilgili ${ozakChats.length} sohbet bulundu.\n`);

    for (const chat of ozakChats) {
        console.log(`\n═══════════════════════════════════`);
        console.log(`📌 ${chat.name} (${chat.isGroup ? 'Grup' : 'Bireysel'})`);
        console.log(`═══════════════════════════════════\n`);

        const messages = await chat.fetchMessages({ limit: 50 });
        for (const msg of messages.reverse()) {
            const contact = await msg.getContact();
            const sender = contact.pushname || contact.name || msg.from;
            const time = new Date(msg.timestamp * 1000).toLocaleString('tr-TR');

            if (msg.hasMedia) {
                const media = await msg.downloadMedia();
                console.log(`[${time}] ${sender} (${msg.type}):`);
                console.log(`   📎 Medya: ${media.filename || 'dosya'} (${media.mimetype})`);
                if (msg.caption) console.log(`   📝 Altyazı: ${msg.caption}`);
            } else {
                console.log(`[${time}] ${sender}: ${msg.body}`);
            }
        }
    }

    console.log("\n✅ Mesajlar okundu, çıkılıyor...");
    await client.destroy();
    process.exit(0);
});

client.on('auth_failure', (msg) => {
    console.error("❌ Auth hatası:", msg);
    process.exit(1);
});

client.on('disconnected', (reason) => {
    if (!resolved) {
        console.log("⚠️ Bağlantı koptu:", reason);
    }
});

console.log("🔄 WhatsApp başlatılıyor...");
client.initialize();

setTimeout(() => {
    if (!resolved) {
        console.log("\n⏰ Zaman aşımı! QR okutulmadı veya bağlantı kurulamadı.");
        process.exit(1);
    }
}, TIMEOUT_MS);
