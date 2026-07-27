/**
 * Project Scraper Service
 *
 * Scrapes project data from official websites, listing sites, and developer pages.
 * Downloads images, floor plans, and extracts amenity/pricing data.
 */
import * as fs from 'fs';
import * as path from 'path';
import * as https from 'https';
import * as http from 'http';

// ─── Types ──────────────────────────────────────────────────────────────────

export interface ScrapedProject {
  name: string;
  developer?: string;
  address?: string;
  city?: string;
  district?: string;
  lat?: number;
  lng?: number;
  yearBuilt?: number;
  totalUnits?: number;
  floors?: number;
  description?: string;
  amenities: string[];
  images: ScrapedImage[];
  floorPlans: ScrapedImage[];
  pricing: PricingInfo[];
  website?: string;
  virtualTourUrl?: string;
}

export interface ScrapedImage {
  url: string;
  localPath?: string;
  type: 'exterior' | 'interior' | 'floor-plan' | 'amenity' | 'other';
  caption?: string;
}

export interface PricingInfo {
  roomType: string;
  minArea: number;
  maxArea: number;
  minPrice: number;
  maxPrice: number;
  currency: string;
}

export interface ScraperConfig {
  projectName: string;
  sources: string[];
  downloadDir: string;
  downloadImages?: boolean;
}

// ─── Image Download ─────────────────────────────────────────────────────────

function downloadFile(url: string, destPath: string): Promise<void> {
  return new Promise((resolve, reject) => {
    const dir = path.dirname(destPath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }

    const protocol = url.startsWith('https') ? https : http;
    const file = fs.createWriteStream(destPath);

    protocol.get(url, (response) => {
      if (response.statusCode === 301 || response.statusCode === 302) {
        downloadFile(response.headers.location!, destPath).then(resolve).catch(reject);
        return;
      }
      response.pipe(file);
      file.on('finish', () => { file.close(); resolve(); });
    }).on('error', (err) => {
      fs.unlink(destPath, () => {});
      reject(err);
    });
  });
}

// ─── Anthill Official Website Scraper ───────────────────────────────────────

