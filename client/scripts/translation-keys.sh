#!/bin/bash

# Translation Keys Management Script
# This script helps manage and validate translation keys across all language files

echo "🌍 Translation Keys Management Tool"
echo "=================================="

LOCALES_DIR="public/locales"
ENGLISH_FILE="$LOCALES_DIR/en.json"

# Check if English file exists
if [ ! -f "$ENGLISH_FILE" ]; then
    echo "❌ English file not found: $ENGLISH_FILE"
    exit 1
fi

# Function to extract all keys from JSON file
extract_keys() {
    local file=$1
    local prefix=$2
    jq -r "paths(scalars) as \$p | \$p | join(\".\")" "$file" | sed "s/^/$prefix/"
}

# Function to check missing keys
check_missing_keys() {
    local source_file=$1
    local target_file=$2
    local lang_code=$3
    
    echo "🔍 Checking missing keys for $lang_code..."
    
    # Extract keys from source and target
    source_keys=$(extract_keys "$source_file" "")
    target_keys=$(extract_keys "$target_file" "")
    
    # Find missing keys
    missing_keys=$(comm -23 <(echo "$source_keys" | sort) <(echo "$target_keys" | sort))
    
    if [ -n "$missing_keys" ]; then
        echo "❌ Missing keys in $lang_code:"
        echo "$missing_keys" | sed 's/^/  - /'
        return 1
    else
        echo "✅ All keys present in $lang_code"
        return 0
    fi
}

# Function to generate translation documentation
generate_docs() {
    echo "📚 Generating Translation Documentation..."
    
    cat > TRANSLATION_KEYS.md << 'EOF'
# Translation Keys Documentation

This document contains all translation keys used in the application.

## Key Structure

Translation keys are organized in a hierarchical structure:

```
{
  "common": {
    "loading": "Loading...",
    "error": "Error"
  },
  "navigation": {
    "dashboard": "Dashboard",
    "properties": "Properties"
  }
}
```

## Available Languages

- English (en) - Base language
- Spanish (es)
- French (fr)
- German (de)
- Italian (it)
- Portuguese (pt)
- Russian (ru)
- Chinese (zh)
- Japanese (ja)
- Arabic (ar)

## Usage in React Components

```typescript
import { useTranslation } from 'react-i18next';

function MyComponent() {
  const { t } = useTranslation();
  
  return (
    <div>
      <h1>{t('navigation.dashboard')}</h1>
      <p>{t('common.loading')}</p>
    </div>
  );
}
```

## Adding New Translation Keys

1. Add the key to `public/locales/en.json`
2. Run this script to check for missing keys in other languages
3. Add translations to all language files
4. Test the application

## Key Naming Conventions

- Use lowercase with dots for nesting: `section.subsection.key`
- Be descriptive but concise
- Group related keys together
- Use consistent naming patterns

EOF

    echo "✅ Documentation generated: TRANSLATION_KEYS.md"
}

# Function to validate all translation files
validate_all() {
    echo "🔍 Validating all translation files..."
    
    local has_errors=false
    
    for file in "$LOCALES_DIR"/*.json; do
        if [ -f "$file" ]; then
            lang_code=$(basename "$file" .json)
            
            # Validate JSON syntax
            if ! jq empty "$file" 2>/dev/null; then
                echo "❌ Invalid JSON in $file"
                has_errors=true
                continue
            fi
            
            # Check missing keys (except English)
            if [ "$lang_code" != "en" ]; then
                if ! check_missing_keys "$ENGLISH_FILE" "$file" "$lang_code"; then
                    has_errors=true
                fi
            fi
        fi
    done
    
    if [ "$has_errors" = true ]; then
        echo "❌ Validation failed"
        return 1
    else
        echo "✅ All translation files are valid"
        return 0
    fi
}

# Function to add new key to all languages
add_key() {
    local key=$1
    local value=$2
    
    if [ -z "$key" ] || [ -z "$value" ]; then
        echo "❌ Usage: $0 add-key <key> <value>"
        exit 1
    fi
    
    echo "➕ Adding key '$key' with value '$value' to all languages..."
    
    for file in "$LOCALES_DIR"/*.json; do
        if [ -f "$file" ]; then
            lang_code=$(basename "$file" .json)
            
            # Add key to English file with provided value
            if [ "$lang_code" = "en" ]; then
                jq --arg key "$key" --arg value "$value" 'setpath($key | split("."); $value)' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
                echo "✅ Added to English: $key = $value"
            else
                # Add placeholder to other languages
                placeholder="[$key] - Translation needed"
                jq --arg key "$key" --arg value "$placeholder" 'setpath($key | split("."); $value)' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
                echo "⏳ Added placeholder to $lang_code: $key"
            fi
        fi
    done
}

# Function to show statistics
show_stats() {
    echo "📊 Translation Statistics:"
    echo "========================"
    
    for file in "$LOCALES_DIR"/*.json; do
        if [ -f "$file" ]; then
            lang_code=$(basename "$file" .json)
            key_count=$(jq 'paths(scalars) | length' "$file")
            file_size=$(du -h "$file" | cut -f1)
            echo "📄 $lang_code: $key_count keys, $file_size"
        fi
    done
}

# Main menu
case "${1:-}" in
    "validate")
        validate_all
        ;;
    "docs")
        generate_docs
        ;;
    "add-key")
        add_key "$2" "$3"
        ;;
    "stats")
        show_stats
        ;;
    "check-missing")
        for file in "$LOCALES_DIR"/*.json; do
            if [ -f "$file" ]; then
                lang_code=$(basename "$file" .json)
                if [ "$lang_code" != "en" ]; then
                    check_missing_keys "$ENGLISH_FILE" "$file" "$lang_code"
                fi
            fi
        done
        ;;
    *)
        echo "Usage: $0 {validate|docs|add-key|stats|check-missing}"
        echo ""
        echo "Commands:"
        echo "  validate      - Validate all translation files"
        echo "  docs          - Generate documentation"
        echo "  add-key       - Add new key to all languages"
        echo "  stats         - Show translation statistics"
        echo "  check-missing - Check for missing keys"
        exit 1
        ;;
esac
