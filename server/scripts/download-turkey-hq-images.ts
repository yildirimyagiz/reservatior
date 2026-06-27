import puppeteer from "puppeteer-extra";
import StealthPlugin from "puppeteer-extra-plugin-stealth";
import fs from "fs";
import path from "path";
import https from "https";

puppeteer.use(StealthPlugin());

const BASE_DATA_DIR = path.resolve(__dirname, "../data/TURKİYE/ISTANBUL/SİSLİ");

const PROJECTS = [
  {
    name: "Anthill",
    query: "Anthill Residence Istanbul Bomonti luxury interior exterior",
    saveDir: path.join(BASE_DATA_DIR, "CUMHURİYET MAH", "ANTHİLL", "Genel Görseller", "HQ_Updates")
  },
  {
    name: "Queen",
    query: "Queen Bomonti Istanbul residence luxury interior",
    saveDir: path.join(BASE_DATA_DIR, "CUMHURİYET MAH", "Queen", "Görseller", "HQ_Updates")
  },
  {
    name: "Bomonti Residences",
    query: "Bomonti Residences By Rotana Istanbul luxury interior",
    saveDir: path.join(BASE_DATA_DIR, "Merkez Mahallesi", "Bomonti Residences By Rotana", "Dış görseller", "HQ_Updates")
  }
];

async function delay(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function downloadImage(url: string, filepath: string): Promise<boolean> {
  return new Promise((resolve) => {
    https.get(url, (res) => {
      if (res.statusCode === 200) {
        const fileStream = fs.createWriteStream(filepath);
        res.pipe(fileStream);
        fileStream.on('finish', () => {
          fileStream.close();
          resolve(true);
        });
      } else {
        res.resume();
        resolve(false);
      }
    }).on('error', () => {
      resolve(false);
    });
  });
}

async function scrapeImagesViaDuckDuckGo(page: any, query: string) {
  const url = `https://duckduckgo.com/?q=${encodeURIComponent(query)}&t=h_&iax=images&ia=images`;
  
  console.log(`[+] DuckDuckGo üzerinden aranıyor: ${query}`);
  
  await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 });
  await delay(3000 + Math.random() * 1000); 

  const imageUrls = await page.evaluate(() => {
    const images = Array.from(document.querySelectorAll('img'));
    return images
      .map((img: any) => img.src && img.src.includes('external-content') ? img.src : (img.getAttribute('data-src') || img.src))
      .filter(src => src && src.includes('http'))
      .filter(src => !src.includes('avatar') && !src.includes('logo'))
  });

  const uniqueUrls = [...new Set(imageUrls)].slice(0, 8); 
  return uniqueUrls;
}

async function run() {
  console.log("🚀 Türkiye Projeleri (Anthill, Queen, Bomonti) için Yüksek Kaliteli Görsel Güncelleme Botu Başlıyor...");
  
  const browser = await puppeteer.launch({ 
    headless: "new", 
    args: ['--no-sandbox', '--disable-setuid-sandbox'] 
  });
  
  const page = await browser.newPage();
  await page.setViewport({ width: 1280, height: 800 });
  
  for (const project of PROJECTS) {
    try {
      console.log(`\n▶ İşlenen Proje: ${project.name}`);
      
      if (!fs.existsSync(project.saveDir)) {
        fs.mkdirSync(project.saveDir, { recursive: true });
      }

      const photos = await scrapeImagesViaDuckDuckGo(page, project.query);
      
      if (photos.length > 0) {
        console.log(`  📸 ${photos.length} görsel bulundu. İndiriliyor...`);
        
        let downloadedCount = 0;
        for (let i = 0; i < photos.length; i++) {
          const url = photos[i] as string;
          const ext = url.includes('.png') ? '.png' : '.jpg';
          const filename = `hq_${project.name.toLowerCase()}_${i + 1}${ext}`;
          const filepath = path.join(project.saveDir, filename);
          
          const success = await downloadImage(url, filepath);
          if (success) {
            downloadedCount++;
          }
        }
        console.log(`  ✅ ${downloadedCount} görsel başarıyla ${project.saveDir} klasörüne kaydedildi.`);
      } else {
        console.log(`  ⚠️ Görsel bulunamadı.`);
      }
      
    } catch (err: any) {
      console.log(`  ❌ Hata (${project.name}): ${err.message}`);
    }
    
    await delay(1000 + Math.random() * 1000);
  }
  
  console.log("\n✅ Tüm operasyonlar tamamlandı.");
  await browser.close();
}

run().catch(console.error);
