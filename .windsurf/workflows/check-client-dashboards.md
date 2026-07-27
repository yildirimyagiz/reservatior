---
description: Check all client-side OS dashboards for API integration and completeness
---

# Check Client-Side Dashboards Workflow

This workflow checks all client-side OS dashboards to ensure they have proper API integration and are fully functional.

## Steps:

1. List all directories in `/client-seo/src/app/[locale]/client/` to identify all OS modules
2. For each OS module directory ending with `-os`:
   - Check if `page.tsx` exists
   - Check if `Dashboard.tsx` exists
   - Verify the Dashboard uses real API integration (not GenericOSDashboard placeholder)
   - Check if the corresponding API client exists in `/client-seo/src/lib/api/`
   - Verify the API client has `getDashboardStats` function
3. Generate a report showing:
   - Which dashboards have real API integration
   - Which dashboards are still using placeholders
   - Which API clients are missing
   - Any errors or inconsistencies found
