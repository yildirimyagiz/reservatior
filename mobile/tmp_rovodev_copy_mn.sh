#!/bin/bash
echo "═══════════════════════════════════════════════════════════════"
echo "📦 M-N DÜZELTMELERİ KOPYALANIYOR..."
echo "═══════════════════════════════════════════════════════════════"
echo ""

count=0
admin_count=0
form_count=0

cd "lib/düzeltmeler/m-n_features_fixed/"

for module_dir in */; do
    module=$(basename "$module_dir")
    
    # Handle special naming: ml__X -> m_l_X
    target_module="$module"
    if [[ "$module" == ml__* ]]; then
        target_module=$(echo "$module" | sed 's/ml__/m_l_/g' | sed 's/__/_/g')
    fi
    
    # Copy admin page
    admin_page="$module_dir/presentation/pages/${module}_admin_page.dart"
    if [ -f "$admin_page" ]; then
        target_dir="../../../lib/features/$target_module/presentation/pages/"
        mkdir -p "$target_dir"
        cp "$admin_page" "$target_dir${module}_admin_page.dart"
        echo "✅ $module → $target_module (admin page)"
        ((admin_count++))
        ((count++))
    fi
    
    # Copy form widget
    form_widget="$module_dir/presentation/widgets/${module}_form_widget.dart"
    if [ -f "$form_widget" ]; then
        target_dir="../../../lib/features/$target_module/presentation/widgets/"
        mkdir -p "$target_dir"
        cp "$form_widget" "$target_dir${module}_form_widget.dart"
        echo "✅ $module → $target_module (form widget)"
        ((form_count++))
        ((count++))
    fi
done

echo ""
echo "───────────────────────────────────────────────────────────────"
echo "📊 ÖZET:"
echo "  • Admin Pages:  $admin_count dosya"
echo "  • Form Widgets: $form_count dosya"
echo "  • TOPLAM:       $count dosya kopyalandı ✅"
echo "═══════════════════════════════════════════════════════════════"
