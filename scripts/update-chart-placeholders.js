#!/usr/bin/env node

/**
 * Script to update all chart placeholders with Recharts components
 * Usage: node scripts/update-chart-placeholders.js
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const searchDir = path.join(__dirname, '../client-seo/src/app/[locale]/client');

console.log('🔍 Finding chart placeholder files...\n');

// Find all files with chart placeholders
try {
  const cmd = `grep -r "will be rendered here" "${searchDir}" --include="*.tsx" -l`;
  const output = execSync(cmd, { encoding: 'utf8' });
  const files = output.trim().split('\n').filter(f => f);
  
  console.log(`📊 Found ${files.length} files with chart placeholders\n`);
  
  // Group by OS module
  const osModules = {};
  files.forEach(file => {
    const match = file.match(/\/client\/([^\/]+-os)\//);
    if (match) {
      const osModule = match[1];
      if (!osModules[osModule]) {
        osModules[osModule] = [];
      }
      osModules[osModule].push(file);
    }
  });
  
  console.log('🎯 OS Modules with chart placeholders:\n');
  Object.entries(osModules).forEach(([module, moduleFiles]) => {
    console.log(`  ${module}: ${moduleFiles.length} file(s)`);
  });
  
  console.log(`\n\n📋 Next steps:`);
  console.log(`  1. Update each OS module dashboard with chart components`);
  console.log(`  2. Add mock data for each chart`);
  console.log(`  3. Import chart components from @/components/charts`);
  
  console.log(`\n\n💡 Example update pattern:`);
  console.log(`  Replace: <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">`);
  console.log(`            <p className="text-gray-500">Chart will be rendered here</p>`);
  console(`          </div>`);
  console.log(`  With: <LineChart data={data} dataKey="value" xAxisKey="month" height={256} />`);
  
} catch (error) {
  console.log('No chart placeholders found');
}
