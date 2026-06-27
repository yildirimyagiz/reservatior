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
    if (typeof value === "string") {
      // Fix Turkish snake_case
      if (file === "tr.json" && value.match(/^Hiçbir [a-z_0-9]+ öğesi bulunamadı\.$/)) {
        data[key] = "Henüz kayıt bulunmamaktadır.";
        fixedCount++;
      }
      // Fix English snake_case
      else if (file === "en.json" && value.match(/^No [a-z_0-9]+ items found\.$/)) {
        data[key] = "No records found.";
        fixedCount++;
      }
    }
  }
  
  if (fixedCount > 0) {
    fs.writeFileSync(filePath, JSON.stringify(data, null, 2), "utf8");
    console.log(`Fixed ${fixedCount} empty messages in ${file}`);
    totalFixed += fixedCount;
  }
}

console.log("Total fixed empty messages across all languages: " + totalFixed);
