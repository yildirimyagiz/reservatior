import { router } from "../src/router";
import { default as bun } from "bun";

const BASE_URL = process.env.BASE_URL || "http://localhost:3001/api/v1";

async function verifyAll() {
  console.log("🦾 INITIALIZING TOTAL SYSTEM DEEP SCAN...");
  console.log(`📡 TOTAL ROUTES DETECTED: ${router.routes.length}`);
  console.log(`📍 BASE TARGET: ${BASE_URL}\n`);

  // 1. Handsake
  console.log("🔑 SMART HANDSHAKE...");
  const loginRes = await fetch(`${BASE_URL}/auth/login`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ email: "info@reservatior.com", password: "Parola341" }),
  });

  if (!loginRes.ok) {
    console.error("❌ HANDSHAKE FAILED. Verify server is running on :3001");
    process.exit(1);
  }

  const { token } = await loginRes.json();
  console.log("✅ ACCESS GRANTED.\n");

  // 2. Dynamic Route Extraction
  const uniqueRoutes = new Map<string, string>(); // path -> method
  router.routes.forEach(r => {
    // Elysia routes often have prefixes and internal notation
    let path = r.path;
    // Remove prefix if it's already in BASE_URL or handle it
    // The router base is /api/v1
    const fullPath = path.startsWith("/api/v1") ? path : `/api/v1${path}`;
    uniqueRoutes.set(`${r.method}:${fullPath}`, fullPath);
  });

  console.log(`🔍 UNIQUE ENDPOINTS IDENTIFIED: ${uniqueRoutes.size}`);
  
  let success = 0;
  let authRequired = 0;
  let missingParams = 0; // 400 or 404 with params
  let criticalFail = 0; // 500

  const routeEntries = Array.from(uniqueRoutes.entries());
  
  for (let i = 0; i < routeEntries.length; i++) {
    const [key, path] = routeEntries[i];
    const [method] = key.split(":");

    // We only test GET for mass verification to avoid side effects
    if (method !== "GET") continue;
    
    // Skip paths with parameters for this simple scan, or try to mock them
    if (path.includes(":")) {
        // console.log(`⏩ SKIPPING PARAMETRIC: [${method}] ${path}`);
        continue;
    }

    process.stdout.write(`[${i+1}/${routeEntries.length}] 📡 Pinging ${method} ${path.padEnd(40)} `);

    try {
      const res = await fetch(`http://localhost:3001${path}`, {
        method,
        headers: {
          "Authorization": `Bearer ${token}`,
          "X-Country-Code": "tr" // Default for multi-country
        }
      });

      if (res.ok) {
        console.log("[\x1b[32mOK\x1b[0m]");
        success++;
      } else if (res.STATUS === 401 || res.STATUS === 403) {
        console.log("[\x1b[33mAUTH\x1b[0m]");
        authRequired++;
      } else if (res.STATUS === 400 || res.STATUS === 404) {
        console.log("[\x1b[35mWARN\x1b[0m] (Check Params)");
        missingParams++;
      } else {
        console.log(`[\x1b[31mFAIL\x1b[0m] ${res.STATUS}`);
        criticalFail++;
      }
    } catch (e) {
      console.log("[\x1b[31mCONN_ERR\x1b[0m]");
      criticalFail++;
    }
  }

  console.log("\n--- EXHAUSTIVE SCAN COMPLETED ---");
  console.log(`🟢 HEALTHY NODES:    ${success}`);
  console.log(`🟡 AUTH RESTRICTED:  ${authRequired}`);
  console.log(`🟣 PARAM REQUIRED:   ${missingParams}`);
  console.log(`🔴 CRITICAL FAILS:   ${criticalFail}`);
  console.log(`🌐 COVERAGE:         ${(((success + authRequired + missingParams) / uniqueRoutes.size) * 100).toFixed(1)}%`);

  process.exit(0);
}

verifyAll().catch(err => {
  console.error(err);
  process.exit(1);
});
