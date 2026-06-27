import fs from "fs";
import { join } from "path";
import zlib from "zlib";

// Define the absolute base directory for organized data
const BASE_DATALAR_DIR = "/Users/os2026/Downloads/Reservatior/datalar/airbnb";

// Elite global travel destination registry with active 2025 S3 links
interface CityConfig {
  country: string;
  state: string;
  city: string;
  listingsUrl: string;
  geojsonUrl: string;
}

const GLOBAL_REGISTRY: CityConfig[] = [
  {
    country: "USA",
    state: "WA",
    city: "Seattle",
    listingsUrl: "https://data.insideairbnb.com/united-states/wa/seattle/2025-09-25/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/united-states/wa/seattle/2025-09-25/visualisations/neighbourhoods.geojson"
  },
  {
    country: "USA",
    state: "NY",
    city: "New York City",
    listingsUrl: "https://data.insideairbnb.com/united-states/ny/new-york-city/2025-12-06/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/united-states/ny/new-york-city/2025-12-06/visualisations/neighbourhoods.geojson"
  },
  {
    country: "USA",
    state: "CA",
    city: "Los Angeles",
    listingsUrl: "https://data.insideairbnb.com/united-states/ca/los-angeles/2025-09-08/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/united-states/ca/los-angeles/2025-09-08/visualisations/neighbourhoods.geojson"
  },
  {
    country: "USA",
    state: "CA",
    city: "San Francisco",
    listingsUrl: "https://data.insideairbnb.com/united-states/ca/san-francisco/2025-09-07/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/united-states/ca/san-francisco/2025-09-07/visualisations/neighbourhoods.geojson"
  },
  {
    country: "USA",
    state: "IL",
    city: "Chicago",
    listingsUrl: "https://data.insideairbnb.com/united-states/il/chicago/2025-09-18/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/united-states/il/chicago/2025-09-18/visualisations/neighbourhoods.geojson"
  },
  {
    country: "USA",
    state: "MA",
    city: "Boston",
    listingsUrl: "https://data.insideairbnb.com/united-states/ma/boston/2025-09-18/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/united-states/ma/boston/2025-09-18/visualisations/neighbourhoods.geojson"
  },
  {
    country: "Netherlands",
    state: "North Holland",
    city: "Amsterdam",
    listingsUrl: "https://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2025-09-05/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/the-netherlands/north-holland/amsterdam/2025-09-05/visualisations/neighbourhoods.geojson"
  },
  {
    country: "Belgium",
    state: "Brussels",
    city: "Brussels",
    listingsUrl: "https://data.insideairbnb.com/belgium/brussels/brussels/2025-09-17/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/belgium/brussels/brussels/2025-09-17/visualisations/neighbourhoods.geojson"
  },
  {
    country: "Belgium",
    state: "Flanders",
    city: "Antwerp",
    listingsUrl: "https://data.insideairbnb.com/belgium/flanders/antwerp/2025-09-19/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/belgium/flanders/antwerp/2025-09-19/visualisations/neighbourhoods.geojson"
  },
  {
    country: "Turkey",
    state: "Marmara",
    city: "Istanbul",
    listingsUrl: "https://data.insideairbnb.com/turkey/marmara/istanbul/2025-09-29/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/turkey/marmara/istanbul/2025-09-29/visualisations/neighbourhoods.geojson"
  },
  {
    country: "United Kingdom",
    state: "England",
    city: "London",
    listingsUrl: "https://data.insideairbnb.com/united-kingdom/england/london/2025-09-06/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/united-kingdom/england/london/2025-09-06/visualisations/neighbourhoods.geojson"
  },
  {
    country: "France",
    state: "Ile de France",
    city: "Paris",
    listingsUrl: "https://data.insideairbnb.com/france/ile-de-france/paris/2025-09-06/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/france/ile-de-france/paris/2025-09-06/visualisations/neighbourhoods.geojson"
  },
  {
    country: "Germany",
    state: "Berlin",
    city: "Berlin",
    listingsUrl: "https://data.insideairbnb.com/germany/berlin/berlin/2025-09-15/data/listings.csv.gz",
    geojsonUrl: "https://data.insideairbnb.com/germany/berlin/berlin/2025-09-15/visualisations/neighbourhoods.geojson"
  }
];

