"use client";
import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Link, useLocation } from "@/lib/react-router-shim";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { LayoutDashboard, Building2, CalendarCheck, FileText, DollarSign, UsersRound, Settings, Brain, BarChart3, Shield, ChevronDown, ChevronRight, Receipt, Star, Globe, ShieldCheck, Gavel, Share2, FileDown, Megaphone, Search, AlertTriangle, Activity, Download, ArrowRightLeft, Zap, Sparkles, Bell } from "lucide-react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { NotificationRing } from "@/components/notifications/NotificationRing";
import { MessageDropdown } from "@/components/layout/MessageDropdown";
import { UserMenu } from "@/components/layout/UserMenu";
import { useLanguage, LANGUAGES } from "@/lib/languages";
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from "@/components/ui/dropdown-menu";
import { useTheme } from "next-themes";
import { usePathname, useRouter } from "next/navigation";
import { cn } from "@/lib/utils";
import { useAuth } from "@/lib/auth/hooks";
import Unauthorized from "@/pages-spa/client/Unauthorized";
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
      title: t("client.src.ai_studio", "AI Studio"),
      href: "/client/ai/studio",
      icon: Sparkles
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
  const { user: authUser, hasPermission } = useAuth();
  const isSuper = userRole === "SUPER_ADMIN" || authUser?.role === "SUPER_ADMIN";
  
  const { theme, setTheme } = useTheme();
  const { currentLang, setLanguage } = useLanguage();
  const pathname = usePathname();
  const router = useRouter();

  const handleLanguageChange = (code: string) => {
    const segments = pathname.split('/').filter(Boolean);
    const currentLocale = segments[0];
    const pathWithoutLocale = currentLocale && LANGUAGES.some(l => l.code === currentLocale)
      ? segments.slice(1).join('/')
      : segments.join('/');

    const newPath = pathWithoutLocale ? `/${code}/${pathWithoutLocale}` : `/${code}`;
    router.push(newPath);
    setLanguage(code);
  };

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
      <div 
        className={cn(
          "flex items-center h-[69px] border-b border-border transition-all duration-300", 
          sidebarOpen ? "justify-between px-4" : "justify-center px-0 cursor-pointer hover:bg-white/5"
        )}
        onClick={() => !sidebarOpen && setSidebarOpen(true)}
      >
        <div className="flex items-center overflow-hidden">
          <img src="/logo-r.jpeg" alt="Reservatior Logo" className="w-8 h-8 shrink-0 rounded-lg object-contain bg-white" />
          <span className={cn(
            "text-lg font-bold text-white tracking-tight whitespace-nowrap transition-all duration-300",
            sidebarOpen ? "ml-2 opacity-100 max-w-[150px]" : "ml-0 opacity-0 max-w-0"
          )}>
            Reservatior
          </span>
        </div>
        {sidebarOpen && (
          <button className="h-7 w-7 shrink-0 text-muted-foreground hover:text-foreground ml-auto" onClick={(e) => { e.stopPropagation(); setSidebarOpen(false); }}>
            <ChevronRight className="w-3.5 h-3.5 rotate-180 transition-transform duration-300" />
          </button>
        )}
      </div>

      <nav className="flex-1 overflow-y-auto py-3 px-2 space-y-0.5">
        {filteredNav.map(item => {
        if (item.children) {
          const visibleChildren = item.children.filter(c => (!c.superOnly || isSuper) && (!c.requiredPermission || isSuper || hasPermission(c.requiredPermission)));
          if (!visibleChildren.length) return null;
          const isExpanded = expandedGroups.includes(item.title);
          const anyChildActive = visibleChildren.some(c => isActive(c.href));
          return <div key={item.title}>
                <button onClick={() => toggleGroup(item.title)} className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", anyChildActive ? "text-primary bg-primary/10 border border-primary/20" : "text-slate-400 hover:text-white hover:bg-white/5")}>
                  <item.icon className="w-4 h-4 shrink-0" />
                  {sidebarOpen && <>
                      <span className="flex-1 text-left">{item.title}</span>
                      {isExpanded ? <ChevronDown className="w-3 h-3" /> : <ChevronRight className="w-3 h-3" />}
                    </>}
                </button>
                {isExpanded && sidebarOpen && <div className="ml-4 mt-0.5 space-y-0.5 border-l border-border pl-2">
                    {visibleChildren.map(child => <Link key={child.href} to={child.href!}>
                        <button className={cn("w-full flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm transition-colors", isActive(child.href) ? "text-primary font-medium bg-primary/10 border border-primary/20" : "text-slate-400 hover:text-white hover:bg-white/5")}>
                          <child.icon className="w-3.5 h-3.5 shrink-0" />
                          <span className="flex-1 text-left">{child.title}</span>
                        </button>
                      </Link>)}
                  </div>}
              </div>;
        }
        return <Link key={item.href} to={item.href!}>
              <button className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", isActive(item.href) ? "text-primary bg-primary/20 border border-primary/20" : "text-slate-400 hover:text-white hover:bg-white/5")}>
                <item.icon className="w-4 h-4 shrink-0" />
                {sidebarOpen && <span className="flex-1 text-left">{item.title}</span>}
              </button>
            </Link>;
      })}
      </nav>

      <div className="border-t border-border p-3">
        {/* We can use UserMenu here or keep it clean, user requested UserMenu in Navbar, so let's keep this as a simple profile summary or remove it. Let's keep it. */}
        <div className="flex items-center gap-2">
          <Avatar className="h-8 w-8 shrink-0">
            <AvatarFallback className="text-xs bg-primary/20 text-primary border border-primary/30">
              {userName.slice(0, 2).toUpperCase()}
            </AvatarFallback>
          </Avatar>
          {sidebarOpen && <div className="flex-1 min-w-0">
              <p className="text-sm font-medium truncate text-white">{userName}</p>
              <p className="text-xs text-slate-400 truncate">{userRole}</p>
            </div>}
        </div>
      </div>
    </div>;
  return <div className="flex h-screen bg-background text-foreground overflow-hidden transition-colors duration-300 p-4 gap-4">
      {/* Desktop Sidebar (Floating & Rounded) */}
      <aside className={cn("hidden md:flex flex-col bg-card/50 backdrop-blur-xl border border-border transition-all duration-300 shrink-0 rounded-[2rem] overflow-hidden", sidebarOpen ? "w-64" : "w-16")}>
        <SidebarContent />
      </aside>

      {/* Mobile Sidebar */}
      {mobileSidebarOpen && <div className="fixed inset-0 z-50 md:hidden">
          <div className="absolute inset-0 bg-black/80 backdrop-blur-sm" onClick={() => setMobileSidebarOpen(false)} />
          <aside className="absolute left-4 top-4 bottom-4 w-64 bg-card rounded-[2rem] flex flex-col overflow-hidden border border-border shadow-2xl">
            <SidebarContent />
          </aside>
        </div>}

      <div className="flex-1 flex flex-col overflow-hidden gap-4">
        {/* Floating Oval Top Navbar */}
        <header className="h-16 shrink-0 bg-card/50 backdrop-blur-xl border border-border rounded-full flex items-center justify-between px-6 shadow-sm">
           <div className="flex items-center gap-4">
              <button className="md:hidden text-slate-400 hover:text-white transition-colors" onClick={() => setMobileSidebarOpen(true)}>
                 <LayoutDashboard className="w-5 h-5" />
              </button>
              <div className="hidden md:flex items-center bg-white/5 border border-white/10 rounded-full px-4 py-2 w-64 md:w-80 transition-colors focus-within:bg-white/10 focus-within:border-white/20">
                 <Search className="w-4 h-4 text-slate-400 mr-2 shrink-0" />
                 <input type="text" placeholder="Search..." className="bg-transparent border-none outline-none text-sm text-white w-full placeholder:text-slate-500" />
              </div>
           </div>
           
           <div className="flex items-center gap-4">
              {/* Theme Toggle */}
              <button
                className="relative w-10 h-10 rounded-full bg-white/5 border border-white/10 flex items-center justify-center text-slate-400 hover:text-white hover:bg-white/10 transition-colors"
                onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
              >
                <div className="w-4 h-4 flex items-center justify-center">
                  <span className="block dark:hidden">🌙</span>
                  <span className="hidden dark:block">☀️</span>
                </div>
              </button>

              <NotificationRing />
              <MessageDropdown />

              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <button className="relative h-10 px-3 rounded-full bg-white/5 border border-white/10 flex items-center justify-center gap-2 text-slate-400 hover:text-white hover:bg-white/10 transition-colors">
                    <Globe className="w-4 h-4" />
                    <span className="text-xs font-medium uppercase">{currentLang.code}</span>
                  </button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end" className="w-48 max-h-80 overflow-y-auto bg-card border-border">
                  {LANGUAGES.map(lang => (
                    <DropdownMenuItem key={lang.code} onClick={() => handleLanguageChange(lang.code)} className="gap-2 cursor-pointer">
                      <span className="text-base">{lang.flag}</span>
                      <span className="flex-1">{lang.name}</span>
                      {currentLang.code === lang.code && <span className="w-2 h-2 rounded-full bg-primary" />}
                    </DropdownMenuItem>
                  ))}
                </DropdownMenuContent>
              </DropdownMenu>

              <div className="flex items-center gap-3 pl-4 border-l border-border">
                 <UserMenu />
              </div>
           </div>
        </header>

        {/* Main Content Area */}
        <main className="flex-1 overflow-auto bg-card/30 backdrop-blur-sm border border-border rounded-[2rem] flex flex-col transition-colors duration-300 shadow-inner relative">
          <div className="flex-1">
            {children}
          </div>
        </main>
      </div>
    </div>;
}