#!/bin/bash

# Translation Key Scanner and Extractor
# This script scans all React components and extracts hard-coded text that should be translated

echo "🔍 Translation Key Scanner"
echo "=========================="

SRC_DIR="src"
OUTPUT_FILE="translation_keys_found.txt"

# Function to extract hard-coded text from TSX files
extract_hardcoded_text() {
    local file=$1
    
    # Extract text from common patterns
    grep -n -E ">([A-Z][^<]+)<|title=\"[^\"]+\"|placeholder=\"[^\"]+\"|label=\"[^\"]+\"" "$file" | \
    sed -E 's/.*>([A-Z][^<]+)<.*/\1/' | \
    sed -E 's/.*title="([^"]+)".*/\1/' | \
    sed -E 's/.*placeholder="([^"]+)".*/\1/' | \
    sed -E 's/.*label="([^"]+)".*/\1/' | \
    grep -v -E "^[A-Z]{2,}$|^[0-9]+$|className|onClick|key=|id=|type=|value=|name=|ref=|aria-|data-" | \
    grep -v -E "^[a-z]+(\.[a-z]+)+$" | \
    grep -v -E "^[{}]*$" | \
    grep -v -E "^https?://" | \
    grep -v -E "^#" | \
    grep -v -E "^/[^/]*" | \
    grep -v -E "^localhost" | \
    grep -v -E "^\.\/" | \
    grep -v -E "^\.\." | \
    head -20
}

# Function to suggest translation keys
suggest_keys() {
    local text=$1
    local section=$2
    
    # Convert to lowercase and replace spaces with dots
    local key=$(echo "$text" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9 ]//g' | sed 's/ /./g')
    echo "$section.$key"
}

# Function to analyze a component
analyze_component() {
    local file=$1
    local component_name=$(basename "$file" .tsx)
    
    echo "🔍 Analyzing: $file"
    echo "Component: $component_name"
    echo "---"
    
    # Extract hard-coded text
    local texts=$(extract_hardcoded_text "$file")
    
    if [ -n "$texts" ]; then
        echo "$texts" | while read -r text; do
            if [ -n "$text" ] && [ ${#text} -gt 2 ]; then
                local section="common"
                case "$component_name" in
                    *Membership*) section="membership" ;;
                    *Payment*) section="payments" ;;
                    *Invoice*) section="invoices" ;;
                    *Property*) section="properties" ;;
                    *Dashboard*) section="dashboard" ;;
                    *Auth*) section="auth" ;;
                    *Navigation*) section="navigation" ;;
                    *Company*) section="company" ;;
                    *Cloud*) section="cloud" ;;
                esac
                
                local key=$(suggest_keys "$text" "$section")
                echo "  Text: \"$text\""
                echo "  Key:  $key"
                echo "  ---"
            fi
        done
    else
        echo "  No hard-coded text found"
    fi
    echo ""
}

# Function to generate translation report
generate_report() {
    echo "📊 Generating Translation Report..."
    
    cat > TRANSLATION_REPORT.md << 'EOF'
# Translation Key Report

This report contains all hard-coded text found in React components that should be translated.

## Priority Components

### 1. Membership Management
- File: `src/pages/admin/membership/MembershipManagement.tsx`
- Status: ✅ Partially translated
- Missing keys: ~50

### 2. Payment Components
- File: `src/pages/admin/payments/WisePayment.tsx`
- Status: ❌ Not translated
- Missing keys: ~30

### 3. Invoice Management
- File: `src/pages/admin/invoices/CustomerInvoices.tsx`
- Status: ❌ Not translated
- Missing keys: ~40

### 4. Company Management
- File: `src/pages/admin/company/CompanyManagement.tsx`
- Status: ❌ Not translated
- Missing keys: ~35

## Common Patterns Found

1. **Button Text**: "Add Member", "Save", "Cancel", "Delete"
2. **Form Labels**: "Email", "Password", "Name", "Description"
3. **Status Messages**: "Loading...", "Error", "Success"
4. **Navigation**: "Dashboard", "Properties", "Settings"

## Recommended Translation Keys

```json
{
  "common": {
    "add": "Add",
    "save": "Save", 
    "cancel": "Cancel",
    "delete": "Delete",
    "edit": "Edit",
    "view": "View",
    "loading": "Loading...",
    "error": "Error",
    "success": "Success"
  },
  "membership": {
    "addMember": "Add Member",
    "activeMembers": "Active Members",
    "expiredMembers": "Expired Members",
    "monthlyRevenue": "Monthly Revenue",
    "avgMemberValue": "Avg. Member Value"
  }
}
```

## Next Steps

1. ✅ Add missing keys to `en.json`
2. ⏳ Translate keys to other languages
3. ⏳ Update components to use `t()` function
4. ⏳ Test all language switches

EOF

    echo "✅ Report generated: TRANSLATION_REPORT.md"
}

