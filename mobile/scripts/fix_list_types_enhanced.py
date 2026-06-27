
import os
import re

stores_dir = 'lib/shared/stores/'

def fix_types_in_store(filepath):
    with open(filepath, 'r') as f:
        content = f.read()
    
    # 1. Find all getters that return List<...> OR dynamic (already fixed by previous script might need further fix if not done correctly)
    list_getters = re.findall(r'(?:List<.*?>\?|dynamic) (\w+)\(', content)
    
    if not list_getters:
        return

    new_content = content
    for getter in list_getters:
        # Change getter return type to dynamic (if not already)
        new_content = re.sub(r'List<.*?>\? (' + getter + r')\(', r'dynamic \1(', new_content)
        
        # 2. Fix STREAM calls
        # (getManyByFieldValue\$|getByFieldValue\$)<.*?>\(\s*getPropVal: getter_name
        new_content = re.sub(r'(getManyByFieldValue\$|getByFieldValue\$)<.*?>\(\s*getPropVal: ' + getter, 
                             r'\1$<dynamic>(getPropVal: ' + getter, new_content)
        
        # 3. Fix SYNC calls
        # (getManyIncluding|getOneIncluding)\(\s*getter_name,
        # In ModelStore: getManyIncluding<W>(GetPropertyValueFunction<T, W> getPropVal, W value, ...)
        # If we just change the getPropVal return type to dynamic, the sync call might still have an issue if it passed a specific type for W.
        # But sync calls don't have explicit type parameters most of the time.
        
        # Example from WebhookStore:
        # List<Webhook> getByEvents(String events, ...) => getManyIncluding(getWebhookEvents, events, ...);
        # Change String events to dynamic events
        
        # 4. Fix getByX method signatures
        # Find getByX(String X, ...) where getPropertyX is a list getter
        # The getter name is built from the method name.
        # Example: getByEvents -> getWebhookEvents
        
        # Find all methods starting with getBy
        get_by_methods = re.findall(r'(\w+) getBy(\w+)\((\w+) (\w+),', new_content)
        for return_type, property_name, param_type, param_name in get_by_methods:
            # Reconstruct getter name (this might vary, but usually it involves the model name)
            # We can check if any list_getter contains 'property_name' (lowercased/uppercased)
            for lg in list_getters:
                if property_name.lower() in lg.lower():
                    # It's a match!
                    # Change param_type to dynamic
                    new_content = new_content.replace(f'getBy{property_name}({param_type} {param_name},', 
                                                     f'getBy{property_name}(dynamic {param_name},')
                    # And for STREAM version
                    new_content = new_content.replace(f'getBy{property_name}$({param_type} {param_name},', 
                                                     f'getBy{property_name}$(dynamic {param_name},')

    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        print(f'Enhanced fix in {filepath}')

for filename in os.listdir(stores_dir):
    if filename.endswith('_store.dart'):
        fix_types_in_store(os.path.join(stores_dir, filename))
