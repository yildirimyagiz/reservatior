const fs = require('fs');
const path = require('path');

const LIB_DIR = '/Users/os2026/Downloads/Reservatior/mobile/lib';
const LOCALES_DIR = '/Users/os2026/Downloads/Reservatior/client/src/locales';
const MOBILE_LOCALES_DIR = '/Users/os2026/Downloads/Reservatior/mobile/assets/translations';

const textPattern1 = /Text\('([^$'\\]+)'\)/g;
const textPattern2 = /Text\("([^$"\\]+)"\)/g;
const constTextPattern1 = /const\s+Text\('([^$'\\]+)'\)/g;
const constTextPattern2 = /const\s+Text\("([^$"\\]+)"\)/g;
const labelPattern1 = /(labelText|hintText|tooltip):\s*'([^$'\\]+)'/g;
const labelPattern2 = /(labelText|hintText|tooltip):\s*"([^$"\\]+)"/g;

function toKey(text) {
    let safe = text.replace(/[^a-zA-Z0-9]/g, '_').toLowerCase();
    safe = safe.replace(/_+/g, '_').replace(/^_|_$/g, '');
    if (!safe) return null;
    return "mobile.auto." + safe.substring(0, 40);
}

function processDartFile(filepath, newKeys) {
    let content = fs.readFileSync(filepath, 'utf8');
    const original = content;

    const hasImport = content.includes("import 'package:easy_localization/easy_localization.dart';");

    function repl(match, p1) {
        if (!p1.trim()) return match;
        const key = toKey(p1);
        if (!key) return match;
        newKeys[key] = p1;
        return `Text('${key}'.tr())`;
    }

    function replLabel(match, attr, val) {
        if (!val.trim()) return match;
        const key = toKey(val);
        if (!key) return match;
        newKeys[key] = val;
        return `${attr}: '${key}'.tr()`;
    }

    content = content.replace(constTextPattern1, repl);
    content = content.replace(constTextPattern2, repl);
    content = content.replace(textPattern1, repl);
    content = content.replace(textPattern2, repl);
    content = content.replace(labelPattern1, replLabel);
    content = content.replace(labelPattern2, replLabel);

    if (content !== original) {
        if (!hasImport) {
            const imports = content.match(/^import\s+.*?;/gm);
            if (imports && imports.length > 0) {
                const lastImport = imports[imports.length - 1];
                content = content.replace(lastImport, lastImport + "\nimport 'package:easy_localization/easy_localization.dart';");
            } else {
                content = "import 'package:easy_localization/easy_localization.dart';\n" + content;
            }
        }

        content = content.replace(/\bconst\s+(Row|Column|Padding|Center|Expanded|Align|SizedBox|ListTile|TextFormField|Card|Container|Icon|ElevatedButton|OutlinedButton|TextButton|FloatingActionButton|Drawer|Scaffold|AppBar|BottomNavigationBar|TabBar|Tab|ListView|GridView|SingleChildScrollView|Stack|Positioned|Flexible|FractionallySizedBox|Spacer|Divider|CircularProgressIndicator|LinearProgressIndicator|Image|Tooltip|Text|InputDecoration|EdgeInsets|BoxDecoration|BorderRadius|Border|BoxShadow|Color|Colors)\b/g, '$1');
        content = content.replace(/\bconst\s+\[/g, '[');
        content = content.replace(/children:\s*const\s*\[/g, 'children: [');

        fs.writeFileSync(filepath, content, 'utf8');
        return true;
    }
    return false;
}

function walk(dir, fileList = []) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const filepath = path.join(dir, file);
        if (fs.statSync(filepath).isDirectory()) {
            walk(filepath, fileList);
        } else if (file.endsWith('.dart')) {
            fileList.push(filepath);
        }
    }
    return fileList;
}

function syncKeys(dir, newKeys) {
    if (!fs.existsSync(dir)) return;
    const files = fs.readdirSync(dir);
    for (const file of files) {
        if (file.endsWith('.json')) {
            const fp = path.join(dir, file);
            let data;
            try {
                data = JSON.parse(fs.readFileSync(fp, 'utf8'));
            } catch (e) {
                console.log(`Could not read ${fp}`);
                continue;
            }
            let added = 0;
            for (const [k, v] of Object.entries(newKeys)) {
                if (!(k in data)) {
                    data[k] = v;
                    added++;
                }
            }
            if (added > 0) {
                fs.writeFileSync(fp, JSON.stringify(data, null, 2) + '\n', 'utf8');
                console.log(`Added ${added} keys to ${fp}`);
            }
        }
    }
}

function main() {
    const newKeys = {};
    let changedFiles = 0;

    const files = walk(LIB_DIR);
    for (const file of files) {
        if (processDartFile(file, newKeys)) {
            changedFiles++;
        }
    }

    console.log(`Changed ${changedFiles} Dart files.`);
    const keyCount = Object.keys(newKeys).length;
    console.log(`Found ${keyCount} new translation keys.`);

    if (keyCount > 0) {
        syncKeys(LOCALES_DIR, newKeys);
        syncKeys(MOBILE_LOCALES_DIR, newKeys);
    }
}

main();
