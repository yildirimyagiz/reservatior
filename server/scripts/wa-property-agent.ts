/**
 * wa-property-agent.ts
 * 
 * Otonom WhatsApp Emlak Ajanı
 * ─────────────────────────────────────────────────────────────────────────────
 * 1. Hedef emlak gruplarını sürekli dinler
 * 2. Her mesajı sınıflandırır: İlan | Talep | Sohbet
 * 3. İlan → DRAFT Property oluşturur, eksik bilgileri DM ile sorar
 * 4. Talep → Lead kaydı oluşturur, eşleşen ilanları alıcıya gönderir
 * 5. İlan sahibine "Alıcınız var" bildirimini iletir
 * ─────────────────────────────────────────────────────────────────────────────
 */

import { Client, LocalAuth, Message } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';
import fs from 'fs';
import path from 'path';
import {
    parsePropertyDetails,
    isPropertyListing,
    isDemandMessage,
    parseDemand,
    type BuyerDemand,
} from '../src/lib/property-parser';
import { prismaManager } from '../src/lib/prisma';
import { PropertyType, ListingStatus, ListingType, PropertyCategory } from '@prisma/client';

// ─── Config ──────────────────────────────────────────────────────────────────

const CHROME_PATH = '/Users/os2026/Downloads/Reservatior/server/chrome/mac_arm-146.0.7680.31/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing';
const DATA_ROOT = path.join(process.cwd(), 'data');
const ORG_ID = 'org_whatsapp_tr';

/**
 * ⚙️  MESSAGING_ENABLED = false  (varsayılan)
 * Mesajlar şimdilik GÖNDERİLMEZ — data/outreach_queue.json dosyasına kaydedilir.
 * Aktifleştirmek için:
 *   MESSAGING_ENABLED=true bun run scripts/wa-property-agent.ts
 * Veya kuyruğu boşaltmak için:
 *   bun run scripts/wa-send-outreach.ts
 */
const MESSAGING_ENABLED = process.env.MESSAGING_ENABLED === 'true';
const OUTREACH_QUEUE_PATH = path.join(DATA_ROOT, 'outreach_queue.json');

// Group keywords to scan (same as historical scanner)
const INCLUDE_KEYWORDS = [
    'gayrimenkul', 'emlak', 'satılık', 'kiralık', 'al-sat', 'al sat', 'portföy',
    'villa', 'residence', 'konut', 'estate', 'vadi', 'inşaat',
    'bosfor', 'developer', 'yatırım', 'investment', 'arsa', 'dükkan', 'ticari',
    'proje', 'bölgesi', 'topkapı', 'rom group', 'object 1',
    'amlak', 'rent', 'house', 'bahçeşehir', 'beylikdüzü', 'inistanbul',
    'torunlar', 'babiller', 'fonyap', 'dia centro', 'ghurair', 'ercan', 'dky',
];
const EXCLUDE_KEYWORDS = ['genel', 'elifin', 'midpoint', 'hacking', 'medrese', 'yemek'];

// ─── Missing Field Definitions ────────────────────────────────────────────────

interface MissingFieldSession {
    propertyId: string;
    phone: string;
    missingFields: string[];
    currentFieldIndex: number;
    collectedData: Record<string, string>;
}

const FIELD_QUESTIONS: Record<string, string> = {
    price:    '💰 İlan fiyatı nedir? (Örn: 5.000.000 ₺ veya 300.000 USD)',
    roomType: '🛏️ Oda sayısı nedir? (Örn: 2+1, 3+1)',
    grossArea:'📐 Brüt metrekare? (Örn: 145 m²)',
    netArea:  '📏 Net metrekare? (Örn: 120 m²)',
    district: '📍 Hangi ilçede? (Örn: Şişli, Beşiktaş)',
    status:   '🔖 Satılık mı, Kiralık mı?',
};

// ─── In-memory state ──────────────────────────────────────────────────────────

const activeSessions: Map<string, MissingFieldSession> = new Map();
const processedMessageIds: Set<string> = new Set();

// ─── WhatsApp Client ──────────────────────────────────────────────────────────

const client = new Client({
    authStrategy: new LocalAuth({
        clientId: 'reservatior-whatsapp',
        dataPath: './.wwebjs_auth',
    }),
    puppeteer: {
        headless: true,
        executablePath: CHROME_PATH,
        args: [
            '--no-sandbox', '--disable-setuid-sandbox',
            '--disable-dev-shm-usage', '--disable-gpu',
            '--no-first-run', '--no-zygote', '--single-process',
        ],
    },
});

