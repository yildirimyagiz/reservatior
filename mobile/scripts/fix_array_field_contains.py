
import os
import re

stores_dir = 'lib/shared/stores/'

def fix_array_field_contains(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    # Replace getManyByArrayFieldContains$<...> with getManyByFieldValue$<dynamic>
    new_content = re.sub(r'getManyByArrayFieldContains\$<[^>]+>', 'getManyByFieldValue$<dynamic>', content)
    
    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Fixed array field contains in {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_array_field_contains(os.path.join(stores_dir, filename))
