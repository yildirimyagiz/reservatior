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
  
  // Fix multiple toast declarations
  // Find "const { toast } = useToast();" and see if there is another "toast" in useToast destructuring.
  if (content.match(/const\s+\{\s*toast\s*\}\s*=\s*useToast\(\);/)) {
    // Check if it's there twice or if there's a multi-line one
    const matches = content.match(/useToast\(\)/g);
    if (matches && matches.length > 1) {
      // It exists multiple times. Remove the exact one we injected: "  const { toast } = useToast();\n"
      content = content.replace(/  const \{ toast \} = useToast\(\);\n/, "");
      changed = true;
    }
  }

  // Fix "use client" position
  // If "use client" is not the very first line, move it to the top.
  if (content.includes('"use client";') || content.includes("'use client';")) {
    const lines = content.split("\n");
    let useClientIndex = -1;
    for (let i = 0; i < lines.length; i++) {
      if (lines[i].includes('"use client";') || lines[i].includes("'use client';")) {
        useClientIndex = i;
        break;
      }
    }
    
    // If it's not the first non-empty line
    if (useClientIndex > 0) {
      const useClientLine = lines[useClientIndex];
      lines.splice(useClientIndex, 1); // remove it
      lines.unshift(useClientLine); // add to top
      content = lines.join("\n");
      changed = true;
    }
  }

  if (changed) fs.writeFileSync(file, content);
});

console.log("Fixes phase 3 applied!");
