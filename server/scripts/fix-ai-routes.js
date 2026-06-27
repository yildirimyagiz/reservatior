const fs = require('fs');
const path = require('path');

const aiTsPath = path.join(__dirname, '..', 'src', 'routes', 'ai.ts');
let content = fs.readFileSync(aiTsPath, 'utf8');

// 1. Replace all async ({ orgId, with async ({ orgId: contextOrgId,
content = content.replace(/async\s*\(\s*\{\s*orgId\s*,/g, 'async ({ orgId: contextOrgId,');

// 2. Add GeminiOpsNotificationCoordinator import at the top
const importTarget = 'import { AiTaskType } from "@prisma/client";';
if (!content.includes('GeminiOpsNotificationCoordinator')) {
  content = content.replace(importTarget, `${importTarget}\nimport { GeminiOpsNotificationCoordinator } from "../services/ai/gemini-ops-coordinator";`);
}

// 3. Upgrade model to gemini-2.5-flash
content = content.replace(/model:\s*"gemini-1.5-flash"/g, 'model: "gemini-2.5-flash"');
content = content.replace(/gemini-1.5-flash for fast responses/g, 'gemini-2.5-flash for fast responses');

// 4. Add the ops-track/trigger route before the translation route
const translateTarget = '  // ─── AI TRANSLATION ──────────────────────────────────────────────────────────';
const opsTrackRoute = `  // ─── GEMINI OTONOM OPERASYONEL TAKİP (OPS TRACKING) ──────────────────────────

  .post("/ops-track/trigger", async ({ orgId: contextOrgId, db, body, set, headers }) => {
    const { sourceType, sourceId } = body as any;
    const region = headers["x-region"] || "US";

    let result = null;
    if (sourceType === "TASK") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackTaskGPS(sourceId, region);
    } else if (sourceType === "KBS_LOG") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackKbsStatus(sourceId, region);
    } else if (sourceType === "ESCROW") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackEscrowChange(sourceId, region);
    } else if (sourceType === "HOST_PENALTY") {
      result = await GeminiOpsNotificationCoordinator.withDB(db as any).trackHostPenalty(sourceId, region);
    } else {
      set.status = 400;
      return { error: \`Invalid sourceType: \${sourceType}\` };
    }

    return { success: true, data: result };
  }, {
    body: t.Object({
      sourceType: t.String(),
      sourceId: t.String()
    })
  })

`;

if (!content.includes('/ops-track/trigger')) {
  content = content.replace(translateTarget, `${opsTrackRoute}${translateTarget}`);
}

fs.writeFileSync(aiTsPath, content, 'utf8');
console.log('✅ ai.ts has been successfully updated and merged!');
