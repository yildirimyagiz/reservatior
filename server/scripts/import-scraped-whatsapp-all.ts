import "dotenv/config";
import { prismaManager } from "../src/lib/prisma";
import fs from "node:fs";
import path from "node:path";
import { RealtimeImporter } from "../src/services/matchmaking/realtime-importer";

// Normalize Country Names for database connection
const COUNTRY_MAP: Record<string, string> = {
  "TURKİYE": "TR",
  "TURKIYE": "TR",
  "TÜRKİYE": "TR",
  "BAE": "AE",
  "UAE": "AE",
  "DUBAI": "AE",
  "DUBAİ": "AE",
};

let importStats = {
  TR: { properties: 0, leads: 0 },
  AE: { properties: 0, leads: 0 },
};

async function processDirectory(dirPath: string, detailsPath: string) {
  try {
    const detailsRaw = fs.readFileSync(detailsPath, "utf-8");
    const details = JSON.parse(detailsRaw);
    const country = details.country || "TURKİYE";
    const countryCode = COUNTRY_MAP[country.toUpperCase()] || "TR";

    const result = await RealtimeImporter.importScrapedDirectory(dirPath, detailsPath);

    if (result) {
      if (result.type === "DEMAND") {
        importStats[countryCode as "TR"|"AE"].leads++;
      } else {
        importStats[countryCode as "TR"|"AE"].properties++;
      }
    }
  } catch (error: any) {
    console.error(`❌ Error processing directory ${dirPath}:`, error.message);
  }
}

async function scanAndImport(dirPath: string) {
  const items = fs.readdirSync(dirPath);
  for (const item of items) {
    const fullPath = path.join(dirPath, item);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      const detailsPath = path.join(fullPath, "details.json");
      if (fs.existsSync(detailsPath)) {
        await processDirectory(fullPath, detailsPath);
      } else {
        await scanAndImport(fullPath);
      }
    }
  }
}

async function main() {
  const dataPath = path.join(process.cwd(), "data");
  console.log("🟢 Starting Recursive Chat Separation & Ingestion...");

  const turkiyePath = path.join(dataPath, "TURKİYE");
  const baePath = path.join(dataPath, "BAE");
  const uaePath = path.join(dataPath, "UAE");

  if (fs.existsSync(turkiyePath)) {
    console.log("🇹🇷 Scanning Turkey Scraped Folder...");
    await scanAndImport(turkiyePath);
  }
  if (fs.existsSync(baePath)) {
    console.log("🇦🇪 Scanning BAE Scraped Folder...");
    await scanAndImport(baePath);
  }
  if (fs.existsSync(uaePath)) {
    console.log("🇦🇪 Scanning UAE Scraped Folder...");
    await scanAndImport(uaePath);
  }

  console.log("\n==============================================");
  console.log("🎉 Recurisve Chat Separation Ingestion Finished!");
  console.log(`🇹🇷 TURKEY (TR) -> Properties: ${importStats.TR.properties}, Leads (Demands): ${importStats.TR.leads}`);
  console.log(`🇦🇪 UAE (AE)    -> Properties: ${importStats.AE.properties}, Leads (Demands): ${importStats.AE.leads}`);
  console.log("==============================================");
}

main()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
