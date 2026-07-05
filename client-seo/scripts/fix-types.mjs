import fs from "fs";
import path from "path";

const walk = (dir, callback) => {
  fs.readdirSync(dir, { withFileTypes: true }).forEach(entry => {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full, callback);
    else if (full.endsWith(".tsx") || full.endsWith(".ts")) callback(full);
  });
};

walk("src/app/[locale]/(spa)", (file) => {
  let content = fs.readFileSync(file, "utf-8");
  let changed = false;

  // 1. Fix missing imports (useMutation, useQueryClient)
  if (content.includes("useMutation(") && !content.includes("useMutation")) {
    if (content.includes("@tanstack/react-query")) {
      content = content.replace(/import\s+{([^}]*)}\s+from\s+["']@tanstack\/react-query["']/g, (m, imports) => {
        if (!imports.includes("useMutation")) return `import {${imports}, useMutation} from "@tanstack/react-query"`;
        return m;
      });
    } else {
      content = `import { useMutation } from "@tanstack/react-query";\n` + content;
    }
    changed = true;
  }
  
  if (content.includes("useQueryClient(") && !content.includes("useQueryClient")) {
    if (content.includes("@tanstack/react-query")) {
      content = content.replace(/import\s+{([^}]*)}\s+from\s+["']@tanstack\/react-query["']/g, (m, imports) => {
        if (!imports.includes("useQueryClient")) return `import {${imports}, useQueryClient} from "@tanstack/react-query"`;
        return m;
      });
    } else {
      content = `import { useQueryClient } from "@tanstack/react-query";\n` + content;
    }
    changed = true;
  }
  
  if (content.includes("apiClient") && !content.includes("apiClient") && !file.includes("client.ts")) {
    content = `import { apiClient } from "@/lib/api/client";\n` + content;
    changed = true;
  }

  // 2. Fix missed layout imports like "./layout/PageShell"
  if (content.includes("./layout/PageShell")) {
    content = content.replace(/from\s+["']\.\/layout\/PageShell["']/g, 'from "@/components/spa-layouts/client/PageShell"');
    changed = true;
  }
  if (content.includes("../layout/PageShell")) {
    content = content.replace(/from\s+["']\.\.\/layout\/PageShell["']/g, 'from "@/components/spa-layouts/client/PageShell"');
    changed = true;
  }

  // 3. Fix missing OpportunityFeed & NetworkDashboard in agent-os
  if (content.includes("./OpportunityFeed")) {
    content = content.replace(/from\s+["']\.\/OpportunityFeed["']/g, 'from "@/app/[locale]/(spa)/agent-os/opportunities/PageContent"');
    changed = true;
  }
  if (content.includes("./NetworkDashboard")) {
    content = content.replace(/from\s+["']\.\/NetworkDashboard["']/g, 'from "@/app/[locale]/(spa)/agent-os/network/PageContent"');
    changed = true;
  }
  
  // 4. Fix TS2345 string | string[]
  if (content.includes("id as string")) {
    // already handled
  } else if (content.match(/useParams\(\)/)) {
    // just cast useParams output to record
    content = content.replace(/const\s+\{\s*id\s*\}\s*=\s*useParams\(\);/g, "const { id } = useParams() as { id: string };");
    changed = true;
  }

  if (changed) fs.writeFileSync(file, content);
});

console.log("Fixes applied!");
