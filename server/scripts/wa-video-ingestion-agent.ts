import makeWASocket, { DisconnectReason, useMultiFileAuthState, fetchLatestBaileysVersion, downloadMediaMessage, WAMessage } from '@whiskeysockets/baileys';
import qrcode from 'qrcode-terminal';
import fs from 'fs';
import path from 'path';
import { prismaManager } from '../src/lib/prisma';
import { parsePropertyDetails, isPropertyListing } from '../src/lib/property-parser';
import { PropertyType, ListingStatus, ListingType, PropertyCategory } from '@prisma/client';

const includeKeywords = [
    'gayrimenkul', 'emlak', 'satılık', 'kiralık', 'al-sat', 'al sat', 'al_sat', 'portföy',
    'villa', 'residence', 'konut', 'estate', 'vadi', 'inşaat', 'yapı', 'yapi',
    'bosfor', 'developer', 'yatırım', 'investment', 'arsa', 'dükkan', 'ticari',
    'proje', 'bölgesi', 'topkapı', 'offers', 'champion', 'rom group', 'object 1',
    'amlak', 'rent', 'house', 'abc', 'bahçeşehir', 'beylikdüzü', 'hayal', 'pera',
    'inistanbul', 'torunlar', 'babiller', 'mekan', 'oğuz', 'fonyap', 'dia centro', 'ghurair', 'ercan', 'suryap', 'turunç', 'dky'
];
const excludeKeywords = ['genel', 'elifin', 'midpoint', 'hacking', 'medrese', 'anadolu', 'antaş', 'yemek'];

const COUNTRY_MAP: Record<string, string> = { "TURKİYE": "TR", "TURKIYE": "TR", "TÜRKİYE": "TR", "BAE": "AE", "DUBAI": "AE", "DUBAİ": "AE" };
const REGION_ENUM_MAP: Record<string, string> = { "TR": "TR", "AE": "UAE" };

// Kümeleme (Clustering) için tampon bellek
// Aynı gruptan art arda gelen mesajları (örn: 5 foto, 1 video, 1 açıklama) tek bir ilanda birleştirmek için 5 dakika bekleriz.
const messageBuffers: Record<string, { messages: WAMessage[], timer: NodeJS.Timeout | null, groupName: string }> = {};

function detectCurrency(priceStr: string, countryCode: string): string {
    const str = priceStr.toUpperCase();
    if (str.includes("USD") || str.includes("$")) return "USD";
    if (str.includes("AED")) return "AED";
    if (str.includes("TL") || str.includes("₺")) return "TRY";
    return countryCode === "TR" ? "TRY" : (countryCode === "AE" ? "AED" : "USD");
}

function normalizePhoneNumber(rawPhone: string, countryCode: string): string {
    let cleaned = rawPhone.replace(/\D/g, '');
    if (countryCode === "TR") {
        if (!cleaned.startsWith('90') && cleaned.length === 10) cleaned = '90' + cleaned;
        else if (cleaned.startsWith('05')) cleaned = '90' + cleaned.substring(1);
    } else if (countryCode === "AE") {
        if (!cleaned.startsWith('971') && cleaned.length === 9) cleaned = '971' + cleaned;
        else if (cleaned.startsWith('05')) cleaned = '971' + cleaned.substring(1);
    }
    return cleaned;
}

