
import os

stores_dir = 'lib/shared/stores/'

replacements = {
    'MLSConnection': 'MlsConnection',
    'MLSExternalListing': 'MlsExternalListing',
    'MLSSyncJob': 'MlsSyncJob',
    'APIIntegration': 'ApiIntegration',
    'APIToken': 'ApiToken',
    'APIKey': 'ApiKey',
}

def fix_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    new_content = content
    for old, new in replacements.items():
        new_content = new_content.replace(old, new)
    
    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Replaced acronyms in {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_file(os.path.join(stores_dir, filename))
