import { PrismaClient } from "@prisma/client";
import puppeteer from "puppeteer-extra";
import StealthPlugin from "puppeteer-extra-plugin-stealth";

puppeteer.use(StealthPlugin());

const client = new PrismaClient({
  datasources: {
    db: {
      url: process.env.DATABASE_URL_US || "postgresql://postgres:1928@localhost:5432/realestate_us"
    }
  }
});

async function delay(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function scrapeImagesViaDuckDuckGo(page: any, property: any) {
  // DuckDuckGo Görsel Arama URL'si (Zillow'u arkadan dolanmak için)
  const searchQuery = `${property.addressLine1}, ${property.city}, ${property.state} real estate house interior exterior`;
  const url = `https://duckduckgo.com/?q=${encodeURIComponent(searchQuery)}&t=h_&iax=images&ia=images`;
  
  console.log(`[+] DuckDuckGo üzerinden fotoğraflar aranıyor: ${searchQuery}`);
  
  await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 });
  await delay(2000 + Math.random() * 1000); 

  // İlk çıkan görsellerin tam boyutlu URL'lerini bulmaya çalış
  const imageUrls = await page.evaluate(() => {
    // DuckDuckGo görsel sonuçlarındaki img elementleri
    const images = Array.from(document.querySelectorAll('img'));
    
    return images
      .map((img: any) => img.src && img.src.includes('external-content') ? img.src : (img.getAttribute('data-src') || img.src))
      .filter(src => src && src.includes('http'))
      .filter(src => !src.includes('avatar') && !src.includes('logo'))
  });

  // Maksimum 5 fotoğraf al
  const uniqueUrls = [...new Set(imageUrls)].slice(0, 5); 
  return uniqueUrls;
}

async function run() {
  console.log("🚀 Anti-Bot Emlak İstihbarat Scraper Botu Başlıyor (DuckDuckGo Mode)...");
  
  const properties = await client.property.findMany({
    where: {
      propertyPhotos: { none: {} } // Every property missing a real photo
    },
    orderBy: { updatedAt: 'asc' }, 
  });

  console.log(`🚀 HEDEF: ${properties.length} mülk için GERÇEK görsel istihbaratı başlıyor...\n`);

  // Headless: true yapabiliriz çünkü DuckDuckGo captcha çıkarmaz.
  // Arkada sessizce çalışsın.
  const browser = await puppeteer.launch({ 
    headless: "new", 
    args: ['--no-sandbox', '--disable-setuid-sandbox'] 
  });
  
  const page = await browser.newPage();
  await page.setViewport({ width: 1280, height: 800 });
  
  for (const property of properties) {
    try {
      const photos = await scrapeImagesViaDuckDuckGo(page, property);
      
      if (photos.length > 0) {
        console.log(`  📸 ${photos.length} gerçek fotoğraf (bypass) bulundu! Veritabanı güncelleniyor...`);
        
        await client.propertyPhoto.deleteMany({
          where: { propertyId: property.id }
        });
        
        const photoRecords = photos.map((url, idx) => ({
          propertyId: property.id,
          orgId: property.orgId,
          url: url,
          isPrimary: idx === 0,
          sortOrder: idx
        }));
        
        await client.propertyPhoto.createMany({
          data: photoRecords
        });

        await client.property.update({
          where: { id: property.id },
          data: { updatedAt: new Date() }
        });
        
      } else {
        console.log(`  ⚠️ Görsel bulunamadı. Adres: ${property.addressLine1}`);
      }
      
    } catch (err: any) {
      console.log(`  ❌ Hata (${property.addressLine1}): ${err.message}`);
    }
    
    // Bot engeli olmadığı için daha kısa bekle (1 saniye)
    await delay(500 + Math.random() * 1000);
  }
  
  console.log("✅ Operasyon tamamlandı.");
  await browser.close();
}

run().catch(console.error);
