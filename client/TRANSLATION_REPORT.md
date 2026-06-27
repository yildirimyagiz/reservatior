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