// ─── Utilities ────────────────────────────────────────────────────────────────

function log(emoji: string, msg: string) {
    console.log(`${new Date().toISOString()} ${emoji} ${msg}`);
}

function normalizePhone(raw: string): string {
    const authorId = raw.split('@')[0];
    const digits = authorId.split(':')[0];
    if (digits.startsWith('90') && digits.length === 12) return digits;
    if (digits.length === 10) return '90' + digits;
    return digits;
}

interface OutreachMessage {
    to: string;           // Phone number (e.g. 905551234567)
    text: string;
    type: 'LISTING_INVITE' | 'DEMAND_MATCH' | 'MISSING_INFO' | 'INFO_COMPLETE';
    propertyId?: string;
    leadId?: string;
    queuedAt: string;
    sentAt?: string;
    status: 'PENDING' | 'SENT' | 'FAILED';
}

function loadQueue(): OutreachMessage[] {
    if (!fs.existsSync(OUTREACH_QUEUE_PATH)) return [];
    try { return JSON.parse(fs.readFileSync(OUTREACH_QUEUE_PATH, 'utf-8')); } catch { return []; }
}

function saveQueue(queue: OutreachMessage[]) {
    fs.writeFileSync(OUTREACH_QUEUE_PATH, JSON.stringify(queue, null, 2), 'utf-8');
}

/**
 * Queue or send a DM from the Reservatior WhatsApp account.
 * When MESSAGING_ENABLED=false, messages are written to outreach_queue.json.
 * All messages are sent as private DMs (not to the group).
 */
async function sendMsg(
    to: string,
    text: string,
    type: OutreachMessage['type'] = 'LISTING_INVITE',
    opts?: { propertyId?: string; leadId?: string }
) {
    const phone = to.replace(/[^0-9]/g, '');
    const entry: OutreachMessage = {
        to: phone,
        text,
        type,
        propertyId: opts?.propertyId,
        leadId: opts?.leadId,
        queuedAt: new Date().toISOString(),
        status: 'PENDING',
    };

    if (!MESSAGING_ENABLED) {
        const queue = loadQueue();
        queue.push(entry);
        saveQueue(queue);
        log('📋', `[QUEUE] ${type} → ${phone} — mesaj kuyruğa eklendi (${queue.length} toplam)`);
        log('💬', `[PREVIEW] ${text.substring(0, 80)}...`);
        return;
    }

    // Live send — always as private DM from Reservatior account
    try {
        const chatId = `${phone}@c.us`;
        await client.sendMessage(chatId, text);
        log('✉️', `[SENT] DM gönderildi → ${phone}`);
    } catch (e) {
        log('⚠️', `DM gönderilemedi → ${phone}: ${e}`);
        // Still queue it for retry
        const queue = loadQueue();
        queue.push({ ...entry, status: 'FAILED' });
        saveQueue(queue);
    }
}

// ─── Property Upsert ──────────────────────────────────────────────────────────

