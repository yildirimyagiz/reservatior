import os
import re
import json

LIB_DIR = '/Users/os2026/Downloads/Reservatior/mobile/lib'
LOCALES_DIR = '/Users/os2026/Downloads/Reservatior/client/src/locales'
MOBILE_LOCALES_DIR = '/Users/os2026/Downloads/Reservatior/mobile/assets/translations'

# Regex to find Text('...') or Text("...") without interpolation
text_pattern1 = re.compile(r"Text\('([^$'\\]+)'\)")
text_pattern2 = re.compile(r'Text\("([^$"\\]+)"\)')
const_text_pattern1 = re.compile(r"const\s+Text\('([^$'\\]+)'\)")
const_text_pattern2 = re.compile(r'const\s+Text\("([^$"\\]+)"\)')

# Regex to find labelText: '...' etc
label_pattern1 = re.compile(r"(labelText|hintText|tooltip):\s*'([^$'\\]+)'")
label_pattern2 = re.compile(r'(labelText|hintText|tooltip):\s*"([^$"\\]+)"')

def to_key(text):
    safe = "".join([c.lower() if c.isalnum() else '_' for c in text])
    safe = re.sub(r'_+', '_', safe).strip('_')
    if not safe:
        return None
    return "mobile.auto." + safe[:40]

def process_dart_file(filepath, new_keys):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original = content
    
    # Check if easy_localization is imported
    has_import = "import 'package:easy_localization/easy_localization.dart';" in content
    
    def repl(m):
        val = m.group(1)
        if len(val.strip()) == 0: return m.group(0)
        key = to_key(val)
        if not key: return m.group(0)
        new_keys[key] = val
        return f"Text('{key}'.tr())"
        
    def repl_label(m):
        attr = m.group(1)
        val = m.group(2)
        if len(val.strip()) == 0: return m.group(0)
        key = to_key(val)
        if not key: return m.group(0)
        new_keys[key] = val
        return f"{attr}: '{key}'.tr()"

    content = const_text_pattern1.sub(repl, content)
    content = const_text_pattern2.sub(repl, content)
    content = text_pattern1.sub(repl, content)
    content = text_pattern2.sub(repl, content)
    content = label_pattern1.sub(repl_label, content)
    content = label_pattern2.sub(repl_label, content)

    if content != original:
        if not has_import:
            # Add import after the last import
            imports = re.findall(r"^import\s+.*?;", content, re.MULTILINE)
            if imports:
                last_import = imports[-1]
                content = content.replace(last_import, last_import + "\nimport 'package:easy_localization/easy_localization.dart';")
            else:
                content = "import 'package:easy_localization/easy_localization.dart';\n" + content
                
        # Aggressive const removal to avoid build errors:
        # 1. Remove "const " before any widget name
        content = re.sub(r'\bconst\s+(Row|Column|Padding|Center|Expanded|Align|SizedBox|ListTile|TextFormField|Card|Container|Icon|ElevatedButton|OutlinedButton|TextButton|FloatingActionButton|Drawer|Scaffold|AppBar|BottomNavigationBar|TabBar|Tab|ListView|GridView|SingleChildScrollView|Stack|Positioned|Flexible|FractionallySizedBox|Spacer|Divider|CircularProgressIndicator|LinearProgressIndicator|Image|Tooltip|Text|InputDecoration|EdgeInsets|BoxDecoration|BorderRadius|Border|BoxShadow|Color|Colors)\b', r'\1', content)
        # 2. Remove "const [" to "["
        content = re.sub(r'\bconst\s+\[', r'[', content)
        # 3. Remove "children: const ["
        content = re.sub(r'children:\s*const\s*\[', r'children: [', content)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

def sync_keys(directory, new_keys):
    if not os.path.exists(directory): return
    for filename in os.listdir(directory):
        if filename.endswith('.json'):
            fp = os.path.join(directory, filename)
            try:
                with open(fp, 'r', encoding='utf-8') as f:
                    data = json.load(f)
            except Exception as e:
                print(f"Could not read {fp}, skipping.")
                continue
                
            added = 0
            for k, v in new_keys.items():
                if k not in data:
                    data[k] = v
                    added += 1
                    
            if added > 0:
                with open(fp, 'w', encoding='utf-8') as f:
                    json.dump(data, f, indent=2, ensure_ascii=False)
                    f.write('\n')
                print(f"Added {added} keys to {fp}.")

def main():
    new_keys = {}
    changed_files = 0
    
    for root, _, files in os.walk(LIB_DIR):
        for file in files:
            if file.endswith('.dart'):
                fp = os.path.join(root, file)
                if process_dart_file(fp, new_keys):
                    changed_files += 1
                    
    print(f"Changed {changed_files} Dart files.")
    print(f"Found {len(new_keys)} new translation keys.")
    
    if len(new_keys) > 0:
        sync_keys(LOCALES_DIR, new_keys)
        sync_keys(MOBILE_LOCALES_DIR, new_keys)

if __name__ == '__main__':
    main()
