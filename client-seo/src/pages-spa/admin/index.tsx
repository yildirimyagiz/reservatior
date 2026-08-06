"use client";

import { t } from"i18next";
import React from "react";
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
export { default as AiVideoGeneration } from './ai/AiVideoGeneration';

// Financial Management
export { default as FinancialReports } from './financial/FinancialReports';
export { default as Payouts } from './financial/Payouts';
export { default as Payments } from './financial/Payments';
export { default as Expenses } from './financial/Expenses';
export { default as EscrowManagement } from './financial/EscrowManagement';
export { default as CouponsManagement } from './financial/CouponsManagement';
export const GlobalTaxSettings = React.lazy(() => import('./financial/GlobalTaxSettings'));
export const CommissionDistribution = React.lazy(() => import('./sales/CommissionDistribution'));
export const GMSITaxReport = React.lazy(() => import('../financial/GMSITaxReport'));
export const EDevletContractWizard = React.lazy(() => import('../edevlet-contract/EDevletContractWizard'));

// Intelligence & Passports
export const PropertyPassport = React.lazy(() => import('./intelligence/PropertyPassport'));
export const MarketPassport = React.lazy(() => import('./intelligence/MarketPassport'));
export const UserPassport = React.lazy(() => import('./intelligence/UserPassport'));
export const AgentPassport = React.lazy(() => import('./intelligence/AgentPassport'));
export const DecisionEngine = React.lazy(() => import('./intelligence/DecisionEngine'));
export const FeedbackLoop = React.lazy(() => import('./intelligence/FeedbackLoop'));
export const ContentPublisher = React.lazy(() => import('./intelligence/ContentPublisher'));
export const RevenueIntelligence = React.lazy(() => import('./intelligence/RevenueIntelligence'));
export const HybridRentalEngine = React.lazy(() => import('./intelligence/HybridRentalEngine'));
export const HybridRentalOSModule = React.lazy(() => import('./intelligence/HybridRentalOSModule'));
export const IntelligenceGraph = React.lazy(() => import('./intelligence/IntelligenceGraph'));
export const SEOGenerator = React.lazy(() => import('./intelligence/SEOGenerator'));

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
 label: t("admin_index_agencies", "Acenteler"),
 icon: 'Building2',
 category: 'crm'
}, {
 path: '/admin/agents',
 component: 'AgentsManagement',
 label: t("admin_index_agents", "Temsilciler"),
 icon: 'UserCheck',
 category: 'crm'
}, {
 path: '/admin/vendors',
 component: 'VendorsManagement',
 label: t("admin_index_vendors", "Satıcılar"),
 icon: 'Wrench',
 category: 'crm'
}, {
 path: '/admin/contacts',
 component: 'ContactsManagement',
 label: t("admin_index_contacts", "Kişiler"),
 icon: 'Users',
 category: 'crm'
},
// Operations
{
 path: '/admin/tasks',
 component: 'TasksManagement',
 label: t("admin_index_tasks", "Görevler"),
 icon: 'Activity',
 category: 'operations'
}, {
 path: '/admin/facilities',
 component: 'FacilitiesManagement',
 label: t("admin_index_facilities", "Tesisler"),
 icon: 'Building',
 category: 'operations'
}, {
 path: '/admin/maintenance',
 component: 'MaintenanceManagement',
 label: t("admin_index_maintenance", "Bakım"),
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
 path: '/admin/gmsi-tax-report',
 component: 'GMSITaxReport',
 label: t("admin_index_gmsi_tax_report", "GMSİ Vergi Beyannamesi"),
 icon: 'FileText',
 category: 'financial'
}, {
 path: '/admin/edevlet-contract-wizard',
 component: 'EDevletContractWizard',
 label: t("admin_index_edevlet_contract_wizard", "e-Devlet & Platform İlan Onayı"),
 icon: 'Building2',
 category: 'financial'
}, {
 path: '/admin/certificates',
 component: 'Certificates',
 label: t("admin_index_certificates", "Sertifikalar & Lisanslar"),
 icon: 'Award',
 category: 'intelligence'
}, {
 path: '/admin/property-passport',
 component: 'PropertyPassport',
 label: t("admin_index_property_passport", "Mülk Pasaportu & Kimlik"),
 icon: 'Building2',
 category: 'intelligence'
}, {
 path: '/admin/market-passport',
 component: 'MarketPassport',
 label: t("admin_index_market_passport", "Piyasa Pasaportu & Analitik"),
 icon: 'Globe',
 category: 'intelligence'
}, {
 path: '/admin/user-passport',
 component: 'UserPassport',
 label: t("admin_index_user_passport", "Kullanıcı Pasaportu & İtibar"),
 icon: 'Users',
 category: 'intelligence'
}, {
 path: '/admin/decision-engine',
 component: 'DecisionEngine',
 label: t("admin_index_decision_engine", "Yapay Zeka Karar Motoru"),
 icon: 'Zap',
 category: 'intelligence'
}, {
 path: '/admin/feedback-loop',
 component: 'FeedbackLoop',
 label: t("admin_index_feedback_loop", "Öğrenme & Geri Bildirim Döngüsü"),
 icon: 'Activity',
 category: 'intelligence'
}, {
 path: '/admin/content-publisher',
 component: 'ContentPublisher',
 label: t("admin_index_content_publisher", "Otomatik İçerik Yayıncısı"),
 icon: 'Megaphone',
 category: 'intelligence'
}, {
  path: '/admin/revenue-intelligence',
  component: 'RevenueIntelligence',
  label: t("admin_index_revenue_intelligence", "Gelir Zekası & Arbitraj"),
  icon: 'DollarSign',
  category: 'intelligence'
 }, {
  path: '/admin/hybrid-rental-engine',
  component: 'HybridRentalEngine',
  label: t("admin_index_hybrid_rental_engine", "Hibrit Kiralama Karar Motoru"),
  icon: 'Brain',
  category: 'intelligence'
 }, {
  path: '/admin/hybrid-rental-os',
  component: 'HybridRentalOSModule',
  label: t("admin_index_hybrid_rental_os", "Hibrit Kiralama & Gelir OS Modülü"),
  icon: 'Cpu',
  category: 'intelligence'
  }, {
  path: '/admin/agent-passport',
  component: 'AgentPassport',
  label: t("admin_index_agent_passport", "Danışman / Ajan Passport (Danışman Karnesi)"),
  icon: 'Star',
  category: 'intelligence'
 }, {
  path: '/admin/intelligence-graph',
  component: 'IntelligenceGraph',
  label: t("admin_index_intelligence_graph", "Zeka Grafiği (Intelligence Graph)"),
  icon: 'Brain',
  category: 'intelligence'
 }, {
  path: '/admin/seo-generator',
  component: 'SEOGenerator',
  label: t("admin_index_seo_generator", "Otomatik SEO Üretici"),
  icon: 'Search',
  category: 'intelligence'
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
 path: '/admin/ai-video',
 component: 'AiVideoGeneration',
 label: t("admin_layout_ai_video_generation", "AI Video Üretim Motoru"),
 icon: 'Sparkles',
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
 label: t("admin_index_crm_agencies", "CRM ve Ajanslar"),
 icon: 'Users',
 description: t("admin_index_manage_contacts_agents", "Kişileri, acenteleri ve satıcıları yönetin")
 },
 operations: {
 label: t("admin_index_operations", "Operasyonlar"),
 icon: 'Activity',
 description: t("admin_index_operations_desc", "Görevleri, tesisleri ve bakımı yönetin")
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