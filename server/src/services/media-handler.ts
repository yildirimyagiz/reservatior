/**
 * Media Handler Service
 *
 * Processes and stores property media: photos, floor plans, videos, documents.
 * Copies files to uploads directory and creates database records.
 */
import prismaManager from '../lib/prisma';
import * as fs from 'fs';
import * as path from 'path';

// ─── Types ──────────────────────────────────────────────────────────────────

export interface MediaImportConfig {
  orgId: string;
  propertyId: string;
  projectId?: string;
  sourceDir: string;
  uploadBase: string;
  projectName: string;
  region?: string;
}

export interface MediaResult {
  photos: number;
  floorPlans: number;
  videos: number;
  documents: number;
  errors: string[];
}

// ─── File Helpers ───────────────────────────────────────────────────────────

const IMAGE_EXTENSIONS = ['.jpg', '.jpeg', '.png', '.webp', '.gif'];
const VIDEO_EXTENSIONS = ['.mp4', '.mov', '.avi', '.mkv', '.webm'];
const DOC_EXTENSIONS = ['.pdf', '.doc', '.docx'];

function ensureDir(dir: string) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
}

function copyFile(src: string, dest: string): void {
  ensureDir(path.dirname(dest));
  fs.copyFileSync(src, dest);
}

// ─── Photo Import ───────────────────────────────────────────────────────────

async function importPhotos(config: MediaImportConfig, result: MediaResult): Promise<void> {
  const prisma = prismaManager.getClient(config.region || 'TR');
  const photoDirs = ['fotograflar', 'dis-mekan', 'ic-mekan', 'pictures', 'photos'];

  for (const dirName of photoDirs) {
    const dir = path.join(config.sourceDir, dirName);
    if (!fs.existsSync(dir)) continue;

    const files = fs.readdirSync(dir).filter(f => {
      const ext = path.extname(f).toLowerCase();
      return IMAGE_EXTENSIONS.includes(ext);
    });

    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const srcPath = path.join(dir, file);
      const destDir = path.join(config.uploadBase, config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-'), 'photos');
      const destPath = path.join(destDir, file);

      try {
        copyFile(srcPath, destPath);
        const photoId = `photo_${config.propertyId}_${Date.now()}_${i}`;
        const relativePath = `/uploads/projects/${config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-')}/photos/${file}`;

        await prisma.propertyPhoto.upsert({
          where: { id: photoId },
          update: {},
          create: {
            id: photoId,
            orgId: config.orgId,
            propertyId: config.propertyId,
            url: relativePath,
            caption: file.replace(/\.[^.]+$/, '').replace(/[-_]/g, ' '),
            isPrimary: i === 0 && dirName === photoDirs[0],
            sortOrder: i,
          },
        });
        result.photos++;
      } catch (e: any) {
        result.errors.push(`Photo ${file}: ${e.message}`);
      }
    }
  }
}

// ─── Floor Plan Import ──────────────────────────────────────────────────────