async function upsertProperty(details: ReturnType<typeof parsePropertyDetails>, mediaDir: string, phone: string) {
    const countryCode = details.country?.includes('BAE') || details.country?.includes('DUBAI') ? 'AE' : 'TR';
    const prisma = prismaManager.getClient(countryCode);

    const uniqueId = `wa_live_${Date.now()}_${Math.random().toString(36).slice(2, 7)}`;
    const city = details.city || 'İSTANBUL';
    const district = details.district || 'Bilinmeyen';

    let type: PropertyType = PropertyType.APARTMENT;
    const pn = (details.projectName || '').toLowerCase();
    if (pn.includes('villa')) type = PropertyType.VILLA;
    else if (pn.includes('ofis') || pn.includes('plaza')) type = PropertyType.OFFICE;
    else if (pn.includes('dükkan') || pn.includes('ticari')) type = PropertyType.RETAIL;

    let listingType: ListingType = ListingType.SALE;
    if (details.status === 'Kiralık') listingType = ListingType.RENT;

    let price: number | null = null;
    const priceMatch = (details.price || '').replace(/\./g, '').match(/\d+/);
    if (priceMatch) price = parseInt(priceMatch[0]);

    const currency = (details.price || '').toUpperCase().includes('USD') ? 'USD'
        : (details.price || '').includes('AED') ? 'AED' : 'TRY';

    // Upsert org
    await prisma.organization.upsert({
        where: { id: ORG_ID },
        update: {},
        create: {
            id: ORG_ID,
            name: 'WhatsApp Scraped Listings (TR)',
            type: 'AGENCY',
            region: 'TR' as any,
            defaultCurrency: 'TRY',
        },
    });

    // Upsert user
    let userId: string | null = null;
    if (phone && phone !== 'Bilinmiyor') {
        try {
            let user = await prisma.user.findFirst({ where: { phone } });
            if (!user) {
                user = await prisma.user.create({
                    data: {
                        email: `${phone}@reservatior.com`,
                        name: details.contactName || 'WhatsApp Kullanıcısı',
                        phone,
                        locale: 'tr-TR',
                    },
                });
            }
            userId = user.id;
        } catch (_) {}
    }

    const property = await prisma.property.upsert({
        where: { id: uniqueId },
        update: {},
        create: {
            id: uniqueId,
            orgId: ORG_ID,
            name: details.projectName || 'WhatsApp Emlak İlanı',
            type,
            propertyCategory: PropertyCategory.RESIDENTIAL,
            listingType,
            listingStatus: ListingStatus.DRAFT,
            region: countryCode === 'AE' ? ('UAE' as any) : ('TR' as any),
            currency,
            addressLine1: `${district}, ${city}`,
            city,
            country: countryCode,
            bedrooms: details.roomType ? parseInt(details.roomType.split('+')[0]) || null : null,
            listingPrice: price,
            notes: `[WhatsApp Bot]\nOda: ${details.roomType}\nBrüt: ${details.grossArea}\nNet: ${details.netArea}\nFiyat: ${details.price}`,
            createdBy: userId,
        },
    });

    // Save media dir reference in notes
    if (fs.existsSync(mediaDir)) {
        const files = fs.readdirSync(mediaDir);
        const photos = files.filter(f => /\.(jpg|jpeg|png)$/i.test(f));
        for (let i = 0; i < photos.length; i++) {
            const relPath = `/data/${path.relative(DATA_ROOT, path.join(mediaDir, photos[i]))}`;
            try {
                await prisma.photo.upsert({
                    where: { url: relPath },
                    update: { propertyId: property.id, featured: i === 0 },
                    create: { url: relPath, type: 'GALLERY', featured: i === 0, propertyId: property.id, originalName: photos[i] },
                });
            } catch (_) {}
        }
    }

    return { uniqueId, property, userId, countryCode, missingFields: getMissingFields(details) };
}

function getMissingFields(details: ReturnType<typeof parsePropertyDetails>): string[] {
    const missing: string[] = [];
    if (!details.price || details.price.trim() === '') missing.push('price');
    if (!details.roomType || details.roomType.trim() === '') missing.push('roomType');
    if (!details.grossArea || details.grossArea.trim() === '') missing.push('grossArea');
    if (!details.district || details.district === 'BİLİNMEYEN_İLÇE') missing.push('district');
    return missing;
}

// ─── Lead Upsert ─────────────────────────────────────────────────────────────

async function upsertLead(demand: BuyerDemand) {
    const prisma = prismaManager.getClient('TR');

    const id = `lead_wa_${Date.now()}_${Math.random().toString(36).slice(2, 7)}`;
    let budgetNum: number | null = null;
    const bm = demand.budget.replace(/\./g, '').match(/\d+/);
    if (bm) budgetNum = parseInt(bm[0]);

    await prisma.organization.upsert({
        where: { id: ORG_ID },
        update: {},
        create: { id: ORG_ID, name: 'WhatsApp Scraped Listings (TR)', type: 'AGENCY', region: 'TR' as any, defaultCurrency: 'TRY' },
    });

    let userId: string | null = null;
    if (demand.contactPhone) {
        try {
            let u = await prisma.user.findFirst({ where: { phone: demand.contactPhone } });
            if (!u) {
                u = await prisma.user.create({
                    data: { email: `${demand.contactPhone}@reservatior.com`, name: demand.contactName || 'Alıcı', phone: demand.contactPhone, locale: 'tr-TR' },
                });
            }
            userId = u.id;
        } catch (_) {}
    }

    const lead = await prisma.lead.create({
        data: {
            id,
            orgId: ORG_ID,
            firstName: (demand.contactName || 'WhatsApp').split(' ')[0],
            lastName: (demand.contactName || '').split(' ').slice(1).join(' ') || 'Alıcı',
            phone: demand.contactPhone,
            budget: budgetNum ? (budgetNum as any) : undefined,
            status: 'NEW' as any,
            notes: `[Sıcaklık: ${demand.intentScore}] [WhatsApp Alım Talebi]\nŞehir: ${demand.city}\nİlçe: ${demand.district}\nOda: ${demand.roomType}\nBütçe: ${demand.budget} ${demand.budgetCurrency}\nTip: ${demand.listingType}\nGrup: ${demand.groupName}\n\nHam mesaj:\n${demand.rawText.substring(0, 300)}`,
            sourceDetail: `WhatsApp Group: ${demand.groupName}`,
            assignedToUserId: userId ?? undefined,
        },
    });

    return lead;
}

