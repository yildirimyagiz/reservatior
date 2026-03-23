#!/usr/bin/env python3
import os
import subprocess
import sys

features_dir = "lib/features"
features = sorted([f for f in os.listdir(features_dir) if os.path.isdir(os.path.join(features_dir, f))])

print("╔════════════════════════════════════════════════════════════════╗")
print("║         HIZLI MODÜL KONTROL (İlk 20 Modül)                   ║")
print("╚════════════════════════════════════════════════════════════════╝")
print()

error_summary = []

for i, feature in enumerate(features[:20], 1):
    feature_path = os.path.join(features_dir, feature)
    print(f"[{i}/20] {feature}...", end=" ", flush=True)
    
    try:
        result = subprocess.run(
            ["flutter", "analyze", feature_path],
            capture_output=True,
            text=True,
            timeout=10
        )
        
        output = result.stdout + result.stderr
        error_count = output.count("error •")
        warning_count = output.count("warning •")
        
        if error_count > 0:
            print(f"❌ {error_count} errors, {warning_count} warnings")
            error_summary.append((feature, error_count, warning_count))
        else:
            print(f"✅ Clean ({warning_count} warnings)")
    except subprocess.TimeoutExpired:
        print("⏱️ Timeout")
    except Exception as e:
        print(f"⚠️ Error: {e}")

print()
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("HATA ÖZETI:")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
for feature, errors, warnings in sorted(error_summary, key=lambda x: x[1], reverse=True):
    print(f"  {feature}: {errors} errors, {warnings} warnings")

print()
print(f"📊 Toplam kontrol edilen: 20 modül")
print(f"❌ Hatalı: {len(error_summary)} modül")
print(f"✅ Temiz: {20 - len(error_summary)} modül")
