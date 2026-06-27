const fs = require("fs");

const overviewPath = "../mobile/lib/features/navigation/presentation/screens/features_overview_screen.dart";
let content = fs.readFileSync(overviewPath, "utf8");

const replacements = {
  "/admin/message": "/messages",
  "/admin/contact": "/contact",
  "/admin/report": "/analytics",
  "/admin/lead": "/leads",
  "/admin/ticket": "/support",
  "/admin/listing": "/listings",
  "/admin/home": "/dashboard",
};

for (const [oldRoute, newRoute] of Object.entries(replacements)) {
  content = content.replace(new RegExp(`'route':\\s*'${oldRoute}'`, 'g'), `'route': '${newRoute}'`);
}

fs.writeFileSync(overviewPath, content, "utf8");
console.log("Fixed remaining custom routes in features_overview_screen.dart");
