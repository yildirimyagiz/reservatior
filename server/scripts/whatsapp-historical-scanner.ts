import { Client, LocalAuth, Message } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';
import fs from 'fs';
import path from 'path';
import { parsePropertyDetails, isPropertyListing } from '../src/lib/property-parser';

const DOWNLOAD_MEDIA = process.env.DOWNLOAD_MEDIA === 'true';


const includeKeywords = [
    'gayrimenkul', 'emlak', 'satılık', 'kiralık', 'al-sat', 'al sat', 'al_sat', 'portföy',
    'villa', 'residence', 'konut', 'estate', 'vadi', 'inşaat', 'yapı', 'yapi',
    'bosfor', 'developer', 'yatırım', 'investment', 'arsa', 'dükkan', 'ticari',
    'proje', 'bölgesi', 'topkapı', 'offers', 'champion', 'rom group', 'object 1',
    'amlak', 'rent', 'house', 'abc', 'bahçeşehir', 'beylikdüzü', 'hayal', 'pera',
    'inistanbul', 'torunlar', 'babiller', 'mekan', 'oğuz', 'fonyap', 'dia centro', 'ghurair', 'ercan', 'suryap', 'turunç', 'dky'
];

const excludeKeywords = [
    'genel', 'elifin', 'midpoint', 'hacking', 'medrese', 'anadolu', 'antaş', 'yemek'
];

console.log("🟢 WhatsApp Geçmiş İlan Tarayıcısı Başlatılıyor...");
console.log("Tarayıcı arka planda açılıyor...");