// Modern browser mimic fetch headers to bypass S3 Cloudflare protection
const headers = {
  "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36",
  "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8",
  "Accept-Language": "en-US,en;q=0.9,tr;q=0.8",
  "Referer": "https://insideairbnb.com/get-the-data/",
  "Connection": "keep-alive"
};

async function downloadFile(url: string, targetPath: string, isGzip = false): Promise<boolean> {
  try {
    const response = await fetch(url, { headers });
    
    if (!response.ok) {
      console.error(`❌ HTTP Error: ${response.status} ${response.statusText} for URL: ${url}`);
      return false;
    }

    const arrayBuffer = await response.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    if (isGzip) {
      // Decompress in memory natively
      console.log(`🤐 Decompressing Gzip natively for target: ${targetPath}`);
      const decompressed = zlib.gunzipSync(buffer);
      fs.writeFileSync(targetPath, decompressed);
    } else {
      fs.writeFileSync(targetPath, buffer);
    }
    return true;
  } catch (err: any) {
    console.error(`⚠️ Network Exception: ${err.message} for URL: ${url}`);
    return false;
  }
}

function cleanName(name: string): string {
  return name.toLowerCase().replace(/[^a-z0-9]/g, "_");
}

async function startGlobalDownload() {
  console.log("🌍 ==================================================");
  console.log("🚀 --- RESERVATOR GLOBAL AIRBNB ACQUISITION ENGINE ---");
  console.log("🌍 ==================================================\n");

  console.log(`📂 Base Directory: ${BASE_DATALAR_DIR}`);
  if (!fs.existsSync(BASE_DATALAR_DIR)) {
    fs.mkdirSync(BASE_DATALAR_DIR, { recursive: true });
  }

  let totalSuccess = 0;
  let totalFail = 0;

  for (const city of GLOBAL_REGISTRY) {
    const cleanCountry = cleanName(city.country);
    const cleanState = cleanName(city.state);
    const cleanCity = cleanName(city.city);

    const folderPath = join(BASE_DATALAR_DIR, cleanCountry, cleanState, cleanCity);
    
    console.log(`\n📦 Organizing: ${city.city}, ${city.state} (${city.country})`);
    console.log(`📁 Target Folder: ${folderPath}`);

    if (!fs.existsSync(folderPath)) {
      fs.mkdirSync(folderPath, { recursive: true });
    }

    const csvPath = join(folderPath, "listings.csv");
    const geojsonPath = join(folderPath, "neighbourhoods.geojson");

    let listingsSuccess = false;
    let geojsonSuccess = false;

    // 1. Download & Decompress Listings
    if (fs.existsSync(csvPath)) {
      console.log(`   ✅ listings.csv already exists. Skipping.`);
      listingsSuccess = true;
    } else {
      console.log(`   📥 Downloading Detailed Listings dataset...`);
      listingsSuccess = await downloadFile(city.listingsUrl, csvPath, true);
      if (listingsSuccess) {
        console.log(`   ✅ listings.csv successfully downloaded and decompressed!`);
      } else {
        console.log(`   ❌ listings.csv failed.`);
      }
    }

    // 2. Download Neighbourhoods GeoJSON
    if (fs.existsSync(geojsonPath)) {
      console.log(`   ✅ neighbourhoods.geojson already exists. Skipping.`);
      geojsonSuccess = true;
    } else {
      console.log(`   📥 Downloading Neighbourhoods GeoJSON...`);
      geojsonSuccess = await downloadFile(city.geojsonUrl, geojsonPath, false);
      if (geojsonSuccess) {
        console.log(`   ✅ neighbourhoods.geojson successfully downloaded!`);
      } else {
        console.log(`   ❌ neighbourhoods.geojson failed.`);
      }
    }

    if (listingsSuccess && geojsonSuccess) {
      totalSuccess++;
    } else {
      totalFail++;
    }
  }

  console.log("\n==================================================");
  console.log("🏁 --- GLOBAL AIRBNB DOWNLOAD COMPLETED ---");
  console.log(`✅ Fully Synchronized Portfolios: ${totalSuccess}`);
  console.log(`❌ Failed or Incomplete Portfolios: ${totalFail}`);
  console.log(`📂 Find your organized files at: ${BASE_DATALAR_DIR}`);
  console.log("==================================================\n");
}

startGlobalDownload().catch(console.error);