async function importFloorPlans(config: MediaImportConfig, result: MediaResult): Promise<void> {
  const prisma = prismaManager.getClient(config.region || 'TR');
  const planDirs = ['kat-planlari', 'kat-planı', 'floor-plans', 'floor-plans', 'FLOOR-APARTMENTS PLAN'];

  for (const dirName of planDirs) {
    const dir = path.join(config.sourceDir, dirName);
    if (!fs.existsSync(dir)) continue;

    // Check for subdirectories (e.g., "3+1", "4+1")
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    let planIndex = 0;

    for (const entry of entries) {
      if (entry.isDirectory()) {
        // Subdirectory with room type
        const subDir = path.join(dir, entry.name);
        const subFiles = fs.readdirSync(subDir).filter(f => IMAGE_EXTENSIONS.includes(path.extname(f).toLowerCase()));

        for (const file of subFiles) {
          const srcPath = path.join(subDir, file);
          const destDir = path.join(config.uploadBase, config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-'), 'floor-plans');
          const destPath = path.join(destDir, `${entry.name}-${file}`);

          try {
            copyFile(srcPath, destPath);
            const fpId = `fp_${config.propertyId}_${planIndex}`;
            const relativePath = `/uploads/projects/${config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-')}/floor-plans/${entry.name}-${file}`;

            await prisma.floorPlan.upsert({
              where: { id: fpId },
              update: {},
              create: {
                id: fpId,
                orgId: config.orgId,
                propertyId: config.propertyId,
                name: `${entry.name} Kat Planı`,
                imageUrl: relativePath,
                floorLevel: 0,
                description: `${config.projectName} ${entry.name} kat planı`,
              },
            });
            result.floorPlans++;
            planIndex++;
          } catch (e: any) {
            result.errors.push(`Floor plan ${file}: ${e.message}`);
          }
        }
      } else if (IMAGE_EXTENSIONS.includes(path.extname(entry.name).toLowerCase())) {
        // Direct image file
        const srcPath = path.join(dir, entry.name);
        const destDir = path.join(config.uploadBase, config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-'), 'floor-plans');
        const destPath = path.join(destDir, entry.name);

        try {
          copyFile(srcPath, destPath);
          const fpId = `fp_${config.propertyId}_${planIndex}`;
          const relativePath = `/uploads/projects/${config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-')}/floor-plans/${entry.name}`;

          await prisma.floorPlan.upsert({
            where: { id: fpId },
            update: {},
            create: {
              id: fpId,
              orgId: config.orgId,
              propertyId: config.propertyId,
              name: entry.name.replace(/\.[^.]+$/, '').replace(/[-_]/g, ' '),
              imageUrl: relativePath,
              floorLevel: 0,
            },
          });
          result.floorPlans++;
          planIndex++;
        } catch (e: any) {
          result.errors.push(`Floor plan ${entry.name}: ${e.message}`);
        }
      }
    }
  }
}

// ─── Video Import ───────────────────────────────────────────────────────────

async function importVideos(config: MediaImportConfig, result: MediaResult): Promise<void> {
  const prisma = prismaManager.getClient(config.region || 'TR');
  const videoDirs = ['videolar', 'videos', 'VIDEOS', 'Tanitim videosu'];

  for (const dirName of videoDirs) {
    const dir = path.join(config.sourceDir, dirName);
    if (!fs.existsSync(dir)) continue;

    const files = fs.readdirSync(dir).filter(f => {
      const ext = path.extname(f).toLowerCase();
      return VIDEO_EXTENSIONS.includes(ext);
    });

    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const srcPath = path.join(dir, file);
      const destDir = path.join(config.uploadBase, config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-'), 'videos');
      const destPath = path.join(destDir, file);

      try {
        copyFile(srcPath, destPath);
        const docId = `doc_video_${config.propertyId}_${Date.now()}_${i}`;
        const relativePath = `/uploads/projects/${config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-')}/videos/${file}`;
        const stats = fs.statSync(srcPath);

        await prisma.document.upsert({
          where: { id: docId },
          update: {},
          create: {
            id: docId,
            orgId: config.orgId,
            propertyId: config.propertyId,
            title: file.replace(/\.[^.]+$/, '').replace(/[-_]/g, ' '),
            documentType: 'CERTIFICATE',
            fileUrl: relativePath,
            mimeType: 'video/mp4',
            fileSize: stats.size,
            checksum: 'placeholder',
            fileName: file,
          },
        });
        result.videos++;
      } catch (e: any) {
        result.errors.push(`Video ${file}: ${e.message}`);
      }
    }
  }
}

// ─── Document Import (PDF) ──────────────────────────────────────────────────

async function importDocuments(config: MediaImportConfig, result: MediaResult): Promise<void> {
  const prisma = prismaManager.getClient(config.region || 'TR');
  const docDirs = ['kataloglar', 'sozlesmeler', 'contracts', 'CATALOGUE', 'PRICE LIST', 'SPECIAL OFFERS'];

  for (const dirName of docDirs) {
    const dir = path.join(config.sourceDir, dirName);
    if (!fs.existsSync(dir)) continue;

    const files = fs.readdirSync(dir).filter(f => {
      const ext = path.extname(f).toLowerCase();
      return DOC_EXTENSIONS.includes(ext);
    });

    for (let i = 0; i < files.length; i++) {
      const file = files[i];
      const srcPath = path.join(dir, file);
      const destDir = path.join(config.uploadBase, config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-'), 'documents');
      const destPath = path.join(destDir, file);

      try {
        copyFile(srcPath, destPath);
        const docId = `doc_${config.propertyId}_${Date.now()}_${i}`;
        const relativePath = `/uploads/projects/${config.projectName.toLowerCase().replace(/[^a-z0-9]+/g, '-')}/documents/${file}`;
        const stats = fs.statSync(srcPath);
        const isCatalog = dirName === 'CATALOGUE';
        const isPriceList = dirName === 'PRICE LIST';

        await prisma.document.upsert({
          where: { id: docId },
          update: {},
          create: {
            id: docId,
            orgId: config.orgId,
            propertyId: config.propertyId,
            title: isCatalog ? `Katalog - ${file.replace(/\.[^.]+$/, '')}` :
                   isPriceList ? `Fiyat Listesi - ${file.replace(/\.[^.]+$/, '')}` :
                   file.replace(/\.[^.]+$/, '').replace(/[-_]/g, ' '),
            documentType: isCatalog ? 'BROCHURE' : isPriceList ? 'INVOICE' : 'CERTIFICATE',
            fileUrl: relativePath,
            mimeType: 'application/pdf',
            fileSize: stats.size,
            checksum: 'placeholder',
            fileName: file,
          },
        });
        result.documents++;
      } catch (e: any) {
        result.errors.push(`Document ${file}: ${e.message}`);
      }
    }
  }
}

// ─── Main Import ────────────────────────────────────────────────────────────

export async function importMedia(config: MediaImportConfig): Promise<MediaResult> {
  const result: MediaResult = { photos: 0, floorPlans: 0, videos: 0, documents: 0, errors: [] };

  console.log(`📸 Importing media for ${config.projectName}...`);

  if (!fs.existsSync(config.sourceDir)) {
    result.errors.push(`Source directory not found: ${config.sourceDir}`);
    return result;
  }

  await importPhotos(config, result);
  await importFloorPlans(config, result);
  await importVideos(config, result);
  await importDocuments(config, result);

  console.log(`✅ Media import complete:`);
  console.log(`   📷 Photos: ${result.photos}`);
  console.log(`   📐 Floor Plans: ${result.floorPlans}`);
  console.log(`   🎬 Videos: ${result.videos}`);
  console.log(`   📄 Documents: ${result.documents}`);
  if (result.errors.length > 0) {
    console.log(`   ⚠️ Errors: ${result.errors.length}`);
  }

  return result;
}
