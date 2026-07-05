"use client";

import { t } from "i18next";
// Admin Pages Index File
// This file exports all admin components for easy importing

// Core Admin Pages
export { default as Dashboard } from './core/Dashboard';
export { default as BookingsManagement } from './BookingsManagement';

// Analytics
export { default as AnalyticsDashboard } from './analytics/AnalyticsDashboard';
export { default as AIServiceAnalytics } from './analytics/AIServiceAnalytics';

// Security
export { default as AdvancedSecurity } from './security/AdvancedSecurity';

// System
export { default as SystemSettings } from './system/SystemSettings';

// Communication
export { default as CommunicationTemplates } from './communication/CommunicationTemplates';

// Documents
export { default as DocumentManagement } from './documents/DocumentManagement';

// Location Services
export { default as LocationServices } from './location/LocationServices';

// Mobile Devices
export { default as MobileDeviceManagement } from './mobile/MobileDeviceManagement';

// AI Configuration
export { default as AIConfiguration } from './ai/AIConfiguration';

// Custom Reports
export { default as CustomReports } from './reports/CustomReports';

// Video Vendor System

// AI
export { default as AIDashboard } from './ai/AIDashboard';
export { default as AIModels } from './ai/AIModels';
export { AIValuation as Valuations, Automation as AutomationRules } from './ai/AIPages';
export { default as LeadScoring } from './ai/LeadScoring';
export { default as SentimentAnalysis } from './ai/SentimentAnalysis';
export { default as FraudDetection } from './ai/FraudDetection';
export { default as PredictiveMaintenance } from './ai/PredictiveMaintenance';
export { default as PredictiveAnalytics } from './ai/PredictiveAnalytics';
export { default as AIChatManagement } from './ai/AIChatManagement';
export { default as AICustomModels } from './ai/Models';
export { default as AIAutomationRules } from './ai/AutomationRules';

// Financial Management
export { default as FinancialReports } from './financial/FinancialReports';
export { default as Payouts } from './financial/Payouts';
export { default as Payments } from './financial/Payments';
export { default as Expenses } from './financial/Expenses';
export { default as EscrowManagement } from './financial/EscrowManagement';
export { default as CouponsManagement } from './financial/CouponsManagement';
export { default as GlobalTaxSettings } from './financial/GlobalTaxSettings';
export { default as CommissionDistribution } from './sales/CommissionDistribution';

// User Management
export { default as Users } from './users/Users';
export { default as Organizations } from './users/Organizations';
export { default as Roles } from './users/Roles';
export { default as Plans } from './users/Plans';

// CRM & Agencies
export { default as AgenciesManagement } from './agencies/AgenciesManagement';
export { default as AgentsManagement } from './agents/AgentsManagement';
export { default as VendorsManagement } from './vendors/VendorsManagement';
export { default as ContactsManagement } from './contacts/ContactsManagement';

// Operations & Facilities
export { default as TasksManagement } from './tasks/TasksManagement';
export { default as FacilitiesManagement } from './facilities/FacilitiesManagement';
export { default as MaintenanceManagement } from './maintenance/MaintenanceManagement';

// Property & Trust
export { default as OwnershipVerification } from './properties/OwnershipVerification';
export { default as AdminProperties } from './properties/AdminProperties';

// Reports & Analytics
export { default as Reports } from './reports/Reports';
export { default as AgentPerformance } from './reports/AgentPerformance';

// Security & Access
export { default as ApiTokens } from './security/ApiTokens';
export { default as Sessions } from './security/Sessions';
export { default as AuditLogs } from './security/AuditLogs';
export { default as SecurityEvents } from './security/SecurityEvents';
export { default as SecurityOverview } from './security/SecurityOverview';
export { default as SecurityScreening } from './security/SecurityScreening';

// System Management
export { default as SystemMetrics } from './system/SystemMetrics';
export { default as Attachments } from './system/Attachments';

// Integrations
export { default as ExportJobs } from './integrations/ExportJobs';
export { default as Exports } from './integrations/Exports';
export { default as MLSIntegration } from './integrations/MLSIntegration';

