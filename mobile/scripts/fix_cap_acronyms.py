
import os
import re

stores_dir = 'lib/shared/stores/'

# Models that were incorrectly capitalized in store references
replacements = {
    'MLSConnection': 'MlsConnection',
    'MLSExternalListing': 'MlsExternalListing',
    'MLSSyncJob': 'MlsSyncJob',
    'APIIntegration': 'ApiIntegration',
    # Add more if found in analysis
}

def fix_store_references(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    new_content = content
    for old, new in replacements.items():
        # Replace only when used as a type or property (not in store class names usually)
        # We target things like ModelFilter<OLD>, List<OLD>, OLD org, etc.
        # But wait! If we do it globally it might be safer IF the class name really should be the new one everywhere EXCEPT where it's part of another word.
        
        # Avoid replacing OLDStore or OLDInclude (unless they are also wrong)
        # Actually, let's target specific patterns:
        new_content = re.sub(r'(?<!\w)' + old + r'(?!\w|Store|Include|Endpoints)', new, new_content)

    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Fixed model name capitalization in {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_store_references(os.path.join(stores_dir, filename))
