
import os
import re

stores_dir = 'lib/shared/stores/'

def fix_types_in_store(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    # 1. Find all getters that return List<...> OR already fixed dynamic
    list_getters = re.findall(r'(?:List<.*?>\?|dynamic) (\w+)\(', content)
    
    if not list_getters:
        return

    new_content = content
    # First, cleanup any accidental double $$
    new_content = new_content.replace('ByFieldValue$$', 'ByFieldValue$')

    for getter in list_getters:
        # Change getter return type to dynamic (ensure consistency)
        new_content = re.sub(r'List<.*?>\? (' + getter + r')\(', r'dynamic \1(', new_content)
        
        # 2. Fix STREAM calls
        # (getManyByFieldValue\$|getByFieldValue\$)<[^>]+>\(\s*getPropVal: getter_name
        new_content = re.sub(r'(getManyByFieldValue\$|getByFieldValue\$)<[^>]+>\(\s*getPropVal: ' + getter, 
                             r'\1<dynamic>(getPropVal: ' + getter, new_content)
        
        # 3. Find any method getByPropertyName(Type param, ...) where PropertyName corresponds to this getter
        match_suffix = re.search(r'get(?:[A-Z]\w+)?([A-Z]\w+)', getter)
        if match_suffix:
            suffix = match_suffix.group(1)
            # Find and replace sync version
            new_content = re.sub(r'(getBy' + suffix + r')\(\s*[^ ]+ ([^,]+),', r'\1(dynamic \2,', new_content)
            # Find and replace stream version
            new_content = re.sub(r'(getBy' + suffix + r'\$)\(\s*[^ ]+ ([^,]+),', r'\1(dynamic \2,', new_content)

    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Enhanced fix (v3) in {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_types_in_store(os.path.join(stores_dir, filename))
