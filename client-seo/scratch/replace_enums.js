const fs = require('fs');
const path = require('path');

const dir = path.join(__dirname, '../src/app/[locale]/admin');

function getFiles(dirPath, arrayOfFiles) {
  files = fs.readdirSync(dirPath);
  arrayOfFiles = arrayOfFiles || [];
  files.forEach(function(file) {
    if (fs.statSync(dirPath + "/" + file).isDirectory()) {
      arrayOfFiles = getFiles(dirPath + "/" + file, arrayOfFiles);
    } else {
      if (file.endsWith('.tsx')) {
        arrayOfFiles.push(path.join(dirPath, "/", file));
      }
    }
  });
  return arrayOfFiles;
}

const files = getFiles(dir);

files.forEach(file => {
  let content = fs.readFileSync(file, 'utf8');

  // Replace <Badge className={STATUS_COLORS[foo.status]}>{foo.status}</Badge>
  // or <Badge className={STATUS_COLORS[foo.status]}>{foo.status.replace("_", " ")}</Badge>
  // with <Badge className={STATUS_COLORS[foo.status]}>{t("admin_status_" + foo.status.toLowerCase())}</Badge>
  
  // We look for: >{([a-zA-Z0-9_]+)\.status(\.replace\([^)]+\))?}</Badge>
  const badgeRegex = />{([a-zA-Z0-9_]+)\.status(?:\.replace\([^)]+\))?}<\/Badge>/g;
  
  if (badgeRegex.test(content)) {
    content = content.replace(badgeRegex, (match, p1) => {
      return `>{t("admin_status_" + ${p1}.status.toLowerCase())}</Badge>`;
    });
    fs.writeFileSync(file, content);
    console.log(`Updated enums in ${file}`);
  }
});
