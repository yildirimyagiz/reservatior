import { default as bun } from "bun";

const BASE_URL = process.env.BASE_URL || "http://localhost:3001/api/v1";

const ENDPOINTS = [
  { path: "/auth/me", method: "GET", description: "Verification of current identity pulse." },
  { path: "/user", method: "GET", description: "Deep retrieve of user bio-metadata." },
  { path: "/property", method: "GET", description: "Listing scan for property nodes." },
  { path: "/feed", method: "GET", description: "Reels and audiovisual telemetry feed." },
  { path: "/notification", method: "GET", description: "System event notification buffer." },
  { path: "/ai-service-task", method: "GET", description: "AI background task update." },
  { path: "/scraping-job", method: "GET", description: "Crawler mission control." },
  { path: "/invoices", method: "GET", description: "Fiscal ledger extraction." },
  { path: "/aimarket-analysis", method: "GET", description: "Professional market trend analysis." },
  { path: "/system/health", method: "GET", description: "Core system integrity check." },
];

async function verify() {
  console.log("🚀 INITIALIZING ENDPOINT TELEMETRY VERIFICATION...");
  console.log(`📍 TARGET: ${BASE_URL}\n`);

  // 1. AUTHENTICATION HANDSHAKE
  console.log("🔑 ATTEMPTING SMART HANDSHAKE (LOGIN)...");
  const loginRes = await fetch(`${BASE_URL}/auth/login`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email: "info@reservatior.com",
      password: "Parola341",
    }),
  });

  if (!loginRes.ok) {
    console.error("❌ HANDSHAKE FAILED. CRITICAL: DATABASE OR AUTH SERVICE UNREACHABLE.");
    console.error(`Status: ${loginRes.STATUS}`);
    process.exit(1);
  }

  const { token } = await loginRes.json();
  console.log("✅ HANDSHAKE COMPLETE. TOKEN CAPTURED.\n");

  // 2. ENDPOINT SCAN
  let successCount = 0;
  let failCount = 0;

  for (const ep of ENDPOINTS) {
    process.stdout.write(`📡 SCANNING: [${ep.method}] ${ep.path.padEnd(25)} `);
    
    try {
      const start = Date.now();
      const res = await fetch(`${BASE_URL}${ep.path}`, {
        method: ep.method,
        headers: {
          "Authorization": `Bearer ${token}`,
          "Content-Type": "application/json",
        },
      });
      const end = Date.now();
      const latency = end - start;

      if (res.ok) {
        console.log(`[\x1b[32mPASS\x1b[0m] ${latency}ms - ${ep.description}`);
        successCount++;
      } else {
        console.log(`[\x1b[31mFAIL\x1b[0m] HTTP ${res.STATUS} - ${ep.description}`);
        failCount++;
      }
    } catch (err) {
      console.log(`[\x1b[31mERROR\x1b[0m] CONNECTION TIMEOUT`);
      failCount++;
    }
  }

  console.log("\n--- VERIFICATION REPORT ---");
  console.log(`✅ SUCCESSFUL NODES: ${successCount}`);
  console.log(`❌ FAILED NODES:     ${failCount}`);
  console.log(`📊 INTEGRITY LEVEL:  ${((successCount / ENDPOINTS.length) * 100).toFixed(1)}%`);

  if (failCount > 0) {
    console.warn("\n⚠️ WARNING: System fragment inconsistency detected. Verify backend routes.");
  } else {
    console.log("\n✨ SYSTEM STABILIZED. FULL MOBILE FEATURE PARITY VALIDATED.");
  }
}

verify().catch(console.error);
