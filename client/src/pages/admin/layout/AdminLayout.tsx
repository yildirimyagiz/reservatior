import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { LayoutDashboard, Building2, CalendarCheck, FileText, DollarSign, UsersRound, Settings, Brain, BarChart3, Shield, ChevronDown, ChevronRight, Receipt, Star, Globe, ShieldCheck, Gavel, Share2, FileDown, Megaphone, Search, AlertTriangle, Activity, Download, ArrowRightLeft, Zap } from "lucide-react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { cn } from "@/lib/utils";
import { useAuth } from "@/lib/auth/hooks";
import Unauthorized from "@/pages/client/Unauthorized";
interface NavItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{
    className?: string;
  }>;
  badge?: string;
  superOnly?: boolean;
  requiredPermission?: string;
  children?: NavItem[];
}
interface AdminLayoutProps {
  children: React.ReactNode;
  userRole?: string;
  userName?: string;
  userEmail?: string;
}
export function AdminLayout({
  children,
  userRole = "ADMIN",
  userName = "Admin",
  userEmail = ""
}: AdminLayoutProps) {
  const {
    t
  } = useTranslation();
  
  const adminNavigation: NavItem[] = [{
    title: t("admin.layout.switch_to_client_app"),
    href: "/dashboard",
    icon: ArrowRightLeft
  }, {
    title: t("admin.layout.admin_dashboard"),
    href: "/admin/dashboard",
    icon: LayoutDashboard
  }, {
    title: t("admin.layout.property_inventory"),
    icon: Building2,
    requiredPermission: "PROPERTIES_VIEW_ALL",
    children: [{
      title: t("admin.layout.portfolio_neural_hub"),
      href: "/admin/properties",
      icon: Zap,
      badge: "AI"
    }, {
      title: t("admin.layout.all_properties"),
      href: "/admin/inventory",
      icon: Building2
    }, {
      title: t("admin.layout.ownership_verifications"),
      href: "/admin/ownership-verification",
      icon: ShieldCheck,
      requiredPermission: "PROPERTIES_MANAGE_ALL"
    }, {
      title: t("admin.layout.channel_manager"),
      href: "/admin/channels",
      icon: Share2,
      requiredPermission: "ORG_MANAGE"
    }, {
      title: t("admin.layout.facilities_management"),
      href: "/admin/inventory/facilities",
      icon: Globe
    }]
  }, {
    title: t("admin.layout.bookings_guests"),
    icon: CalendarCheck,
    requiredPermission: "BOOKINGS_VIEW_ALL",
    children: [{
      title: t("admin.layout.all_bookings"),
      href: "/admin/bookings",
      icon: CalendarCheck
    }, {
      title: t("admin.layout.guest_database"),
      href: "/admin/guests",
      icon: UsersRound,
      requiredPermission: "USERS_MANAGE"
    }]
  }, {
    title: t("admin.layout.users_security"),
    icon: Shield,
    requiredPermission: "USERS_MANAGE",
    children: [{
      title: t("admin.layout.system_users"),
      href: "/admin/users",
      icon: UsersRound
    }, {
      title: t("admin.layout.agent_directory"),
      href: "/admin/agents",
      icon: Star
    }, {
      title: "Organizations/Agencies",
      href: "/admin/organizations",
      icon: Building2,
      superOnly: true
    }, {
      title: t("admin.layout.roles_access"),
      href: "/admin/roles",
      icon: Shield,
      superOnly: true
    }, {
      title: t("admin.layout.security_screenings"),
      href: "/admin/security-screening",
      icon: ShieldCheck
    }, {
      title: t("admin.layout.security_events"),
      href: "/admin/security",
      icon: AlertTriangle,
      superOnly: true
    }, {
      title: t("admin.layout.advanced_security"),
      href: "/admin/advanced-security",
      icon: Shield,
      superOnly: true
    }, {
      title: t("admin.layout.audit_logs"),
      href: "/admin/audit-logs",
      icon: FileText,
      superOnly: true
    }, {
      title: t("admin.layout.api_tokens"),
      href: "/admin/api-tokens",
      icon: Zap,
      superOnly: true
    }, {
      title: t("admin.layout.active_sessions"),
      href: "/admin/sessions",
      icon: UsersRound,
      superOnly: true
    }]
  }, {
    title: t("admin.layout.legal_compliance"),
    icon: Gavel,
    requiredPermission: "GOV_INTEGRATIONS_MANAGE",
    children: [{
      title: t("admin.layout.compliance_center"),
      href: "/admin/compliance",
      icon: ShieldCheck
    }, {
      title: t("admin.layout.solicitor_management"),
      href: "/admin/solicitors",
      icon: UsersRound
    }, {
      title: t("admin.layout.immigration_checks"),
      href: "/admin/immigration",
      icon: Globe
    }, {
      title: t("admin.layout.right_to_rent"),
      href: "/admin/right-to-rent",
      icon: FileText
    }]
  }, {
    title: t("admin.layout.tenants_leases"),
    icon: FileText,
    requiredPermission: "LEASES_MANAGE_ALL",
    children: [{
      title: t("admin.layout.tenant_directory"),
      href: "/admin/tenants",
      icon: UsersRound
    }, {
      title: t("admin.layout.lease_management"),
      href: "/admin/leases",
      icon: FileText
    }]
  }, {
    title: t("admin.layout.financials"),
    icon: DollarSign,
    requiredPermission: "FINANCE_MANAGE",
    children: [{
      title: t("admin.layout.financial_reports"),
      href: "/admin/financial-reports",
      icon: DollarSign
    }, {
      title: t("admin.layout.payouts"),
      href: "/admin/payouts",
      icon: Receipt
    }, {
      title: t("admin.layout.investor_hub"),
      href: "/admin/investors",
      icon: Brain
    }, {
      title: t("admin.layout.escrow"),
      href: "/admin/escrow",
      icon: Shield
    }, {
      title: t("admin.layout.plans_tiers"),
      href: "/admin/plans",
      icon: Star,
      superOnly: true
    }]
  }, {
    title: t("admin.layout.ai_automations"),
    icon: Brain,
    requiredPermission: "REPORTS_VIEW",
    children: [{
      title: t("admin.layout.ai_dashboard"),
      href: "/admin/ai-dashboard",
      icon: LayoutDashboard
    }, {
      title: t("admin.layout.ai_models"),
      href: "/admin/ai-models",
      icon: Brain,
      superOnly: true
    }, {
      title: t("admin.layout.marketing_automation"),
      href: "/admin/marketing",
      icon: Megaphone
    }, {
      title: t("admin.layout.scraping_status"),
      href: "/admin/scraping",
      icon: Search
    }]
  }, {
    title: t("admin.layout.integrations_export"),
    icon: Download,
    requiredPermission: "EXPORTS_MANAGE",
    children: [{
      title: t("admin.layout.mls_rules"),
      href: "/admin/mls",
      icon: Globe,
      superOnly: true
    }, {
      title: t("admin.layout.export_jobs"),
      href: "/admin/export-jobs",
      icon: Download
    }, {
      title: t("admin.layout.data_exports"),
      href: "/admin/exports",
      icon: FileDown
    }]
  }, {
    title: t("admin.layout.system_setup"),
    icon: Settings,
    requiredPermission: "SETTINGS_MANAGE",
    children: [{
      title: t("admin.layout.documents_admin"),
      href: "/admin/document-management",
      icon: FileText
    }, {
      title: t("admin.layout.communication_logs"),
      href: "/admin/communication-logs",
      icon: Activity
    }, {
      title: t("admin.layout.location_db"),
      href: "/admin/location",
      icon: Globe
    }, {
      title: t("admin.layout.metrics"),
      href: "/admin/metrics",
      icon: BarChart3,
      superOnly: true
    }, {
      title: t("admin.layout.system_settings"),
      href: "/admin/system-settings",
      icon: Settings,
      superOnly: true
    }, {
      title: t("admin.layout.audit_trail"),
      href: "/admin/audit-logs",
      icon: Activity
    }]
  }];
  const location = useLocation();
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [mobileSidebarOpen, setMobileSidebarOpen] = useState(false);
  const [expandedGroups, setExpandedGroups] = useState<string[]>(["Users & Security", "Financials"]);
  const {
    user: authUser,
    hasPermission
  } = useAuth();
  const isSuper = userRole === "SUPER_ADMIN" || authUser?.role === "SUPER_ADMIN";
  const toggleGroup = (title: string) => {
    setExpandedGroups(prev => prev.includes(title) ? prev.filter(t => t !== title) : [...prev, title]);
  };
  const isActive = (href?: string) => {
    if (!href) return false;
    return location.pathname.startsWith(href);
  };
  const filteredNav = adminNavigation.filter(item => {
    if (item.superOnly && !isSuper) return false;
    if (item.requiredPermission && !isSuper && !hasPermission(item.requiredPermission)) return false;
    return true;
  });
  const SidebarContent = () => <div className="flex flex-col h-full">
      <div className="flex items-center justify-end px-4 py-5 border-b border-border dark:border-border/50 min-h-[69px]">
        <button className="h-7 w-7 shrink-0 text-muted-foreground hover:text-foreground" onClick={() => setSidebarOpen(!sidebarOpen)}>
          <ChevronRight className={`w-3.5 h-3.5 transition-transform ${sidebarOpen ? 'rotate-180' : ''}`} />
        </button>
      </div>

      <nav className="flex-1 overflow-y-auto py-3 px-2 space-y-0.5">
        {filteredNav.map(item => {
        if (item.children) {
          const visibleChildren = item.children.filter(c => (!c.superOnly || isSuper) && (!c.requiredPermission || isSuper || hasPermission(c.requiredPermission)));
          if (!visibleChildren.length) return null;
          const isExpanded = expandedGroups.includes(item.title);
          const anyChildActive = visibleChildren.some(c => isActive(c.href));
          return <div key={item.title}>
                <button onClick={() => toggleGroup(item.title)} className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", anyChildActive ? "text-primary bg-primary/10 border border-primary/20" : "text-muted-foreground hover:text-foreground hover:bg-accent/50")}>
                  <item.icon className="w-4 h-4 shrink-0" />
                  {sidebarOpen && <>
                      <span className="flex-1 text-left">{item.title}</span>
                      {isExpanded ? <ChevronDown className="w-3 h-3" /> : <ChevronRight className="w-3 h-3" />}
                    </>}
                </button>
                {isExpanded && sidebarOpen && <div className="ml-4 mt-0.5 space-y-0.5 border-l border-border dark:border-border/50 pl-2">
                    {visibleChildren.map(child => <Link key={child.href} to={child.href!}>
                        <button className={cn("w-full flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm transition-colors", isActive(child.href) ? "text-primary font-medium bg-primary/10 border border-primary/20" : "text-muted-foreground hover:text-foreground hover:bg-accent/50")}>
                          <child.icon className="w-3.5 h-3.5 shrink-0" />
                          <span className="flex-1 text-left">{child.title}</span>
                        </button>
                      </Link>)}
                  </div>}
              </div>;
        }
        return <Link key={item.href} to={item.href!}>
              <button className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", isActive(item.href) ? "text-primary bg-primary/20 border border-primary/20" : "text-muted-foreground hover:text-foreground hover:bg-accent/50")}>
                <item.icon className="w-4 h-4 shrink-0" />
                {sidebarOpen && <span className="flex-1 text-left">{item.title}</span>}
              </button>
            </Link>;
      })}
      </nav>

      <div className="border-t border-border dark:border-border/50 p-3">
        <div className="flex items-center gap-2">
          <Avatar className="h-8 w-8 shrink-0">
            <AvatarFallback className="text-xs bg-primary/20 text-primary border border-primary/30">
              {userName.slice(0, 2).toUpperCase()}
            </AvatarFallback>
          </Avatar>
          {sidebarOpen && <div className="flex-1 min-w-0">
              <p className="text-sm font-medium truncate text-foreground">{userName}</p>
              <p className="text-xs text-muted-foreground truncate">{userEmail}</p>
            </div>}
        </div>
      </div>
    </div>;
  return <div className="flex flex-col h-screen bg-background text-foreground overflow-hidden transition-colors duration-300">
      {/* Unified Application Header - Full Width */}
      <AppHeader />

      <div className="flex flex-1 overflow-hidden">
        {/* Desktop Sidebar */}
        <aside className={cn("hidden md:flex flex-col border-r border-border dark:border-border/50 bg-card transition-all duration-300 shrink-0", sidebarOpen ? "w-64" : "w-16")}>
          <SidebarContent />
        </aside>

        {/* Mobile Sidebar */}
        {mobileSidebarOpen && <div className="fixed inset-0 z-50 md:hidden">
            <div className="absolute inset-0 bg-card" onClick={() => setMobileSidebarOpen(false)} />
            <aside className="absolute left-0 top-0 bottom-0 w-64 bg-card flex flex-col pt-16">
              <SidebarContent />
            </aside>
          </div>}

        <main className="flex-1 overflow-auto bg-background flex flex-col transition-colors duration-300">
          <div className="flex-1">
            {children}
          </div>
          <Footer />
        </main>
      </div>
    </div>;
}