// ─── Buyer ↔ Seller Matching ─────────────────────────────────────────────────

async function findMatchingProperties(demand: BuyerDemand): Promise<Array<{ id: string; name: string; listingPrice: number | null; currency: string; city: string; bedrooms: number | null }>> {
    try {
        const prisma = prismaManager.getClient('TR');
        const budgetMatch = demand.budget.replace(/\./g, '').match(/\d+/);
        const budget = budgetMatch ? parseInt(budgetMatch[0]) : null;

        const where: any = {
            listingStatus: { in: ['AVAILABLE', 'DRAFT'] },
            city: demand.city,
            listingType: demand.listingType,
        };
        if (demand.district) where.addressLine1 = { contains: demand.district, mode: 'insensitive' };
        if (demand.roomType) {
            const beds = parseInt(demand.roomType.split('+')[0]);
            if (!isNaN(beds)) where.bedrooms = beds;
        }
        if (budget) {
            const margin = 1.2; // 20% above budget
            where.listingPrice = { lte: Math.round(budget * margin) };
        }

        const props = await prisma.property.findMany({ where, take: 5, select: { id: true, name: true, listingPrice: true, currency: true, city: true, bedrooms: true } });
        return props as any;
    } catch (e) {
        log('⚠️', `Match query failed: ${e}`);
        return [];
    }
}

// ─── Message Handlers ─────────────────────────────────────────────────────────

async function handleListingMessage(msg: Message, chat: any, combinedText: string, mediaDir: string, phone: string) {
    const details = parsePropertyDetails(combinedText, chat.name);
    details.contactPhone = phone;
    try {
        const contact = await msg.getContact();
        details.contactName = contact.pushname || contact.name || 'Bilinmiyor';
    } catch (_) {}

    const { uniqueId, userId, missingFields } = await upsertProperty(details, mediaDir, phone);
    log('🏠', `DRAFT ilan oluşturuldu: ${uniqueId} (${details.projectName})`);

    const propertyLink = `https://reservatior.com/en/property/${uniqueId}`;

    if (missingFields.length === 0) {
        // All info complete → invite to publish
        await sendMsg(phone,
            `🏠 *Merhaba ${details.contactName}!* Reservatior'dan yazıyoruz.\n\n${details.projectName || 'İlanınızı'} sistemimize kaydettik ve yayına hazır! ✅\n\n*İlanı yayınlamak için:*\n👉 ${propertyLink}\n\nHerhangi bir sorunuz olursa buradayız! 🤝`,
            'LISTING_INVITE', { propertyId: uniqueId }
        );
    } else {
        // Start missing info collection flow
        const session: MissingFieldSession = {
            propertyId: uniqueId,
            phone,
            missingFields,
            currentFieldIndex: 0,
            collectedData: {},
        };
        activeSessions.set(phone, session);

        const firstQuestion = FIELD_QUESTIONS[missingFields[0]];
        await sendMsg(phone,
            `🏠 *Merhaba ${details.contactName}!* Reservatior'dan yazıyoruz.\n\n` +
            `*${details.projectName || 'İlanınızı'}* sistemimize ekledik! Birkaç bilgi eksik, yardımcı olabilir misiniz?\n\n` +
            firstQuestion,
            'MISSING_INFO', { propertyId: uniqueId }
        );
        log('🤖', `Eksik bilgi süreci başlatıldı: ${phone} → ${missingFields.join(', ')}`);
    }
}

