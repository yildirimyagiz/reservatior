import 'dotenv/config';
import { Api, TelegramClient } from 'telegram';
import { StringSession } from 'telegram/sessions';
import { NewMessage, NewMessageEvent } from 'telegram/events';
// @ts-ignore
import input from 'input';
import fs from 'fs';
import path from 'path';
import { parsePropertyDetails } from '../src/lib/property-parser';

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
    console.log(`📡 Gerçek Zamanlı Dinleyici Aktif! Yeni mesajlar bekleniyor...\n`);

    let messageBuffer: any[] = [];
    let debounceTimer: NodeJS.Timeout | null = null;

    // Buffer'daki mesajları işleyen fonksiyon
    async function processBuffer() {
        if (messageBuffer.length === 0) return;

        // Buffer'ı kopyala ve temizle
        const group = [...messageBuffer];
        messageBuffer = [];

        console.log(`\n=================================================`);
        console.log(`🔔 Yeni İlan Bildirimi: ${group.length} mesajlık küme işleniyor...`);

        // Proje ismini ve detaylarını bul
        let combinedText = group.map(m => m.message || "").join('\n');
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

            fs.writeFileSync(`${baseFileName}.txt`, messageText, 'utf-8');

            if (msg.media) {
                // İndirme
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
                    console.log('');

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
            } else {
                console.log(`💬 Sadece metin: msg_${messageId}`);
            }
        }
        console.log(`✅ ${details.projectName} işlemi tamamlandı. Bekleniyor...\n`);
    }

    // Yeni mesaj geldiğinde tetiklenen event
    client.addEventHandler((event: NewMessageEvent) => {
        const msg = event.message;
        
        // Sadece hedef kanaldan gelen mesajları kabul et
        if (msg.chatId && msg.chatId.toString() === channel.entity.id.toString()) {
            messageBuffer.push(msg);
            
            // Eğer yeni bir mesaj geldiyse mevcut zamanlayıcıyı sıfırla
            if (debounceTimer) {
                clearTimeout(debounceTimer);
            }
            
            // 30 saniye boyunca yeni mesaj gelmezse buffer'daki mesajları işle
            debounceTimer = setTimeout(() => {
                processBuffer();
            }, 30000);
        }
    }, new NewMessage({}));

    // Sürekli çalışması için process'in kapanmasını engelliyoruz
    process.on('SIGINT', () => {
        console.log("🛑 Sistem kapatılıyor...");
        process.exit(0);
    });
}

main().catch(console.error);
