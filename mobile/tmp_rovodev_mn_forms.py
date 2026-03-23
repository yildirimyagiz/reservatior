#!/usr/bin/env python3
import re
import os

modules = [
    "maintenance_block", "maintenance_work_order", "map_data", "map_layer",
    "marketing_campaign", "mention", "message", "mls_data_mapping",
    "mls_listing_enhancement", "mobile_device", "mortgage", "mortgage_offer",
    "mortgage_pre_approval", "negotiation_offer", "neighborhood", "notification"
]

fixed_count = 0

for module in modules:
    src_path = f"lib/düzeltmeler/m-n_features_fixed/{module}/presentation/widgets/{module}_form_widget.dart"
    
    if not os.path.exists(src_path):
        continue
    
    with open(src_path, 'r') as f:
        lines = f.readlines()
    
    new_lines = []
    i = 0
    while i < len(lines):
        line = lines[i]
        new_lines.append(line)
        
        # Check if this is a decoration line in TextFormField
        if 'decoration:' in line and 'TextFormField' in ''.join(lines[max(0,i-5):i+1]):
            # Look ahead for onSaved
            for j in range(i+1, min(i+10, len(lines))):
                if 'onSaved:' in lines[j]:
                    # Extract variable name
                    match = re.search(r'_([a-zA-Z][a-zA-Z0-9_]*)\s*=', lines[j])
                    if match and 'initialValue:' not in ''.join(lines[i:j]):
                        var_name = match.group(1)
                        indent = ' ' * 16
                        new_lines.append(f"{indent}initialValue: _{var_name}?.toString() ?? '',\n")
                    break
        
        i += 1
    
    with open(src_path, 'w') as f:
        f.writelines(new_lines)
    
    print(f"✅ {module}")
    fixed_count += 1

print(f"\n✅ Toplam {fixed_count} form widget düzeltildi!")
