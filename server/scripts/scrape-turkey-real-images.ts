import { PrismaClient } from "@prisma/client";
import puppeteer from "puppeteer-extra";
import StealthPlugin from "puppeteer-extra-plugin-stealth";

puppeteer.use(StealthPlugin());

const client = new PrismaClient({
  datasources: {
    db: {
      url: process.env.DATABASE_URL_TR || "postgresql://postgres:1928@localhost:5432/realestate_tr"
    }
  }
});

async function delay(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function scrapeImagesViaDuckDuckGo(page: any, query: string) {
  const url = `https://duckduckgo.com/?q=${encodeURIComponent(query)}&t=h_&iax=images&ia=images`;
  
  console.log(`[+] DuckDuckGo üzerinden fotoğraflar aranıyor: ${query}`);
  
  await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 60000 });
  await delay(2000 + Math.random() * 1000); 

  const imageUrls = await page.evaluate(() => {
    const images = Array.from(document.querySelectorAll('img'));
    
    return images
      .map((img: any) => img.src && img.src.includes('external-content') ? img.src : (img.getAttribute('data-src') || img.src))
      .filter(src => src && src.includes('http'))
      .filter(src => !src.includes('avatar') && !src.includes('logo'))
  });

  const uniqueUrls = [...new Set(imageUrls)].slice(0, 5); 
  return uniqueUrls;
}

async function run() {
  console.log("🚀 Türkiye Projeleri İçin Yüksek Kaliteli Görsel Botu Başlıyor...");
  
  const properties = await client.property.findMany({
    where: {
      OR: [
        { name: { contains: 'Anthill', mode: 'insensitive' } },
        { name: { contains: 'Queen', mode: 'insensitive' } },
        { name: { contains: 'Bomonti', mode: 'insensitive' } }
      ]
    },
    orderBy: { updatedAt: 'asc' }, 
  });

  console.log(`🚀 HEDEF: ${properties.length} Türkiye mülkü için GERÇEK görsel istihbaratı başlıyor...\n`);

  const browser = await puppeteer.launch({ 
    headless: "new", 
    args: ['--no-sandbox', '--disable-setuid-sandbox'] 
  });
  
  const page = await browser.newPage();
  await page.setViewport({ width: 1280, height: 800 });
  
  for (const property of properties) {
    try {
      let searchQuery = "";
      if (property.name.toLowerCase().includes("anthill")) {
        searchQuery = "Anthill Residence Istanbul interior luxury";
      } else if (property.name.toLowerCase().includes("queen")) {
        searchQuery = "Queen Bomonti Istanbul residence interior";
      } else if (property.name.toLowerCase().includes("bomonti")) {
        searchQuery = "Bomonti Residences By Rotana Istanbul luxury interior";
      } else {
        searchQuery = `${property.name} Istanbul residence luxury interior`;
      }

      const photos = await scrapeImagesViaDuckDuckGo(page, searchQuery);
      
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
        console.log(`  ⚠️ Görsel bulunamadı. Proje: ${property.name}`);
      }
      
    } catch (err: any) {
      console.log(`  ❌ Hata (${property.name}): ${err.message}`);
    }
    
    await delay(500 + Math.random() * 1000);
  }
  
  console.log("✅ Operasyon tamamlandı.");
  await browser.close();
}

run().catch(console.error);
