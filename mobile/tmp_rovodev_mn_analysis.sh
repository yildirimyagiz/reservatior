#!/bin/bash
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "📊 DETAYLI ANALİZ"
echo "═══════════════════════════════════════════════════════════════"
echo ""

cd "lib/düzeltmeler/m-n_features_fixed/" 2>/dev/null || exit 1

total_admin=0
total_form=0

for module_dir in */; do
    module=$(basename "$module_dir")
    
    admin_page="$module_dir/presentation/pages/${module}_admin_page.dart"
    form_widget="$module_dir/presentation/widgets/${module}_form_widget.dart"
    
    if [ -f "$admin_page" ]; then
        ((total_admin++))
        admin="✅"
    else
        admin="❌"
    fi
    
    if [ -f "$form_widget" ]; then
        ((total_form++))
        form="✅"
    else
        form="❌"
    fi
    
    printf "%-35s | Admin: %-2s | Form: %-2s\n" "$module" "$admin" "$form"
done

echo ""
echo "───────────────────────────────────────────────────────────────"
echo "📊 TOPLAM:"
echo "   Admin Pages:  $total_admin"
echo "   Form Widgets: $total_form"
echo "   TOPLAM:       $((total_admin + total_form)) dosya"
echo "═══════════════════════════════════════════════════════════════"
