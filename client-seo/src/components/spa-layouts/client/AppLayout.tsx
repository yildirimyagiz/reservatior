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
  title: t("client.src.dashboard"),
  href: "/dashboard",
  icon: LayoutDashboard
}, {
  title: t("client.src.today"),
  href: "/calendar",
  icon: CalendarClock
}, {
  title: t("client.src.analytics"),
  href: "/analytics",
  icon: BarChart3,
  permissions: ["REPORTS_VIEW"]
}, {
  title: t("client.src.property_management"),
  icon: Building,
  permissions: ["PROPERTIES_MANAGE", "LISTINGS_MANAGE"],
  children: [{
    title: t("client.src.properties"),
    href: "/property",
    icon: Home
  }, {
    title: t("client.src.listings"),
    href: "/listings",
    icon: List
  }, {
    title: t("client.src.bookings"),
    href: "/bookings",
    icon: Calendar
  }, {
    title: t("client.src.reservations"),
    href: "/reservations",
    icon: CalendarCheck
  }, {
    title: t("client.src.res_tracking"),
    href: "/reservations/tracking",
    icon: Activity
  }, {
    title: t("client.src.maintenance"),
    href: "/maintenance",
    icon: Wrench,
    permissions: ["TASKS_MANAGE"]
  }, {
    title: t("client.src.facilities_services"),
    href: "/facilities",
    icon: LayoutGrid,
    permissions: ["ORG_MANAGE"]
  }, {
    title: t("client.src.availability"),
    href: "/availability",
    icon: CalendarDays
  }, {
    title: t("client.src.channels"),
    href: "/channels",
    icon: Globe,
    permissions: ["MLS_MANAGE"]
  }, {
    title: t("client.src.discounts"),
    href: "/discounts",
    icon: Tag,
    permissions: ["FINANCE_MANAGE"]
  }]
}, {
  title: t("client.src.communication"),
  icon: MessageSquare,
  children: [{
    title: t("client.src.all_messages"),
    href: "/messages",
    icon: MessageSquare,
    permissions: ["MESSAGES_USE"]
  }, {
    title: t("client.src.communication_logs"),
    href: "/communication-logs",
    icon: HistoryIcon,
    permissions: ["MESSAGES_USE"]
  }, {
    title: t("client.src.notifications"),
    href: "/notifications",
    icon: Bell
  }, {
    title: t("client.src.files_media"),
    href: "/files",
    icon: FolderKanban
  }, {
    title: t("client.src.activities"),
    href: "/activities",
    icon: Activity
  }]
}, {
  title: t("client.src.agents_agencies"),
  icon: UserCheck,
  roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN"],
  children: [{
    title: t("client.src.agents"),
    href: "/agents",
    icon: Users
  }, {
    title: t("client.src.agencies"),
    href: "/agencies",
    icon: Building2,
    superOnly: true
  }, {
    title: t("client.src.mortgages"),
    href: "/mortgages",
    icon: Landmark
  }, {
    title: t("client.src.agency_dashboard"),
    href: "/agency-dashboard",
    icon: LayoutDashboard
  }, {
    title: t("client.src.agent_teams"),
    href: "/agent-teams",
    icon: Users
  }, {
    title: t("client.src.performance"),
    href: "/agent-performance",
    icon: TrendingUp
  }, {
    title: t("client.src.video_vendors"),
    href: "/video-vendors",
    icon: Video
  }, {
    title: t("client.src.commissions"),
    href: "/commissions",
    icon: Percent,
    permissions: ["FINANCE_MANAGE"]
  }]
}, {
  title: t("client.src.leases_tenants"),
  icon: FileText,
  permissions: ["LEASES_MANAGE"],
  children: [{
    title: t("client.src.leases"),
    href: "/leases",
    icon: FileText
  }, {
    title: t("client.src.tenants"),
    href: "/tenants",
    icon: Users
  }, {
    title: t("client.src.applications"),
    href: "/tenant-applications",
    icon: UserPlus
  }, {
    title: t("client.src.rent_schedule"),
    href: "/rent-schedule",
    icon: CalendarDays
  }, {
    title: t("client.src.rent_arrears"),
    href: "/rent-arrears",
    icon: AlertTriangle
  }, {
    title: t("client.src.increases"),
    href: "/increases",
    icon: TrendingUp
  }]
}, {
  title: t("client.src.financial"),
  icon: DollarSign,
  permissions: ["FINANCE_MANAGE"],
  children: [{
    title: t("client.src.payments"),
    href: "/payments",
    icon: CreditCard
  }, {
    title: t("client.src.invoices"),
    href: "/financial/invoices",
    icon: Receipt
  }, {
    title: t("client.src.expenses"),
    href: "/expenses",
    icon: Receipt
  }, {
    title: t("client.src.extra_charges"),
    href: "/extra-charges",
    icon: Tag
  }, {
    title: t("client.src.payouts"),
    href: "/payouts",
    icon: ArrowRightLeft
  }, {
    title: t("client.src.subscriptions"),
    href: "/subscriptions",
    icon: CreditCard,
    superOnly: true
  }, {
    title: t("client.src.escrow"),
    href: "/escrow",
    icon: Shield
  }, {
    title: t("client.src.investor_portfolio"),
    href: "/investors/portfolio",
    icon: Briefcase
  }, {
    title: t("client.src.mortgages"),
    href: "/mortgages",
    icon: Landmark
  }, {
    title: t("client.src.financial_reports"),
    href: "/financial",
    icon: FileBarChart,
    permissions: ["REPORTS_VIEW"]
  }, {
    title: t("client.src.commission_rules"),
    href: "/financial/commission-rules",
    icon: Percent
  }, {
    title: t("client.src.tax_records"),
    href: "/financial/taxes",
    icon: Calculator,
    permissions: ["TAX_MANAGE"]
  }, {
    title: t("client.src.budgets"),
    href: "/financial/budgets",
    icon: PieChart
  }, {
    title: t("client.src.help_desk"),
    href: "/payout-and-helpdesk",
    icon: Target
  }]
}, {
  title: t("client.src.contacts_crm"),
  icon: Users,
  children: [{
    title: t("client.src.contacts"),
    href: "/contacts",
    icon: Users
  }, {
    title: t("client.src.leads"),
    href: "/leads",
    icon: Target
  }, {
    title: t("client.src.deals"),
    href: "/deals",
    icon: Briefcase
  }, {
    title: t("client.src.offers"),
    href: "/offers",
    icon: Zap
  }, {
    title: t("client.src.client_relationships"),
    href: "/client-relationships",
    icon: Share2
  }, {
    title: t("client.src.referrals"),
    href: "/referrals",
    icon: Share2
  }, {
    title: t("client.src.guests"),
    href: "/guests",
    icon: User
  }, {
    title: t("client.src.guest_followup"),
    href: "/guests/follow-up",
    icon: Target
  }, {
    title: t("client.src.tags_manager"),
    href: "/tags",
    icon: Tag
  }]
}, {
  title: t("client.src.contracts_legal"),
  icon: FileSignature,
  permissions: ["CONTRACTS_MANAGE"],
  children: [{
    title: t("client.src.contracts"),
    href: "/contracts",
    icon: FileText
  }, {
    title: t("client.src.documents"),
    href: "/documents",
    icon: FileText
  }, {
    title: t("client.src.signatures"),
    href: "/signatures",
    icon: PenTool
  }, {
    title: t("client.src.templates"),
    href: "/document-templates",
    icon: LayoutTemplate
  }, {
    title: t("client.src.disclosures"),
    href: "/property-disclosures",
    icon: ScrollText
  }, {
    title: t("client.src.compliance"),
    href: "/legal/compliance",
    icon: Shield
  }, {
    title: t("client.src.deposit_protection"),
    href: "/legal/deposit-protection",
    icon: Shield
  }, {
    title: t("client.src.right_to_rent"),
    href: "/legal/right-to-rent",
    icon: UserCheck
  }, {
    title: t("client.src.solicitors"),
    href: "/legal/solicitors",
    icon: Scale
  }]
}, {
  title: t("client.src.projects_tasks"),
  icon: CheckSquare,
  children: [{
    title: t("client.src.tasks"),
    href: "/tasks",
    icon: CheckSquare
  }, {
    title: t("client.src.task_kanban"),
    href: "/tasks/kanban",
    icon: LayoutGrid
  }, {
    title: t("client.src.task_events"),
    href: "/task-events",
    icon: Calendar
  }, {
    title: t("client.src.projects"),
    href: "/projects",
    icon: FolderKanban
  }, {
    title: t("client.src.appointments"),
    href: "/appointments",
    icon: CalendarClock
  }, {
    title: t("client.src.events"),
    href: "/events",
    icon: Calendar
  }]
}, {
  title: t("client.src.system_settings"),
  icon: Settings,
  adminOnly: true,
  children: [{
    title: t("client.src.general_settings"),
    href: "/settings",
    icon: Settings
  }, {
    title: t("client.src.integrations"),
    href: "/integrations",
    icon: Puzzle
  }, {
    title: t("client.src.mls_connections"),
    href: "/mls",
    icon: Globe,
    permissions: ["MLS_MANAGE"]
  }, {
    title: t("client.src.webhooks"),
    href: "/webhooks",
    icon: Webhook,
    permissions: ["SETTINGS_MANAGE"]
  }, {
    title: t("client.src.api_keys"),
    href: "/api-keys",
    icon: Key,
    permissions: ["SETTINGS_MANAGE"]
  }, {
    title: t("client.src.audit_logs"),
    href: "/audit-logs",
    icon: ScrollText
  }]
}, {
  title: t("client.src.ai_strategic_tools"),
  icon: Brain,
  permissions: ["ORG_MANAGE", "REPORTS_VIEW"],
  children: [{
    title: t("client.src.ai_studio"),
    href: "/ai-studio",
    icon: Sparkles
  }, {
    title: t("client.src.lead_scoring"),
    href: "/ai/lead-scoring",
    icon: Target
  }, {
    title: t("client.src.property_valuation"),
    href: "/ai/valuation",
    icon: TrendingUp
  }, {
    title: t("client.src.recommendations"),
    href: "/ai/recommendations",
    icon: Lightbulb
  }, {
    title: t("client.src.sentiment_analysis"),
    href: "/ai/sentiment",
    icon: Brain
  }, {
    title: t("client.src.automation_rules"),
    href: "/automation",
    icon: Zap
  }, {
    title: t("client.src.marketplace_brain", "Marketplace OS Brain"),
    href: "/marketplace-brain",
    icon: Brain
  }]
}, {
  title: t("client.src.my_account"),
  icon: User,
  children: [{
    title: t("client.src.profile"),
    href: "/profile",
    icon: User
  }, {
    title: t("client.src.favorites"),
    href: "/favorites",
    icon: Heart
  }, {
    title: t("client.src.my_listings"),
    href: "/my-listings",
    icon: List
  }, {
    title: t("client.src.compare_list"),
    href: "/compare",
    icon: ArrowRightLeft
  }, {
    title: t("client.src.reviews"),
    href: "/reviews",
    icon: MessageSquare
  }, {
    title: t("client.src.security_settings"),
    href: "/security-settings",
    icon: Shield
  }, {
    title: t("client.src.mobile_devices"),
    href: "/mobile-devices",
    icon: Activity
  }, {
    title: t("client.src.billing"),
    href: "/billing",
    icon: CreditCard
  }, {
    title: t("client.src.support"),
    href: "/support",
    icon: Target
  }, {
    title: t("client.src.settings"),
    href: "/settings",
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
        <main className="flex-1 overflow-auto bg-[#1b1c22] flex flex-col">
          <div className="flex-1">
            {children}
          </div>
          <Footer />
        </main>
      </div>
    </div>;
}