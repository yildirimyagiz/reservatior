import {
  LayoutDashboard, Building2, CalendarCheck, FileText, DollarSign,
  UsersRound, Settings, Brain, BarChart3, Shield, ChevronDown,
  ChevronRight, Receipt, Star, Globe, ShieldCheck, Gavel, Share2,
  FileDown, Megaphone, Search, AlertTriangle, Activity, Download,
  ArrowRightLeft, Zap, Sparkles, X, Clock, Filter, ArrowLeft,
  Wallet, PiggyBank, Home, ScrollText, Landmark, ShoppingCart,
  Package, Truck, Box, Users, Award, Smartphone, Store
} from "lucide-react";

export interface NavItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{ className?: string }>;
  badge?: string;
  superOnly?: boolean;
  requiredPermission?: string;
  children?: NavItem[];
}

export function getAdminNavigation(t: (key: string, fallback?: string) => string): NavItem[] {
  return [{
    title: t("admin_layout_switch_to_client_app"),
    href: "/dashboard",
    icon: ArrowRightLeft
  }, {
    title: t("admin_layout_admin_dashboard"),
    href: "/admin/dashboard",
    icon: LayoutDashboard
  }, {
    title: t("admin_layout_property_inventory"),
    icon: Building2,
    requiredPermission: "PROPERTIES_VIEW_ALL",
    children: [{
      title: t("admin_layout_portfolio_neural_hub"),
      href: "/admin/properties",
      icon: Zap,
      badge: "AI"
    }, {
      title: t("admin_layout_all_properties"),
      href: "/admin/inventory",
      icon: Building2
    }, {
      title: t("admin_layout_ownership_verifications"),
      href: "/admin/ownership-verification",
      icon: ShieldCheck,
      requiredPermission: "PROPERTIES_MANAGE_ALL"
    }, {
      title: t("admin_layout_channel_manager"),
      href: "/admin/channels",
      icon: Share2,
      requiredPermission: "ORG_MANAGE"
    }, {
      title: t("admin_layout_facilities_management"),
      href: "/admin/inventory/facilities",
      icon: Globe
    }]
  }, {
    title: t("admin_layout_bookings_guests"),
    icon: CalendarCheck,
    requiredPermission: "BOOKINGS_VIEW_ALL",
    children: [{
      title: t("admin_layout_all_bookings"),
      href: "/admin/bookings",
      icon: CalendarCheck
    }, {
      title: t("admin_layout_guest_database"),
      href: "/admin/guests",
      icon: UsersRound,
      requiredPermission: "USERS_MANAGE"
    }]
  }, {
    title: t("admin_layout_users_security"),
    icon: Shield,
    requiredPermission: "USERS_MANAGE",
    children: [{
      title: t("admin_layout_system_users"),
      href: "/admin/users",
      icon: UsersRound
    }, {
      title: t("admin_layout_agent_directory"),
      href: "/admin/agents",
      icon: Star
    }, {
      title: "Organizations/Agencies",
      href: "/admin/organizations",
      icon: Building2,
      superOnly: true
    }, {
      title: t("admin_layout_roles_access"),
      href: "/admin/roles",
      icon: Shield,
      superOnly: true
    }, {
      title: t("admin_layout_security_screenings"),
      href: "/admin/security-screening",
      icon: ShieldCheck
    }, {
      title: t("admin_layout_security_events"),
      href: "/admin/security",
      icon: AlertTriangle,
      superOnly: true
    }, {
      title: t("admin_layout_advanced_security"),
      href: "/admin/advanced-security",
      icon: Shield,
      superOnly: true
    }, {
      title: t("admin_layout_audit_logs"),
      href: "/admin/audit-logs",
      icon: FileText,
      superOnly: true
    }, {
      title: t("admin_layout_api_tokens"),
      href: "/admin/api-tokens",
      icon: Zap,
      superOnly: true
    }, {
      title: t("admin_layout_active_sessions"),
      href: "/admin/sessions",
      icon: UsersRound,
      superOnly: true
    }]
  }, {
    title: t("admin_layout_legal_compliance"),
    icon: Gavel,
    requiredPermission: "GOV_INTEGRATIONS_MANAGE",
    children: [{
      title: t("admin_layout_compliance_center"),
      href: "/admin/compliance",
      icon: ShieldCheck
    }, {
      title: t("admin_layout_solicitor_management"),
      href: "/admin/solicitors",
      icon: UsersRound
    }, {
      title: t("admin_layout_immigration_checks"),
      href: "/admin/immigration",
      icon: Globe
    }, {
      title: t("admin_layout_right_to_rent"),
      href: "/admin/right-to-rent",
      icon: FileText
    }]
  }, {
    title: t("admin_layout_tenants_leases"),
    icon: FileText,
    requiredPermission: "LEASES_MANAGE_ALL",
    children: [{
      title: t("admin_layout_tenant_directory"),
      href: "/admin/tenants",
      icon: UsersRound
    }, {
      title: t("admin_layout_lease_management"),
      href: "/admin/leases",
      icon: FileText
    }]
  }, {
    title: t("admin_layout_financials"),
    icon: DollarSign,
    requiredPermission: "FINANCE_MANAGE",
    children: [{
      title: t("admin_layout_financial_reports"),
      href: "/admin/financial-reports",
      icon: DollarSign
    }, {
      title: t("admin_layout_payouts"),
      href: "/admin/payouts",
      icon: Receipt
    }, {
      title: t("admin_layout_investor_hub"),
      href: "/admin/investors",
      icon: Brain
    }, {
      title: t("admin_layout_escrow"),
      href: "/admin/escrow",
      icon: Shield
    }, {
      title: t("admin_layout_plans_tiers"),
      href: "/admin/plans",
      icon: Star,
      superOnly: true
    }]
  }, {
    title: t("admin_layout_ai_automations"),
    icon: Brain,
    requiredPermission: "REPORTS_VIEW",
    children: [{
      title: t("admin_layout_ai_dashboard"),
      href: "/admin/ai-dashboard",
      icon: LayoutDashboard
    }, {
      title: t("client.src.ai_studio", "AI Studio"),
      href: "/admin/ai/studio",
      icon: Sparkles
    }, {
      title: t("admin_layout_ai_models"),
      href: "/admin/ai-models",
      icon: Brain,
      superOnly: true
    }, {
      title: t("admin_layout_marketing_automation"),
      href: "/admin/marketing",
      icon: Megaphone
    }, {
      title: t("admin_layout_scraping_status"),
      href: "/admin/scraping",
      icon: Search
    }]
  }, {
    title: t("admin_layout_integrations_export"),
    icon: Download,
    requiredPermission: "EXPORTS_MANAGE",
    children: [{
      title: t("admin_layout_mls_rules"),
      href: "/admin/mls",
      icon: Globe,
      superOnly: true
    }, {
      title: t("admin_layout_export_jobs"),
      href: "/admin/export-jobs",
      icon: Download
    }, {
      title: t("admin_layout_data_exports"),
      href: "/admin/exports",
      icon: FileDown
    }]
  }, {
    title: t("admin_layout_financial_operations", "Financial Operations"),
    icon: Wallet,
    requiredPermission: "FINANCE_MANAGE",
    children: [{
      title: t("admin_layout_kumbara_deposits", "Kumbara Deposits"),
      href: "/admin/kumbara",
      icon: PiggyBank,
      requiredPermission: "KUMBARA_MANAGE"
    }, {
      title: t("admin_layout_trust_scores", "Trust Scores"),
      href: "/admin/trust-score",
      icon: Shield,
      requiredPermission: "TRUST_SCORE_VIEW"
    }, {
      title: t("admin_layout_purchase_intents_rto", "Purchase Intents (RTO)"),
      href: "/admin/purchase-intents",
      icon: Home,
      requiredPermission: "RTO_MANAGE"
    }, {
      title: t("admin_layout_reo_portfolio", "REO Portfolio"),
      href: "/admin/reo",
      icon: Building2,
      requiredPermission: "REO_MANAGE"
    }, {
      title: t("admin_layout_financial_audit", "Financial Audit"),
      href: "/admin/audit-log",
      icon: ScrollText,
      requiredPermission: "AUDIT_LOGS_VIEW"
    }, {
      title: t("admin_layout_bank_accounts", "Bank Accounts"),
      href: "/admin/bank-accounts",
      icon: Landmark,
      requiredPermission: "FINANCE_MANAGE"
    }]
  }, {
    title: "Commerce OS",
    icon: ShoppingCart,
    requiredPermission: "COMMERCE_MANAGE",
    children: [{
      title: "Products",
      href: "/admin/products",
      icon: Package,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Suppliers",
      href: "/admin/suppliers",
      icon: Truck,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Bundles",
      href: "/admin/bundles",
      icon: Box,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Agents",
      href: "/admin/commerce-agents",
      icon: Users,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Commissions",
      href: "/admin/commissions",
      icon: DollarSign,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Orders",
      href: "/admin/commerce-orders",
      icon: ShoppingCart,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Campaigns",
      href: "/admin/campaigns",
      icon: Megaphone,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Certificates",
      href: "/admin/certificates",
      icon: Award,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Asset Marketplace",
      href: "/admin/marketplace",
      icon: Store,
      requiredPermission: "COMMERCE_MANAGE"
    }, {
      title: "Agent Mobile",
      href: "/admin/agent-mobile",
      icon: Smartphone,
      requiredPermission: "COMMERCE_MANAGE"
    }]
  }, {
    title: "SEO & Analytics",
    icon: Search,
    children: [{
      title: "SEO Generator",
      href: "/admin/seo-generator",
      icon: Search
    }]
  }, {
    title: t("admin_layout_system_setup"),
    icon: Settings,
    requiredPermission: "SETTINGS_MANAGE",
    children: [{
      title: t("admin_layout_documents_admin"),
      href: "/admin/document-management",
      icon: FileText
    }, {
      title: t("admin_layout_communication_logs"),
      href: "/admin/communication-logs",
      icon: Activity
    }, {
      title: t("admin_layout_location_db"),
      href: "/admin/location",
      icon: Globe
    }, {
      title: t("admin_layout_ai_video_generation"),
      href: "/admin/ai-video",
      icon: Sparkles
    }, {
      title: t("admin_layout_system_settings"),
      href: "/admin/system-settings",
      icon: Settings,
      superOnly: true
    }, {
      title: t("admin_layout_audit_trail"),
      href: "/admin/audit-logs",
      icon: Activity
    }]
  }];
}
