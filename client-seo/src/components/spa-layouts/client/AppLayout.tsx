import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Link, useLocation } from "@/lib/react-router-shim";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { LayoutDashboard, Building, Calendar, FileText, DollarSign, Users, Settings, Brain, BarChart3, TrendingUp, Wrench, Target, Shield, UserCheck, ChevronDown, ChevronRight, Briefcase, FileSignature, Receipt, Zap, Puzzle, ScrollText, Download, Home, List, CalendarCheck, UserPlus, CalendarDays, Calculator, PieChart, Percent, ArrowRightLeft, Share2, FolderKanban, CalendarClock, PenTool, LayoutTemplate, Building2, FileBarChart, Webhook, CheckSquare, Sparkles, Lightbulb, User, CreditCard, AlertTriangle, Key, Globe, MessageSquare, Bell, Video, Star, Heart, LayoutGrid, Tag, Landmark, Scale, Activity, History as HistoryIcon } from "lucide-react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { cn } from "@/lib/utils";
interface NavItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{
    className?: string;
  }>;
  badge?: string;
  adminOnly?: boolean;
  superOnly?: boolean;
  roles?: string[];
  permissions?: string[];
  children?: NavItem[];
}
const navigation: NavItem[] = [{
  title: t("client.nav.dashboard"),
  href: '/admin/dashboard',
  icon: LayoutDashboard
}, {
  title: t("client.nav.today"),
  href: "/calendar",
  icon: CalendarClock
}, {
  title: t("client.nav.analytics"),
  href: '/admin/analytics',
  icon: BarChart3,
  permissions: ["REPORTS_VIEW"]
}, {
  title: t("client.nav.property_management"),
  icon: Building,
  permissions: ["PROPERTIES_MANAGE", "LISTINGS_MANAGE"],
  children: [{
    title: t("common.properties"),
    href: '/admin/properties',
    icon: Home
  }, {
    title: t("client.nav.listings"),
    href: '/client/listings',
    icon: List
  }, {
    title: t("common.bookings"),
    href: "/bookings",
    icon: Calendar
  }, {
    title: t("client.nav.reservations"),
    href: "/reservations",
    icon: CalendarCheck
  }, {
    title: t("client.nav.res_tracking"),
    href: "/reservations/tracking",
    icon: Activity
  }, {
    title: t("client.nav.maintenance"),
    href: "/maintenance",
    icon: Wrench,
    permissions: ["TASKS_MANAGE"]
  }, {
    title: t("client.nav.facilities_services"),
    href: "/facilities",
    icon: LayoutGrid,
    permissions: ["ORG_MANAGE"]
  }, {
    title: t("client.nav.availability"),
    href: "/availability",
    icon: CalendarDays
  }, {
    title: t("client.nav.channels"),
    href: "/channels",
    icon: Globe,
    permissions: ["MLS_MANAGE"]
  }, {
    title: t("client.nav.discounts"),
    href: "/discounts",
    icon: Tag,
    permissions: ["FINANCE_MANAGE"]
  }]
}, {
  title: t("client.nav.communication"),
  icon: MessageSquare,
  children: [{
    title: t("client.nav.all_messages"),
    href: '/client/messages',
    icon: MessageSquare,
    permissions: ["MESSAGES_USE"]
  }, {
    title: t("client.nav.communication_logs"),
    href: "/communication-logs",
    icon: HistoryIcon,
    permissions: ["MESSAGES_USE"]
  }, {
    title: t("client.nav.notifications"),
    href: '/client/messages',
    icon: Bell
  }, {
    title: t("client.nav.files_media"),
    href: "/files",
    icon: FolderKanban
  }, {
    title: t("client.nav.activities"),
    href: "/activities",
    icon: Activity
  }]
}, {
  title: t("client.nav.agents_agencies"),
  icon: UserCheck,
  roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN"],
  children: [{
    title: t("client.nav.agents"),
    href: "/agents",
    icon: Users
  }, {
    title: t("client.nav.agencies"),
    href: "/agencies",
    icon: Building2,
    superOnly: true
  }, {
    title: t("client.nav.mortgages"),
    href: '/client/mortgages',
    icon: Landmark
  }, {
    title: t("client.nav.agency_dashboard"),
    href: "/agency-dashboard",
    icon: LayoutDashboard
  }, {
    title: t("client.nav.agent_teams"),
    href: "/agent-teams",
    icon: Users
  }, {
    title: t("client.nav.performance"),
    href: "/agent-performance",
    icon: TrendingUp
  }, {
    title: t("client.nav.video_vendors"),
    href: "/video-vendors",
    icon: Video
  }, {
    title: t("client.nav.commissions"),
    href: "/commissions",
    icon: Percent,
    permissions: ["FINANCE_MANAGE"]
  }]
}, {
  title: t("client.nav.leases_tenants"),
  icon: FileText,
  permissions: ["LEASES_MANAGE"],
  children: [{
    title: t("client.nav.leases"),
    href: '/client/leases',
    icon: FileText
  }, {
    title: t("client.nav.tenants"),
    href: '/client/tenants',
    icon: Users
  }, {
    title: t("client.nav.applications"),
    href: '/client/tenants',
    icon: UserPlus
  }, {
    title: t("client.nav.rent_schedule"),
    href: '/client/leases',
    icon: CalendarDays
  }, {
    title: t("client.nav.rent_arrears"),
    href: "/rent-arrears",
    icon: AlertTriangle
  }, {
    title: t("client.nav.increases"),
    href: "/increases",
    icon: TrendingUp
  }]
}, {
  title: t("client.nav.financial"),
  icon: DollarSign,
  permissions: ["FINANCE_MANAGE"],
  children: [{
    title: t("client.nav.payments"),
    href: "/payments",
    icon: CreditCard
  }, {
    title: t("client.nav.invoices"),
    href: '/admin/invoices',
    icon: Receipt
  }, {
    title: t("client.nav.expenses"),
    href: "/expenses",
    icon: Receipt
  }, {
    title: t("client.nav.extra_charges"),
    href: '/admin/payments',
    icon: Tag
  }, {
    title: t("client.nav.payouts"),
    href: "/payouts",
    icon: ArrowRightLeft
  }, {
    title: t("client.nav.subscriptions"),
    href: "/subscriptions",
    icon: CreditCard,
    superOnly: true
  }, {
    title: t("client.nav.escrow"),
    href: "/escrow",
    icon: Shield
  }, {
    title: t("client.nav.investor_portfolio"),
    href: "/investors/portfolio",
    icon: Briefcase
  }, {
    title: t("client.nav.mortgages"),
    href: '/client/mortgages',
    icon: Landmark
  }, {
    title: t("client.nav.financial_reports"),
    href: '/client/financial',
    icon: FileBarChart,
    permissions: ["REPORTS_VIEW"]
  }, {
    title: t("client.nav.commission_rules"),
    href: "/financial/commission-rules",
    icon: Percent
  }, {
    title: t("client.nav.tax_records"),
    href: '/admin/financial',
    icon: Calculator,
    permissions: ["TAX_MANAGE"]
  }, {
    title: t("client.nav.budgets"),
    href: '/admin/financial',
    icon: PieChart
  }, {
    title: t("client.nav.help_desk"),
    href: "/payout-and-helpdesk",
    icon: Target
  }]
}, {
  title: t("client.nav.contacts_crm"),
  icon: Users,
  children: [{
    title: t("client.nav.contacts"),
    href: '/client/contacts',
    icon: Users
  }, {
    title: t("client.nav.leads"),
    href: '/client/contacts',
    icon: Target
  }, {
    title: t("client.nav.deals"),
    href: '/client/deals',
    icon: Briefcase
  }, {
    title: t("client.nav.offers"),
    href: '/client/deals',
    icon: Zap
  }, {
    title: t("client.nav.client_relationships"),
    href: '/client/crm',
    icon: Share2
  }, {
    title: t("client.nav.referrals"),
    href: '/client/contacts',
    icon: Share2
  }, {
    title: t("client.nav.guests"),
    href: "/guests",
    icon: User
  }, {
    title: t("client.nav.guest_followup"),
    href: "/guests/follow-up",
    icon: Target
  }, {
    title: t("client.nav.tags_manager"),
    href: "/tags",
    icon: Tag
  }]
}, {
  title: t("client.nav.contracts_legal"),
  icon: FileSignature,
  permissions: ["CONTRACTS_MANAGE"],
  children: [{
    title: t("client.nav.contracts"),
    href: '/client/contracts',
    icon: FileText
  }, {
    title: t("common.documents"),
    href: '/client/file-management',
    icon: FileText
  }, {
    title: t("client.nav.signatures"),
    href: '/client/contracts',
    icon: PenTool
  }, {
    title: t("common.templates"),
    href: "/document-templates",
    icon: LayoutTemplate
  }, {
    title: t("client.nav.disclosures"),
    href: "/property-disclosures",
    icon: ScrollText
  }, {
    title: t("client.nav.compliance"),
    href: "/legal/compliance",
    icon: Shield
  }, {
    title: t("client.nav.deposit_protection"),
    href: "/legal/deposit-protection",
    icon: Shield
  }, {
    title: t("client.nav.right_to_rent"),
    href: "/legal/right-to-rent",
    icon: UserCheck
  }, {
    title: t("client.nav.solicitors"),
    href: "/legal/solicitors",
    icon: Scale
  }]
}, {
  title: t("client.nav.projects_tasks"),
  icon: CheckSquare,
  children: [{
    title: t("client.nav.tasks"),
    href: '/client/tasks',
    icon: CheckSquare
  }, {
    title: t("client.nav.task_kanban"),
    href: "/tasks/kanban",
    icon: LayoutGrid
  }, {
    title: t("client.nav.task_events"),
    href: "/task-events",
    icon: Calendar
  }, {
    title: t("client.nav.projects"),
    href: "/projects",
    icon: FolderKanban
  }, {
    title: t("client.nav.appointments"),
    href: "/appointments",
    icon: CalendarClock
  }, {
    title: t("client.nav.events"),
    href: "/events",
    icon: Calendar
  }]
}, {
  title: t("client.nav.system_settings"),
  icon: Settings,
  adminOnly: true,
  children: [{
    title: t("client.nav.general_settings"),
    href: '/admin/settings',
    icon: Settings
  }, {
    title: t("client.nav.integrations"),
    href: "/integrations",
    icon: Puzzle
  }, {
    title: t("client.nav.mls_connections"),
    href: "/mls",
    icon: Globe,
    permissions: ["MLS_MANAGE"]
  }, {
    title: t("client.nav.webhooks"),
    href: "/webhooks",
    icon: Webhook,
    permissions: ["SETTINGS_MANAGE"]
  }, {
    title: t("client.nav.api_keys"),
    href: "/api-keys",
    icon: Key,
    permissions: ["SETTINGS_MANAGE"]
  }, {
    title: t("client.nav.audit_logs"),
    href: "/audit-logs",
    icon: ScrollText
  }]
}, {
  title: t("client.nav.ai_strategic_tools"),
  icon: Brain,
  permissions: ["ORG_MANAGE", "REPORTS_VIEW"],
  children: [{
    title: t("client.nav.ai_studio"),
    href: "/ai-studio",
    icon: Sparkles
  }, {
    title: t("client.nav.lead_scoring"),
    href: "/ai/lead-scoring",
    icon: Target
  }, {
    title: t("client.nav.property_valuation"),
    href: "/ai/valuation",
    icon: TrendingUp
  }, {
    title: t("client.nav.recommendations"),
    href: "/ai/recommendations",
    icon: Lightbulb
  }, {
    title: t("client.nav.sentiment_analysis"),
    href: "/ai/sentiment",
    icon: Brain
  }, {
    title: t("client.nav.automation_rules"),
    href: "/automation",
    icon: Zap
  }, {
    title: t("client.src.marketplace_brain", "Marketplace OS Brain"),
    href: "/marketplace-brain",
    icon: Brain
  }]
}, {
  title: t("client.nav.my_account"),
  icon: User,
  children: [{
    title: t("client.nav.profile"),
    href: "/profile",
    icon: User
  }, {
    title: t("client.nav.favorites"),
    href: "/favorites",
    icon: Heart
  }, {
    title: t("client.nav.my_listings"),
    href: "/my-listings",
    icon: List
  }, {
    title: t("client.nav.compare_list"),
    href: "/compare",
    icon: ArrowRightLeft
  }, {
    title: t("client.nav.reviews"),
    href: "/reviews",
    icon: MessageSquare
  }, {
    title: t("client.nav.security_settings"),
    href: "/security-settings",
    icon: Shield
  }, {
    title: t("client.nav.mobile_devices"),
    href: "/mobile-devices",
    icon: Activity
  }, {
    title: t("client.nav.billing"),
    href: '/admin/billing',
    icon: CreditCard
  }, {
    title: t("client.nav.support"),
    href: "/support",
    icon: Target
  }, {
    title: t("common.settings"),
    href: '/admin/settings',
    icon: Settings
  }]
}];
import { useAuth } from "@/lib/auth/hooks";
interface AppLayoutProps {
  children: React.ReactNode;
}
export function AppLayout({
  children
}: AppLayoutProps) {
  const {
    t
  } = useTranslation();
  const {
    user,
    hasPermission,
    hasAnyPermission
  } = useAuth();
  const userRole = user?.role || "USER";
  const userName = user?.name || "User";
  const userEmail = user?.email || "";
  const location = useLocation();
  const isAdmin = userRole === "SUPER_ADMIN" || userRole === "ORG_ADMIN" || userRole === "ADMIN";
  const isSuper = userRole === "SUPER_ADMIN";
  const isActive = (href?: string) => {
    if (!href) return false;
    if (href === "/") return location.pathname === "/";
    return location.pathname.startsWith(href);
  };
  const filteredNav = navigation.filter(item => {
    if (item.superOnly && !isSuper) return false;
    if (item.adminOnly && !isAdmin) return false;
    if (item.roles && !item.roles.includes(userRole)) return false;
    if (item.permissions && !hasAnyPermission(item.permissions)) return false;
    return true;
  });

  return <div className="flex flex-col h-screen bg-background overflow-hidden">
      {/* Unified Application Header - Full Width */}
      <AppHeader />

      <div className="flex flex-1 overflow-hidden">
        {/* Main content */}
        <main className="flex flex-1 flex-col overflow-auto bg-background">
          <div className="flex-1">
            {children}
          </div>
          <Footer />
        </main>
      </div>
    </div>;
}