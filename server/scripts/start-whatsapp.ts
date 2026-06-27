import { Client, LocalAuth, Message } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';
import fs from 'fs';
import path from 'path';
import { getRegionFromWhatsApp } from '../src/lib/country-detector';
import { BotController } from '../src/services/bot/bot-controller';
import { parsePropertyDetails } from '../src/lib/property-parser';

const targetGroups = [
    'Konut | Residence',
    'TURUNÇ GAYRİMENKUL PORTFÖY',
    'SURYAP REAL ESTATE',
    'Luxury Villas For Sale',
    'DKY AL-SAT',
    'ERCAN',
    'VADİSTANBUL 2El',
    'Dubai: AL GHURAIR',
    'AL GHURAIR'
];

const groupBuffers = new Map<string, Message[]>();
const groupTimers = new Map<string, NodeJS.Timeout>();

async function processWhatsAppGroupBuffer(groupId: string, groupName: string) {
    const messages = groupBuffers.get(groupId) || [];
    groupBuffers.delete(groupId);
    groupTimers.delete(groupId);

    if (messages.length === 0) return;

    console.log(`\n=================================================`);
    console.log(`🔔 Yeni İlan Bildirimi (WhatsApp): [${groupName}] grubunda ${messages.length} mesajlık küme işleniyor...`);

    // Proje ismini ve detaylarını bul
    let combinedText = messages.map(m => m.body || "").join('\n');
    const details = parsePropertyDetails(combinedText, groupName);

    const projectDir = path.join(process.cwd(), 'data', details.country, details.city, details.district, details.projectName);
    if (!fs.existsSync(projectDir)) {
        fs.mkdirSync(projectDir, { recursive: true });
    }

    // Detayları JSON olarak kaydet
    fs.writeFileSync(path.join(projectDir, 'details.json'), JSON.stringify(details, null, 2), 'utf-8');

    for (const msg of messages) {
        const messageId = msg.id.id; 
        const messageText = msg.body || "";
        const baseFileName = path.join(projectDir, `msg_${messageId}`);

        if (messageText) {
            fs.writeFileSync(`${baseFileName}.txt`, messageText, 'utf-8');
        }

        if (msg.hasMedia) {
            console.log(`⬇️ İndiriliyor (WhatsApp): msg_${messageId}...`);
            try {
                const media = await msg.downloadMedia();
                if (media) {
                    const buffer = Buffer.from(media.data, 'base64');
                    let ext = '.bin';
                    if (media.mimetype.includes('jpeg') || media.mimetype.includes('jpg')) ext = '.jpg';
                    else if (media.mimetype.includes('png')) ext = '.png';
                    else if (media.mimetype.includes('pdf')) ext = '.pdf';
                    else if (media.mimetype.includes('mp4') || media.mimetype.includes('video')) ext = '.mp4';
                    
                    const mediaPath = `${baseFileName}${ext}`;
                    fs.writeFileSync(mediaPath, buffer);
                    console.log(`💾 Kaydedildi: msg_${messageId}${ext}`);
                }
            } catch (e) {
                console.error(`❌ İndirme hatası: msg_${messageId}`, e);
            }
        }
    }
    console.log(`✅ ${details.projectName} işlemi tamamlandı. Bekleniyor...\n`);
}


console.log("🟢 Reservatior WhatsApp AI Botu Başlatılıyor...");
console.log("Lütfen bekleyin, tarayıcı arka planda açılıyor...");

const client = new Client({
    authStrategy: new LocalAuth({ 
        clientId: 'reservatior-whatsapp',
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

client.on('qr', (qr) => {
    console.log('\n======================================================');
    console.log('📱 WhatsApp Business Uygulamanızı Açın');
    console.log('🔗 Sağ üstteki üç nokta (veya Ayarlar) > Bağlı Cihazlar > Cihaz Bağla\'ya tıklayın');
    console.log('📷 Aşağıdaki QR kodu telefonunuzla taratın:');
    console.log('======================================================\n');
    qrcode.generate(qr, { small: true });
});

client.on('ready', () => {
    console.log('\n✅ WhatsApp Business hesabınıza başarıyla bağlanıldı!');
    console.log('🤖 Reservatior WhatsApp (Gemini AI) Asistanı mesajları dinlemeye hazır.');
});

client.on('message', async (message) => {
    // Sadece kullanıcıdan gelen mesajları işle
    if (message.from === 'status@broadcast') return;
    
    // Grup mu yoksa DM mi olduğunu kontrol et
    const chat = await message.getChat();
    if (chat.isGroup) {
        const isTarget = targetGroups.some(t => chat.name.includes(t));
        if (isTarget) {
            const groupId = chat.id._serialized;
            if (!groupBuffers.has(groupId)) {
                groupBuffers.set(groupId, []);
            }
            groupBuffers.get(groupId)!.push(message);

            if (groupTimers.has(groupId)) {
                clearTimeout(groupTimers.get(groupId)!);
            }

            // 30 saniye boyunca mesaj gelmezse buffer'ı işle
            groupTimers.set(groupId, setTimeout(() => {
                processWhatsAppGroupBuffer(groupId, chat.name);
            }, 30000));
        }
        return; // AI botu gruplara otomatik cevap vermesin
    }

    console.log(`\n📩 [WhatsApp] Gelen Mesaj [${message.from}]: ${message.body}`);
    
    try {
        const userId = message.from;
        
        // Numara analizine göre tam bölge tespiti
        const { lang, region } = getRegionFromWhatsApp(message.from);

        // API kredisi olmadığı için Gemini AI botu şimdilik devre dışı bırakıldı.
        // await BotController.processMessage(message.body, 'whatsapp', userId, lang, region);
        
        console.log(`[WhatsApp] ${userId} numaralı kullanıcıdan mesaj alındı, ancak AI bot devre dışı.`);
        // await message.reply("Sistemimizde geçici bir bakım çalışması yapılmaktadır.");
    } catch (error) {
        console.error('WhatsApp Bot Error:', error);
    }
});

client.on('disconnected', (reason) => {
    console.log('❌ WhatsApp bağlantısı koptu:', reason);
});

client.initialize();
