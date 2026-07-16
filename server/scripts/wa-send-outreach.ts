/**
 * wa-send-outreach.ts
 * ─────────────────────────────────────────────────────────────────────────────
 * data/outreach_queue.json dosyasındaki PENDING mesajları Reservatior
 * WhatsApp hesabından bireysel DM (özel mesaj) olarak gönderir.
 *
 * KULLANIM:
 *   bun run scripts/wa-send-outreach.ts             # Tümünü gönder
 *   bun run scripts/wa-send-outreach.ts --dry-run   # Sadece listele, gönderme
 *   bun run scripts/wa-send-outreach.ts --type LISTING_INVITE  # Sadece bir tip
 *   bun run scripts/wa-send-outreach.ts --limit 50  # İlk 50 mesajı gönder
 * ─────────────────────────────────────────────────────────────────────────────
 */

import { Client, LocalAuth } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';
import fs from 'fs';
import path from 'path';

const CHROME_PATH = '/Users/os2026/Downloads/Reservatior/server/chrome/mac_arm-146.0.7680.31/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing';
const DATA_ROOT = path.join(process.cwd(), 'data');
const QUEUE_PATH = path.join(DATA_ROOT, 'outreach_queue.json');
const SENT_LOG_PATH = path.join(DATA_ROOT, 'outreach_sent.json');

// ─── CLI Args ─────────────────────────────────────────────────────────────────
const args = process.argv.slice(2);
const DRY_RUN = args.includes('--dry-run');
const TYPE_FILTER = args.includes('--type') ? args[args.indexOf('--type') + 1] : null;
const LIMIT = args.includes('--limit') ? parseInt(args[args.indexOf('--limit') + 1]) : Infinity;
const DELAY_MS = 3000; // 3 sn aralık — WhatsApp spam koruması için

interface OutreachMessage {
    to: string;
    text: string;
    type: 'LISTING_INVITE' | 'DEMAND_MATCH' | 'MISSING_INFO' | 'INFO_COMPLETE';
    propertyId?: string;
    leadId?: string;
    queuedAt: string;
    sentAt?: string;
    status: 'PENDING' | 'SENT' | 'FAILED';
}

function log(emoji: string, msg: string) {
    console.log(`${new Date().toISOString()} ${emoji}  ${msg}`);
}

function sleep(ms: number) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function loadQueue(): OutreachMessage[] {
    if (!fs.existsSync(QUEUE_PATH)) { log('⚠️', 'Kuyruk dosyası bulunamadı: ' + QUEUE_PATH); return []; }
    return JSON.parse(fs.readFileSync(QUEUE_PATH, 'utf-8'));
}

function saveQueue(queue: OutreachMessage[]) {
    fs.writeFileSync(QUEUE_PATH, JSON.stringify(queue, null, 2), 'utf-8');
}

function appendSentLog(msg: OutreachMessage) {
    const log: OutreachMessage[] = fs.existsSync(SENT_LOG_PATH)
        ? JSON.parse(fs.readFileSync(SENT_LOG_PATH, 'utf-8'))
        : [];
    log.push({ ...msg, sentAt: new Date().toISOString(), status: 'SENT' });
    fs.writeFileSync(SENT_LOG_PATH, JSON.stringify(log, null, 2), 'utf-8');
}

// ─── WhatsApp Client ──────────────────────────────────────────────────────────

const client = new Client({
    authStrategy: new LocalAuth({
        clientId: 'reservatior-whatsapp',
        dataPath: './.wwebjs_auth',
    }),
    puppeteer: {
        headless: true,
        executablePath: CHROME_PATH,
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage', '--disable-gpu'],
    },
});

client.on('qr', (qr) => {
    console.log('\n📱 WhatsApp QR — Rezervatior hesabıyla giriş yapın:\n');
    qrcode.generate(qr, { small: true });
});

client.on('ready', async () => {
    log('✅', '📱 Reservatior WhatsApp hesabı bağlandı.');

    const queue = loadQueue();
    let pending = queue.filter(m => m.status === 'PENDING');

    if (TYPE_FILTER) {
        pending = pending.filter(m => m.type === TYPE_FILTER);
        log('🔍', `Filtre aktif: sadece "${TYPE_FILTER}" tipi mesajlar`);
    }

    const toSend = pending.slice(0, LIMIT === Infinity ? undefined : LIMIT);
    const skipped = queue.length - pending.length;

    log('📋', `Kuyruk özeti:`);
    log('📊', `  Toplam kayıt: ${queue.length}`);
    log('📊', `  PENDING: ${pending.length}`);
    log('📊', `  Zaten gönderilmiş/başarısız: ${skipped}`);
    log('📊', `  Şimdi gönderilecek: ${toSend.length}`);

    if (DRY_RUN) {
        log('🧪', 'DRY-RUN modu aktif — mesajlar gönderilmeyecek:');
        toSend.forEach((m, i) => {
            console.log(`\n[${i + 1}/${toSend.length}] → ${m.to} (${m.type})`);
            console.log(`  Kuyruğa eklenme: ${m.queuedAt}`);
            console.log(`  Mesaj:\n  ${m.text.substring(0, 120)}...`);
        });
        log('✅', 'Dry-run tamamlandı. Göndermek için --dry-run flagini kaldırın.');
        process.exit(0);
        return;
    }

    if (toSend.length === 0) {
        log('✅', 'Gönderilecek mesaj yok. Kuyruk boş veya hepsi zaten gönderildi.');
        process.exit(0);
        return;
    }

    let sent = 0;
    let failed = 0;

    for (let i = 0; i < toSend.length; i++) {
        const msg = toSend[i];
        const chatId = `${msg.to}@c.us`;

        try {
            await client.sendMessage(chatId, msg.text);
            log('✉️', `[${i + 1}/${toSend.length}] GÖNDER → ${msg.to} (${msg.type})`);

            // Update in queue
            const idx = queue.findIndex(q => q.to === msg.to && q.queuedAt === msg.queuedAt);
            if (idx >= 0) queue[idx].status = 'SENT';
            appendSentLog(msg);
            sent++;
        } catch (e) {
            log('❌', `[${i + 1}/${toSend.length}] HATA → ${msg.to}: ${e}`);
            const idx = queue.findIndex(q => q.to === msg.to && q.queuedAt === msg.queuedAt);
            if (idx >= 0) queue[idx].status = 'FAILED';
            failed++;
        }

        saveQueue(queue);

        // Throttle — WhatsApp bans if too fast
        if (i < toSend.length - 1) {
            log('⏳', `${DELAY_MS / 1000}sn bekleniyor...`);
            await sleep(DELAY_MS);
        }
    }

    log('🎉', `\nTamamlandı! Gönderilen: ${sent} | Hatalı: ${failed}`);
    log('📁', `Kuyruk: ${QUEUE_PATH}`);
    log('📁', `Gönderim logu: ${SENT_LOG_PATH}`);
    process.exit(0);
});

client.on('auth_failure', (msg) => {
    log('❌', `Kimlik doğrulama hatası: ${msg}`);
    process.exit(1);
});

client.initialize();
