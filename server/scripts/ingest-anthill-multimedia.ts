import { PrismaClient } from '@prisma/client';
import fs from 'fs';
import path from 'path';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';
const prisma = new PrismaClient({ datasources: { db: { url: trDatabaseUrl } } });

const BASE_DIR = path.join(__dirname, '../data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET MAH/ANTHİLL');
const URL_PREFIX = '/data/TURKİYE/ISTANBUL/SİSLİ/CUMHURİYET%20MAH/ANTHİLL';

async function walkDir(dir: string, fileList: string[] = []) {
  if (!fs.existsSync(dir)) return fileList;
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      await walkDir(filePath, fileList);
    } else {
      fileList.push(filePath);
    }
  }
  return fileList;
}

async function main() {
  await prisma.$connect();
  const properties = await prisma.$queryRaw<any[]>`SELECT id, "orgId" FROM "Property" WHERE id ILIKE '%anthill%' OR name ILIKE '%anthill%'`;
  if (properties.length === 0) return;

  const allFiles = await walkDir(BASE_DIR);
  
  const genPhotos: string[] = [];
  const floorPlanImages: string[] = [];
  const videos: string[] = [];

  for (const f of allFiles) {
    if (f.includes('.DS_Store')) continue;
    const ext = path.extname(f).toLowerCase();
    const relPath = path.relative(BASE_DIR, f);
    const url = `${URL_PREFIX}/${relPath.split(path.sep).map(encodeURIComponent).join('/')}`;
    
    if (f.includes('Genel Görseller') && ['.jpg', '.png', '.jpeg', '.webp'].includes(ext)) {
      genPhotos.push(url);
    } else if (['.mov', '.mp4'].includes(ext)) {
      videos.push(url);
    } else if ((f.includes('PLANLAR') || f.includes('Kat Planları')) && !f.includes('Videolar') && ['.jpg', '.png', '.jpeg'].includes(ext)) {
      floorPlanImages.push(url);
    }
  }

  const targetProperties = properties.slice(0, 15);
  for (const prop of targetProperties) {
    await prisma.propertyPhoto.deleteMany({ where: { propertyId: prop.id } });
    await prisma.floorPlan.deleteMany({ where: { propertyId: prop.id } });
    await prisma.videoContent.deleteMany({ where: { propertyId: prop.id } });
    
    for (let i = 0; i < genPhotos.length; i++) {
      await prisma.propertyPhoto.create({
        data: {
          id: `photo_${prop.id}_${i}`,
          orgId: prop.orgId,
          propertyId: prop.id,
          url: genPhotos[i],
          isPrimary: i === 0,
          sortOrder: i
        }
      });
    }

    for (let i = 0; i < floorPlanImages.length; i++) {
      await prisma.floorPlan.create({
        data: {
          id: `fp_${prop.id}_${i}`,
          orgId: prop.orgId,
          propertyId: prop.id,
          name: `Floor Plan ${i+1}`,
          imageUrl: floorPlanImages[i],
          floorLevel: 1,
        }
      });
    }

    for (let i = 0; i < videos.length; i++) {
      await prisma.videoContent.create({
        data: {
          id: `vid_${prop.id}_${i}`,
          orgId: prop.orgId,
          propertyId: prop.id,
          title: `Virtual Tour ${i+1}`,
          url: videos[i],
          status: 'PUBLISHED',
          platform: 'INSTAGRAM_REELS',
          primaryLoraStyle: 'FILM_NOIR',
          prompt: 'Virtual tour inside the property',
          durationSeconds: 60,
          mimeType: videos[i].endsWith('.mp4') ? 'video/mp4' : 'video/quicktime'
        }
      });
    }
    console.log(`Updated ${prop.id}`);
  }
}

main().catch(console.error).finally(() => prisma.$disconnect());