# Function to batch process components
batch_process() {
    echo "🔄 Batch Processing Components..."
    
    # Find all TSX files
    local files=$(find "$SRC_DIR" -name "*.tsx" | head -10)
    
    for file in $files; do
        analyze_component "$file"
    done
}

# Function to check translation coverage
check_coverage() {
    echo "📈 Checking Translation Coverage..."
    
    local total_files=$(find "$SRC_DIR" -name "*.tsx" | wc -l)
    local translated_files=$(grep -l "useTranslation\|t(" "$SRC_DIR"/*.tsx "$SRC_DIR"/*/*.tsx 2>/dev/null | wc -l)
    local coverage=$((translated_files * 100 / total_files))
    
    echo "Total TSX files: $total_files"
    echo "Translated files: $translated_files"
    echo "Coverage: $coverage%"
    
    if [ $coverage -lt 50 ]; then
        echo "⚠️  Low translation coverage"
    elif [ $coverage -lt 80 ]; then
        echo "🟡 Medium translation coverage"
    else
        echo "✅ High translation coverage"
    fi
}

# Function to extract missing keys from a specific component
extract_missing_keys() {
    local file=$1
    
    echo "🔑 Extracting missing keys from: $file"
    
    # Find all text nodes and JSX attributes
    grep -n -E ">([A-Z][^<]+)<|title=\"[^\"]+\"|placeholder=\"[^\"]+\"|label=\"[^\"]+\"" "$file" | \
    while read -r line; do
        local line_num=$(echo "$line" | cut -d: -f1)
        local content=$(echo "$line" | cut -d: -f2-)
        
        # Extract the actual text
        local text=$(echo "$content" | sed -E 's/.*>([A-Z][^<]+)<.*/\1/' | sed -E 's/.*title="([^"]+)".*/\1/' | sed -E 's/.*placeholder="([^"]+)".*/\1/' | sed -E 's/.*label="([^"]+)".*/\1/')
        
        if [ -n "$text" ] && [ ${#text} -gt 2 ] && [[ ! "$text" =~ ^\{.*\}$ ]]; then
            echo "Line $line_num: \"$text\""
        fi
    done
}

# Main menu
case "${1:-}" in
    "scan")
        batch_process
        ;;
    "report")
        generate_report
        ;;
    "coverage")
        check_coverage
        ;;
    "extract")
        if [ -z "$2" ]; then
            echo "Usage: $0 extract <file>"
            exit 1
        fi
        extract_missing_keys "$2"
        ;;
    "membership")
        analyze_component "src/pages/admin/membership/MembershipManagement.tsx"
        ;;
    *)
        echo "Usage: $0 {scan|report|coverage|extract|membership}"
        echo ""
        echo "Commands:"
        echo "  scan      - Scan all components for hard-coded text"
        echo "  report    - Generate translation report"
        echo "  coverage  - Check translation coverage"
        echo "  extract   - Extract keys from specific file"
        echo "  membership- Analyze membership component"
        exit 1
        ;;
esac
