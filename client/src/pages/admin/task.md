# Admin Modules Backend Entegrasyon Takibi

## Status Key
- [x] Tamamlandı (full CRUD + dark theme + API)

## Modules

### Agencies
- [x] PartnerAgreements.tsx — apiClient, dark theme, create + state transition dialog

### AI
- [x] AIDashboard.tsx — removed dead dialog, replaced static data with useQuery + apiClient, dark theme
- [x] Analytics.tsx — dark theme, recharts charts, static data
- [x] Dashboard.tsx — dark theme, recharts charts, static data
- [x] FraudDetection.tsx — apiClient, useQuery, remove duplicate isAddOpen, dark theme
- [x] MLTasks.tsx — apiClient, useQuery with refetchInterval, create dialog, dark theme
- [x] Models.tsx — apiClient, useQuery, create/register dialog, dark theme
- [x] PredictiveAnalytics.tsx — apiClient, useQuery (maintenance + price predictions), dark theme
- [x] SentimentAnalysis.tsx — apiClient, useQuery, dark theme

### Analytics
- [x] AIServiceAnalytics.tsx — apiClient, useQuery, dark theme
- [x] Analytics.tsx — dark theme, recharts charts, static data
- [x] AnalyticsDashboard.tsx — removed PageShell, dark theme, useQuery with mock fallback

### Billing
- [x] Billing.tsx — removed static mock, useQuery + apiClient for invoices/plans, dark theme

### Cloud
- [x] GoogleCloudManager.tsx — removed PageShell, dark theme, useQuery/useMutation

### Compliance
- [x] ComplianceDashboard.tsx — removed PageShell, useQuery, dark theme

### Core
- [x] Dashboard.tsx — removed PageShell, useQuery, dark theme + recharts

### Dynamic
- [x] DynamicAdminPage.tsx — apiClient, useQuery/useMutation, fix duplicate toast/isAddOpen, dark theme

### Escrow
- [x] EscrowDashboard.tsx — removed PageShell, added useQuery/apiClient, create + release dialogs, dark theme

### Financial
- [x] CommissionRules.tsx — removed PageShell, useQuery, full CRUD with edit/delete dialogs, dark theme
- [x] Commissions.tsx — removed PageShell/mock, useQuery + full CRUD, dark theme
- [x] EscrowManagement.tsx — removed PageShell, fixed API endpoints, create dialog, dark theme tabs
- [x] FinancialReports.tsx — removed PageShell, unused dialog imports, dark theme + recharts
- [x] GlobalTaxSettings.tsx — removed PageShell, apiClient (globalTaxApi), dark theme
- [x] Reports.tsx — replaced static mock with useQuery (dashboard-analytics + reports), dark theme
- [x] Transactions.tsx — add create dialog, dark theme, computed categories, removed mock data

### Integrations
- [x] B2BHotelIntegrations.tsx — apiClient, useQuery, dark theme

### Inventory
- [x] PropertyInventory.tsx — apiClient, useQuery/useMutation, dark theme

### Invoices
- [x] CustomerInvoices.tsx — apiClient, useQuery/useMutation, dark theme

### Layout
- [x] AdminLayout.tsx — dark theme sidebar/nav

### Marketing
- [x] MarketingAutomation.tsx — apiClient, useQuery/useMutation, dark theme

### Membership
- [x] MembershipManagement.tsx — apiClient, useQuery/useMutation, dark theme

### Payments
- [x] WisePayment.tsx — removed PageShell/useEffect, useQuery + useMutation, dark theme

### Projects
- [x] DigitalTwin.tsx — dark theme, hover cards
- [x] ProjectDashboard.tsx — apiClient, useQuery/useMutation, dark theme

### Property
- [x] AdminProperties.tsx — apiClient, useQuery/useMutation, dark theme
- [x] OwnershipVerification.tsx — apiClient, useQuery/useMutation, dark theme
- [x] PropertyAnalytics.tsx — apiClient, useQuery, dark theme
- [x] PropertyInventory.tsx — apiClient, useQuery/useMutation, dark theme
- [x] PropertyViewings.tsx — apiClient, useQuery/useMutation, dark theme

### Reports
- [x] Reports.tsx — removed PageShell, apiClient, useQuery/mutation, dark theme

### Sales
- [x] CommissionDistribution.tsx — apiClient, useQuery, dark theme

### Scraping
- [x] ScrapingDashboard.tsx — apiClient, useQuery, dark theme

### Security
- [x] SecurityEvents.tsx — removed PageShell, apiClient, useQuery/mutation, dark theme
- [x] SecurityOverview.tsx — dark theme, static data
- [x] SecurityScreening.tsx — apiClient, useQuery, dark theme
- [x] Sessions.tsx — apiClient, useQuery, dark theme

### Settings
- [x] Settings.tsx — apiClient, dark theme

### System
- [x] SystemManagement.tsx — apiClient, useQuery, dark theme
- [x] SystemMonitoring.tsx — dark theme, static data

### Additional Completed (pre-existing)
- [x] company/CompanyManagement.tsx
- [x] financial/Invoices.tsx
- [x] financial/Mortgages.tsx
- [x] users/UserManagement.tsx
- [x] vendors/VendorsManagement.tsx
