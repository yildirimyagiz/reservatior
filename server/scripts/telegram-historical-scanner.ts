import 'dotenv/config';
import { Api, TelegramClient } from 'telegram';
import { StringSession } from 'telegram/sessions';
// @ts-ignore
import input from 'input';
import fs from 'fs';
import path from 'path';
import { parsePropertyDetails, isPropertyListing } from '../src/lib/property-parser';

const DOWNLOAD_MEDIA = process.env.DOWNLOAD_MEDIA === 'true';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { BotController } from '../src/services/bot/bot-controller';

const apiId = process.env.TELEGRAM_API_ID ? parseInt(process.env.TELEGRAM_API_ID) : 0;
const apiHash = process.env.TELEGRAM_API_HASH || '';

if (!apiId || !apiHash) {
    console.error("❌ HATA: TELEGRAM_API_ID veya TELEGRAM_API_HASH bulunamadı!");
    console.error("Lütfen .env dosyanıza bu değerleri ekleyin. (https://my.telegram.org adresinden alabilirsiniz)");
    process.exit(1);
}

const SESSION_FILE = './.telegram_session';
let sessionString = '';
if (fs.existsSync(SESSION_FILE)) {
    sessionString = fs.readFileSync(SESSION_FILE, 'utf-8');
}

const stringSession = new StringSession(sessionString);
const client = new TelegramClient(stringSession, apiId, apiHash, {
    connectionRetries: 5,
});


