import fs from "fs";
import { join } from "path";
import readline from "readline";
import zlib from "zlib";

const DOWNLOADS_DIR = "/Users/os2026/Downloads";
const TARGET_DATALAR_DIR = "/Users/os2026/Downloads/Reservatior/datalar/airbnb";
const LOCAL_CSV_TEMP = join(__dirname, "../data/temp-detect.csv");

// Native high-fidelity CSV Line Parser
function parseCSVLine(line: string): string[] {
  const result: string[] = [];
  let current = "";
  let inQuotes = false;
  
  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      if (inQuotes && line[i + 1] === '"') {
        current += '"';
        i++;
      } else {
        inQuotes = !inQuotes;
      }
    } else if (char === ',' && !inQuotes) {
      result.push(current.trim());
      current = "";
    } else {
      current += char;
    }
  }
  result.push(current.trim());
  return result;
}

// Geographic routing engine
function detectCityMeta(sampleRow: Record<string, string>): { country: string, state: string, city: string } {
  const neighborhood = (sampleRow.neighbourhood_cleansed || "").toLowerCase();
  
  // Amsterdam
  if (
    neighborhood.includes("centrum-") || neighborhood.includes("oud-west") || 
    neighborhood.includes("de pijp") || neighborhood.includes("baarsjes") || 
    neighborhood.includes("westerpark")
  ) {
    return { country: "netherlands", state: "north_holland", city: "amsterdam" };
  }
  
  // Brussels/Belgium
  if (
    neighborhood.includes("ixelles") || neighborhood.includes("saint-gilles") || 
    neighborhood.includes("schaerbeek") || neighborhood.includes("anderlecht") || 
    neighborhood.includes("antwerpen") || neighborhood.includes("berchem")
  ) {
    return { country: "belgium", state: "brussels", city: "brussels" };
  }

  // London
  if (
    neighborhood.includes("westminster") || neighborhood.includes("kensington") || 
    neighborhood.includes("hackney") || neighborhood.includes("tower hamlets") || 
    neighborhood.includes("camden")
  ) {
    return { country: "united_kingdom", state: "england", city: "london" };
  }

  // Paris
  if (
    neighborhood.includes("buttes-montmartre") || neighborhood.includes("popincourt") || 
    neighborhood.includes("vaugirard") || neighborhood.includes("entrepot")
  ) {
    return { country: "france", state: "ile_de_france", city: "paris" };
  }

  // USA Cities
  if (neighborhood.includes("manhattan") || neighborhood.includes("brooklyn") || neighborhood.includes("queens") || neighborhood.includes("bronx")) {
    return { country: "usa", state: "ny", city: "new_york_city" };
  }
  if (neighborhood.includes("hollywood") || neighborhood.includes("venice") || neighborhood.includes("downtown") && sampleRow.zipcode?.startsWith("90")) {
    return { country: "usa", state: "ca", city: "los_angeles" };
  }
  if (neighborhood.includes("mission") || neighborhood.includes("soma") || neighborhood.includes("presidio")) {
    return { country: "usa", state: "ca", city: "san_francisco" };
  }
  if (neighborhood.includes("loop") || neighborhood.includes("lincoln park") || neighborhood.includes("wicker park")) {
    return { country: "usa", state: "il", city: "chicago" };
  }
  if (neighborhood.includes("back bay") || neighborhood.includes("beacon hill") || neighborhood.includes("south end")) {
    return { country: "usa", state: "ma", city: "boston" };
  }
  if (neighborhood.includes("broadway") || neighborhood.includes("capitol hill") || neighborhood.includes("downtown") && sampleRow.zipcode?.startsWith("98")) {
    return { country: "usa", state: "wa", city: "seattle" };
  }
  
  return { country: "usa", state: "unknown", city: "unknown" };
}

