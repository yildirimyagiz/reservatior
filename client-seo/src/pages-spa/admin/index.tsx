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
  label: t("admin_index_agencies", "Agencies"),
  icon: 'Building2',
  category: 'crm'
}, {
  path: '/admin/agents',
  component: 'AgentsManagement',
  label: t("admin_index_agents", "Agents"),
  icon: 'UserCheck',
  category: 'crm'
}, {
  path: '/admin/vendors',
  component: 'VendorsManagement',
  label: t("admin_index_vendors", "Vendors"),
  icon: 'Wrench',
  category: 'crm'
}, {
  path: '/admin/contacts',
  component: 'ContactsManagement',
  label: t("admin_index_contacts", "Contacts"),
  icon: 'Users',
  category: 'crm'
},
// Operations
{
  path: '/admin/tasks',
  component: 'TasksManagement',
  label: t("admin_index_tasks", "Tasks"),
  icon: 'Activity',
  category: 'operations'
}, {
  path: '/admin/facilities',
  component: 'FacilitiesManagement',
  label: t("admin_index_facilities", "Facilities"),
  icon: 'Building',
  category: 'operations'
}, {
  path: '/admin/maintenance',
  component: 'MaintenanceManagement',
  label: t("admin_index_maintenance", "Maintenance"),
  icon: 'Wrench',
  category: 'operations'
},
// Analytics
{
  path: '/admin/analytics',
  component: 'AnalyticsDashboard',
  label: t("admin_index_analytics_dashboard"),
  icon: 'BarChart3',
  category: 'analytics'
}, {
  path: '/admin/service-analytics',
  component: 'AIServiceAnalytics',
  label: t("admin_index_ai_service_tracking"),
  icon: 'Brain',
  category: 'analytics'
},
// Security
{
  path: '/admin/advanced-security',
  component: 'AdvancedSecurity',
  label: t("admin_index_advanced_security"),
  icon: 'Shield',
  category: 'security'
},
// System
{
  path: '/admin/system-settings',
  component: 'SystemSettings',
  label: t("admin_index_system_settings"),
  icon: 'Settings',
  category: 'system'
},
// Communication
{
  path: '/admin/communication-templates',
  component: 'CommunicationTemplates',
  label: t("admin_index_communication_templates"),
  icon: 'Mail',
  category: 'communication'
},
// Documents
{
  path: '/admin/document-management',
  component: 'DocumentManagement',
  label: t("admin_index_document_management"),
  icon: 'FileText',
  category: 'documents'
},
// Location Services
{
  path: '/admin/location-services',
  component: 'LocationServices',
  label: t("admin_index_location_services"),
  icon: 'Map',
  category: 'location'
},
// Mobile Devices
{
  path: '/admin/mobile-devices',
  component: 'MobileDeviceManagement',
  label: t("admin_index_mobile_devices"),
  icon: 'Smartphone',
  category: 'mobile'
},
// AI Configuration
{
  path: '/admin/ai-configuration',
  component: 'AIConfiguration',
  label: t("admin_index_ai_configuration"),
  icon: 'Brain',
  category: 'ai'
},
// Custom Reports
{
  path: '/admin/custom-reports',
  component: 'CustomReports',
  label: t("admin_index_custom_reports"),
  icon: 'FileText',
  category: 'reports'
},
// Core
{
  path: '/admin/dashboard',
  component: 'Dashboard',
  label: t("admin_index_dashboard"),
  icon: 'LayoutDashboard',
  category: 'core'
},
// Users
{
  path: '/admin/users',
  component: 'Users',
  label: t("admin_index_users"),
  icon: 'Users',
  category: 'users'
}, {
  path: '/admin/organizations',
  component: 'Organizations',
  label: t("admin_index_organizations"),
  icon: 'Building2',
  category: 'users'
}, {
  path: '/admin/roles',
  component: 'Roles',
  label: t("admin_index_roles"),
  icon: 'Shield',
  category: 'users'
}, {
  path: '/admin/plans',
  component: 'Plans',
  label: t("admin_index_plans"),
  icon: 'CreditCard',
  category: 'users'
},
// Reports
{
  path: '/admin/reports',
  component: 'Reports',
  label: t("admin_index_reports"),
  icon: 'FileText',
  category: 'reports'
}, {
  path: '/admin/agent-performance',
  component: 'AgentPerformance',
  label: t("admin_index_agent_performance"),
  icon: 'TrendingUp',
  category: 'reports'
},
// Financial
{
  path: '/admin/financial-reports',
  component: 'FinancialReports',
  label: t("admin_index_financial_reports"),
  icon: 'DollarSign',
  category: 'financial'
}, {
  path: '/admin/payouts',
  component: 'Payouts',
  label: t("admin_index_payouts"),
  icon: 'Banknote',
  category: 'financial'
}, {
  path: '/admin/escrow',
  component: 'EscrowManagement',
  label: t("admin_index_escrow_management"),
  icon: 'Scale',
  category: 'financial'
}, {
  path: '/admin/coupons',
  component: 'CouponsManagement',
  label: t("admin_index_escrow_management"),
  icon: 'Scale',
  category: 'financial'
}, {
  path: '/admin/commission-distribution',
  component: 'CommissionDistribution',
  label: t("admin_index_sales_commissions"),
  icon: 'HandCoins',
  category: 'financial'
}, {
  path: '/admin/tax-settings',
  component: 'GlobalTaxSettings',
  label: t("admin_index_tax_compliance"),
  icon: 'Landmark',
  category: 'financial'
}, {
  path: '/admin/security-screening',
  component: 'SecurityScreening',
  label: t("admin_index_security_screening"),
  icon: 'ShieldCheck',
  category: 'security'
}, {
  path: '/admin/api-tokens',
  component: 'ApiTokens',
  label: t("admin_index_api_tokens"),
  icon: 'Key',
  category: 'security'
}, {
  path: '/admin/sessions',
  component: 'Sessions',
  label: t("admin_index_sessions"),
  icon: 'Monitor',
  category: 'security'
}, {
  path: '/admin/audit-logs',
  component: 'AuditLogs',
  label: t("admin_index_audit_logs"),
  icon: 'ScrollText',
  category: 'security'
}, {
  path: '/admin/security',
  component: 'SecurityOverview',
  label: t("admin_index_security_overview"),
  icon: 'Shield',
  category: 'security'
}, {
  path: '/admin/security-events',
  component: 'SecurityEvents',
  label: t("admin_index_security_events"),
  icon: 'ShieldAlert',
  category: 'security'
},
// System
{
  path: '/admin/system-metrics',
  component: 'SystemMetrics',
  label: t("admin_index_system_metrics"),
  icon: 'Activity',
  category: 'system'
}, {
  path: '/admin/attachments',
  component: 'Attachments',
  label: t("admin_index_attachments"),
  icon: 'Paperclip',
  category: 'system'
},
// Integrations
{
  path: '/admin/export-jobs',
  component: 'ExportJobs',
  label: t("admin_index_export_jobs"),
  icon: 'Download',
  category: 'integrations'
}, {
  path: '/admin/exports',
  component: 'Exports',
  label: t("admin_index_exports"),
  icon: 'FileDown',
  category: 'integrations'
}, {
  path: '/admin/mls-integration',
  component: 'MLSIntegration',
  label: t("admin_index_mls_integration"),
  icon: 'Link',
  category: 'integrations'
},
// Predict Price Engine
{
  path: '/admin/properties',
  component: 'AdminProperties',
  label: t("admin_index_portfolio_neural_hub"),
  icon: 'Building2',
  category: 'property'
}, {
  path: '/admin/ownership-verification',
  component: 'OwnershipVerification',
  label: t("admin_index_ownership_verification"),
  icon: 'ShieldCheck',
  category: 'property'
}, {
  path: '/admin/valuations',
  component: 'Valuations',
  label: t("admin_index_ai_valuations"),
  icon: 'Brain',
  category: 'property'
}, {
  path: '/admin/lead-conversions',
  component: 'LeadConversions',
  label: t("admin_index_lead_conversions"),
  icon: 'TrendingUp',
  category: 'property'
}, {
  path: '/admin/market-insights',
  component: 'MarketInsights',
  label: t("admin_index_market_insights"),
  icon: 'BarChart',
  category: 'property'
},
// Video Vendor System
{
  path: '/admin/video-vendors',
  component: 'VideoVendors',
  label: t("admin_index_video_vendors"),
  icon: 'Video',
  category: 'marketing'
}, {
  path: '/admin/video-partnerships',
  component: 'VideoVendorPartnerships',
  label: t("admin_index_vendor_partnerships"),
  icon: 'Handshake',
  category: 'marketing'
}, {
  path: '/admin/agent-videos',
  component: 'AgentVideos',
  label: t("admin_index_agent_videos"),
  icon: 'Camera',
  category: 'marketing'
},
// AI
{
  path: '/admin/ai-dashboard',
  component: 'AIDashboard',
  label: t("admin_index_ai_dashboard"),
  icon: 'Brain',
  category: 'ai'
}, {
  path: '/admin/ai-models',
  component: 'AIModels',
  label: t("admin_index_ai_models"),
  icon: 'Brain',
  category: 'ai'
},
// Marketing
{
  path: '/admin/marketing',
  component: 'MarketingAutomation',
  label: t("admin_index_marketing_automation"),
  icon: 'Megaphone',
  category: 'marketing'
}];
export const adminCategories = {
  crm: {
    label: t("admin_index_crm_agencies", "CRM & Agencies"),
    icon: 'Users',
    description: t("admin_index_manage_contacts_agents", "Manage contacts, agents, and vendors")
  },
  operations: {
    label: t("admin_index_operations", "Operations"),
    icon: 'Activity',
    description: t("admin_index_operations_desc", "Manage tasks, facilities, and maintenance")
  },
  core: {
    label: t("admin_index_core"),
    icon: 'LayoutDashboard',
    description: t("admin_index_main_admin_dashboard_and")
  },
  users: {
    label: t("admin_index_user_management"),
    icon: 'Users',
    description: t("admin_index_manage_users_organizations_roles")
  },
  financial: {
    label: t("admin_index_financial"),
    icon: 'DollarSign',
    description: t("admin_index_financial_reports_payouts_escrow")
  },
  reports: {
    label: t("admin_index_reports"),
    icon: 'FileText',
    description: t("admin_index_system_reports_and_analytics")
  },
  security: {
    label: t("admin_index_security"),
    icon: 'Shield',
    description: t("admin_index_security_access_control_and")
  },
  system: {
    label: t("admin_index_system"),
    icon: 'Settings',
    description: t("admin_index_system_metrics_and_configuration")
  },
  integrations: {
    label: t("admin_index_integrations"),
    icon: 'Plug',
    description: t("admin_index_thirdparty_integrations_mls_and")
  },
  ai: {
    label: t("admin_index_ai"),
    icon: 'Brain',
    description: t("admin_index_ai_model_monitoring_and")
  },
  property: {
    label: t("admin_index_predict_price_engine"),
    icon: 'Brain',
    description: t("admin_index_aipowered_property_valuations_lead")
  },
  marketing: {
    label: t("admin_index_video_vendor_system"),
    icon: 'Video',
    description: t("admin_index_video_vendor_management_partnerships")
  }
};