async function processMessageCluster(jid: string, sock: any) {
    const buffer = messageBuffers[jid];
    if (!buffer || buffer.messages.length === 0) return;

    const messages = [...buffer.messages];
    const groupName = buffer.groupName;
    buffer.messages = []; // Clear buffer

    // Extract text body from all messages
    let combinedText = "";
    let mediaMessages: WAMessage[] = [];

    for (const msg of messages) {
        const text = msg.message?.conversation || msg.message?.extendedTextMessage?.text || msg.message?.imageMessage?.caption || msg.message?.videoMessage?.caption || "";
        combinedText += text + "\n";
        
        if (msg.message?.imageMessage || msg.message?.videoMessage || msg.message?.documentMessage) {
            mediaMessages.push(msg);
        }
    }

    if (!isPropertyListing(combinedText, mediaMessages.length)) {
        return; // Emlak ilanı değilse atla
    }

    console.log(`\n🏢 Yeni İlan Kümesi İşleniyor: ${groupName} (${messages.length} mesaj)`);
    const details = parsePropertyDetails(combinedText, groupName);

    // Gönderici Tespiti
    const firstMsg = messages[0];
    
    // Baileys 'participant' alanını LID olarak verebilir. Eğer pn veya participantPn gibi bir alan varsa onu kullanacağız.
    let senderId = firstMsg.key.participant || firstMsg.key.remoteJid || "";
    
    // Mesajdan gelen gizli numarayı (PN/LID eşleşmesini) yakala
    if (firstMsg.participant) senderId = firstMsg.participant;
    
    // Bazen Baileys 'participantPn' içinde gerçek numarayı taşır
    if ((firstMsg as any).participantPn || (firstMsg.key as any).participantPn) {
        senderId = (firstMsg as any).participantPn || (firstMsg.key as any).participantPn;
    }

    const rawPhone = senderId.split('@')[0];
    details.contactPhone = rawPhone;
    details.contactName = firstMsg.pushName || "Bilinmeyen Gönderici";

    // Klasör Yapısı (Dosyaları da yedeklemek için)
    const listingFolder = `${details.status}_${firstMsg.messageTimestamp}`;
    const projectDir = path.join(process.cwd(), 'data', details.country || 'TURKİYE', details.city || 'Bilinmiyor', details.district || 'Bilinmiyor', details.projectName || 'Bilinmeyen_Proje', listingFolder);
    
    if (!fs.existsSync(projectDir)) {
        fs.mkdirSync(projectDir, { recursive: true });
    }
    fs.writeFileSync(path.join(projectDir, 'details.json'), JSON.stringify(details, null, 2), 'utf-8');
    fs.writeFileSync(path.join(projectDir, 'description.txt'), combinedText, 'utf-8');

    const downloadedMedia: { filename: string, isVideo: boolean, url: string }[] = [];

    // Medya İndirme
    for (const msg of mediaMessages) {
        try {
            const buffer = await downloadMediaMessage(msg, 'buffer', {}, { logger: console as any, reuploadRequest: sock.updateMediaMessage });
            let ext = '.bin';
            let isVideo = false;
            
            if (msg.message?.imageMessage) ext = '.jpg';
            else if (msg.message?.videoMessage) { ext = '.mp4'; isVideo = true; }
            else if (msg.message?.documentMessage?.mimetype?.includes('pdf')) ext = '.pdf';

            const filename = `msg_${msg.key.id}${ext}`;
            const mediaPath = path.join(projectDir, filename);
            fs.writeFileSync(mediaPath, buffer);
            
            const relativePath = path.relative(path.join(process.cwd(), "data"), mediaPath);
            downloadedMedia.push({ filename, isVideo, url: `/data/${relativePath}` });
            console.log(`⬇️ Medya İndirildi: ${filename}`);
        } catch (err) {
            console.error(`❌ Medya indirme hatası (${msg.key.id}):`, err);
        }
    }

    // === VERİTABANI (PRISMA) KAYDI ===
    try {
        const country = details.country || "TURKİYE";
        const countryCode = COUNTRY_MAP[country.toUpperCase()] || "TR";
        const prisma = prismaManager.getClient(countryCode);

        const orgId = `org_whatsapp_${countryCode.toLowerCase()}`;
        await prisma.organization.upsert({
            where: { id: orgId },
            update: {},
            create: { id: orgId, name: `WhatsApp Scraped Listings (${countryCode})`, type: "AGENCY", region: REGION_ENUM_MAP[countryCode] as any, defaultCurrency: countryCode === "TR" ? "TRY" : "USD" },
        });

        const normalizedPhone = normalizePhoneNumber(rawPhone, countryCode);
        let userId = null;

        if (normalizedPhone) {
            let user = await prisma.user.findFirst({ where: { phone: normalizedPhone } });
            if (!user) {
                user = await prisma.user.create({
                    data: { email: `${normalizedPhone}@reservatior.com`, name: details.contactName, phone: normalizedPhone, locale: countryCode === "TR" ? "tr-TR" : "en-US" }
                });
            }
            userId = user.id;

            await prisma.contact.upsert({
                where: { id: `contact_wa_${normalizedPhone}` },
                update: { fullName: details.contactName, phone: normalizedPhone },
                create: { id: `contact_wa_${normalizedPhone}`, orgId, type: "OWNER_CONTACT", fullName: details.contactName, phone: normalizedPhone, email: user.email },
            });
        }

        const rawPrice = details.price || "";
        const price = rawPrice ? parseInt(rawPrice.replace(/\D/g, "")) : null;
        const currency = detectCurrency(rawPrice, countryCode);

        const uniqueId = `wa_${listingFolder}`;
        const property = await prisma.property.upsert({
            where: { id: uniqueId },
            update: { listingPrice: price, currency, notes: combinedText },
            create: {
                id: uniqueId, orgId, name: details.projectName || "WhatsApp Emlak İlanı", type: PropertyType.APARTMENT, propertyCategory: PropertyCategory.RESIDENTIAL, listingType: ListingType.SALE,
                listingStatus: ListingStatus.DRAFT, region: REGION_ENUM_MAP[countryCode] as any, currency, addressLine1: `${details.district || "Bilinmeyen İlçe"}, ${details.city || "İstanbul"}`,
                city: details.city || "İstanbul", country: countryCode, notes: combinedText, listingPrice: price, createdBy: userId
            },
        });

        for (let i = 0; i < downloadedMedia.length; i++) {
            const media = downloadedMedia[i];
            if (media.isVideo) {
                const videoId = `video_wa_${uniqueId}_${media.filename}`;
                await prisma.agentVideo.upsert({
                    where: { id: videoId },
                    update: { propertyId: property.id, videoUrl: media.url },
                    create: { id: videoId, orgId, agentId: "whatsapp_agent", vendorId: "vendor_whatsapp", propertyId: property.id, title: "WhatsApp Video Turu", videoUrl: media.url, status: "completed" },
                });
                await prisma.videoContent.upsert({
                    where: { id: `vc_${videoId}` },
                    update: { url: media.url },
                    create: { id: `vc_${videoId}`, orgId, propertyId: property.id, title: "WhatsApp Video", url: media.url, status: "READY", pipeline: "KREA_REALTIME", platform: "TIKTOK" }
                });
            } else {
                await prisma.photo.upsert({
                    where: { url: media.url },
                    update: { propertyId: property.id, featured: i === 0 },
                    create: { url: media.url, type: "GALLERY", featured: i === 0, propertyId: property.id, originalName: media.filename },
                });
            }
        }
        console.log(`✅ Prisma DB'ye Kaydedildi: ${uniqueId}`);
    } catch (e: any) {
        console.error(`❌ Prisma DB Kayıt Hatası:`, e.message);
    }
}

