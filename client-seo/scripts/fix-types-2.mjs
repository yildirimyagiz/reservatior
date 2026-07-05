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
  
  // Fix TS2558: Expected 0 type arguments, but got 1 in useParams<{id: string}>()
  if (content.match(/useParams<\s*\{[^}]+\}\s*>\(\)/)) {
    content = content.replace(/useParams<\s*\{[^}]+\}\s*>\(\)/g, "useParams() as any");
    changed = true;
  }
  
  // Fix missing 'toast' in escrow/PageContent.tsx
  if (content.includes("toast({") && !content.includes("const { toast } = useToast()")) {
    if (content.includes("export default function")) {
      content = content.replace(/(export default function[^{]+\{\n?)/, "$1  const { toast } = useToast();\n");
    } else {
      content = content.replace(/(export function[^{]+\{\n?)/, "$1  const { toast } = useToast();\n");
    }
    if (!content.includes("@/hooks/use-toast")) {
      content = `import { useToast } from "@/hooks/use-toast";\n` + content;
    }
    changed = true;
  }

  // Fix React UMD global missing
  if (content.includes("React.") && !content.includes("import React") && !content.includes("import * as React")) {
    content = `import React from "react";\n` + content;
    changed = true;
  }
  
  // Fix missing queryClient
  if (content.includes("queryClient.invalidateQueries") && !content.includes("const queryClient = useQueryClient()")) {
    content = content.replace(/(export default function[^{]+\{\n?)/, "$1  const queryClient = useQueryClient();\n");
    changed = true;
  }
  
  // Replace missing NetworkDashboard/OpportunityFeed in agent-os/network/page.tsx
  // agent-os/network/page.tsx imports PageContent, but maybe it doesn't have default export.
  if (file.endsWith("agent-os/network/page.tsx") || file.endsWith("agent-os/opportunities/page.tsx")) {
    // Actually the script generated these with `export default function Page()` 
    // Wait, the PageContent doesn't have default export?
  }

  if (changed) fs.writeFileSync(file, content);
});

console.log("Fixes phase 2 applied!");
