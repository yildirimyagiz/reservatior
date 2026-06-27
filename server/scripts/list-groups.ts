import { Client, LocalAuth } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';

console.log("🟢 WhatsApp Grup Listesi Çıkarılıyor...");
console.log("Tarayıcı arka planda açılıyor...");

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
    qrcode.generate(qr, { small: true });
});

client.on('ready', async () => {
    console.log('\n✅ WhatsApp hesabınıza bağlandı!\n');

    try {
        const chats = await client.getChats();
        const groups = chats.filter(chat => chat.isGroup);

        console.log(`📋 Toplam ${groups.length} gruba üyesiniz.\n`);

        groups.forEach((group, index) => {
            console.log(`${index + 1}. ${group.name}`);
        });

        console.log(`\n📌 İsterseniz bu listeden "Emlak", "Gayrimenkul" vs. içerenleri filtreleyebiliriz.`);
        process.exit(0);

    } catch (error) {
        console.error("Grupları alırken hata oluştu:", error);
        process.exit(1);
    }
});

client.initialize();
