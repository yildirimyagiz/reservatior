import { Client, LocalAuth } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { BotController } from '../src/services/bot/bot-controller';

console.log("🔍 WhatsApp Google Drive Scanner Başlatılıyor...");

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

const client = new Client({
    authStrategy: new LocalAuth({ 
        clientId: 'reservatior-whatsapp',
        dataPath: './.wwebjs_auth'
    }),
    puppeteer: {
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    }
});

// Regex to find Google Drive file links
const GDRIVE_REGEX = /https?:\/\/(?:drive|docs)\.google\.com\/(?:file\/d\/|open\?id=|document\/d\/|presentation\/d\/|spreadsheets\/d\/)([a-zA-Z0-9_-]+)/i;

client.on('qr', (qr) => {
    console.log('\n📸 Lütfen aşağıdaki QR kodunu WhatsApp ile okutun:');
    qrcode.generate(qr, { small: true });
});

client.on('ready', async () => {
    console.log("\n✅ WhatsApp'a bağlanıldı. Geçmiş mesajlar Drive linkleri için taranıyor...");
    
    try {
        const chats = await client.getChats();
        console.log(`Toplam ${chats.length} sohbet bulundu. Tarama başlıyor...`);

        for (const chat of chats) {
            const messages = await chat.fetchMessages({ limit: 50 });
            
            for (const msg of messages) {
                if (msg.body && GDRIVE_REGEX.test(msg.body)) {
                    const match = msg.body.match(GDRIVE_REGEX);
                    if (match && match[1]) {
                        const fileId = match[1];
                        console.log(`\n📌 Google Drive Linki Bulundu [${chat.name} - ${msg.from}]:`);
                        console.log(`Link: ${match[0]}`);
                        console.log(`File ID: ${fileId}`);
                        
                        try {
                            console.log(`⬇️ Dosya indiriliyor (Public Link varsayılıyor)...`);
                            // Download using public export link
                            const downloadUrl = `https://drive.google.com/uc?export=download&id=${fileId}`;
                            const response = await fetch(downloadUrl);
                            
                            if (!response.ok) {
                                console.log(`⚠️ İndirme başarısız: ${response.statusText}`);
                                continue;
                            }
                            
                            const arrayBuffer = await response.arrayBuffer();
                            const buffer = Buffer.from(arrayBuffer);
                            
                            const contentType = response.headers.get('content-type') || 'application/pdf';
                            
                            // Eğer Google virüs taraması HTML sayfasına atarsa, direkt geçelim (büyük dosyalar için bypass gerekebilir)
                            if (contentType.includes('text/html')) {
                                console.log(`⚠️ Google Drive HTML uyarı sayfası döndürdü (Dosya boyutu büyük olabilir). AI analizi atlanıyor.`);
                                continue;
                            }

                            console.log(`📄 İndirildi: ${buffer.length} bytes, Tür: ${contentType}`);
                            
                            // Convert to Base64 for Gemini
                            const base64Data = buffer.toString('base64');
                            
                            console.log(`🤖 Gemini AI ile analiz ediliyor...`);
                            const promptText = `Sen bir gayrimenkul uzmanısın. Ekteki proje kataloğunu (PDF veya Görsel) incele. İçerisinden şu bilgileri JSON formatında çıkar:
{
  "projectName": "Projenin veya kataloğun adı",
  "description": "Projenin genel açıklaması ve özellikleri",
  "address": "Konum, şehir veya mahalle bilgisi",
  "projectType": "RESIDENTIAL veya COMMERCIAL"
}
Sadece geçerli bir JSON döndür. Başka bir metin ekleme.`;
                            
                            const result = await model.generateContent([
                                promptText, 
                                {
                                    inlineData: {
                                        data: base64Data,
                                        mimeType: contentType
                                    }
                                }
                            ]);

                            const jsonStr = result.response.text().replace(/```json/g, '').replace(/```/g, '').trim();
                            const parsedData = JSON.parse(jsonStr);
                            
                            console.log("🤖 AI Analizi Sonucu:", parsedData);

                            // TR veritabanına Proje olarak kaydet
                            console.log("💾 TR Veritabanına (Project) kaydediliyor...");
                            const dbResult = await BotController.handleCreateProjectFromCatalog(parsedData, msg.from, 'TR');
                            
                            console.log("✅ Sonuç:", dbResult.text);

                        } catch (error: any) {
                            console.log(`⚠️ Hata oluştu: ${error.message}`);
                        }
                    }
                }
            }
        }
        
        console.log("\n✅ Tarama tamamlandı!");
        process.exit(0);
        
    } catch (err) {
        console.error("Tarama sırasında hata:", err);
        process.exit(1);
    }
});

client.initialize();
