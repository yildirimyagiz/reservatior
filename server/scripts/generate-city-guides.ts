import { prisma } from "../src/lib/prisma";
import { AIBlogGenerator } from "../src/services/ai/ai-blog-generator";

const CATEGORIES = [
  "Gezilecek Yerler ve Sosyal Hayat",
  "Yazlık Ev Almak İçin Nedenler ve Yatırım Fırsatları",
  "Ulaşım Ağı ve Yeni Gelişen Yaşam Alanları",
  "Öğrenciler ve Genç Profesyoneller İçin Yaşam Maliyeti",
  "Emlak Piyasası ve Kira Getirisi Analizi",
  "Aileler İçin Sosyal Olanaklar ve Okullar"
];

async function run() {
  const admin = await prisma.user.findFirst();
  if (!admin) {
    console.log("No users in database. Cannot create a post.");
    return;
  }

  // 1. Veritabanından tüm benzersiz lokasyonları (Şehir/Ülke) çekelim
  const locations = await prisma.location.findMany({
    select: {
      city: true,
      state: true,
      country: true
    },
    distinct: ['city', 'country']
  });

  if (locations.length === 0) {
    console.log("Sistemde hiç lokasyon bulunamadı. Lütfen önce mülk ekleyin.");
    return;
  }

  console.log(`Toplam ${locations.length} farklı lokasyon bulundu. Blog üretimi başlıyor...`);

  // 2. Her lokasyon için rastgele bir kategoride blog yazısı üret
  for (const loc of locations) {
    // Örnek Format: "Kadıköy, İstanbul, Türkiye" veya "New York, USA"
    const locationString = [loc.city, loc.state, loc.country].filter(Boolean).join(", ");
    
    // Rastgele kategori seç
    const randomCategory = CATEGORIES[Math.floor(Math.random() * CATEGORIES.length)];
    
    console.log(`İşleniyor: ${locationString} -> ${randomCategory}`);
    try {
      // Not: Yüksek hacimli üretimlerde Gemini Rate Limit (Kota) aşımını engellemek için gecikme eklenmeli.
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      const post = await AIBlogGenerator.generateAndSaveGuide(locationString, randomCategory, admin.id);
      console.log(`✔ Başarılı: ${post.title}`);
    } catch (e) {
      console.error(`X Hata (${locationString}):`, e);
    }
  }
  
  console.log("Tüm lokasyonlar için blog üretim süreci tamamlandı.");
}

run().catch(console.error).finally(() => process.exit(0));
