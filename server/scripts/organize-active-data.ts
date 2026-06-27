import fs from "fs";
import { join } from "path";

const DATA_DIR = "/Users/os2026/Downloads/Reservatior/server/data";
const TARGET_DIR = "/Users/os2026/Downloads/Reservatior/server/data/airbnb";

interface CityMeta {
  country: string;
  state: string;
  city: string;
}

// Coordinate bounding boxes for high-fidelity geocoding
function detectCityByCoords(lat: number, lng: number): CityMeta | null {
  // Istanbul: 41.0, 29.0
  if (lat > 40.8 && lat < 41.3 && lng > 28.4 && lng < 29.5) {
    return { country: "turkey", state: "marmara", city: "istanbul" };
  }
  // London: 51.5, -0.12
  if (lat > 51.2 && lat < 51.7 && lng > -0.6 && lng < 0.3) {
    return { country: "united_kingdom", state: "england", city: "london" };
  }
  // Paris: 48.85, 2.35
  if (lat > 48.75 && lat < 48.95 && lng > 2.2 && lng < 2.5) {
    return { country: "france", state: "ile_de_france", city: "paris" };
  }
  // Berlin: 52.52, 13.4
  if (lat > 52.3 && lat < 52.7 && lng > 13.0 && lng < 13.8) {
    return { country: "germany", state: "berlin", city: "berlin" };
  }
  // Seattle: 47.6, -122.3
  if (lat > 47.4 && lat < 47.8 && lng > -122.5 && lng < -122.1) {
    return { country: "usa", state: "wa", city: "seattle" };
  }
  // New York City: 40.7, -74.0
  if (lat > 40.4 && lat < 40.95 && lng > -74.3 && lng < -73.6) {
    return { country: "usa", state: "ny", city: "new_york_city" };
  }
  // Los Angeles: 34.05, -118.25
  if (lat > 33.6 && lat < 34.4 && lng > -119.0 && lng < -117.5) {
    return { country: "usa", state: "ca", city: "los_angeles" };
  }
  // San Francisco: 37.77, -122.4
  if (lat > 37.6 && lat < 37.9 && lng > -122.6 && lng < -122.3) {
    return { country: "usa", state: "ca", city: "san_francisco" };
  }
  // Chicago: 41.88, -87.6
  if (lat > 41.6 && lat < 42.1 && lng > -88.0 && lng < -87.4) {
    return { country: "usa", state: "il", city: "chicago" };
  }
  // Boston: 42.36, -71.05
  if (lat > 42.2 && lat < 42.5 && lng > -71.2 && lng < -70.8) {
    return { country: "usa", state: "ma", city: "boston" };
  }
  // Amsterdam: 52.36, 4.9
  if (lat > 52.25 && lat < 52.45 && lng > 4.7 && lng < 5.1) {
    return { country: "netherlands", state: "north_holland", city: "amsterdam" };
  }
  // Brussels: 50.85, 4.35
  if (lat > 50.75 && lat < 50.95 && lng > 4.2 && lng < 4.5) {
    return { country: "belgium", state: "brussels", city: "brussels" };
  }
  // Antwerp: 51.2, 4.4
  if (lat > 51.1 && lat < 51.35 && lng > 4.3 && lng < 4.55) {
    return { country: "belgium", state: "flanders", city: "antwerp" };
  }
  // Bordeaux, France
  if (lat > 44.7 && lat < 45.0 && lng > -0.7 && lng < -0.4) {
    return { country: "france", state: "nouvelle_aquitaine", city: "bordeaux" };
  }
  // Bristol, UK
  if (lat > 51.35 && lat < 51.55 && lng > -2.7 && lng < -2.5) {
    return { country: "united_kingdom", state: "england", city: "bristol" };
  }
  // Austin, TX, USA
  if (lat > 30.1 && lat < 30.5 && lng > -97.9 && lng < -97.5) {
    return { country: "usa", state: "tx", city: "austin" };
  }
  // Belize Islands, Belize
  if (lat > 16.0 && lat < 18.5 && lng > -89.2 && lng < -87.5) {
    return { country: "belize", state: "belize", city: "belize_islands" };
  }
  // Sydney, Australia
  if (lat > -34.1 && lat < -33.5 && lng > 150.8 && lng < 151.4) {
    return { country: "australia", state: "nsw", city: "sydney" };
  }
  // Albany, NY, USA
  if (lat > 42.5 && lat < 42.8 && lng > -73.9 && lng < -73.6) {
    return { country: "usa", state: "ny", city: "albany" };
  }
  // Bergamo, Italy
  if (lat > 45.6 && lat < 45.9 && lng > 9.5 && lng < 10.2) {
    return { country: "italy", state: "lombardy", city: "bergamo" };
  }
  // Athens, Greece
  if (lat > 37.8 && lat < 38.2 && lng > 23.5 && lng < 24.0) {
    return { country: "greece", state: "attica", city: "athens" };
  }
  // Barossa Valley, Australia
  if (lat > -34.8 && lat < -34.2 && lng > 138.8 && lng < 139.3) {
    return { country: "australia", state: "sa", city: "barossa_valley" };
  }
  // Barwon South West, Australia
  if (lat > -39.0 && lat < -37.5 && lng > 141.0 && lng < 145.0) {
    return { country: "australia", state: "vic", city: "barwon_south_west" };
  }
  // Bangkok, Thailand
  if (lat > 13.5 && lat < 14.0 && lng > 100.3 && lng < 100.8) {
    return { country: "thailand", state: "bangkok", city: "bangkok" };
  }
  // Barcelona, Spain
  if (lat > 41.2 && lat < 41.6 && lng > 2.0 && lng < 2.3) {
    return { country: "spain", state: "catalonia", city: "barcelona" };
  }
  // Bozeman, MT, USA
  if (lat > 45.5 && lat < 45.8 && lng > -111.2 && lng < -110.8) {
    return { country: "usa", state: "mt", city: "bozeman" };
  }
  // Sunshine Coast, Australia
  if (lat > -27.0 && lat < -25.5 && lng > 152.5 && lng < 153.5) {
    return { country: "australia", state: "qld", city: "sunshine_coast" };
  }
  // Asheville, NC, USA
  if (lat > 35.4 && lat < 35.8 && lng > -82.8 && lng < -82.3) {
    return { country: "usa", state: "nc", city: "asheville" };
  }
  // Bologna, Italy
  if (lat > 44.3 && lat < 44.6 && lng > 11.2 && lng < 11.5) {
    return { country: "italy", state: "emilia_romagna", city: "bologna" };
  }
  // Brisbane, Australia
  if (lat > -27.7 && lat < -27.2 && lng > 152.8 && lng < 153.3) {
    return { country: "australia", state: "qld", city: "brisbane" };
  }

  return null;
}