export async function scrapeAnthillOfficial(projectName: string = 'Anthill Residence'): Promise<ScrapedProject> {
  const baseUrl = 'https://anthillresidences.com';
  const project: ScrapedProject = {
    name: projectName,
    developer: 'Ant Yapı',
    address: 'Cumhuriyet Mah. İncirlidede Cad. No:6, 34380 Bomonti – Şişli, İstanbul',
    city: 'Istanbul',
    district: 'Şişli',
    lat: 41.055611,
    lng: 28.980645,
    yearBuilt: 2011,
    totalUnits: 804,
    floors: 54,
    description: 'Anthill Residence, 54 katlı ikiz kulelerden oluşan, 360 derece İstanbul manzarasına sahip lüks konut projesi.',
    amenities: [
      'Kapalı/Açık Yüzme Havuzu',
      'Çocuk Yüzme Havuzu',
      'Fitness Center / Spor Salonu',
      'Sauna',
      'Hamam',
      'Spa & Masaj Odaları',
      'Kayak Alanı',
      'Basketbol Sahası',
      'Futbol Sahası',
      'Tenis Kortu',
      'Çocuk Oyun Alanı',
      'Güneşlenme Terası',
      'Vitamin Bar',
      'Yürüyüş Alanı',
      'Yeşil Alan',
      'Kapalı Otopark',
      'Güvenlik (24/7)',
      'Kamera Sistemi',
      'Jeneratör',
      'Concierge Hizmeti',
      'Akıllı Ev Sistemi',
      'Restoran',
      'Kafe',
      'Toplantı Salonu',
      'Alışveriş Alanı (Çarşı)',
    ],
    images: [],
    floorPlans: [],
    pricing: [
      { roomType: '1+1', minArea: 86, maxArea: 95, minPrice: 498000, maxPrice: 607000, currency: 'USD' },
      { roomType: '2+1', minArea: 96, maxArea: 121, minPrice: 545000, maxPrice: 812000, currency: 'USD' },
      { roomType: '3+1', minArea: 150, maxArea: 180, minPrice: 599000, maxPrice: 900000, currency: 'USD' },
      { roomType: '4+1', minArea: 180, maxArea: 200, minPrice: 800000, maxPrice: 1200000, currency: 'USD' },
    ],
    website: baseUrl,
    virtualTourUrl: 'https://anthillresidences.com/sanal_tur/sanal-tur.html',
  };

  // Image URLs from official website
  const imageUrls: Array<{ url: string; type: ScrapedImage['type']; caption: string }> = [
    // Spot images
    { url: `${baseUrl}/images/spot_image/img_000.jpg`, type: 'exterior', caption: 'Anthill Residence Dış Mekan' },
    { url: `${baseUrl}/images/spot_image/img_00.jpg`, type: 'exterior', caption: 'Anthill Residence Genel Görünüm' },
    { url: `${baseUrl}/images/spot_image/img_01.jpg`, type: 'exterior', caption: 'Anthill Residence Kuleler' },
    { url: `${baseUrl}/images/spot_image/img_02.jpg`, type: 'interior', caption: 'Anthill Residence İç Mekan' },
    { url: `${baseUrl}/images/spot_image/img_03.jpg`, type: 'interior', caption: 'Anthill Residence Daire' },
    { url: `${baseUrl}/images/spot_image/img_04.jpg`, type: 'amenity', caption: 'Anthill Residence Sosyal Alan' },
    // Concept images
    { url: `${baseUrl}/images/img_konsept_01.jpg`, type: 'exterior', caption: 'Konsept Görseli 1' },
    { url: `${baseUrl}/images/img_konsept_02.jpg`, type: 'exterior', caption: 'Konsept Görseli 2' },
    // Architecture
    { url: `${baseUrl}/images/img_mimari_01.jpg`, type: 'exterior', caption: 'Mimari Görsel 1' },
    { url: `${baseUrl}/images/img_mimari_03.jpg`, type: 'exterior', caption: 'Mimari Görsel 2' },
    // Interior design
    { url: `${baseUrl}/images/img_ic_tasarim_01.jpg`, type: 'interior', caption: 'İç Tasarım 1' },
    { url: `${baseUrl}/images/img_ic_tasarim_02.jpg`, type: 'interior', caption: 'İç Tasarım 2' },
    { url: `${baseUrl}/images/img_ic_tasarim_03.jpg`, type: 'interior', caption: 'İç Tasarım 3' },
    // Lifestyle
    { url: `${baseUrl}/images/img_anthillyasamtarzi_01.jpg`, type: 'amenity', caption: 'Yaşam Tarzı 1' },
    { url: `${baseUrl}/images/img_anthillyasamtarzi_02.jpg`, type: 'amenity', caption: 'Yaşam Tarzı 2' },
    { url: `${baseUrl}/images/img_anthillyasamtarzi_03.jpg`, type: 'amenity', caption: 'Yaşam Tarzı 3' },
    { url: `${baseUrl}/images/img_anthillyasamtarzi_04.jpg`, type: 'amenity', caption: 'Yaşam Tarzı 4' },
    // SPA & Fitness
    { url: `${baseUrl}/images/img_pasifik_01.jpg`, type: 'amenity', caption: 'SPA & Fitness 1' },
    { url: `${baseUrl}/images/img_pasifik_02.jpg`, type: 'amenity', caption: 'SPA & Fitness 2' },
    { url: `${baseUrl}/images/img_pasifik_03.jpg`, type: 'amenity', caption: 'SPA & Fitness 3' },
    { url: `${baseUrl}/images/img_pasifik_04.jpg`, type: 'amenity', caption: 'SPA & Fitness 4' },
    { url: `${baseUrl}/images/img_pasifik_05.jpg`, type: 'amenity', caption: 'SPA & Fitness 5' },
    { url: `${baseUrl}/images/img_pasifik_06.jpg`, type: 'amenity', caption: 'SPA & Fitness 6' },
    // Activities
    { url: `${baseUrl}/images/img_aktiviteler_07.jpg`, type: 'amenity', caption: 'Aktiviteler 1' },
    { url: `${baseUrl}/images/img_aktiviteler_09.jpg`, type: 'amenity', caption: 'Aktiviteler 2' },
    { url: `${baseUrl}/images/img_aktiviteler_10.jpg`, type: 'amenity', caption: 'Aktiviteler 3' },
    { url: `${baseUrl}/images/img_aktiviteler_11.jpg`, type: 'amenity', caption: 'Aktiviteler 4' },
    // Sales
    { url: `${baseUrl}/images/img_satis_05.jpg`, type: 'exterior', caption: 'Satış Görseli' },
    // Bomonti
    { url: `${baseUrl}/images/img_bomonti_01.jpg`, type: 'exterior', caption: 'Bomonti Bölgesi' },
    // Image scroller
    ...Array.from({ length: 20 }, (_, i) => {
      const num = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,22,23][i];
      return { url: `${baseUrl}/images/image_scroller/big/${num}.jpg`, type: 'exterior' as ScrapedImage['type'], caption: `Görsel ${num}` };
    }),
  ];

  project.images = imageUrls.map(img => ({
    url: img.url,
    type: img.type,
    caption: img.caption,
  }));

  // Floor plans
  const floorPlanUrls: Array<{ url: string; caption: string }> = [
    { url: `${baseUrl}/images/daire_planlari/1.jpg`, caption: 'A ve B Kule 3. Kat Planı' },
    { url: `${baseUrl}/images/daire_planlari/2.jpg`, caption: 'A ve B Kule 3. Kat Alternatif Plan' },
    { url: `${baseUrl}/images/daire_planlari/3.jpg`, caption: 'A ve B Kule 6, 10, 14, 19 ve 24. Kat Planı' },
    { url: `${baseUrl}/images/daire_planlari/4.jpg`, caption: 'A ve B Kule 6, 10, 14, 19 ve 24. Kat Alternatif' },
    { url: `${baseUrl}/images/daire_planlari/5.jpg`, caption: 'A ve B Kule 35, 36, 38 ve 39. Kat Planı' },
    { url: `${baseUrl}/images/daire_planlari/6.jpg`, caption: 'A ve B Kule 35, 36, 38 ve 39. Kat Alternatif' },
  ];

  project.floorPlans = floorPlanUrls.map(fp => ({
    url: fp.url,
    type: 'floor-plan' as ScrapedImage['type'],
    caption: fp.caption,
  }));

  return project;
}

