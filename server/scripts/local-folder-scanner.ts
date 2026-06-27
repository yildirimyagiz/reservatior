import fs from 'fs';
import path from 'path';
import { GoogleGenerativeAI } from '@google/generative-ai';
import { BotController } from '../src/services/bot/bot-controller';

console.log("📂 Local Folder / Cloud Drive Scanner Başlatılıyor...");

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

// Klasör yolunu parametre olarak al. Eğer parametre yoksa Mac'teki iCloud Drive yolunu varsayılan yap.
// (Google Drive için: 'Library/CloudStorage/GoogleDrive')
const ICLOUD_PATH = path.join(process.env.HOME || '', 'Library/Mobile Documents/com~apple~CloudDocs');
const targetDir = process.argv[2] || ICLOUD_PATH;

if (!fs.existsSync(targetDir)) {
    console.error(`❌ Hata: Klasör bulunamadı -> ${targetDir}`);
    console.log(`Kullanım: bun run scripts/local-folder-scanner.ts "/klasor/yolu"`);
    console.log(`Not: iCloud Drive için varsayılan yol kullanıldı. Eğer farklı bir klasör tarayacaksanız, yolunu tırnak içinde belirtin.`);
    process.exit(1);
}

const SUPPORTED_EXTENSIONS = ['.pdf', '.jpg', '.jpeg', '.png'];

async function scanDirectory(dirPath: string) {
    console.log(`\n🔍 Taranıyor: ${dirPath}`);
    const files = fs.readdirSync(dirPath);

    for (const file of files) {
        const fullPath = path.join(dirPath, file);
        const stat = fs.statSync(fullPath);

        // Alt klasörleri de tara
        if (stat.isDirectory()) {
            await scanDirectory(fullPath);
        } else {
            const ext = path.extname(file).toLowerCase();
            if (SUPPORTED_EXTENSIONS.includes(ext)) {
                console.log(`\n📌 Katalog Bulundu: ${file}`);
                await processCatalogFile(fullPath, ext);
            }
        }
    }
}

async function processCatalogFile(filePath: string, ext: string) {
    try {
        const buffer = fs.readFileSync(filePath);
        
        // Mime Type belirle
        let mimeType = 'application/pdf';
        if (ext === '.jpg' || ext === '.jpeg') mimeType = 'image/jpeg';
        if (ext === '.png') mimeType = 'image/png';

        console.log(`🤖 Gemini AI ile analiz ediliyor (${buffer.length} bytes)...`);
        
        const base64Data = buffer.toString('base64');
        const promptText = `Sen bir gayrimenkul uzmanısın. Ekteki proje kataloğunu (PDF veya Görsel) incele. İçerisinden şu bilgileri JSON formatında çıkar:
{
  "projectName": "Projenin veya kataloğun adı (Dosya adı: ${path.basename(filePath)} ipucu olabilir)",
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
                    mimeType: mimeType
                }
            }
        ]);

        const jsonStr = result.response.text().replace(/```json/g, '').replace(/```/g, '').trim();
        const parsedData = JSON.parse(jsonStr);
        
        console.log("🤖 AI Analizi Sonucu:", parsedData);

        // TR veritabanına Proje olarak kaydet
        console.log("💾 TR Veritabanına (Project) kaydediliyor...");
        // Dosya yolunu veya adını userId/source olarak kaydediyoruz ki nereden geldiği bilinsin
        const dbResult = await BotController.handleCreateProjectFromCatalog(parsedData, `local:${path.basename(filePath)}`, 'TR');
        
        console.log("✅ Sonuç:", dbResult.text);

    } catch (error: any) {
        console.log(`⚠️ Dosya işlenirken hata oluştu (${filePath}): ${error.message}`);
    }
}

// Taramayı başlat
scanDirectory(targetDir).then(() => {
    console.log("\n✅ Tüm yerel/bulut (iCloud vb.) klasör taraması tamamlandı!");
    process.exit(0);
});
