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
const UPLOADS_DIR = path.join(__dirname, "../../client/public/uploads/anthill");

function getFilesInDir(dir: string): string[] {
  if (!fs.existsSync(dir)) return [];
  const files = fs.readdirSync(dir);
  return files
    .filter(f => f.match(/\.(jpg|jpeg|png|webp|gif)$/i))
    .map(f => path.join(dir, f));
}

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
    console.log("🚀 Anthill Yerel Görselleri İlgili Dairelere Spesifik Olarak Eşleştiriliyor...");
    await prisma.$connect();

    // 1. Ortak Görselleri Bul
    const genelGorseller = getFilesInDir(path.join(BASE_PATH, "Genel Görseller"));
    const blokA_1plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1/Fotoğraflar"));
    const blokA_2plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1/Fotoğraflar"));
    
    const blokB_1plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1/Fotoğraflar"));
    const blokB_2plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1/Fotoğraflar"));

    // 2. Spesifik Daire Klasörlerini Bul
    const specificUnits: { block: string, unitNumber: string, images: string[] }[] = [];
    
    // A Blok
    const aDirs1 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1"), { withFileTypes: true }) : [];
    const aDirs2 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1"), { withFileTypes: true }) : [];
    
    // B Blok
    const bDirs1 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1"), { withFileTypes: true }) : [];
    const bDirs2 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1"), { withFileTypes: true }) : [];

    const processSpecificDirs = (dirs: fs.Dirent[], blockPath: string, blockName: string) => {
      for (const d of dirs) {
        if (d.isDirectory() && d.name.match(/^[AB]\d+/)) {
          const unitNumber = parseInt(d.name.replace(/\D/g, ""), 10).toString(); // B0408 -> 408
          specificUnits.push({
            block: blockName,
            unitNumber: unitNumber,
            images: getFilesInDir(path.join(blockPath, d.name))
          });
        }
      }
    };

    processSpecificDirs(aDirs1, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1"), "A");
    processSpecificDirs(aDirs2, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1"), "A");
    processSpecificDirs(bDirs1, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1"), "B");
    processSpecificDirs(bDirs2, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1"), "B");

    console.log(`Bulunan spesifik daire klasörleri: ${specificUnits.map(u => u.block + u.unitNumber).join(", ")}`);

    // 3. Veritabanından Çek
    const properties = await prisma.property.findMany({
      where: {
        OR: [
          { name: { contains: "Anthill", mode: "insensitive" } },
          { name: { contains: "Anthil", mode: "insensitive" } }
        ]
      }
    });

    for (const property of properties) {
      const isBlokA = property.name.includes(" A ") || property.name.includes("Blok A") || property.name.includes("A Blok");
      const isBlokB = property.name.includes(" B ") || property.name.includes("Blok B") || property.name.includes("B Blok");
      const is1plus1 = property.name.includes("1+1");
      const is2plus1 = property.name.includes("2+1");

      // Daire numarasını property isminden bul: "Anthill B Blok - Daire 408" -> "408"
      const unitNumberMatch = property.name.match(/Daire\s*(\d+)/i);
      const propertyUnitNumber = unitNumberMatch ? unitNumberMatch[1] : null;

      let selectedImages: string[] = [];

      // Sadece o daireye spesifik klasör var mı kontrol et
      const specificMatch = specificUnits.find(u => 
        (isBlokA && u.block === "A" && u.unitNumber === propertyUnitNumber) ||
        (isBlokB && u.block === "B" && u.unitNumber === propertyUnitNumber)
      );

      // Genel ve blok fotoğraflarını daima ekle
      selectedImages.push(...genelGorseller);

      if (isBlokA) {
        if (is1plus1) selectedImages.push(...blokA_1plus1);
        if (is2plus1) selectedImages.push(...blokA_2plus1);
      }

      if (isBlokB) {
        if (is1plus1) selectedImages.push(...blokB_1plus1);
        if (is2plus1) selectedImages.push(...blokB_2plus1);
      }

      // Varsa spesifik fotoğrafları en başa al (veya sonuna ekle)
      if (specificMatch && specificMatch.images.length > 0) {
        // Spesifik resimler çok önemli olduğu için öncelikli (veya onlara ayrı etiket vs verilebilir)
        // En başa ekliyorum ki primary görsel olma ihtimali yüksek olsun.
        selectedImages = [...specificMatch.images, ...selectedImages];
        console.log(`🎯 SPESİFİK EŞLEŞME: [${property.name}] dairesine ${specificMatch.images.length} adet özel görsel atandı.`);
      }

      // Sadece tekil (unique) görselleri al
      selectedImages = [...new Set(selectedImages)];

      if (selectedImages.length > 0) {
        await prisma.propertyPhoto.deleteMany({
          where: { propertyId: property.id }
        });

        const photoRecords = selectedImages.map((absPath, idx) => {
          const publicUrl = copyToPublicAndGetUrl(absPath);
          return {
            propertyId: property.id,
            orgId: property.orgId,
            url: publicUrl,
            isPrimary: idx === 0, // Eğer spesifik görsel varsa, o primary olacak.
            sortOrder: idx
          };
        });

        await prisma.propertyPhoto.createMany({
          data: photoRecords
        });
      }
    }

    console.log("\n✅ Tüm daireler spesifik görselleriyle beraber başarıyla güncellendi.");

  } catch (error) {
    console.error("HATA:", error);
  } finally {
    await prisma.$disconnect();
  }
}

run();