// ─── Download All Project Assets ────────────────────────────────────────────

export async function downloadProjectAssets(
  project: ScrapedProject,
  downloadDir: string
): Promise<ScrapedProject> {
  const projectDir = path.join(downloadDir, project.name.toLowerCase().replace(/[^a-z0-9]+/g, '-'));

  const dirs = [
    path.join(projectDir, 'dis-mekan'),
    path.join(projectDir, 'ic-mekan'),
    path.join(projectDir, 'amenity'),
    path.join(projectDir, 'kat-planlari'),
  ];

  for (const dir of dirs) {
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  }

  console.log(`📥 Downloading ${project.images.length} images + ${project.floorPlans.length} floor plans...`);

  // Download images
  for (let i = 0; i < project.images.length; i++) {
    const img = project.images[i];
    const subdir = img.type === 'exterior' ? 'dis-mekan' :
                   img.type === 'interior' ? 'ic-mekan' :
                   img.type === 'amenity' ? 'amenity' : 'dis-mekan';
    const ext = path.extname(new URL(img.url).pathname) || '.jpg';
    const filename = `${project.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}_${i + 1}${ext}`;
    const localPath = path.join(projectDir, subdir, filename);

    try {
      await downloadFile(img.url, localPath);
      img.localPath = `/uploads/projects/${project.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}/${subdir}/${filename}`;
      if ((i + 1) % 10 === 0) console.log(`   📸 Downloaded ${i + 1}/${project.images.length}`);
    } catch (e: any) {
      console.log(`   ⚠️ Failed to download ${img.url}: ${e.message}`);
    }
  }

  // Download floor plans
  for (let i = 0; i < project.floorPlans.length; i++) {
    const fp = project.floorPlans[i];
    const ext = path.extname(new URL(fp.url).pathname) || '.jpg';
    const filename = `kat-plani-${i + 1}${ext}`;
    const localPath = path.join(projectDir, 'kat-planlari', filename);

    try {
      await downloadFile(fp.url, localPath);
      fp.localPath = `/uploads/projects/${project.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}/kat-planlari/${filename}`;
    } catch (e: any) {
      console.log(`   ⚠️ Failed to download floor plan ${fp.url}: ${e.message}`);
    }
  }

  console.log(`✅ Download complete: ${projectDir}`);
  return project;
}

// ─── Export Scraped Data as JSON ─────────────────────────────────────────────

export function exportScrapedData(project: ScrapedProject, outputDir: string): void {
  if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });

  const outputPath = path.join(outputDir, `${project.name.toLowerCase().replace(/[^a-z0-9]+/g, '-')}-scraped.json`);
  fs.writeFileSync(outputPath, JSON.stringify(project, null, 2));
  console.log(`📄 Exported: ${outputPath}`);
}
