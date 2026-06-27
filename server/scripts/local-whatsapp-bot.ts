import { Client, LocalAuth } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';

console.log("🟢 Local WhatsApp Bot Başlatılıyor...");

// Session bilgilerini kaydetmek için LocalAuth
const client = new Client({
    authStrategy: new LocalAuth({ clientId: "fairride-reservatior-local" }),
    puppeteer: {
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    }
});

// Soru-cevap durumlarını hafızada tutalım
const userStates: Record<string, { step: number; pickup?: string; dropoff?: string; vehicleType?: string }> = {};

// Sürücülerin olduğu WhatsApp grubu adı (Senin telefonda kuracağın grubun adı tam olarak bu olmalı)
const DRIVER_GROUP_NAME = "FairRide Transfer Havuzu";

client.on('qr', (qr) => {
    console.log("📱 DİKKAT: Telefonunuzdan WhatsApp uygulamasını açın.");
    console.log("📱 Ayarlar -> Bağlı Cihazlar -> Cihaz Bağla diyerek aşağıdaki kodu okutun:\n");
    qrcode.generate(qr, { small: true });
});

client.on('ready', () => {
    console.log('✅ HARİKA! WhatsApp Başarıyla Bağlandı.');
    console.log(`🤖 Artık bu telefon numarası bir bot gibi çalışacak.`);
});

// Sürücü grubuna iş paslama fonksiyonu
async function broadcastToGroup(message: string) {
    try {
        const chats = await client.getChats();
        const driverGroup = chats.find(c => c.isGroup && c.name === DRIVER_GROUP_NAME);
        
        if (driverGroup) {
            await client.sendMessage(driverGroup.id._serialized, message);
            console.log("📢 İlan Sürücü Grubuna Gönderildi!");
        } else {
            console.log(`⚠️ '${DRIVER_GROUP_NAME}' adında bir grup bulunamadı. Lütfen telefonda bu isimde bir grup kurun.`);
        }
    } catch (err) {
        console.error("Grup mesajı hatası:", err);
    }
}

client.on('message', async (msg) => {
    const chatId = msg.from;
    const text = msg.body.toLowerCase().trim();

    // Kendi gönderdiğimiz mesajları veya broadcast'leri yoksay
    if (msg.from === 'status@broadcast' || msg.fromMe) return;

    // Eğer mesaj Sürücü grubundan geliyorsa (İşi kabul etme senaryosu)
    const chat = await msg.getChat();
    if (chat.isGroup && chat.name === DRIVER_GROUP_NAME) {
        if (text.includes("alıyorum") || text.includes("ben alırım")) {
            const contact = await msg.getContact();
            await msg.reply(`✅ Harika ${contact.pushname}, bu iş sana atandı! Müşteri ile iletişime geçiyorum.`);
            // (Burada otelciye "Sürücü bulundu" diye otomatik mesaj atılabilir)
        }
        return;
    }

    // --- OTELCİ İŞ OLUŞTURMA AKIŞI (BİREBİR MESAJ) ---
    if (text === '/start' || text === 'merhaba' || text === 'araç çağır') {
        userStates[chatId] = { step: 1 };
        await client.sendMessage(chatId, "👋 *Reservatior VIP Transfer*\n\nFairRide ağından hızlıca araç çağırmak için lütfen *Nereden alınacağınızı* (kalkış noktanızı) yazın veya konum atın.");
        return;
    }

    const state = userStates[chatId];
    if (!state) return; 

    if (state.step === 1) {
        if (msg.location) {
            state.pickup = `Konum: ${msg.location.latitude}, ${msg.location.longitude}`;
        } else {
            state.pickup = msg.body;
        }
        state.step = 2;
        await client.sendMessage(chatId, "📍 Kalkış alındı. Şimdi lütfen *Nereye* gideceğinizi yazın.");
        return;
    }

    if (state.step === 2) {
        state.dropoff = msg.body;
        state.step = 3;
        await client.sendMessage(chatId, "🚗 *Hangi araç tipine ihtiyacınız var?*\nLütfen bir rakam yazın:\n1️⃣ VIP Transfer (Vito)\n2️⃣ Standart (Taksi)\n3️⃣ Moto Kurye");
        return;
    }

    if (state.step === 3) {
        if (text === '1') state.vehicleType = 'VIP Vito';
        else if (text === '2') state.vehicleType = 'Standart Taksi';
        else if (text === '3') state.vehicleType = 'Moto Kurye';
        else {
            await client.sendMessage(chatId, "❌ Lütfen 1, 2 veya 3 yazın.");
            return;
        }

        await client.sendMessage(chatId, `✅ *Talebiniz Alındı!*\n\nKalkış: ${state.pickup}\nVarış: ${state.dropoff}\nAraç: ${state.vehicleType}\n\nSürücülerimiz yönlendiriliyor...`);

        // OTOMATİK OLARAK SÜRÜCÜ GRUBUNA İLAN AT
        const groupMsg = `🚨 *YENİ TRANSFER TALEBİ* 🚨\n\n📌 *Kalkış:* ${state.pickup}\n🏁 *Varış:* ${state.dropoff}\n🚗 *Araç Tipi:* ${state.vehicleType}\n\nİşi almak isteyen "Alıyorum" yazsın!`;
        await broadcastToGroup(groupMsg);

        delete userStates[chatId];
    }
});

client.initialize();
