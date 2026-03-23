#!/bin/bash

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║         TÜM MODÜLLER ANALYZE RAPORU                           ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Tüm feature klasörlerini al
features=$(ls -1 lib/features | sort)

total_features=0
features_with_errors=0
features_without_errors=0

> tmp_error_summary.txt

for feature in $features; do
  if [ -d "lib/features/$feature" ]; then
    total_features=$((total_features + 1))
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "[$total_features] Analyzing: $feature"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Analyze çalıştır ve sadece error satırlarını say
    error_count=$(flutter analyze "lib/features/$feature" 2>&1 | grep -c "error •")
    warning_count=$(flutter analyze "lib/features/$feature" 2>&1 | grep -c "warning •")
    info_count=$(flutter analyze "lib/features/$feature" 2>&1 | grep -c "info •")
    
    if [ $error_count -gt 0 ]; then
      echo "❌ ERRORS: $error_count | WARNINGS: $warning_count | INFO: $info_count"
      features_with_errors=$((features_with_errors + 1))
      echo "$feature: $error_count errors, $warning_count warnings" >> tmp_error_summary.txt
    else
      echo "✅ CLEAN | WARNINGS: $warning_count | INFO: $info_count"
      features_without_errors=$((features_without_errors + 1))
    fi
    echo ""
  fi
done

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    ÖZET RAPOR                                  ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Toplam Feature: $total_features"
echo "❌ Hatalı Modüller: $features_with_errors"
echo "✅ Temiz Modüller: $features_without_errors"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "En Çok Hatalı Modüller (İlk 10):"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sort -t':' -k2 -rn tmp_error_summary.txt | head -10