async function getFirstRowsRobust(filePath: string, maxRows = 200): Promise<{ headers: string[], rows: Record<string, string>[] }> {
  return new Promise((resolve, reject) => {
    const stream = fs.createReadStream(filePath, { encoding: "utf8" });
    let headers: string[] = [];
    let rowCells: string[] = [];
    let currentCell = "";
    let inQuotes = false;
    const rows: Record<string, string>[] = [];

    stream.on("data", (chunk: string) => {
      for (let i = 0; i < chunk.length; i++) {
        const char = chunk[i];
        if (char === '"') {
          if (inQuotes && chunk[i + 1] === '"') {
            currentCell += '"';
            i++;
          } else {
            inQuotes = !inQuotes;
          }
        } else if (char === ',' && !inQuotes) {
          rowCells.push(currentCell.trim());
          currentCell = "";
        } else if ((char === '\n' || char === '\r') && !inQuotes) {
          if (char === '\r' && chunk[i + 1] === '\n') {
            i++;
          }
          rowCells.push(currentCell.trim());
          currentCell = "";
          
          if (rowCells.length > 0 && rowCells.some(c => c !== "")) {
            if (headers.length === 0) {
              headers = rowCells.map(h => h.toLowerCase().replace(/['"]+/g, ''));
            } else {
              const row: Record<string, string> = {};
              headers.forEach((header, index) => {
                row[header] = (rowCells[index] || "").replace(/['"]+/g, '');
              });
              rows.push(row);
              if (rows.length >= maxRows) {
                stream.destroy();
                resolve({ headers, rows });
                return;
              }
            }
          }
          rowCells = [];
        } else {
          currentCell += char;
        }
      }
    });

    stream.on("end", () => {
      if (rowCells.length > 0 && headers.length > 0) {
        const row: Record<string, string> = {};
        headers.forEach((header, index) => {
          row[header] = (rowCells[index] || "").replace(/['"]+/g, '');
        });
        rows.push(row);
      }
      resolve({ headers, rows });
    });

    stream.on("error", (err) => {
      reject(err);
    });
  });
}

async function startOrganization() {
  console.log("🧹 ==================================================");
  console.log("🚀 --- RESERVATOR CSV DATA CLEANUP & ORGANIZER ---");
  console.log("🧹 ==================================================\n");

  const files = fs.readdirSync(DATA_DIR);
  console.log(`Scanning data folder: ${DATA_DIR}`);

  const listingsList: {
    fileName: string;
    filePath: string;
    cityInfo: CityMeta;
    neighbourhoods: Set<string>;
    sizeBytes: number;
  }[] = [];

  const neighbourhoodsList: {
    fileName: string;
    filePath: string;
    neighbourhoods: string[];
    sizeBytes: number;
  }[] = [];

  // 1. Analyze and detect
  for (const file of files) {
    if (!file.endsWith(".csv")) continue;
    const filePath = join(DATA_DIR, file);
    const stats = fs.statSync(filePath);
    if (stats.size === 0) {
      console.log(`⚠️ Skipping 0-byte file: ${file}`);
      // Safely delete empty listings
      fs.unlinkSync(filePath);
      continue;
    }

    const { rows } = await getFirstRowsRobust(filePath, 200);
    if (rows.length === 0) {
      console.log(`⚠️ Skipping empty row file: ${file}`);
      continue;
    }

    const lowerName = file.toLowerCase();
    if (lowerName.startsWith("listings") || lowerName.endsWith("listings.csv")) {
      let cityInfo: CityMeta | null = null;
      for (const row of rows) {
        const latVal = parseFloat(row["latitude"] || "");
        const lngVal = parseFloat(row["longitude"] || "");
        if (!isNaN(latVal) && !isNaN(lngVal)) {
          cityInfo = detectCityByCoords(latVal, lngVal);
          if (cityInfo) break;
        }
      }

      if (!cityInfo) {
        console.warn(`⚠️ Could not detect geographic location for listings: ${file}`);
        cityInfo = { country: "unknown", state: "unknown", city: "unknown" };
      }

      const neighSet = new Set<string>();
      rows.forEach(r => {
        const n = r["neighbourhood_cleansed"] || r["neighbourhood"] || "";
        if (n) neighSet.add(n.toLowerCase());
      });

      listingsList.push({
        fileName: file,
        filePath,
        cityInfo,
        neighbourhoods: neighSet,
        sizeBytes: stats.size
      });
    } else if (lowerName.startsWith("neighbourhoods")) {
      const neighList: string[] = [];
      rows.forEach(r => {
        const n = r["neighbourhood"] || "";
        if (n) neighList.push(n.toLowerCase());
      });

      neighbourhoodsList.push({
        fileName: file,
        filePath,
        neighbourhoods: neighList,
        sizeBytes: stats.size
      });
    }
  }

  // Map each neighbourhoods.csv to its best matching listings city location
  const finalMoveQueue: {
    sourcePath: string;
    destFolder: string;
    destName: string;
    sizeBytes: number;
  }[] = [];

  console.log("\n--- Geographic Mapping & Pair Matching ---");

  // Add listings moves
  for (const item of listingsList) {
    if (item.cityInfo.city === "unknown") {
      console.log(`❌ Skipping unknown listings file: ${item.fileName}`);
      continue;
    }

    const destFolder = join(TARGET_DIR, item.cityInfo.country, item.cityInfo.state, item.cityInfo.city);
    finalMoveQueue.push({
      sourcePath: item.filePath,
      destFolder,
      destName: "listings.csv",
      sizeBytes: item.sizeBytes
    });

    console.log(`📝 Listings: ${item.fileName} -> ${item.cityInfo.country}/${item.cityInfo.state}/${item.cityInfo.city}/listings.csv`);
  }

  // Match and add neighbourhoods moves
  for (const nItem of neighbourhoodsList) {
    let bestMatch: typeof listingsList[0] | null = null;
    let maxIntersection = 0;

    for (const lItem of listingsList) {
      let intersectionCount = 0;
      for (const name of nItem.neighbourhoods) {
        if (lItem.neighbourhoods.has(name)) {
          intersectionCount++;
        }
      }
      if (intersectionCount > maxIntersection) {
        maxIntersection = intersectionCount;
        bestMatch = lItem;
      }
    }

    if (bestMatch && maxIntersection > 0 && bestMatch.cityInfo.city !== "unknown") {
      const destFolder = join(TARGET_DIR, bestMatch.cityInfo.country, bestMatch.cityInfo.state, bestMatch.cityInfo.city);
      finalMoveQueue.push({
        sourcePath: nItem.filePath,
        destFolder,
        destName: "neighbourhoods.csv",
        sizeBytes: nItem.sizeBytes
      });
      console.log(`🗺️ Neighbourhoods: ${nItem.fileName} matched with ${bestMatch.fileName} -> ${bestMatch.cityInfo.country}/${bestMatch.cityInfo.state}/${bestMatch.cityInfo.city}/neighbourhoods.csv`);
    } else {
      console.warn(`❌ No match found for neighbourhoods: ${nItem.fileName}`);
    }
  }

  // 2. Execute moves, verify, and cleanup
  console.log("\n--- Executing Moves & Verification ---");
  let movedCount = 0;

  for (const action of finalMoveQueue) {
    try {
      if (!fs.existsSync(action.destFolder)) {
        fs.mkdirSync(action.destFolder, { recursive: true });
      }

      const destPath = join(action.destFolder, action.destName);
      
      console.log(`🚚 Copying ${action.sourcePath.split("/").pop()} to ${destPath}...`);
      fs.copyFileSync(action.sourcePath, destPath);

      // Verify file existence and size
      if (fs.existsSync(destPath)) {
        const destStats = fs.statSync(destPath);
        if (destStats.size === action.sizeBytes) {
          console.log(`   ✅ Copy verified. Deleting source file...`);
          fs.unlinkSync(action.sourcePath);
          movedCount++;
        } else {
          console.error(`   ❌ Verification failed: size mismatch! (Expected: ${action.sizeBytes}, Got: ${destStats.size}). Retaining source file.`);
        }
      } else {
        console.error(`   ❌ Verification failed: destination file does not exist! Retaining source file.`);
      }
    } catch (e: any) {
      console.error(`   ❌ Failed to process ${action.sourcePath}: ${e.message}`);
    }
  }

  console.log(`\n🏁 Done. Successfully organized and verified ${movedCount} files! 🚀\n`);
}

startOrganization().catch(console.error);
