const fs = require("fs");

const overviewPath = "../mobile/lib/features/navigation/presentation/screens/features_overview_screen.dart";
let content = fs.readFileSync(overviewPath, "utf8");

const replacements = {
  "/admin/user_activity_log": "/activity",
  "/admin/user-activity-log": "/activity",
  "/admin/event": "/events",
  "/admin/export_file": "/files",
  "/admin/export-file": "/files",
  "/admin/ai": "/ai-studio",
  "/admin/recommendation_result": "/ai-recommendations",
  "/admin/recommendation-result": "/ai-recommendations",
  "/admin/deal": "/deals",
  "/admin/financial": "/financial",
  "/admin/organization": "/organization",
  "/admin/organizations": "/organization",
  "/admin/dashboard_widget": "/dashboard-widgets",
  "/admin/dashboard-widget": "/dashboard-widgets",
  "/admin/pricing_rule": "/pricing",
  "/admin/pricing-rule": "/pricing",
  "/admin/channel": "/channels",
  "/admin/property_promotion": "/listing-promotion"
};

for (const [oldRoute, newRoute] of Object.entries(replacements)) {
  content = content.replace(new RegExp(`'route':\\s*'${oldRoute}'`, 'g'), `'route': '${newRoute}'`);
}

fs.writeFileSync(overviewPath, content, "utf8");
console.log("Fixed custom routes in features_overview_screen.dart");