async function handleDemandMessage(msg: Message, chat: any, text: string, phone: string) {
    let contactName = 'Alıcı';
    try { contactName = (await msg.getContact()).pushname || 'Alıcı'; } catch (_) {}

    const demand = parseDemand(text, chat.name, contactName, phone);
    const lead = await upsertLead(demand);
    log('🔍', `Alım talebi kaydedildi: ${lead.id} — ${demand.roomType} ${demand.city} ${demand.budget}`);

    // Find matching listings
    const matches = await findMatchingProperties(demand);

    if (matches.length > 0) {
        const matchLines = matches.map((p, i) => {
            const priceStr = p.listingPrice ? `${p.listingPrice.toLocaleString('tr-TR')} ${p.currency}` : 'Fiyat sorunuz';
            const roomStr = p.bedrooms ? `${p.bedrooms}+1` : '';
            return `${i + 1}️⃣ *${p.name}* — ${priceStr} ${roomStr}\n   👉 reservatior.com/en/property/${p.id}`;
        }).join('\n\n');

        await sendMsg(phone,
            `👋 *Merhaba ${contactName}!* Reservatior'dan yazıyoruz.\n\n` +
            `${demand.district ? demand.district + ', ' : ''}${demand.city}'de *${demand.roomType}* aradığınızı gördük.\n\n` +
            `Kriterlerinize uyan *${matches.length} ilan* bulduk:\n\n${matchLines}\n\n` +
            `Daha fazla bilgi almak ister misiniz? Hemen yardımcı olabiliriz! 🏠`,
            'DEMAND_MATCH', { leadId: lead.id }
        );
        log('🤝', `${matches.length} eşleşme bulundu ve alıcıya gönderildi: ${phone}`);
    } else {
        await sendMsg(phone,
            `👋 *Merhaba ${contactName}!* Reservatior'dan yazıyoruz.\n\n` +
            `${demand.city}'de ${demand.roomType || 'mülk'} talebinizi aldık ve sistemimize kaydettik. ✅\n\n` +
            `Kriterlerinize uyan yeni bir ilan geldiğinde sizi hemen haberdar edeceğiz!\n\n` +
            `Platformumuzu incelemek ister misiniz? 👉 reservatior.com`,
            'DEMAND_MATCH', { leadId: lead.id }
        );
        log('📋', `Talep kaydedildi ama eşleşme bulunamadı: ${phone}`);
    }
}

async function handleMissingInfoReply(msg: Message, phone: string, text: string) {
    const session = activeSessions.get(phone)!;
    const currentField = session.missingFields[session.currentFieldIndex];
    session.collectedData[currentField] = text.trim();

    log('📝', `Bilgi alındı [${currentField}]: "${text.trim()}" ← ${phone}`);

    // Move to next field
    session.currentFieldIndex++;

    if (session.currentFieldIndex < session.missingFields.length) {
        const nextField = session.missingFields[session.currentFieldIndex];
        await sendMsg(phone, FIELD_QUESTIONS[nextField], 'MISSING_INFO', { propertyId: session.propertyId });
    } else {
        // All collected — update property
        activeSessions.delete(phone);
        await updatePropertyWithCollectedData(session);

        const propertyLink = `https://reservatior.com/en/property/${session.propertyId}`;
        await sendMsg(phone,
            `🎉 *Harika, teşekkürler!* İlanınız tamamlandı.\n\n` +
            `Artık yayına alabilirsiniz:\n👉 ${propertyLink}\n\n` +
            `İyi satışlar dileriz! 🏠✨`,
            'INFO_COMPLETE', { propertyId: session.propertyId }
        );
        log('✅', `Tüm bilgiler toplandı ve ilan güncellendi: ${session.propertyId}`);
    }
}

async function updatePropertyWithCollectedData(session: MissingFieldSession) {
    try {
        const prisma = prismaManager.getClient('TR');
        const updateData: any = {};

        for (const [field, value] of Object.entries(session.collectedData)) {
            if (field === 'price') {
                const m = value.replace(/\./g, '').match(/\d+/);
                if (m) updateData.listingPrice = parseInt(m[0]);
                const currency = value.toUpperCase().includes('USD') ? 'USD' : value.includes('AED') ? 'AED' : 'TRY';
                updateData.currency = currency;
            } else if (field === 'roomType') {
                const beds = parseInt(value.split('+')[0]);
                if (!isNaN(beds)) updateData.bedrooms = beds;
            } else if (field === 'grossArea') {
                const m = value.match(/\d+/);
                if (m) updateData.squareMeters = parseInt(m[0]);
            } else if (field === 'district') {
                updateData.addressLine1 = value;
            } else if (field === 'status') {
                const isRent = value.toLowerCase().includes('kiralık');
                updateData.listingType = isRent ? 'RENT' : 'SALE';
            }
        }

        if (Object.keys(updateData).length > 0) {
            await prisma.property.update({ where: { id: session.propertyId }, data: updateData });
        }
    } catch (e) {
        log('⚠️', `Property update failed: ${e}`);
    }
}

