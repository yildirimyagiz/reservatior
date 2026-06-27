
import os
import re

stores_dir = 'lib/shared/stores/'

def fix_types_in_store(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    # 1. Find all getters that return List<...>
    # Example: List<String>? getWebhookEvents(Webhook webhook) => webhook.events;
    list_getters = re.findall(r'List<.*?>\? (\w+)\(', content)
    
    if not list_getters:
        return

    new_content = content
    for getter in list_getters:
        # Change getter return type to dynamic
        new_content = re.sub(r'List<.*?>\? (' + getter + r')\(', r'dynamic \1(', new_content)
        
        # 2. Find all getManyByFieldValue$ or getByFieldValue$ calls that use this getter
        # Pattern: (getManyByFieldValue\$|getByFieldValue\$)<.*?>\(\s*getPropVal: getter_name
        
        def replace_call(match):
            call_name = match.group(1)
            return f'{call_name}$<dynamic>(getPropVal: {getter}'

        new_content = re.sub(r'(getManyByFieldValue\$|getByFieldValue\$)<.*?>\(\s*getPropVal: ' + getter, 
                             replace_call, new_content)

    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Fixed types in {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_types_in_store(os.path.join(stores_dir, filename))
