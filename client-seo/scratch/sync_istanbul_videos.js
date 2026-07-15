const fs = require('fs');
const path = require('path');

const sourceDir = path.join(__dirname, '../../server/data/TURKİYE/ISTANBUL');
const manifestPath = path.join(__dirname, '../src/pages-spa/client/istanbul-videos.json');

function findMp4s(dir, fileList = []) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const filePath = path.join(dir, file);
    if (fs.statSync(filePath).isDirectory()) {
      findMp4s(filePath, fileList);
    } else if (file.toLowerCase().endsWith('.mp4')) {
      fileList.push(filePath);
    }
  }
  return fileList;
}

const allMp4s = findMp4s(sourceDir);
console.log(`Found ${allMp4s.length} MP4 files in ${sourceDir}`);

const manifest = [];
for (const filePath of allMp4s) {
  // Convert physical path to URL path
  const relPath = path.relative(sourceDir, filePath);
  // Ensure URL uses forward slashes, and encode URI components for spaces/special chars
  const urlPath = `/videos/istanbul/${relPath.split(path.sep).map(p => encodeURIComponent(p)).join('/')}`;
  manifest.push(urlPath);
}

fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));

console.log(`Successfully generated manifest with ${manifest.length} videos.`);