// ─── Group Message Handler ────────────────────────────────────────────────────

client.on('message', async (msg: Message) => {
    try {
        // Skip duplicates and own messages
        if (msg.fromMe) return;
        if (processedMessageIds.has(msg.id.id)) return;
        processedMessageIds.add(msg.id.id);
        // Keep set bounded
        if (processedMessageIds.size > 10000) {
            const arr = [...processedMessageIds];
            arr.slice(0, 5000).forEach(id => processedMessageIds.delete(id));
        }

        const chat = await msg.getChat();
        const text = msg.body || '';
        const phone = normalizePhone(msg.author || msg.from);

        // ── Direct message: check if in an active session ──
        if (!chat.isGroup) {
            if (activeSessions.has(phone)) {
                await handleMissingInfoReply(msg, phone, text);
            }
            return;
        }

        // ── Group message: check if target group ──
        const chatNameLower = chat.name.toLowerCase();
        const isTargetGroup =
            INCLUDE_KEYWORDS.some(kw => chatNameLower.includes(kw)) &&
            !EXCLUDE_KEYWORDS.some(kw => chatNameLower.includes(kw));

        if (!isTargetGroup) return;

        // ── Download media if any ──
        let mediaDir = '';
        if (msg.hasMedia) {
            try {
                const media = await msg.downloadMedia();
                if (media) {
                    const timestamp = Date.now();
                    const projectDir = path.join(DATA_ROOT, 'TURKİYE', 'ISTANBUL', 'Bilinmeyen_Proje', `live_${timestamp}`);
                    fs.mkdirSync(projectDir, { recursive: true });
                    const ext = media.mimetype.includes('jpeg') || media.mimetype.includes('jpg') ? '.jpg'
                        : media.mimetype.includes('png') ? '.png'
                        : media.mimetype.includes('mp4') || media.mimetype.includes('video') ? '.mp4' : '.bin';
                    const filePath = path.join(projectDir, `media${ext}`);
                    fs.writeFileSync(filePath, Buffer.from(media.data, 'base64'));
                    mediaDir = projectDir;
                    log('📥', `Medya indirildi: ${filePath}`);
                }
            } catch (e) {
                log('⚠️', `Medya indirme hatası: ${e}`);
            }
        }

        const mediaCount = msg.hasMedia ? 1 : 0;

        // ── Classify ──
        if (isDemandMessage(text)) {
            log('🔍', `TALEP tespit edildi — ${chat.name} — "${text.substring(0, 60)}..."`);
            await handleDemandMessage(msg, chat, text, phone);
        } else if (isPropertyListing(text, mediaCount)) {
            log('🏠', `İLAN tespit edildi — ${chat.name} — "${text.substring(0, 60)}..."`);
            await handleListingMessage(msg, chat, text, mediaDir, phone);
        } else {
            log('💬', `Sohbet atlandı — ${chat.name} — "${text.substring(0, 40)}..."`);
        }
    } catch (e) {
        console.error('Message handler error:', e);
    }
});

// ─── Boot ─────────────────────────────────────────────────────────────────────

client.on('qr', (qr) => {
    console.log('\n📱 WhatsApp QR Kodu — Telefonda okutun:\n');
    qrcode.generate(qr, { small: true });
});

client.on('ready', () => {
    log('✅', '🤖 Reservatior Otonom WhatsApp Ajanı aktif!');
    log('📡', 'Hedef emlak grupları dinleniyor...');
    log('🔄', 'İlanlar → DRAFT Property | Talepler → Lead | Eksik bilgi → DM kuyruğu');
    if (MESSAGING_ENABLED) {
        log('✉️', 'Mesajlaşma AKTİF — DM\'ler Reservatior hesabından anında gönderilecek');
    } else {
        log('📋', `Mesajlaşma PASİF — Mesajlar kuyruğa yazılıyor: ${OUTREACH_QUEUE_PATH}`);
        log('💡', 'Aktifleştirmek için: MESSAGING_ENABLED=true bun run scripts/wa-property-agent.ts');
        log('💡', 'Kuyruğu göndermek için: bun run scripts/wa-send-outreach.ts');
    }
});

client.on('auth_failure', (msg) => {
    log('❌', `Auth hatası: ${msg}`);
});

client.on('disconnected', (reason) => {
    log('🔌', `Bağlantı kesildi: ${reason}. Yeniden bağlanılıyor...`);
    client.initialize();
});

client.initialize();
