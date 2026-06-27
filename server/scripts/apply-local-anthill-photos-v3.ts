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

// B0408 (Blok B, 4. Kat, 8. Daire) -> Veritabanı NO: (Kat-1)*9 + Daire
function parseFolderToSequentialNo(folderName: string): string | null {
  const match = folderName.match(/^[AB](\d{2})(\d{2})$/);
  if (!match) return null;
  const floor = parseInt(match[1], 10);
  const apt = parseInt(match[2], 10);
  
  const no = (floor - 1) * 9 + apt;
  return no.toString();
}

async function run() {
  try {
    console.log("🚀 Anthill Yerel Görselleri İlgili Dairelere GERÇEK NO Eşleştirmesiyle Yapılıyor...");
    await prisma.$connect();

    // 1. Ortak Görselleri Bul
    const genelGorseller = getFilesInDir(path.join(BASE_PATH, "Genel Görseller"));
    const blokA_1plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1/Fotoğraflar"));
    const blokA_2plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1/Fotoğraflar"));
    
    const blokB_1plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1/Fotoğraflar"));
    const blokB_2plus1 = getFilesInDir(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1/Fotoğraflar"));

    // 2. Spesifik Daire Klasörlerini Bul
    const specificUnits: { block: string, folderName: string, mappedNo: string, images: string[] }[] = [];
    
    const aDirs1 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1"), { withFileTypes: true }) : [];
    const aDirs2 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1"), { withFileTypes: true }) : [];
    const bDirs1 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1"), { withFileTypes: true }) : [];
    const bDirs2 = fs.existsSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1")) ? fs.readdirSync(path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1"), { withFileTypes: true }) : [];

    const processSpecificDirs = (dirs: fs.Dirent[], blockPath: string, blockName: string) => {
      for (const d of dirs) {
        if (d.isDirectory() && d.name.match(/^[AB]\d{4}$/)) {
          const mappedNo = parseFolderToSequentialNo(d.name);
          if (mappedNo) {
            specificUnits.push({
              block: blockName,
              folderName: d.name,
              mappedNo,
              images: getFilesInDir(path.join(blockPath, d.name))
            });
          }
        }
      }
    };

    processSpecificDirs(aDirs1, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/1+1"), "A");
    processSpecificDirs(aDirs2, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok A/2+1"), "A");
    processSpecificDirs(bDirs1, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/1+1"), "B");
    processSpecificDirs(bDirs2, path.join(BASE_PATH, "PLANLAR&Fotolar/Blok B/2+1"), "B");

    console.log("📌 Çözümlenen Spesifik Daireler:");
    for (const u of specificUnits) {
      console.log(`- Klasör: ${u.folderName} -> Hedef Daire NO: ${u.mappedNo} (${u.images.length} görsel)`);
    }

    // 3. Veritabanından Çek
    const properties = await prisma.property.findMany({
      where: {
        OR: [
          { name: { contains: "Anthill", mode: "insensitive" } },
          { name: { contains: "Anthil", mode: "insensitive" } }
        ]
      }
    });

    let exactMatches = 0;

    for (const property of properties) {
      const isBlokA = property.name.includes(" A ") || property.name.includes("Blok A") || property.name.includes("A Blok");
      const isBlokB = property.name.includes(" B ") || property.name.includes("Blok B") || property.name.includes("B Blok");
      const is1plus1 = property.name.includes("1+1");
      const is2plus1 = property.name.includes("2+1");

      const unitNumberMatch = property.name.match(/Daire\s*(\d+)/i);
      const propertyUnitNumber = unitNumberMatch ? unitNumberMatch[1] : null;

      let selectedImages: string[] = [];

      // Spesifik eşleşme kontrolü (Mapped NO üzerinden)
      const specificMatch = specificUnits.find(u => 
        (isBlokA && u.block === "A" && u.mappedNo === propertyUnitNumber) ||
        (isBlokB && u.block === "B" && u.mappedNo === propertyUnitNumber)
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

      // Varsa spesifik fotoğrafları en başa al
      if (specificMatch && specificMatch.images.length > 0) {
        selectedImages = [...specificMatch.images, ...selectedImages];
        console.log(`🎯 TAM İSABET: [${property.name}] dairesine klasöründen (${specificMatch.folderName}) ${specificMatch.images.length} özel görsel eklendi.`);
        exactMatches++;
      }

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
            isPrimary: idx === 0,
            sortOrder: idx
          };
        });

        await prisma.propertyPhoto.createMany({
          data: photoRecords
        });
      }
    }

    console.log(`\n✅ İşlem tamamlandı. Toplam ${exactMatches} adet daireye kendi "spesifik" klasöründen nokta atışı fotoğrafları atandı.`);

  } catch (error) {
    console.error("HATA:", error);
  } finally {
    await prisma.$disconnect();
  }
}

run();
