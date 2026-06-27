
import os
import re

stores_dir = 'lib/shared/stores/'

# Regex to find getBy$(...) with multiple parameters
# Pattern: storeInstance.getBy$(\n\s+id,\n\s+useCache: useCache,\n\s+modelFilter: modelFilter,\n\s+includes: includes)
# We want to keep only id and modelFilter.

pattern = re.compile(r'(getBy\$\(\s+[^,]+),\s+useCache: useCache,\s+modelFilter: modelFilter,\s+includes: includes\)', re.MULTILINE)

# Also handle cases where parameters are on the same line or differently spaced
pattern_all = re.compile(r'getBy\$\((.*?)\)', re.DOTALL)

def fix_store_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Simple strategy: for any getBy$ call, extract the arguments and keep only the first and modelFilter if present
    
    def replace_get_by(match):
        args_str = match.group(1)
        # Parse arguments
        args = [a.strip() for a in args_str.split(',')]
        new_args = []
        if len(args) > 0:
            new_args.append(args[0]) # The ID
        
        # Look for modelFilter
        for a in args:
            if 'modelFilter:' in a:
                new_args.append(a)
                break
        
        return f'getBy$({", ".join(new_args)})'

    new_content = re.sub(r'getBy\$\(([\s\S]*?)\)', replace_get_by, content)
    
    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Fixed {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_store_file(os.path.join(stores_dir, filename))
