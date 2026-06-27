const fs = require("fs");
const path = require("path");

const translationsDir = "assets/translations";
const files = fs.readdirSync(translationsDir).filter(f => f.endsWith(".json"));

let totalFixed = 0;

for (const file of files) {
  const filePath = path.join(translationsDir, file);
  const data = JSON.parse(fs.readFileSync(filePath, "utf8"));
  
  let fixedCount = 0;
  for (const [key, value] of Object.entries(data)) {
    if (typeof value === "string" && value.startsWith("feature.") && value.endsWith(".title")) {
      // It's a faulty title. Resolve it!
      if (data[value]) {
        data[key] = data[value];
        fixedCount++;
      } else {
        // Fallback: extract the name from the key
        const parts = value.split(".");
        if (parts.length >= 2) {
          const name = parts[1].replace(/([A-Z])/g, ' $1').replace(/^./, str => str.toUpperCase());
          data[key] = name;
          fixedCount++;
        }
      }
    }
  }
  
  if (fixedCount > 0) {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2), "utf8");
    console.log(`Fixed ${fixedCount} titles in ${file}`);
    totalFixed += fixedCount;
  }
}

console.log("Total fixed titles across all languages: " + totalFixed);
