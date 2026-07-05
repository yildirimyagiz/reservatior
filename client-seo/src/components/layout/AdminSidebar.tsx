"use client";

import { useState } from "react";
import { Link } from "@/lib/react-router-shim";
import { usePathname } from "next/navigation";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import {
  LayoutDashboard, Building2, CalendarCheck, FileText, DollarSign,
  UsersRound, Settings, Brain, Shield, ChevronDown, ChevronRight,
  Receipt, Star, Globe, ShieldCheck, Gavel, Share2, FileDown, Megaphone,
  Search, Activity, Download, Wrench,
  Contact, Store, Briefcase, CheckSquare, Cloud, MapPin,
  CreditCard, Ticket, Bot, PieChart, TrendingUp, BarChart3,
  ClipboardList, Server, ArrowRightLeft, UserCog, Wallet, BookOpen, LayoutList
} from "lucide-react";
import { cn } from "@/lib/utils";
import { useAuth } from "@/lib/auth/hooks";

interface NavItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{ className?: string }>;
  badge?: string;
  superOnly?: boolean;
  requiredPermission?: string;
  children?: NavItem[];
}

const adminNavigation: NavItem[] = [
  {
    title: "Switch to Client App",
    href: "/",
    icon: ArrowRightLeft
  },
  {
    title: "Operating Systems",
    icon: Activity,
    children: [
      { title: "Agent OS", href: "/agent-os", icon: UserCog, requiredPermission: "AGENT_OS_ACCESS" },
      { title: "Booking OS", href: "/booking-os", icon: BookOpen, requiredPermission: "BOOKING_OS_ACCESS" },
      { title: "Listing OS", href: "/listing-os", icon: LayoutList, requiredPermission: "LISTING_OS_ACCESS" },
      { title: "Finance OS", href: "/finance-os", icon: Wallet, requiredPermission: "FINANCE_OS_ACCESS" },
    ]
  },
  {
    title: "Admin Dashboard",
    href: "/admin",
    icon: LayoutDashboard
  },
  {
    title: "Property & Inventory",
    icon: Building2,
    requiredPermission: "PROPERTIES_VIEW_ALL",
    children: [
      { title: "All Inventory", href: "/admin/inventory", icon: Building2 },
      { title: "Facilities", href: "/admin/facilities", icon: Globe },
      { title: "Maintenance", href: "/admin/maintenance", icon: Wrench }
    ]
  },
  {
    title: "Bookings & Reservations",
    icon: CalendarCheck,
    requiredPermission: "BOOKINGS_VIEW_ALL",
    children: [
      { title: "Bookings", href: "/admin/bookings", icon: CalendarCheck },
      { title: "Reservations", href: "/admin/reservations", icon: Ticket }
    ]
  },
  {
    title: "Users & Security",
    icon: Shield,
    requiredPermission: "USERS_MANAGE",
    children: [
      { title: "Users", href: "/admin/users", icon: UsersRound },
      { title: "Agencies", href: "/admin/agencies", icon: Store },
      { title: "Contacts", href: "/admin/contacts", icon: Contact },
      { title: "Vendors", href: "/admin/vendors", icon: Briefcase },
      { title: "Organization", href: "/admin/organization", icon: Building2 },
      { title: "Security", href: "/admin/security", icon: Shield }
    ]
  },
  {
    title: "Financial",
    icon: DollarSign,
    requiredPermission: "FINANCE_MANAGE",
    children: [
      { title: "Billing", href: "/admin/billing", icon: CreditCard },
      { title: "Payments", href: "/admin/payments", icon: DollarSign },
      { title: "Invoices", href: "/admin/invoices", icon: Receipt },
      { title: "Financial Reports", href: "/admin/financial", icon: BarChart3 },
      { title: "Sales & Commission", href: "/admin/sales", icon: TrendingUp },
      { title: "Escrow", href: "/admin/escrow", icon: Shield }
    ]
  },
  {
    title: "Operations",
    icon: Activity,
    requiredPermission: "ORG_MANAGE",
    children: [
      { title: "Tasks", href: "/admin/tasks", icon: CheckSquare },
      { title: "Projects", href: "/admin/projects", icon: ClipboardList },
      { title: "Reports", href: "/admin/reports", icon: FileText }
    ]
  },
  {
    title: "AI & Analytics",
    icon: Brain,
    children: [
      { title: "AI Dashboard", href: "/admin/ai", icon: Bot },
      { title: "Analytics", href: "/admin/analytics", icon: PieChart },
      { title: "Marketing", href: "/admin/marketing", icon: Megaphone },
      { title: "Scraping", href: "/admin/scraping", icon: Search }
    ]
  },
  {
    title: "Integrations & Export",
    icon: Download,
    requiredPermission: "EXPORTS_MANAGE",
    children: [
      { title: "Integrations", href: "/admin/integrations", icon: Share2 },
      { title: "Documents", href: "/admin/documents", icon: FileText },
      { title: "Location DB", href: "/admin/location", icon: MapPin },
      { title: "Cloud Infrastructure", href: "/admin/cloud", icon: Cloud }
    ]
  },
  {
    title: "System & Setup",
    icon: Settings,
    requiredPermission: "SETTINGS_MANAGE",
    children: [
      { title: "Settings", href: "/admin/settings", icon: Settings },
      { title: "Membership", href: "/admin/membership", icon: Star },
      { title: "Mobile Devices", href: "/admin/mobile", icon: Server },
      { title: "Audit Logs", href: "/admin/security", icon: Activity }
    ]
  },
  {
    title: "Legal & Compliance",
    icon: Gavel,
    requiredPermission: "GOV_INTEGRATIONS_MANAGE",
    children: [
      { title: "Compliance Center", href: "/admin/security", icon: ShieldCheck },
      { title: "Documents", href: "/admin/documents", icon: FileText }
    ]
  }
];

