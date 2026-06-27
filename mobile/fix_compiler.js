const fs = require('fs');
const path = require('path');

function addImport(filePath) {
  let content = fs.readFileSync(filePath, 'utf8');
  if (!content.includes('package:easy_localization/easy_localization.dart')) {
    const importStr = "import 'package:easy_localization/easy_localization.dart';\n";
    if (content.includes('import ')) {
      content = content.replace(/import (.*?);\n/, (match) => match + importStr);
    } else {
      content = importStr + content;
    }
    fs.writeFileSync(filePath, content);
    console.log(`Added import to ${filePath}`);
  }
}

function removeConst(filePath, searchStrings) {
  let content = fs.readFileSync(filePath, 'utf8');
  let lines = content.split('\n');
  let changed = false;

  for (let i = 0; i < lines.length; i++) {
    for (const str of searchStrings) {
      if (lines[i].includes(str)) {
        if (lines[i].includes('const ')) {
          lines[i] = lines[i].replace(/const /g, '');
          changed = true;
        }
        for (let j = 1; j <= 5 && (i - j) >= 0; j++) {
           if (lines[i - j].includes('const ')) {
             lines[i - j] = lines[i - j].replace(/const /g, '');
             changed = true;
             break;
           }
        }
      }
    }
  }

  if (changed) {
    fs.writeFileSync(filePath, lines.join('\n'));
    console.log(`Removed const from ${filePath}`);
  }
}

function processDir(dir) {
  for (const f of fs.readdirSync(dir)) {
    const p = path.join(dir, f);
    if (fs.statSync(p).isDirectory()) {
      processDir(p);
    } else if (p.endsWith('.dart')) {
      const name = path.basename(p);
      
      // Need import
      if (['property_valuation_notifier.dart', 'subtitle_preview_widget.dart', 'listing.dart', 'location.dart', 'notification.dart', 'realtime_notification_service.dart', 'notification_analytics_service.dart'].includes(name)) {
        addImport(p);
      }
      
      // Need const removal
      if (name === 'ai_tool_details_screen.dart') {
        removeConst(p, ['mobile.leftovers.experience_ultimate_luxury_living_at_thi']);
      }
      if (name === 'push_notification_service.dart') {
        removeConst(p, [
          'mobile.leftovers.general_notifications',
          'mobile.leftovers.general_app_notifications',
          'mobile.leftovers.chat_and_communication_notifications',
          'mobile.leftovers.property_updates',
          'mobile.leftovers.property_related_notifications',
          'mobile.leftovers.system_and_maintenance_notifications'
        ]);
      }
    }
  }
}

processDir('/Users/os2026/Downloads/Reservatior/mobile/lib');
console.log("Fixes applied successfully.");
