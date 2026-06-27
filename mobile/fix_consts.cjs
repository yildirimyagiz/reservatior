const fs = require('fs');

const files = [
  'lib/features/home/presentation/screens/home_screen.dart',
  'lib/features/property/presentation/pages/property_admin_page.dart',
  'lib/features/booking/presentation/pages/neural_booking_center.dart',
  'lib/features/settings/presentation/pages/settings_page.dart',
  'lib/features/notification/presentation/pages/notification_admin_page.dart',
  'lib/features/property/presentation/screens/property_details_screen.dart',
  'lib/features/message/presentation/screens/messages_screen.dart'
];

for (const file of files) {
  if (!fs.existsSync(file)) continue;
  let content = fs.readFileSync(file, 'utf8');
  
  // replace const [ ... .tr() ... ]
  content = content.replace(/const\s+\[([\s\S]*?)\]/g, (match, inner) => {
    if (inner.includes('.tr(')) return `[${inner}]`;
    return match;
  });

  // replace const Text( ... .tr() ... )
  content = content.replace(/const\s+Text\(([\s\S]*?)\)/g, (match, inner) => {
    if (inner.includes('.tr(')) return `Text(${inner})`;
    return match;
  });

  // replace const Tab( ... .tr() ... )
  content = content.replace(/const\s+Tab\(([\s\S]*?)\)/g, (match, inner) => {
    if (inner.includes('.tr(')) return `Tab(${inner})`;
    return match;
  });

  // replace const ListTile( ... .tr() ... )
  content = content.replace(/const\s+ListTile\(([\s\S]*?)\)/g, (match, inner) => {
    if (inner.includes('.tr(')) return `ListTile(${inner})`;
    return match;
  });

  fs.writeFileSync(file, content, 'utf8');
}
console.log('Fixed const issues');
