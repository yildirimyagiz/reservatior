
import os
import re

stores_dir = 'lib/shared/stores/'

# Models and Stores that were incorrectly capitalized
replacements = {
    'MLSConnection': 'MlsConnection',
    'MLSExternalListing': 'MlsExternalListing',
    'MLSSyncJob': 'MlsSyncJob',
    'APIIntegration': 'ApiIntegration',
    'APIToken': 'ApiToken',
    'APIKey': 'ApiKey',
}

def fix_store_references(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    new_content = content
    for old, new in replacements.items():
        # Match whole words only
        new_content = re.sub(r'(?<!\w)' + old + r'(?!\w)', new, new_content)

    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Fixed capitalization in {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_store_references(os.path.join(stores_dir, filename))
