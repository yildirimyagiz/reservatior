import { PrismaClient } from "@prisma/client";
import fs from "fs";
import path from "path";

const trDatabaseUrl = process.env.DATABASE_URL_TR || "postgresql://postgres:1928@localhost:5432/realestate_tr";

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

const BASE_PATH = "/Users/os2026/Downloads/Reservatior/server/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL";
const UPLOADS_DIR = path.join(__dirname, "../../client/public/uploads/anthill"); // Hedef klasör (Next/Vite public)

// Klasördeki tüm dosyaları okumak için yardımcı fonksiyon
function getFilesInDir(dir: string): string[] {
  if (!fs.existsSync(dir)) return [];
  const files = fs.readdirSync(dir);
  return files
    .filter(f => f.match(/\.(jpg|jpeg|png|webp|gif)$/i))
    .map(f => path.join(dir, f));
}

// Görselleri kopyalama ve yeni URL oluşturma
function copyToPublicAndGetUrl(absolutePath: string): string {
  if (!fs.existsSync(UPLOADS_DIR)) {
    fs.mkdirSync(UPLOADS_DIR, { recursive: true });
  }
  const filename = path.basename(absolutePath);
  const destPath = path.join(UPLOADS_DIR, filename);
  
  if (!fs.existsSync(destPath)) {
    fs.copyFileSync(absolutePath, destPath);
  }
  
  return `/uploads/anthill/${filename}`;
}

async function run() {
  try {
    console.log("🚀 Anthill Yerel Görselleri Veritabanına İşleniyor...");
    await prisma.$connect();

    // 1. Görselleri Bul
    const genelGorseller = getFilesInDir(path.join(BASE_PATH, "Genel Görseller"));
    const blokA_1plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1/Fotoğraflar"));
    const blokA_2plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1/Fotoğraflar"));
    
    const blokB_1plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1/Fotoğraflar"));
    const blokB_2plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1/Fotoğraflar"));

    // Ayrıca Blok B klasörleri içindeki spesifik daire fotoğrafları (B0408, B1106 vb.)
    const blokBDirs = fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1"), { withFileTypes: true });
    let specificUnits: { unitName: string, images: string[] }[] = [];
    
    for (const d of blokBDirs) {
      if (d.isDirectory() && d.name.startsWith("B")) {
        specificUnits.push({
          unitName: d.name,
          images: getFilesInDir(path.join(BASE_PATH, `PLANLAR&Fotolar/Blok B/1+1/${d.name}`))
        });
      }
    }

    // 2. Anthill Mülklerini Veritabanından Çek
    const properties = await prisma.property.findMany({
      where: {
        OR: [
          { name: { contains: "Anthill", mode: "insensitive" } },
          { name: { contains: "Anthil", mode: "insensitive" } }
        ]
      }
    });

    console.log(`\nBulunan Toplam Anthill Dairesi: ${properties.length}`);

    for (const property of properties) {
      const isBlokA = property.name.includes(" A ") || property.name.includes("Blok A") || property.name.includes("A Blok");
      const isBlokB = property.name.includes(" B ") || property.name.includes("Blok B") || property.name.includes("B Blok");
      const is1plus1 = property.name.includes("1+1");
      const is2plus1 = property.name.includes("2+1");

      let selectedImages: string[] = [];

      // Genel Görselleri Herkese Ekle
      selectedImages.push(...genelGorseller);

      // Blok A filtrelemesi
      if (isBlokA) {
        if (is1plus1) selectedImages.push(...blokA_1plus1);
        if (is2plus1) selectedImages.push(...blokA_2plus1);
      }

      // Blok B filtrelemesi
      if (isBlokB) {
        if (is1plus1) selectedImages.push(...blokB_1plus1);
        if (is2plus1) selectedImages.push(...blokB_2plus1);
        
        // Spesifik B dairesi ise
        const match = specificUnits.find(u => property.name.includes(u.unitName));
        if (match) {
          selectedImages.push(...match.images);
        }
      }

      // Sadece tekil (unique) görselleri al
      selectedImages = [...new Set(selectedImages)];

      if (selectedImages.length > 0) {
        // Eski fotoğrafları sil
        await prisma.propertyPhoto.deleteMany({
          where: { propertyId: property.id }
        });

        // Yeni fotoğrafları oluştur (Public URL'lere dönüştürerek)
        const photoRecords = selectedImages.map((absPath, idx) => {
          const publicUrl = copyToPublicAndGetUrl(absPath);
          return {
            propertyId: property.id,
            orgId: property.orgId,
            url: publicUrl,
            isPrimary: idx === 0, // İlk genel görsel primary olur
            sortOrder: idx
          };
        });

        await prisma.propertyPhoto.createMany({
          data: photoRecords
        });

        console.log(`✅ [${property.name}] -> ${selectedImages.length} adet orijinal fotoğraf eklendi.`);
      }
    }

    console.log("\n✅ Tüm yerel Anthill klasörleri tarandı ve veritabanı başarıyla güncellendi.");

  } catch (error) {
    console.error("HATA:", error);
  } finally {
    await prisma.$disconnect();
  }
}

run();