// Marketing
export { default as MarketingAutomation } from './marketing/MarketingAutomation';

// Projects
export { default as ProjectDashboard } from './projects/ProjectDashboard';

// Compliance
export { default as ComplianceDashboard } from './compliance/ComplianceDashboard';

// Inventory
export { default as PropertyInventory } from './inventory/PropertyInventory';

// Scraping
export { default as ScrapingDashboard } from './scraping/ScrapingDashboard';

// Admin Routes Configuration
export const adminRoutes = [
// CRM & Agencies
{
  path: '/admin/agencies',
  component: 'AgenciesManagement',
  label: t("admin.index.agencies", "Agencies"),
  icon: 'Building2',
  category: 'crm'
}, {
  path: '/admin/agents',
  component: 'AgentsManagement',
  label: t("admin.index.agents", "Agents"),
  icon: 'UserCheck',
  category: 'crm'
}, {
  path: '/admin/vendors',
  component: 'VendorsManagement',
  label: t("admin.index.vendors", "Vendors"),
  icon: 'Wrench',
  category: 'crm'
}, {
  path: '/admin/contacts',
  component: 'ContactsManagement',
  label: t("admin.index.contacts", "Contacts"),
  icon: 'Users',
  category: 'crm'
},
// Operations
{
  path: '/admin/tasks',
  component: 'TasksManagement',
  label: t("admin.index.tasks", "Tasks"),
  icon: 'Activity',
  category: 'operations'
}, {
  path: '/admin/facilities',
  component: 'FacilitiesManagement',
  label: t("admin.index.facilities", "Facilities"),
  icon: 'Building',
  category: 'operations'
}, {
  path: '/admin/maintenance',
  component: 'MaintenanceManagement',
  label: t("admin.index.maintenance", "Maintenance"),
  icon: 'Wrench',
  category: 'operations'
},
// Analytics
{
  path: '/admin/analytics',
  component: 'AnalyticsDashboard',
  label: t("admin.index.analytics_dashboard"),
  icon: 'BarChart3',
  category: 'analytics'
}, {
  path: '/admin/service-analytics',
  component: 'AIServiceAnalytics',
  label: t("admin.index.ai_service_tracking"),
  icon: 'Brain',
  category: 'analytics'
},
// Security
{
  path: '/admin/advanced-security',
  component: 'AdvancedSecurity',
  label: t("admin.index.advanced_security"),
  icon: 'Shield',
  category: 'security'
},
// System
{
  path: '/admin/system-settings',
  component: 'SystemSettings',
  label: t("admin.index.system_settings"),
  icon: 'Settings',
  category: 'system'
},
// Communication
{
  path: '/admin/communication-templates',
  component: 'CommunicationTemplates',
  label: t("admin.index.communication_templates"),
  icon: 'Mail',
  category: 'communication'
},
// Documents
{
  path: '/admin/document-management',
  component: 'DocumentManagement',
  label: t("admin.index.document_management"),
  icon: 'FileText',
  category: 'documents'
},
// Location Services
{
  path: '/admin/location-services',
  component: 'LocationServices',
  label: t("admin.index.location_services"),
  icon: 'Map',
  category: 'location'
},
// Mobile Devices
{
  path: '/admin/mobile-devices',
  component: 'MobileDeviceManagement',
  label: t("admin.index.mobile_devices"),
  icon: 'Smartphone',
  category: 'mobile'
},
// AI Configuration
{
  path: '/admin/ai-configuration',
  component: 'AIConfiguration',
  label: t("admin.index.ai_configuration"),
  icon: 'Brain',
  category: 'ai'
},
// Custom Reports
{
  path: '/admin/custom-reports',
  component: 'CustomReports',
  label: t("admin.index.custom_reports"),
  icon: 'FileText',
  category: 'reports'
},
// Core
{
  path: '/admin/dashboard',
  component: 'Dashboard',
  label: t("admin.index.dashboard"),
  icon: 'LayoutDashboard',
  category: 'core'
},
// Users
{
  path: '/admin/users',
  component: 'Users',
  label: t("admin.index.users"),
  icon: 'Users',
  category: 'users'
}, {
  path: '/admin/organizations',
  component: 'Organizations',
  label: t("admin.index.organizations"),
  icon: 'Building2',
  category: 'users'
}, {
  path: '/admin/roles',
  component: 'Roles',
  label: t("admin.index.roles"),
  icon: 'Shield',
  category: 'users'
}, {
  path: '/admin/plans',
  component: 'Plans',
  label: t("admin.index.plans"),
  icon: 'CreditCard',
  category: 'users'
},
// Reports
{
  path: '/admin/reports',
  component: 'Reports',
  label: t("admin.index.reports"),
  icon: 'FileText',
  category: 'reports'
}, {
  path: '/admin/agent-performance',
  component: 'AgentPerformance',
  label: t("admin.index.agent_performance"),
  icon: 'TrendingUp',
  category: 'reports'
},
// Financial
{
  path: '/admin/financial-reports',
  component: 'FinancialReports',
  label: t("admin.index.financial_reports"),
  icon: 'DollarSign',
  category: 'financial'
}, {
  path: '/admin/payouts',
  component: 'Payouts',
  label: t("admin.index.payouts"),
  icon: 'Banknote',
  category: 'financial'
}, {
  path: '/admin/escrow',
  component: 'EscrowManagement',
  label: t("admin.index.escrow_management"),
  icon: 'Scale',
  category: 'financial'
}, {
  path: '/admin/coupons',
  component: 'CouponsManagement',
  label: t("admin.index.escrow_management"),
  icon: 'Scale',
  category: 'financial'
}, {
  path: '/admin/commission-distribution',
  component: 'CommissionDistribution',
  label: t("admin.index.sales_commissions"),
  icon: 'HandCoins',
  category: 'financial'
}, {
  path: '/admin/tax-settings',
  component: 'GlobalTaxSettings',
  label: t("admin.index.tax_compliance"),
  icon: 'Landmark',
  category: 'financial'
}, {
  path: '/admin/security-screening',
  component: 'SecurityScreening',
  label: t("admin.index.security_screening"),
  icon: 'ShieldCheck',
  category: 'security'
}, {
  path: '/admin/api-tokens',
  component: 'ApiTokens',
  label: t("admin.index.api_tokens"),
  icon: 'Key',
  category: 'security'
}, {
  path: '/admin/sessions',
  component: 'Sessions',
  label: t("admin.index.sessions"),
  icon: 'Monitor',
  category: 'security'
}, {
  path: '/admin/audit-logs',
  component: 'AuditLogs',
  label: t("admin.index.audit_logs"),
  icon: 'ScrollText',
  category: 'security'
}, {
  path: '/admin/security',
  component: 'SecurityOverview',
  label: t("admin.index.security_overview"),
  icon: 'Shield',
  category: 'security'
}, {
  path: '/admin/security-events',
  component: 'SecurityEvents',
  label: t("admin.index.security_events"),
  icon: 'ShieldAlert',
  category: 'security'
},
// System
{
  path: '/admin/system-metrics',
  component: 'SystemMetrics',
  label: t("admin.index.system_metrics"),
  icon: 'Activity',
  category: 'system'
}, {
  path: '/admin/attachments',
  component: 'Attachments',
  label: t("admin.index.attachments"),
  icon: 'Paperclip',
  category: 'system'
},
// Integrations
{
  path: '/admin/export-jobs',
  component: 'ExportJobs',
  label: t("admin.index.export_jobs"),
  icon: 'Download',
  category: 'integrations'
}, {
  path: '/admin/exports',
  component: 'Exports',
  label: t("admin.index.exports"),
  icon: 'FileDown',
  category: 'integrations'
}, {
  path: '/admin/mls-integration',
  component: 'MLSIntegration',
  label: t("admin.index.mls_integration"),
  icon: 'Link',
  category: 'integrations'
},
// Predict Price Engine
{
  path: '/admin/properties',
  component: 'AdminProperties',
  label: t("admin.index.portfolio_neural_hub"),
  icon: 'Building2',
  category: 'property'
}, {
  path: '/admin/ownership-verification',
  component: 'OwnershipVerification',
  label: t("admin.index.ownership_verification"),
  icon: 'ShieldCheck',
  category: 'property'
}, {
  path: '/admin/valuations',
  component: 'Valuations',
  label: t("admin.index.ai_valuations"),
  icon: 'Brain',
  category: 'property'
}, {
  path: '/admin/lead-conversions',
  component: 'LeadConversions',
  label: t("admin.index.lead_conversions"),
  icon: 'TrendingUp',
  category: 'property'
}, {
  path: '/admin/market-insights',
  component: 'MarketInsights',
  label: t("admin.index.market_insights"),
  icon: 'BarChart',
  category: 'property'
},
// Video Vendor System
{
  path: '/admin/video-vendors',
  component: 'VideoVendors',
  label: t("admin.index.video_vendors"),
  icon: 'Video',
  category: 'marketing'
}, {
  path: '/admin/video-partnerships',
  component: 'VideoVendorPartnerships',
  label: t("admin.index.vendor_partnerships"),
  icon: 'Handshake',
  category: 'marketing'
}, {
  path: '/admin/agent-videos',
  component: 'AgentVideos',
  label: t("admin.index.agent_videos"),
  icon: 'Camera',
  category: 'marketing'
},
// AI
{
  path: '/admin/ai-dashboard',
  component: 'AIDashboard',
  label: t("admin.index.ai_dashboard"),
  icon: 'Brain',
  category: 'ai'
}, {
  path: '/admin/ai-models',
  component: 'AIModels',
  label: t("admin.index.ai_models"),
  icon: 'Brain',
  category: 'ai'
},
// Marketing
{
  path: '/admin/marketing',
  component: 'MarketingAutomation',
  label: t("admin.index.marketing_automation"),
  icon: 'Megaphone',
  category: 'marketing'
}];
export const adminCategories = {
  crm: {
    label: t("admin.index.crm_agencies", "CRM & Agencies"),
    icon: 'Users',
    description: t("admin.index.manage_contacts_agents", "Manage contacts, agents, and vendors")
  },
  operations: {
    label: t("admin.index.operations", "Operations"),
    icon: 'Activity',
    description: t("admin.index.operations_desc", "Manage tasks, facilities, and maintenance")
  },
  core: {
    label: t("admin.index.core"),
    icon: 'LayoutDashboard',
    description: t("admin.index.main_admin_dashboard_and")
  },
  users: {
    label: t("admin.index.user_management"),
    icon: 'Users',
    description: t("admin.index.manage_users_organizations_roles")
  },
  financial: {
    label: t("admin.index.financial"),
    icon: 'DollarSign',
    description: t("admin.index.financial_reports_payouts_escrow")
  },
  reports: {
    label: t("admin.index.reports"),
    icon: 'FileText',
    description: t("admin.index.system_reports_and_analytics")
  },
  security: {
    label: t("admin.index.security"),
    icon: 'Shield',
    description: t("admin.index.security_access_control_and")
  },
  system: {
    label: t("admin.index.system"),
    icon: 'Settings',
    description: t("admin.index.system_metrics_and_configuration")
  },
  integrations: {
    label: t("admin.index.integrations"),
    icon: 'Plug',
    description: t("admin.index.thirdparty_integrations_mls_and")
  },
  ai: {
    label: t("admin.index.ai"),
    icon: 'Brain',
    description: t("admin.index.ai_model_monitoring_and")
  },
  property: {
    label: t("admin.index.predict_price_engine"),
    icon: 'Brain',
    description: t("admin.index.aipowered_property_valuations_lead")
  },
  marketing: {
    label: t("admin.index.video_vendor_system"),
    icon: 'Video',
    description: t("admin.index.video_vendor_management_partnerships")
  }
};