const client = new Client({
    authStrategy: new LocalAuth({ 
        clientId: 'reservatior-whatsapp',
        dataPath: './.wwebjs_auth'
    }),
    puppeteer: {
        headless: true,
        executablePath: '/Users/os2026/Downloads/Reservatior/server/chrome/mac_arm-146.0.7680.31/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing',
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
    console.log('\n✅ WhatsApp hesabınıza bağlandı!');
    console.log(`📌 İndirme Modu: ${DOWNLOAD_MEDIA ? 'AÇIK (Medyalar indirilecek)' : 'KAPALI (Sadece envanter çıkarılacak)'}`);
    console.log('📌 Hedef gruplar bulunuyor ve geçmiş mesajlar taranıyor...\n');

    const inventoryRows: string[] = ["Ülke,Şehir,İlçe,Proje,Durum,Blok,Kat,Oda,Fiyat,Vatandaşlık,Gönderen,Telefon"];
    
    // Üyeleri toplamak için Set
    const members = new Set<string>();
    const membersPath = path.join(process.cwd(), 'data', 'members.csv');
    if (fs.existsSync(membersPath)) {
        const existingMembers = fs.readFileSync(membersPath, 'utf-8').split('\n');
        for (const m of existingMembers) {
            if (m.trim()) members.add(m.split(',')[1]?.trim() || "");
        }
    } else {
        fs.writeFileSync(membersPath, "İsim,Telefon,Grup\n", 'utf-8');
    }

    try {
        const chats = await client.getChats();
        const targetChats = chats.filter(chat => {
            if (!chat.isGroup) return false;
            const name = chat.name.toLowerCase();
            if (excludeKeywords.some(kw => name.includes(kw))) return false;
            return includeKeywords.some(kw => name.includes(kw));
        });

        if (targetChats.length === 0) {
            console.log("❌ Belirtilen gruplar bulunamadı.");
            process.exit(0);
        }

        console.log(`Toplam ${targetChats.length} adet hedef grup bulundu. Taranıyor...\n`);

        for (const chat of targetChats) {
            console.log(`\n=================================================`);
            console.log(`📱 Grup Taranıyor: ${chat.name}`);
            
            // Son 150 mesajı getir (WhatsApp Web kısıtlamalarına göre değişebilir)
            const messages = await chat.fetchMessages({ limit: 150 });
            
            if (!messages || messages.length === 0) {
                console.log(`Bu grupta mesaj bulunamadı veya çekilemedi.`);
                continue;
            }

            console.log(`Toplam ${messages.length} mesaj çekildi. Kümeleniyor...`);

            // Mesajları kronolojik sıraya diz (Eskiden yeniye)
            const chronologicalMessages = messages.sort((a, b) => a.timestamp - b.timestamp);

            const groups: Message[][] = [];
            let currentGroup: Message[] = [];
            let lastTime = 0;

            for (const msg of chronologicalMessages) {
                const msgTime = msg.timestamp; // saniye cinsinden

                if (currentGroup.length === 0) {
                    currentGroup.push(msg);
                    lastTime = msgTime;
                } else {
                    const diffMinutes = Math.abs(msgTime - lastTime) / 60;
                    if (diffMinutes <= 10) { // 10 dakika içindeki mesajları aynı ilan sayalım
                        currentGroup.push(msg);
                        lastTime = msgTime;
                    } else {
                        groups.push([...currentGroup]);
                        currentGroup = [msg];
                        lastTime = msgTime;
                    }
                }
            }
            if (currentGroup.length > 0) {
                groups.push([...currentGroup]);
            }

            console.log(`Toplam ${groups.length} farklı ilan/proje kümesi tespit edildi.`);

            for (const group of groups) {
                let combinedText = group.map(m => m.body || "").join('\n');
                const mediaCount = group.filter(m => m.hasMedia).length;

                if (!isPropertyListing(combinedText, mediaCount)) {
                    console.log(`🗑️ İlan dışı mesaj (sohbet) atlanıyor: "${combinedText.substring(0, 30).replace(/\n/g, ' ')}..."`);
                    continue;
                }

                // Proje ismini ve detaylarını bul
                const details = parsePropertyDetails(combinedText, chat.name);

                // Gönderici bilgilerini çek
                try {
                    const contact = await group[0].getContact();
                    const authorId = group[0].author || group[0].from;
                    
                    details.contactName = contact.pushname || contact.name || "Bilinmiyor";
                    
                    // Çoklu cihaz (multi-device) sorunu için ':5209' kısmını temizle
                    if (authorId) {
                        const rawId = authorId.split('@')[0]; // 905321234567:5209
                        details.contactPhone = rawId.split(':')[0]; // Sadece 905321234567
                    } else {
                        details.contactPhone = contact.number || "Bilinmiyor";
                    }

                    if (details.contactPhone !== "Bilinmiyor" && !members.has(details.contactPhone)) {
                        members.add(details.contactPhone);
                        fs.appendFileSync(membersPath, `"${details.contactName}","${details.contactPhone}","${chat.name}"\n`, 'utf-8');
                    }
                } catch (e) {
                    console.log("Gönderici bilgisi alınamadı.");
                }

                // Klasör yapısına Durum (Satılık/Kiralık) ve Timestamp ekliyoruz ki aynı projedeki farklı ilanlar birbirini ezmesin
                const listingFolder = `${details.status}_${group[0].timestamp}`;
                const projectDir = path.join(process.cwd(), 'data', details.country, details.city, details.district, details.projectName, listingFolder);
                if (!fs.existsSync(projectDir)) {
                    fs.mkdirSync(projectDir, { recursive: true });
                }

                console.log(`\n🏢 Küme İşleniyor: ${details.projectName} [${details.status}] (${group.length} mesaj)`);
                
                // Detayları JSON olarak kaydet
                fs.writeFileSync(path.join(projectDir, 'details.json'), JSON.stringify(details, null, 2), 'utf-8');

                for (const msg of group) {
                    const messageId = msg.id.id; 
                    const messageText = msg.body || "";
                    const baseFileName = path.join(projectDir, `msg_${messageId}`);

                    if (messageText) {
                        fs.writeFileSync(`${baseFileName}.txt`, messageText, 'utf-8');
                    }

                    if (msg.hasMedia) {
                        if (!DOWNLOAD_MEDIA) {
                            console.log(`👀 Medya tespit edildi ancak DOWNLOAD_MEDIA=false olduğu için atlanıyor: msg_${messageId}`);
                            continue;
                        }

                        const checkPaths = [
                            `${baseFileName}.jpg`,
                            `${baseFileName}.png`,
                            `${baseFileName}.mp4`,
                            `${baseFileName}.pdf`,
                        ];
                        const alreadyDownloaded = checkPaths.some(p => fs.existsSync(p));
                        if (alreadyDownloaded) {
                            console.log(`⏩ Atlanıyor (Zaten inmiş): msg_${messageId}`);
                            continue;
                        }

                        console.log(`⬇️ İndiriliyor: msg_${messageId}...`);
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
                    } else {
                        console.log(`💬 Sadece metin: msg_${messageId}`);
                    }
                }
                
                inventoryRows.push(`"${details.country}","${details.city}","${details.district}","${details.projectName}","${details.status}","${details.block}","${details.floor}","${details.roomType}","${details.price}","${details.citizenship}","${details.contactName}","${details.contactPhone}"`);
            }
        }

        // CSV Dosyasını Kaydet
        const inventoryPath = path.join(process.cwd(), 'data', 'inventory_whatsapp.csv');
        fs.writeFileSync(inventoryPath, inventoryRows.join('\n'), 'utf-8');
        console.log(`\n📄 Envanter raporu oluşturuldu: ${inventoryPath}`);

        console.log(`\n✅ Geçmiş tarama başarıyla tamamlandı!`);
        process.exit(0);

    } catch (error) {
        console.error("Tarama sırasında hata:", error);
        process.exit(1);
    }
});

client.initialize();