async function main() {
    console.log("🚀 Baileys Hibrit (Geçmiş + Canlı) Medya ve İlan Tarayıcı Başlatılıyor...");
    const authDir = path.join(process.cwd(), '.baileys_auth');
    const { state, saveCreds } = await useMultiFileAuthState(authDir);
    const { version } = await fetchLatestBaileysVersion();

    const sock = makeWASocket({
        version,
        auth: state,
        printQRInTerminal: false,
        browser: ['Reservatior', 'Chrome', '120.0'],
    });

    sock.ev.on('creds.update', saveCreds);

    let groupCache: Record<string, string> = {}; // jid -> name

    sock.ev.on('connection.update', async (update) => {
        const { connection, qr } = update;
        if (qr) qrcode.generate(qr, { small: true });

        if (connection === 'open') {
            console.log("\n✅ Bağlantı Başarılı! Gruplar analiz ediliyor...");
            const groups = await sock.groupFetchAllParticipating();
            
            let matchedCount = 0;
            for (const key in groups) {
                const name = (groups[key].subject || '').toLowerCase();
                if (includeKeywords.some(kw => name.includes(kw)) && !excludeKeywords.some(kw => name.includes(kw))) {
                    groupCache[key] = groups[key].subject;
                    matchedCount++;
                }
            }
            console.log(`🎯 ${matchedCount} hedef grup bulundu. 7/24 Canlı Dinleme ve Geçmiş Senkronizasyonu başlatıldı...\n`);
        }
    });

    sock.ev.on('messaging-history.set', async ({ messages }) => {
        if (!messages) return;
        console.log(`\n📚 Geçmiş senkronizasyon paketi alındı: ${messages.length} mesaj`);
        
        for (const msg of messages) {
            const jid = msg.key.remoteJid;
            if (!jid || !groupCache[jid]) continue;

            const groupName = groupCache[jid];
            
            if (!messageBuffers[jid]) {
                messageBuffers[jid] = { messages: [], timer: null, groupName };
            }

            messageBuffers[jid].messages.push(msg as WAMessage);

            if (messageBuffers[jid].timer) {
                clearTimeout(messageBuffers[jid].timer!);
            }
            
            messageBuffers[jid].timer = setTimeout(() => {
                processMessageCluster(jid, sock);
            }, 5 * 60 * 1000); // 5 dakika
        }
    });

    // Mesajlar (Geçmiş senkronizasyon ve canlı yeni mesajlar buradan akar)
    sock.ev.on('messages.upsert', async ({ messages }) => {
        for (const msg of messages) {
            const jid = msg.key.remoteJid;
            if (!jid || !groupCache[jid]) continue; // Sadece hedef gruplar

            const groupName = groupCache[jid];
            
            if (!messageBuffers[jid]) {
                messageBuffers[jid] = { messages: [], timer: null, groupName };
            }

            messageBuffers[jid].messages.push(msg);

            // 5 dakika boyunca yeni mesaj gelmezse kümeyi işle
            if (messageBuffers[jid].timer) {
                clearTimeout(messageBuffers[jid].timer!);
            }
            
            messageBuffers[jid].timer = setTimeout(() => {
                processMessageCluster(jid, sock);
            }, 5 * 60 * 1000); // 5 dakika
        }
    });
}

main();
