import { Client, LocalAuth } from 'whatsapp-web.js';
import * as fs from 'fs';

const QR_FILE = '/root/reservatior/server/whatsapp-qr.png';

const client = new Client({
    authStrategy: new LocalAuth({ clientId: 'ozak-gyo-reader' }),
    puppeteer: {
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-gpu'],
        executablePath: '/root/.cache/puppeteer/chrome/linux-149.0.7827.22/chrome-linux64/chrome',
    }
});

client.on('qr', async (qr) => {
    const qrcode = await import('qrcode');
    await qrcode.toFile(QR_FILE, qr, { width: 400, margin: 2 });
    console.log(`QR PNG: ${QR_FILE}`);
    console.log('Bu dosyayı aç, telefonundan okut.');
});

client.on('ready', async () => {
    console.log('✅ ZATEN BAĞLI!');
    const chats = await client.getChats();
    const ozakChats = chats.filter(c => {
        const name = (c.name || '').toLowerCase();
        return ['ozak', 'özak', 'gyo', 'acente'].some(k => name.includes(k));
    });
    console.log(`Özak sohbet: ${ozakChats.length} adet`);
    for (const chat of ozakChats) {
        console.log(`\n--- ${chat.name} ---`);
        const msgs = await chat.fetchMessages({ limit: 20 });
        for (const m of msgs.reverse()) {
            console.log(m.body || '[medya]');
        }
    }
    await client.destroy();
    process.exit(0);
});

client.on('auth_failure', (m) => { console.error('Auth hatası:', m); process.exit(1); });
client.on('disconnected', (r) => { if (r !== 'NAVIGATION') console.log('Koptu:', r); });

client.initialize();
setTimeout(() => { console.log('Zaman aşımı'); process.exit(1); }, 180_000);