interface AdminSidebarProps {
  sidebarOpen: boolean;
  onToggle: () => void;
}

export default function AdminSidebar({ sidebarOpen, onToggle }: AdminSidebarProps) {
  const pathname = usePathname();
  const { hasPermission, user } = useAuth();
  const isSuper = user?.role === "SUPER_ADMIN";
  const [expandedGroups, setExpandedGroups] = useState<string[]>(["Financial", "Users & Security"]);

  const toggleGroup = (title: string) => {
    setExpandedGroups(prev =>
      prev.includes(title)
        ? prev.filter(t => t !== title)
        : [...prev, title]
    );
  };

  const isActive = (href?: string) => {
    if (!href) return false;
    if (href === "/") return false; // never highlight "Switch to Client"
    const locale = pathname.split("/")[1];
    const localized = `/${locale}${href}`;
    return pathname === localized || pathname.startsWith(`${localized}/`);
  };

  const filteredNav = adminNavigation.filter(item => {
    if (item.superOnly && !isSuper) return false;
    if (item.requiredPermission && !isSuper && !hasPermission(item.requiredPermission)) return false;
    return true;
  });

  const userName = user?.name || "Admin";
  const userEmail = user?.email || "";

  return (
    <div className="flex flex-col h-full">
      {/* Toggle header */}
      <div className="flex items-center justify-end px-4 py-5 border-b border-white/10 min-h-[69px]">
        <button
          className="h-7 w-7 shrink-0 text-muted-foreground hover:text-foreground"
          onClick={onToggle}
        >
          <ChevronRight className={`w-3.5 h-3.5 transition-transform ${sidebarOpen ? 'rotate-180' : ''}`} />
        </button>
      </div>

      {/* Navigation */}
      <nav className="flex-1 overflow-y-auto py-3 px-2 space-y-0.5">
        {filteredNav.map(item => {
          if (item.children) {
            const visibleChildren = item.children.filter(c =>
              (!c.superOnly || isSuper) &&
              (!c.requiredPermission || isSuper || hasPermission(c.requiredPermission))
            );
            if (!visibleChildren.length) return null;
            const isExpanded = expandedGroups.includes(item.title);
            const anyChildActive = visibleChildren.some(c => isActive(c.href));
            const Icon = item.icon;

            return (
              <div key={item.title}>
                <button
                  onClick={() => toggleGroup(item.title)}
                  className={cn(
                    "w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors",
                    anyChildActive
                      ? "text-primary bg-primary/10 border border-primary/20"
                      : "text-slate-400 hover:text-white hover:bg-white/5"
                  )}
                >
                  <Icon className="w-4 h-4 shrink-0" />
                  {sidebarOpen && (
                    <>
                      <span className="flex-1 text-left">{item.title}</span>
                      {isExpanded ? <ChevronDown className="w-3 h-3" /> : <ChevronRight className="w-3 h-3" />}
                    </>
                  )}
                </button>
                {isExpanded && sidebarOpen && (
                  <div className="ml-4 mt-0.5 space-y-0.5 border-l border-white/10 pl-2">
                    {visibleChildren.map(child => (
                      <Link key={child.href} to={child.href!}>
                        <button
                          className={cn(
                            "w-full flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm transition-colors",
                            isActive(child.href)
                              ? "text-primary font-medium bg-primary/10 border border-primary/20"
                              : "text-slate-400 hover:text-white hover:bg-white/5"
                          )}
                        >
                          <child.icon className="w-3.5 h-3.5 shrink-0" />
                          <span className="flex-1 text-left">{child.title}</span>
                        </button>
                      </Link>
                    ))}
                  </div>
                )}
              </div>
            );
          }

          const Icon = item.icon;
          return (
            <Link key={item.href} to={item.href!}>
              <button
                className={cn(
                  "w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors",
                  isActive(item.href)
                    ? "text-primary bg-primary/20 border border-primary/20"
                    : "text-slate-400 hover:text-white hover:bg-white/5"
                )}
              >
                <Icon className="w-4 h-4 shrink-0" />
                {sidebarOpen && <span className="flex-1 text-left">{item.title}</span>}
              </button>
            </Link>
          );
        })}
      </nav>

      {/* User area */}
      <div className="border-t border-white/10 p-3">
        <div className="flex items-center gap-2">
          <Avatar className="h-8 w-8 shrink-0">
            <AvatarFallback className="text-xs bg-primary/20 text-primary border border-primary/30">
              {userName.slice(0, 2).toUpperCase()}
            </AvatarFallback>
          </Avatar>
          {sidebarOpen && (
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium truncate text-white">{userName}</p>
              <p className="text-xs text-slate-400 truncate">{userEmail}</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
