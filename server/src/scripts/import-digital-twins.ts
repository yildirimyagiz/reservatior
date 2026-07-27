/**
 * Digital Twin Import Script
 *
 * Imports portfolio data from XLSX/CSV files and web scraping.
 * Creates properties, contacts, listings, floor plans, photos, and digital twins.
 *
 * Usage:
 *   bun run import-digital-twins                           # Import all from default dir
 *   bun run import-digital-twins --project "Anthill"       # Import specific project
 *   bun run import-digital-twins --scrape-anthill          # Scrape Anthill from web
 *   bun run import-digital-twins --dry-run                 # Preview only
 */
import { importPortfolio, importAllFromDirectory } from '../services/portfolio-import';
import { scrapeAnthillOfficial, downloadProjectAssets, exportScrapedData } from '../services/project-scraper';
import prismaManager from '../lib/prisma';
import * as path from 'path';

const DATA_DIR = path.join(__dirname, '../../datalar/csv-output');
const UPLOAD_DIR = path.join(__dirname, '../../uploads/projects');

interface ScriptArgs {
  project?: string;
  scrapeAnthill?: boolean;
  dryRun?: boolean;
  region?: string;
}

function parseArgs(): ScriptArgs {
  const args = process.argv.slice(2);
  const result: ScriptArgs = { region: 'TR' };

  for (let i = 0; i < args.length; i++) {
    if (args[i] === '--project' && args[i + 1]) result.project = args[++i];
    if (args[i] === '--scrape-anthill') result.scrapeAnthill = true;
    if (args[i] === '--dry-run') result.dryRun = true;
    if (args[i] === '--region' && args[i + 1]) result.region = args[++i];
  }
  return result;
}

async function importAnthillFromCSV(dryRun: boolean) {
  console.log('\n' + '='.repeat(60));
  console.log('🏢 ANTHILL RESIDENCE - CSV IMPORT');
  console.log('='.repeat(60));

  const csvPath = path.join(DATA_DIR, 'ANTHİLL 2018_Sayfa1.csv');

  const result = await importPortfolio({
    filePath: csvPath,
    projectName: 'Anthill Residence',
    projectAddress: 'Cumhuriyet Mah. İncirlidede Cad. No:6, Şişli/İstanbul',
    city: 'Istanbul',
    district: 'Şişli',
    subDistrict: 'Bomonti',
    country: 'TR',
    lat: 41.055611,
    lng: 28.980645,
    yearBuilt: 2011,
    region: 'TR',
    dryRun,
  });

  return result;
}

async function scrapeAnthillFromWeb(dryRun: boolean) {
  console.log('\n' + '='.repeat(60));
  console.log('🌐 ANTHILL RESIDENCE - WEB SCRAPING');
  console.log('='.repeat(60));

  const project = await scrapeAnthillOfficial();
  console.log(`📊 Scraped: ${project.images.length} images, ${project.floorPlans.length} floor plans`);
  console.log(`📊 Amenities: ${project.amenities.length}`);
  console.log(`📊 Pricing: ${project.pricing.length} room types`);

  if (!dryRun) {
    await downloadProjectAssets(project, UPLOAD_DIR);
  }

  exportScrapedData(project, UPLOAD_DIR);

  // Create amenity records in database
  if (!dryRun) {
    const prisma = prismaManager.getClient('TR');
    const facilityId = 'fac_ANTHILL_RESIDENCE';

    for (const amenity of project.amenities) {
      const amenityId = `amenity_anthill_${amenity.toLowerCase().replace(/[^a-z0-9]+/g, '')}`;
      try {
        await prisma.sharedAmenity.upsert({
          where: { id: amenityId },
          update: { name: amenity },
          create: {
            id: amenityId,
            facilityId,
            name: amenity,
          },
        });
      } catch (e) {
        // Skip if facility doesn't exist yet
      }
    }
    console.log(`✅ ${project.amenities.length} amenities saved to database`);
  }

  return project;
}

async function main() {
  const args = parseArgs();

  console.log('🚀 DIGITAL TWIN IMPORT ENGINE');
  console.log(`📋 Args:`, JSON.stringify(args, null, 2));

  if (args.scrapeAnthill) {
    await scrapeAnthillFromWeb(args.dryRun || false);
  }

  if (args.project) {
    const csvPath = path.join(DATA_DIR, `${args.project}.csv`);
    await importPortfolio({
      filePath: csvPath,
      projectName: args.project,
      region: args.region,
      dryRun: args.dryRun,
    });
  } else {
    // Import Anthill from CSV
    await importAnthillFromCSV(args.dryRun || false);
  }

  console.log('\n🏆 ALL IMPORTS COMPLETE');
  await prismaManager.disconnectAll();
}

main().catch(console.error);
