import os
import re
import json

LIB_DIR = '/Users/os2026/Downloads/Reservatior/mobile/lib'
TRANSLATIONS_DIR = '/Users/os2026/Downloads/Reservatior/mobile/assets/translations'
CLIENT_LOCALES_DIR = '/Users/os2026/Downloads/Reservatior/client/src/locales'

# Find all 'something'.tr() or "something".tr() in the Dart files
tr_pattern = re.compile(r"['\"]([^'\"]+)['\"]\.tr\(\)")

def extract_keys_from_dart(directory):
    keys = set()
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                try:
                    with open(filepath, 'r', encoding='utf-8') as f:
                        content = f.read()
                        matches = tr_pattern.findall(content)
                        for m in matches:
                            # Skip keys that contain interpolation or formatting variables
                            if '$' not in m and '{' not in m:
                                keys.add(m)
                except Exception as e:
                    print(f"Error reading {filepath}: {e}")
    return sorted(list(keys))

def format_default_value(key):
    # Try to make a readable label from the key
    parts = key.split('.')
    last_part = parts[-1]
    # Split camelCase
    words = re.sub(r'([A-Z])', r' \1', last_part).split()
    words = [w.capitalize() for w in words]
    # If it's a known auto key like mobile_auto_something
    if last_part.startswith('auto_') or 'auto' in key:
        clean = last_part.replace('auto_', '').replace('_', ' ')
        return clean.strip().capitalize()
    return ' '.join(words).strip()

def sync_missing_keys():
    print(f"🔍 Scanning ENTIRE lib directory ({LIB_DIR}) for .tr() keys...")
    used_keys = extract_keys_from_dart(LIB_DIR)
    print(f"Found {len(used_keys)} unique translation keys in all Dart files.")

    if not os.path.exists(TRANSLATIONS_DIR):
        print(f"Error: Translations directory {TRANSLATIONS_DIR} does not exist.")
        return

    # Load all JSON translation files
    json_files = [f for f in os.listdir(TRANSLATIONS_DIR) if f.endswith('.json')]
    print(f"Found {len(json_files)} translation languages.")

    for json_file in json_files:
        filepath = os.path.join(TRANSLATIONS_DIR, json_file)
        client_filepath = os.path.join(CLIENT_LOCALES_DIR, json_file)
        
        # Load mobile translations
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                data = json.load(f)
        except Exception as e:
            print(f"Error loading JSON {json_file}: {e}")
            continue

        # Load client translations if available
        client_data = {}
        if os.path.exists(client_filepath):
            try:
                with open(client_filepath, 'r', encoding='utf-8') as f:
                    client_data = json.load(f)
            except Exception as e:
                print(f"Error loading client JSON {json_file}: {e}")

        added_count = 0
        updated_from_client = 0
        
        for key in used_keys:
            # Case 1: Key is completely missing in mobile locales
            if key not in data:
                if key in client_data:
                    data[key] = client_data[key]
                    updated_from_client += 1
                else:
                    data[key] = format_default_value(key)
                added_count += 1
            # Case 2: Key exists but its value is a generic placeholder or equal to the key itself,
            # and we have a much better translation inside the client locales
            elif key in client_data:
                # If the translation is just a placeholder (camelCase formatted name or key itself),
                # always overwrite it with the high-quality client translation!
                current_val = data[key]
                placeholder = format_default_value(key)
                if current_val == placeholder or current_val == key or current_val == "":
                    if current_val != client_data[key]:
                        data[key] = client_data[key]
                        updated_from_client += 1
                        added_count += 1

        if added_count > 0:
            try:
                # Sort alphabetically to keep translations organized
                sorted_data = dict(sorted(data.items()))
                with open(filepath, 'w', encoding='utf-8') as f:
                    json.dump(sorted_data, f, indent=2, ensure_ascii=False)
                print(f"✅ Synced {json_file}: added/updated {added_count} keys ({updated_from_client} fetched from client locales)")
            except Exception as e:
                print(f"Error writing JSON {json_file}: {e}")
        else:
            print(f"✅ {json_file} is already 100% up to date.")

if __name__ == '__main__':
    sync_missing_keys()