async function getFirstRow(filePath: string): Promise<Record<string, string> | null> {
  const fileStream = fs.createReadStream(filePath);
  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });

  let headers: string[] = [];
  let firstRow: Record<string, string> | null = null;

  for await (const line of rl) {
    if (!line.trim()) continue;
    const columns = parseCSVLine(line);
    
    if (headers.length === 0) {
      headers = columns.map(h => h.toLowerCase().replace(/['"]+/g, ''));
      continue;
    }

    const row: Record<string, string> = {};
    headers.forEach((header, index) => {
      row[header] = (columns[index] || "").replace(/['"]+/g, '');
    });

    firstRow = row;
    break;
  }
  rl.close();
  return firstRow;
}

const SERVER_DATA_DIR = "/Users/os2026/Downloads/Reservatior/server/data";

async function organizeDownloads() {
  console.log("🧹 --- RESERVATOR DOWNLOAD ORGANIZER & EXTRACTOR ---");
  
  if (!fs.existsSync(TARGET_DATALAR_DIR)) {
    fs.mkdirSync(TARGET_DATALAR_DIR, { recursive: true });
  }

  const sourceDirs = [DOWNLOADS_DIR, SERVER_DATA_DIR];
  let processedCount = 0;

  for (const sourceDir of sourceDirs) {
    if (!fs.existsSync(sourceDir)) continue;
    console.log(`📡 Scanning source directory: ${sourceDir}`);

    const files = fs.readdirSync(sourceDir);
    for (const file of files) {
      const lower = file.toLowerCase();
      if (lower.startsWith("listings") && (lower.endsWith(".csv") || lower.endsWith(".gz"))) {
        const fullPath = join(sourceDir, file);
        console.log(`\n🔍 Found dataset file: ${file}`);

        let tempCsvPath = LOCAL_CSV_TEMP;
        let isGz = lower.endsWith(".gz");

        // Decompress temporarily to read and detect
        if (isGz) {
          try {
            const buffer = fs.readFileSync(fullPath);
            const decompressed = zlib.gunzipSync(buffer);
            // Ensure directory for temp exists
            fs.mkdirSync(join(__dirname, "../data"), { recursive: true });
            fs.writeFileSync(tempCsvPath, decompressed);
          } catch (e: any) {
            console.error(`   ❌ Failed to decompress ${file}: ${e.message}`);
            continue;
          }
        } else {
          tempCsvPath = fullPath;
        }

        // Read first row to detect city metadata
        const sampleRow = await getFirstRow(tempCsvPath);
        if (isGz) {
          try { fs.unlinkSync(LOCAL_CSV_TEMP); } catch {}
        }

        if (!sampleRow) {
          console.error("   ❌ File is empty or invalid.");
          continue;
        }

        const meta = detectCityMeta(sampleRow);
        if (meta.city === "unknown") {
          console.log(`   ⚠️ Could not automatically identify the city for ${file}. Skipping.`);
          continue;
        }

        const destinationFolder = join(TARGET_DATALAR_DIR, meta.country, meta.state, meta.city);
        fs.mkdirSync(destinationFolder, { recursive: true });
        const destPath = join(destinationFolder, "listings.csv");

        console.log(`   🕵️ Detected City: ${meta.city.toUpperCase()} (${meta.country.toUpperCase()})`);
        console.log(`   🚚 Moving & Extracting to: ${destPath}`);

        try {
          if (isGz) {
            const buffer = fs.readFileSync(fullPath);
            const decompressed = zlib.gunzipSync(buffer);
            fs.writeFileSync(destPath, decompressed);
          } else {
            fs.copyFileSync(fullPath, destPath);
          }
          
          // Safely delete the processed source file from source directory to clean up!
          fs.unlinkSync(fullPath);
          console.log("   ✅ Organized successfully!");
          processedCount++;
        } catch (err: any) {
          console.error(`   ❌ Failed to move: ${err.message}`);
        }
      }
    }
  }

  console.log(`\n🏁 Clean-up completed. Organized ${processedCount} downloads. 🚀\n`);
}

organizeDownloads().catch(console.error);
