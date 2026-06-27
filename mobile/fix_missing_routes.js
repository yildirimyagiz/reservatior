const fs = require('fs');

const overviewFile = '/Users/os2026/Downloads/Reservatior/mobile/lib/features/navigation/presentation/screens/features_overview_screen.dart';
let content = fs.readFileSync(overviewFile, 'utf8');

const replacements = {
  "'/messages'": "'/admin/message'",
  "'/ai-studio'": "'/admin/ai'",
  "'/financial'": "'/admin/financial'",
  "'/deals'": "'/admin/deal'",
  "'/activity'": "'/admin/user-activity-log'",
  "'/events'": "'/admin/event'",
  "'/files'": "'/admin/export-file'",
  "'/organization'": "'/admin/organizations'",
  "'/widgets'": "'/admin/dashboard-widget'",
  "'/ai-recommendations'": "'/admin/recommendation-result'",
  "'/channels'": "'/admin/channel'",
  "'/listing-promotion'": "'/admin/property_promotion'",
  "'/pricing'": "'/admin/pricing-rule'"
};

for (const [oldVal, newVal] of Object.entries(replacements)) {
  content = content.replace(`'route': ${oldVal}`, `'route': ${newVal}`);
}

fs.writeFileSync(overviewFile, content);
console.log("Replaced invalid routes in features_overview_screen.dart");
