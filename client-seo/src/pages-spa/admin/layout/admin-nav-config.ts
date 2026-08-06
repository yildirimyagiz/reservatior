import {
  LayoutDashboard, Building2, CalendarCheck, FileText, DollarSign,
  UsersRound, Settings, Brain, BarChart3, Shield, ChevronDown,
  ChevronRight, Receipt, Star, Globe, ShieldCheck, Gavel, Share2,
  FileDown, Megaphone, Search, AlertTriangle, Activity, Download,
  ArrowRightLeft, Zap, Sparkles, X, Clock, Filter, ArrowLeft,
  Wallet, PiggyBank, Home, ScrollText, Landmark, ShoppingCart,
  Package, Truck, Box, Users, Award, Smartphone, Store, Cpu
} from "lucide-react";

export interface NavItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{ className?: string }>;
  badge?: string;
  superOnly?: boolean;
  requiredPermission?: string;
  children?: NavItem[];
  colorClass?: string;
}

export function getAdminNavigation(t: (key: string, fallback?: string) => string): NavItem[] {
  return [{
    title: t("admin.nav.switch_to_client_app", "Müşteri Uygulamasına Geç"),
    href: "/dashboard",
    icon: ArrowRightLeft,
    colorClass: "text-slate-400 dark:text-slate-400"
  }, {
    title: t("admin.nav.admin_dashboard", "Yönetici Paneli"),
    href: "/admin/dashboard",
    icon: LayoutDashboard,
    colorClass: "text-emerald-500 dark:text-emerald-400"
  }, {
    title: t("admin.nav.property_inventory", "Mülk Envanteri"),
    icon: Building2,
    requiredPermission: "PROPERTIES_VIEW_ALL",
    colorClass: "text-blue-500 dark:text-blue-400",
    children: [{
      title: t("admin.nav.portfolio_neural_hub", "Akıllı Portföy Merkezi (Ai Hub)"),
      href: "/admin/properties",
      icon: Zap,
      badge: "AI",
      colorClass: "text-cyan-500 dark:text-cyan-400"
    }, {
      title: t("admin.nav.all_properties", "Tüm Mülkler"),
      href: "/admin/inventory",
      icon: Building2,
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.ownership_verifications", "Mülkiyet Doğrulamaları"),
      href: "/admin/ownership-verification",
      icon: ShieldCheck,
      requiredPermission: "PROPERTIES_MANAGE_ALL",
      colorClass: "text-purple-500 dark:text-purple-400"
    }, {
      title: t("admin.nav.channel_manager", "Kanal Yöneticisi (Channel Manager)"),
      href: "/admin/channels",
      icon: Share2,
      requiredPermission: "ORG_MANAGE",
      colorClass: "text-amber-500 dark:text-amber-400"
    }, {
      title: t("admin.nav.facilities_management", "Tesis Yönetimi"),
      href: "/admin/inventory/facilities",
      icon: Globe,
      colorClass: "text-teal-500 dark:text-teal-400"
    }]
  }, {
    title: t("admin.nav.bookings_guests", "Rezervasyonlar Ve Misafirler"),
    icon: CalendarCheck,
    requiredPermission: "BOOKINGS_VIEW_ALL",
    colorClass: "text-orange-500 dark:text-orange-400",
    children: [{
      title: t("admin.nav.all_bookings", "Tüm Rezervasyonlar"),
      href: "/admin/bookings",
      icon: CalendarCheck,
      colorClass: "text-orange-500 dark:text-orange-400"
    }, {
      title: t("admin.nav.guest_database", "Misafir Veritabanı"),
      href: "/admin/guests",
      icon: UsersRound,
      requiredPermission: "USERS_MANAGE",
      colorClass: "text-indigo-500 dark:text-indigo-400"
    }]
  }, {
    title: t("admin.nav.users_security", "Kullanıcılar Ve Güvenlik"),
    icon: Shield,
    requiredPermission: "USERS_MANAGE",
    colorClass: "text-purple-500 dark:text-purple-400",
    children: [{
      title: t("admin.nav.system_users", "Sistem Kullanıcıları"),
      href: "/admin/users",
      icon: UsersRound,
      colorClass: "text-purple-500 dark:text-purple-400"
    }, {
      title: t("admin.nav.agent_directory", "Danışman Rehberi"),
      href: "/admin/agents",
      icon: Star,
      colorClass: "text-amber-500 dark:text-amber-400"
    }, {
      title: t("admin.nav.organizations_agencies", "Kurumlar & Emlak Ofisleri"),
      href: "/admin/organizations",
      icon: Building2,
      superOnly: true,
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.roles_access", "Roller Ve Erişim"),
      href: "/admin/roles",
      icon: Shield,
      superOnly: true,
      colorClass: "text-slate-400 dark:text-slate-400"
    }, {
      title: t("admin.nav.security_screenings", "Güvenlik Taramaları"),
      href: "/admin/security-screening",
      icon: ShieldCheck,
      colorClass: "text-green-500 dark:text-green-400"
    }, {
      title: t("admin.nav.security_events", "Güvenlik Olayları"),
      href: "/admin/security",
      icon: AlertTriangle,
      superOnly: true,
      colorClass: "text-red-500 dark:text-red-400"
    }, {
      title: t("admin.nav.advanced_security", "Gelişmiş Güvenlik"),
      href: "/admin/advanced-security",
      icon: Shield,
      superOnly: true,
      colorClass: "text-indigo-500 dark:text-indigo-400"
    }, {
      title: t("admin.nav.audit_logs", "Denetim Kayıtları"),
      href: "/admin/audit-logs",
      icon: FileText,
      superOnly: true,
      colorClass: "text-slate-500 dark:text-slate-400"
    }, {
      title: t("admin.nav.api_tokens", "Api Jetonları (API Anahtar Yetkileri)"),
      href: "/admin/api-tokens",
      icon: Zap,
      superOnly: true,
      colorClass: "text-yellow-500 dark:text-yellow-400"
    }, {
      title: t("admin.nav.active_sessions", "Aktif Oturumlar"),
      href: "/admin/sessions",
      icon: UsersRound,
      superOnly: true,
      colorClass: "text-violet-500 dark:text-violet-400"
    }]
  }, {
    title: t("admin.nav.legal_compliance", "Hukuk Ve Uyumluluk"),
    icon: Gavel,
    requiredPermission: "GOV_INTEGRATIONS_MANAGE",
    colorClass: "text-slate-400 dark:text-slate-400",
    children: [{
      title: t("admin.nav.compliance_center", "Uyumluluk Merkezi"),
      href: "/admin/compliance",
      icon: ShieldCheck,
      colorClass: "text-green-500 dark:text-green-400"
    }, {
      title: t("admin.nav.solicitor_management", "Avukat/danışman Yönetimi"),
      href: "/admin/solicitors",
      icon: UsersRound,
      colorClass: "text-indigo-500 dark:text-indigo-400"
    }, {
      title: t("admin.nav.immigration_checks", "Göçmenlik Ve Vize Kontrolleri"),
      href: "/admin/immigration",
      icon: Globe,
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.right_to_rent", "Kiralama Hakkı Kontrolü"),
      href: "/admin/right-to-rent",
      icon: FileText,
      colorClass: "text-amber-500 dark:text-amber-400"
    }]
  }, {
    title: t("admin.nav.tenants_leases", "Kiracılar Ve Sözleşmeler"),
    icon: FileText,
    requiredPermission: "LEASES_MANAGE_ALL",
    colorClass: "text-rose-500 dark:text-rose-400",
    children: [{
      title: t("admin.nav.tenant_directory", "Kiracı Rehberi"),
      href: "/admin/tenants",
      icon: UsersRound,
      colorClass: "text-purple-500 dark:text-purple-400"
    }, {
      title: t("admin.nav.lease_management", "Kira Sözleşmesi (Lease) Yönetimi"),
      href: "/admin/leases",
      icon: FileText,
      colorClass: "text-rose-500 dark:text-rose-400"
    }]
  }, {
    title: t("admin.nav.financials", "Finansallar"),
    icon: DollarSign,
    requiredPermission: "FINANCE_MANAGE",
    colorClass: "text-emerald-500 dark:text-emerald-400",
    children: [{
      title: t("admin.nav.financial_reports", "Finansal Raporlar"),
      href: "/admin/financial-reports",
      icon: DollarSign,
      colorClass: "text-emerald-500 dark:text-emerald-400"
    }, {
      title: t("admin.nav.payouts", "Hak Edişler (Ev Sahibi Ödemeleri)"),
      href: "/admin/payouts",
      icon: Receipt,
      colorClass: "text-amber-500 dark:text-amber-400"
    }, {
      title: t("admin.nav.investor_hub", "Yatırımcı Merkezi (İnvestor Hub)"),
      href: "/admin/investors",
      icon: Brain,
      colorClass: "text-violet-500 dark:text-violet-400"
    }, {
      title: t("admin.nav.escrow", "Güvenli Ödeme (Güvenli Ödeme)"),
      href: "/admin/escrow",
      icon: Shield,
      colorClass: "text-indigo-500 dark:text-indigo-400"
    }, {
      title: t("admin.nav.plans_tiers", "Planlar Ve Seviyeler"),
      href: "/admin/plans",
      icon: Star,
      superOnly: true,
      colorClass: "text-yellow-500 dark:text-yellow-400"
    }]
  }, {
    title: t("admin.nav.ai_automations", "Yapay Zeka & Otomasyonlar"),
    icon: Brain,
    requiredPermission: "REPORTS_VIEW",
    colorClass: "text-cyan-500 dark:text-cyan-400",
    children: [{
      title: t("admin.nav.ai_dashboard", "Yapay Zeka Paneli"),
      href: "/admin/ai-dashboard",
      icon: LayoutDashboard,
      colorClass: "text-cyan-500 dark:text-cyan-400"
    }, {
      title: t("admin.nav.ai_studio", "AI İçerik & Görsel Stüdyo"),
      href: "/admin/ai/studio",
      icon: Sparkles,
      colorClass: "text-pink-500 dark:text-pink-400"
    }, {
      title: t("admin.nav.ai_models", "Yapay Zeka Modelleri"),
      href: "/admin/ai-models",
      icon: Brain,
      superOnly: true,
      colorClass: "text-teal-500 dark:text-teal-400"
    }, {
      title: t("admin.nav.marketing_automation", "Pazarlama Otomasyonu"),
      href: "/admin/marketing",
      icon: Megaphone,
      colorClass: "text-pink-500 dark:text-pink-400"
    }, {
      title: t("admin.nav.scraping_status", "Veri Çekme (Scraping) Durumu"),
      href: "/admin/scraping",
      icon: Search,
      colorClass: "text-yellow-500 dark:text-yellow-400"
    }]
  }, {
    title: t("admin.nav.integrations_export", "Entegrasyonlar & Veri Aktarımı"),
    icon: Download,
    requiredPermission: "EXPORTS_MANAGE",
    colorClass: "text-indigo-500 dark:text-indigo-400",
    children: [{
      title: t("admin.nav.focus_rules", "MLS Kuralları & Çapraz Entegrasyon"),
      href: "/admin/mls",
      icon: Globe,
      superOnly: true,
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.export_jobs", "Dışa Aktarma Görevleri"),
      href: "/admin/export-jobs",
      icon: Download,
      colorClass: "text-slate-400 dark:text-slate-400"
    }, {
      title: t("admin.nav.data_exports", "Veri Dışa Aktarımı"),
      href: "/admin/exports",
      icon: FileDown,
      colorClass: "text-green-500 dark:text-green-400"
    }]
  }, {
    title: t("admin.nav.financial_operations", "Finansal Operasyonlar OS"),
    icon: Wallet,
    requiredPermission: "FINANCE_MANAGE",
    colorClass: "text-emerald-500 dark:text-emerald-400",
    children: [{
      title: t("admin.nav.kumbara_deposits", "Kumbara & Birikim Havuzları"),
      href: "/admin/kumbara",
      icon: PiggyBank,
      requiredPermission: "KUMBARA_MANAGE",
      colorClass: "text-rose-500 dark:text-rose-400"
    }, {
      title: t("admin.nav.trust_scores", "Güven ve Kredi Skorları"),
      href: "/admin/trust-score",
      icon: Shield,
      requiredPermission: "TRUST_SCORE_VIEW",
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.purchase_intents_rto", "Kademeli Satın Alma (RTO)"),
      href: "/admin/purchase-intents",
      icon: Home,
      requiredPermission: "RTO_MANAGE",
      colorClass: "text-green-500 dark:text-green-400"
    }, {
      title: t("admin.nav.reo_portfolio", "Kurumsal Portföy (REO)"),
      href: "/admin/reo",
      icon: Building2,
      requiredPermission: "REO_MANAGE",
      colorClass: "text-orange-500 dark:text-orange-400"
    }, {
      title: t("admin.nav.financial_audit", "Finansal Denetim İzi"),
      href: "/admin/audit-log",
      icon: ScrollText,
      requiredPermission: "AUDIT_LOGS_VIEW",
      colorClass: "text-slate-500 dark:text-slate-400"
    }, {
      title: t("admin.nav.bank_accounts", "Banka Hesapları & Entegrasyon"),
      href: "/admin/bank-accounts",
      icon: Landmark,
      requiredPermission: "FINANCE_MANAGE",
      colorClass: "text-blue-500 dark:text-blue-400"
    }]
  }, {
    title: t("admin.nav.commerce_os", "Ticaret OS"),
    icon: ShoppingCart,
    requiredPermission: "COMMERCE_MANAGE",
    colorClass: "text-pink-500 dark:text-pink-400",
    children: [{
      title: t("admin.nav.products", "Ürünler & Hizmetler"),
      href: "/admin/products",
      icon: Package,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-orange-500 dark:text-orange-400"
    }, {
      title: t("admin.nav.suppliers", "Tedarikçiler & Servisler"),
      href: "/admin/suppliers",
      icon: Truck,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.bundles", "Hizmet Paketleri (Bundles)"),
      href: "/admin/bundles",
      icon: Box,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-purple-500 dark:text-purple-400"
    }, {
      title: t("admin.nav.commerce_agents", "Satış Partnerleri"),
      href: "/admin/commerce-agents",
      icon: Users,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-amber-500 dark:text-amber-400"
    }, {
      title: t("admin.nav.commissions", "Komisyon Dağıtımları"),
      href: "/admin/commissions",
      icon: DollarSign,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-green-500 dark:text-green-400"
    }, {
      title: t("admin.nav.orders", "Siparişler & İşlemler"),
      href: "/admin/commerce-orders",
      icon: ShoppingCart,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-pink-500 dark:text-pink-400"
    }, {
      title: t("admin.nav.campaigns", "Kampanyalar & İndirimler"),
      href: "/admin/campaigns",
      icon: Megaphone,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-red-500 dark:text-red-400"
    }, {
      title: t("admin.nav.certificates", "Sertifikalar & Lisanslar"),
      href: "/admin/certificates",
      icon: Award,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-yellow-500 dark:text-yellow-400"
    }, {
      title: t("admin.nav.asset_marketplace", "Varlık Pazarı (Marketplace)"),
      href: "/admin/marketplace",
      icon: Store,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-teal-500 dark:text-teal-400"
    }, {
      title: t("admin.nav.agent_mobile", "Saha Mobil Uygulaması"),
      href: "/admin/agent-mobile",
      icon: Smartphone,
      requiredPermission: "COMMERCE_MANAGE",
      colorClass: "text-indigo-500 dark:text-indigo-400"
    }]
  }, {
    title: t("admin.nav.intelligence_ai", "Zeka & AI Motorları"),
    icon: Brain,
    badge: "NEW",
    colorClass: "text-cyan-500 dark:text-cyan-400",
    children: [{
      title: t("admin.nav.property_passport", "Mülk Karnesi"),
      href: "/admin/property-passport",
      icon: Building2,
      badge: "AI",
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.market_passport", "Bölge Zekası"),
      href: "/admin/market-passport",
      icon: Globe,
      badge: "AI",
      colorClass: "text-green-500 dark:text-green-400"
    }, {
      title: t("admin.nav.user_passport", "Kullanıcı Karnesi"),
      href: "/admin/user-passport",
      icon: UsersRound,
      colorClass: "text-purple-500 dark:text-purple-400"
    }, {
      title: t("admin.nav.agent_passport", "Danışman Karnesi"),
      href: "/admin/agent-passport",
      icon: Star,
      colorClass: "text-amber-500 dark:text-amber-400"
    }, {
      title: t("admin.nav.decision_engine", "Karar Motoru"),
      href: "/admin/decision-engine",
      icon: Zap,
      badge: "AI",
      colorClass: "text-red-500 dark:text-red-400"
    }, {
      title: t("admin.nav.feedback_loop", "Geri Bildirim Döngüsü"),
      href: "/admin/feedback-loop",
      icon: Activity,
      colorClass: "text-orange-500 dark:text-orange-400"
    }, {
      title: t("admin.nav.content_publisher", "İçerik Yayıncısı & SEO"),
      href: "/admin/content-publisher",
      icon: Megaphone,
      colorClass: "text-pink-500 dark:text-pink-400"
    }, {
      title: t("admin.nav.revenue_intelligence", "Gelir Zekası"),
      href: "/admin/revenue-intelligence",
      icon: DollarSign,
      colorClass: "text-emerald-500 dark:text-emerald-400"
    }, {
      title: t("admin.nav.hybrid_rental_engine", "Karma Kiralama Karar Motoru"),
      href: "/admin/hybrid-rental-engine",
      icon: Brain,
      badge: "AI",
      colorClass: "text-cyan-500 dark:text-cyan-400"
    }, {
      title: t("admin.nav.hybrid_rental_os", "Karma Kiralama & Gelir OS"),
      href: "/admin/hybrid-rental-os",
      icon: Cpu,
      badge: "OS",
      colorClass: "text-purple-500 dark:text-purple-400"
    }, {
      title: t("admin.nav.global_hybrid_rental_os", "Global Hibrit Kiralama OS"),
      href: "/admin/global-hybrid-rental-os",
      icon: Globe,
      badge: "GLOBAL",
      colorClass: "text-teal-500 dark:text-teal-400"
    }, {
      title: t("admin.nav.intelligence_graph", "Zeka Grafiği"),
      href: "/admin/intelligence-graph",
      icon: Brain,
      colorClass: "text-indigo-500 dark:text-indigo-400"
    }, {
      title: t("admin.nav.seo_generator", "Otomatik SEO Üretici"),
      href: "/admin/seo-generator",
      icon: Search,
      colorClass: "text-yellow-500 dark:text-yellow-400"
    }]
  }, {
    title: t("admin.nav.system_setup", "Sistem Kurulumu"),
    icon: Settings,
    requiredPermission: "SETTINGS_MANAGE",
    colorClass: "text-orange-500 dark:text-orange-400",
    children: [{
      title: t("admin.nav.documents_admin", "Belge Yönetimi"),
      href: "/admin/document-management",
      icon: FileText,
      colorClass: "text-slate-500 dark:text-slate-400"
    }, {
      title: t("admin.nav.communication_logs", "İletişim Kayıtları"),
      href: "/admin/communication-logs",
      icon: Activity,
      colorClass: "text-blue-500 dark:text-blue-400"
    }, {
      title: t("admin.nav.location_db", "Konum Veritabanı"),
      href: "/admin/location",
      icon: Globe,
      colorClass: "text-green-500 dark:text-green-400"
    }, {
      title: t("admin.nav.ai_video_generation", "AI Video Üretim Motoru"),
      href: "/admin/ai-video",
      icon: Sparkles,
      colorClass: "text-violet-500 dark:text-violet-400"
    }, {
      title: t("admin.nav.system_settings", "Sistem Ayarları"),
      href: "/admin/system-settings",
      icon: Settings,
      superOnly: true,
      colorClass: "text-orange-500 dark:text-orange-400"
    }, {
      title: t("admin.nav.audit_trail", "Denetim İzi (Şeffaf Denetim Trail)"),
      href: "/admin/audit-logs",
      icon: Activity,
      colorClass: "text-red-500 dark:text-red-400"
    }]
  }];
}
