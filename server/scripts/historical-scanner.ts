import { Client, LocalAuth, MessageMedia } from 'whatsapp-web.js';
import qrcode from 'qrcode-terminal';
import { AIGateway } from '../src/services/ai/ai-gateway';
import { BotController } from '../src/services/bot/bot-controller';
import { getRegionFromWhatsApp } from '../src/lib/country-detector';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { MediaProcessor } from '../src/services/ml/media-processor';

console.log("🔍 WhatsApp Historical Scanner Başlatılıyor...");

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

// Filtreleme kelimeleri
const RELEVANT_KEYWORDS = /(satılık|satilik|satlık|m2|fiyat|satış|satılık daire|satılık villa)/i;

client.on('qr', (qr) => {
    console.log('\n📸 Lütfen aşağıdaki QR kodunu WhatsApp ile okutun:');
    qrcode.generate(qr, { small: true });
});

client.on('ready', async () => {
    console.log("\n✅ WhatsApp'a bağlanıldı. Geçmiş mesajlar taranıyor...");
    
    try {
        const chats = await client.getChats();
        console.log(`Toplam ${chats.length} sohbet bulundu. Filtreleme başlıyor...`);

        for (const chat of chats) {
            // İsterseniz burada sadece "Emlak Grubu" gibi belirli isimli chat'leri filtreleyebilirsiniz
            // if (!chat.name.toLowerCase().includes('emlak')) continue;

            const messages = await chat.fetchMessages({ limit: 50 }); // Son 50 mesaja bak
            
            for (const msg of messages) {
                if (msg.body && RELEVANT_KEYWORDS.test(msg.body)) {
                    console.log(`\n📌 İlgili Mesaj Bulundu [${chat.name} - ${msg.from}]:`);
                    console.log(msg.body.substring(0, 100) + '...');
                    
                    let imagePart: any = null;
                    let mediaLocalPath: string | null = null;
                    let catalogType: string = 'second_hand';

                    // Eğer mesajda veya mesaj alıntılandığında fotoğraf varsa indir
                    if (msg.hasMedia) {
                        try {
                            const media = await msg.downloadMedia();
                            if (media && media.mimetype.startsWith('image/')) {
                                console.log(`📸 Fotoğraf indirildi (${media.mimetype}). ML Servisiyle analiz ediliyor...`);
                                const mlResult = await MediaProcessor.processAndCategorizeMedia(media.data, media.mimetype, msg.body);
                                catalogType = mlResult.catalogType;
                                mediaLocalPath = mlResult.localPath;
                                
                                imagePart = {
                                    inlineData: {
                                        data: media.data,
                                        mimeType: media.mimetype
                                    }
                                };
                            }
                        } catch(e) {
                            console.error("Medya indirilemedi:", e);
                        }
                    }

                    // AI Analizi
                    try {
                        let promptText = `Aşağıdaki emlak ilanı mesajını analiz et. Şehir, fiyat, para birimi, oda sayısı (beds) ve mülk tipi (propertyType) bilgilerini JSON formatında çıkar.\nMesaj: "${msg.body}"`;
                        
                        let result;
                        if (imagePart) {
                            promptText += `\nLütfen ekteki fotoğrafa da bakarak, evin durumunu (manzara, oda sayısı vb.) açıklamaya (description) ekle.`;
                            result = await model.generateContent([promptText, imagePart]);
                        } else {
                            result = await model.generateContent(promptText);
                        }

                        const jsonStr = result.response.text().replace(/```json/g, '').replace(/```/g, '').trim();
                        const parsedData = JSON.parse(jsonStr);
                        
                        console.log("🤖 AI Analizi Sonucu:", parsedData);

                        // Numaraya göre bölge tespiti yap
                        const { lang, region } = getRegionFromWhatsApp(msg.from);

                        // Veritabanına DRAFT (Taslak) olarak kaydet
                        const dbResult = await BotController.handleCreateListing({
                            city: parsedData.city || parsedData.şehir,
                            price: parsedData.price || parsedData.fiyat,
                            currency: parsedData.currency || parsedData.para_birimi,
                            beds: parsedData.beds || parsedData.oda_sayısı,
                            propertyType: parsedData.propertyType || parsedData.tip,
                            description: parsedData.description || parsedData.açıklama || msg.body
                        }, msg.from, lang, region, catalogType, mediaLocalPath ? [mediaLocalPath] : undefined);

                        console.log("💾 Veritabanı Kaydı:", dbResult.text);

                    } catch (aiError: any) {
                        console.log(`⚠️ AI ayrıştırması başarısız (Muhtemelen API Key Hatası): ${aiError.message}`);
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
