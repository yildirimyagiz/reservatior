/**
 * Migration execution script for SPA to Native App Router.
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const PAGES_SPA = path.join(ROOT, "src/pages-spa");
const APP_ROUTES = path.join(ROOT, "src/app/[locale]/(spa)");
const SPA_LAYOUTS_DIR = path.join(ROOT, "src/components/spa-layouts");

// ─── 1. MOUNT SPA LAYOUTS ──────────────────────────────────────────────────
function migrateLayouts() {
  if (!fs.existsSync(SPA_LAYOUTS_DIR)) {
    fs.mkdirSync(SPA_LAYOUTS_DIR, { recursive: true });
  }

  const layoutDirs = [
    { src: path.join(PAGES_SPA, "client/layout"), dest: "client" },
    { src: path.join(PAGES_SPA, "admin/layout"), dest: "admin" },
    { src: path.join(PAGES_SPA, "agent_os/layout"), dest: "agent_os" },
    { src: path.join(PAGES_SPA, "finance_os/layout"), dest: "finance_os" },
  ];

  for (const l of layoutDirs) {
    if (fs.existsSync(l.src)) {
      const destDir = path.join(SPA_LAYOUTS_DIR, l.dest);
      fs.mkdirSync(destDir, { recursive: true });
      fs.cpSync(l.src, destDir, { recursive: true });
      console.log(`✅ Copied layouts from ${l.src} to ${destDir}`);
    }
  }
}

// ─── 2. PROCESS COMPONENTS ─────────────────────────────────────────────────
function processPages() {
  let migrated = 0;
  
  function walkRoutes(dir) {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    
    for (const entry of entries) {
      const full = path.join(dir, entry.name);
      
      if (entry.isDirectory()) {
        walkRoutes(full);
        continue;
      }
      
      if (entry.name !== "page.tsx") continue;
      
      const content = fs.readFileSync(full, "utf-8");
      
      // Extract dynamic import path
      const dynamicMatch = content.match(/import\s*\(\s*["'](@\/pages-spa\/[^"']+)["']\s*\)/);
      if (!dynamicMatch) continue;
      
      const componentAliasPath = dynamicMatch[1]; // e.g. @/pages-spa/client/Explore
      const relativeToSpa = componentAliasPath.replace("@/pages-spa/", "") + ".tsx";
      const sourceFile = path.join(PAGES_SPA, relativeToSpa);
      
      if (!fs.existsSync(sourceFile)) {
        console.warn(`⚠️ Source missing: ${sourceFile}`);
        continue;
      }
      
      // Move (Copy) component to route dir as PageContent.tsx
      const targetContentPath = path.join(dir, "PageContent.tsx");
      let compContent = fs.readFileSync(sourceFile, "utf-8");
      
      // Clean up Helmet
      compContent = compContent.replace(/import\s+\{\s*Helmet\s*\}\s+from\s+["']react-helmet-async["'];?\n?/g, "");
      compContent = compContent.replace(/<Helmet>[\s\S]*?<\/Helmet>/g, "");
      
      // Fix relative imports pointing to layouts
      // Example: "../../client/layout/PageShell" -> "@/components/spa-layouts/client/PageShell"
      compContent = compContent.replace(/from\s+["'](\.\.\/)+([^"']+\/layout\/[^"']+)["']/g, (match, up, rest) => {
        // rest is like "client/layout/PageShell" or "admin/layout/AdminLayout"
        const newPath = rest.replace("/layout/", "/");
        return `from "@/components/spa-layouts/${newPath}"`;
      });
      // Also catch exact "../layout" or "../../layout"
      compContent = compContent.replace(/from\s+["'](\.\.\/)+layout\/([^"']+)["']/g, (match, up, rest) => {
        // Figure out which layout it meant based on source path
        let area = "client";
        if (sourceFile.includes("/admin/")) area = "admin";
        if (sourceFile.includes("/agent_os/")) area = "agent_os";
        if (sourceFile.includes("/finance_os/")) area = "finance_os";
        
        return `from "@/components/spa-layouts/${area}/${rest}"`;
      });
      
      fs.writeFileSync(targetContentPath, compContent);
      
      // Rewrite page.tsx to static import
      const newPageContent = content
        .replace(/import dynamic from "next\/dynamic";\n?/g, "")
        .replace(/const PageContent = dynamic\([\s\S]*?\);/g, 'import PageContent from "./PageContent";');
      
      fs.writeFileSync(full, newPageContent);
      migrated++;
    }
  }
  
  walkRoutes(APP_ROUTES);
  console.log(`✅ Migrated ${migrated} pages to native App Router.`);
}

console.log("🚀 Starting Phase 2 Migration...");
migrateLayouts();
processPages();
console.log("✅ Done.");
