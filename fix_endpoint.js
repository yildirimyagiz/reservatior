const fs = require('fs');
const path = require('path');

const targetFiles = [
  "company/CompanyManagement.tsx",
  "documents/DocumentManagement.tsx",
  "financial/CouponsManagement.tsx",
  "financial/EscrowManagement.tsx",
  "financial/ExtraCharges.tsx",
  "financial/Invoices.tsx",
  "financial/Mortgages.tsx",
  "financial/Payments.tsx",
  "financial/Transactions.tsx",
  "invoices/CustomerInvoices.tsx",
  "marketing/MarketingAutomation.tsx",
  "membership/MembershipManagement.tsx",
  "organization/Organizations.tsx",
  "organization/SubscriptionManagement.tsx",
  "organization/UserManagement.tsx",
  "projects/ProjectDashboard.tsx",
  "property/AdminProperties.tsx",
  "property/PropertyPromotions.tsx",
  "reports/CustomReports.tsx",
  "reports/Reports.tsx",
  "reservations/Reservations.tsx",
  "security/AuditLogs.tsx",
  "security/SecurityEvents.tsx",
  "system/NotificationTemplates.tsx",
  "system/SystemManagement.tsx",
  "users/Organizations.tsx",
  "users/UserManagement.tsx",
  "users/Users.tsx",
  "vendors/VendorsManagement.tsx"
];

const workspacePath = path.join(__dirname, 'client/src/pages/admin');

targetFiles.forEach(target => {
  const fullPath = path.join(workspacePath, target);
  if (!fs.existsSync(fullPath)) return;

  let code = fs.readFileSync(fullPath, 'utf8');
  
  // Extract endpoint name from filename
  let endpointName = target.split('/').pop().replace('.tsx', '').toLowerCase();
  
  // Replace ${endpointName} with actual endpointName
  code = code.replace(/\$\{endpointName\}/g, endpointName);
  
  fs.writeFileSync(fullPath, code);
});
console.log("Fixed endpointName syntax errors.");