async function main() {
    console.log("🔍 Telegram Historical Scanner Başlatılıyor...");
    
    await client.start({
        phoneNumber: async () => await input.text('Lütfen telefon numaranızı girin (Uluslararası formatta, örn: +90532...): '),
        password: async () => await input.text('Eğer İki Adımlı Doğrulama (2FA) varsa şifrenizi girin: '),
        phoneCode: async () => await input.text('Telegramdan gelen onay kodunu girin: '),
        onError: (err) => console.log(err),
    });

    console.log("✅ Telegram'a başarıyla bağlanıldı!");
    
    // Oturumu kaydet (Böylece her seferinde kod sormaz)
    fs.writeFileSync(SESSION_FILE, client.session.save() as unknown as string);

    const dialogs = await client.getDialogs({});
    
    // Aramak istediğiniz kanal adı
    const targetChannelName = 'tramend resale';
    const channel = dialogs.find(d => d.title?.toLowerCase().includes(targetChannelName));

    if (!channel) {
        console.error(`❌ '${targetChannelName}' isminde bir sohbet veya kanal bulunamadı.`);
        process.exit(1);
    }

    console.log(`📌 Hedef Kanal Bulundu: ${channel.title} (ID: ${channel.id})`);
    console.log(`📌 İndirme Modu: ${DOWNLOAD_MEDIA ? 'AÇIK (Medyalar indirilecek)' : 'KAPALI (Sadece envanter çıkarılacak)'}`);
    console.log(`Geçmiş mesajlar taranıyor...`);
    
    const inventoryRows: string[] = ["Ülke,Şehir,İlçe,Proje,Blok,Kat,Oda,Fiyat,Vatandaşlık"];

    // Son 50 mesajı al (Bu sayıyı ihtiyacınıza göre artırabilirsiniz)
    const messages = await client.getMessages(channel.entity, { limit: 50 });

    console.log(`Toplam ${messages.length} mesaj bulundu. İşleniyor...`);

    // Telegram API mesajları yeniden eskiye verir. Biz eskiden yeniye (kronolojik) işleyelim
    const chronologicalMessages = messages.reverse();

    // 1. AŞAMA: Mesajları zamana göre kümelere (listing/proje) ayır
    // Peş peşe atılan mesajlar (örneğin 3 dakika içinde atılanlar) aynı proje kabul edilir.
    const groups: any[][] = [];
    let currentGroup: any[] = [];
    let lastMsgDate = 0;

    for (const msg of chronologicalMessages) {
        if (!msg.message && !msg.media) continue;

        if (currentGroup.length === 0) {
            currentGroup.push(msg);
            lastMsgDate = msg.date;
        } else {
            // Eğer aradaki fark 3 dakikadan (180 saniye) az ise aynı gruba ekle
            if (msg.date - lastMsgDate < 180) {
                currentGroup.push(msg);
            } else {
                groups.push(currentGroup);
                currentGroup = [msg];
            }
            lastMsgDate = msg.date;
        }
    }
    if (currentGroup.length > 0) {
        groups.push(currentGroup);
    }

    console.log(`\nToplam ${groups.length} farklı ilan/proje kümesi tespit edildi.`);

    // 2. AŞAMA: Kümeleri işle ve indir
    for (const group of groups) {
        console.log(`\n=================================================`);
        console.log(`🏢 Küme İşleniyor: ${group.length} mesaj`);

        // Proje ismini ve detaylarını bul
        let combinedText = group.map(m => m.message || "").join('\n');
        const mediaCount = group.filter(m => m.media).length;

        if (!isPropertyListing(combinedText, mediaCount)) {
            console.log(`🗑️ İlan dışı mesaj (sohbet) atlanıyor: "${combinedText.substring(0, 30).replace(/\n/g, ' ')}..."`);
            continue;
        }

        const details = parsePropertyDetails(combinedText, channel.title || "");

        const projectDir = path.join(process.cwd(), 'data', details.country, details.city, details.district, details.projectName);
        if (!fs.existsSync(projectDir)) {
            fs.mkdirSync(projectDir, { recursive: true });
        }

        console.log(`🏢 Klasör: ${projectDir}`);

        // Detayları JSON olarak kaydet
        fs.writeFileSync(path.join(projectDir, 'details.json'), JSON.stringify(details, null, 2), 'utf-8');

        for (const msg of group) {
            const messageId = msg.id;
            const messageText = msg.message || "";
            const baseFileName = path.join(projectDir, `msg_${messageId}`);

            // Text'i kaydet (hızlı olduğu için hep üstüne yazabiliriz)
            fs.writeFileSync(`${baseFileName}.txt`, messageText, 'utf-8');

            if (msg.media) {
                if (!DOWNLOAD_MEDIA) {
                    console.log(`👀 Medya tespit edildi ancak DOWNLOAD_MEDIA=false olduğu için atlanıyor: msg_${messageId}`);
                    continue;
                }

                // Zaten inmiş mi kontrol et
                const filesInDir = fs.readdirSync(projectDir);
                const isAlreadyDownloaded = filesInDir.some(f => f.startsWith(`msg_${messageId}.`) && !f.endsWith('.txt'));

                if (isAlreadyDownloaded) {
                    console.log(`⏩ Atlanıyor (Zaten inmiş): msg_${messageId}`);
                } else {
                    console.log(`⬇️ İndiriliyor: msg_${messageId}...`);
                    try {
                        let mimeType = 'image/jpeg';
                        const mediaBuffer = await client.downloadMedia(msg.media, {
                            progressCallback: (downloaded: any, total: any) => {
                                if (total) {
                                    const percent = Math.round((Number(downloaded) / Number(total)) * 100);
                                    process.stdout.write(`\r⏳ %${percent}  (${Number(downloaded)}/${Number(total)} bytes)`);
                                }
                            }
                        }) as Buffer;
                        console.log(''); // Yeni satıra geç

                        if (mediaBuffer) {
                            if (msg.media.className === 'MessageMediaDocument' && msg.media.document) {
                                mimeType = msg.media.document.mimeType || mimeType;
                            } else if (msg.media.className === 'MessageMediaPhoto') {
                                mimeType = 'image/jpeg';
                            }

                            let ext = '.bin';
                            if (mimeType.includes('jpeg') || mimeType.includes('jpg')) ext = '.jpg';
                            else if (mimeType.includes('png')) ext = '.png';
                            else if (mimeType.includes('pdf')) ext = '.pdf';
                            else if (mimeType.includes('mp4') || mimeType.includes('video')) ext = '.mp4';
                            
                            const mediaPath = `${baseFileName}${ext}`;
                            fs.writeFileSync(mediaPath, mediaBuffer);
                            console.log(`💾 Kaydedildi: msg_${messageId}${ext}`);
                        }
                    } catch (e) {
                        console.error(`❌ İndirme hatası: msg_${messageId}`, e);
                    }
                }
            } else {
                console.log(`💬 Sadece metin: msg_${messageId}`);
            }
        }
        
        inventoryRows.push(`"${details.country}","${details.city}","${details.district}","${details.projectName}","${details.block}","${details.floor}","${details.roomType}","${details.price}","${details.citizenship}"`);
    }

    // CSV Dosyasını Kaydet
    const inventoryPath = path.join(process.cwd(), 'data', 'inventory_telegram.csv');
    fs.writeFileSync(inventoryPath, inventoryRows.join('\n'), 'utf-8');
    console.log(`\n📄 Envanter raporu oluşturuldu: ${inventoryPath}`);

    console.log("\n✅ Tarama tamamlandı!");
    process.exit(0);
}

main().catch(console.error);
