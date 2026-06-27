import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { cn } from '@/lib/utils';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Home, Building2, Users, Calendar, FileText, Settings, DollarSign, Shield, Database, Menu, X, ChevronDown, ChevronRight, Brain, TrendingUp, Package, MessageSquare, Bell, Search, HelpCircle, Edit, LayoutGrid, Tag, ShieldCheck, ClipboardCheck, BarChart3, RefreshCw, Contact, Store, BadgeCheck, Briefcase, Activity, Building, Wrench, CheckSquare, Server } from 'lucide-react';
import { useAuth } from "@/lib/auth";
interface SidebarItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{
    className?: string;
  }>;
  badge?: string | number;
  requiredPermission?: string;
  children?: SidebarItem[];
}
const sidebarItems: SidebarItem[] = [{
  title: t("client.src.dashboard"),
  href: '/',
  icon: Home
}, {
  title: t("client.src.properties"),
  icon: Building2,
  children: [{
    title: t("client.src.portfolio_hub"),
    href: '/properties',
    icon: ShieldCheck,
    requiredPermission: "PROPERTIES_VIEW_ALL"
  }, {
    title: t("client.src.property_search"),
    href: '/property-search',
    icon: Search
  }, {
    title: t("client.src.all_properties"),
    href: '/admin/properties',
    icon: Building2,
    requiredPermission: "PROPERTIES_VIEW_ALL"
  }, {
    title: t("client.src.listings"),
    href: '/listings',
    icon: Package
  }]
}, {
  title: t("client.src.financial"),
  icon: DollarSign,
  children: [{
    title: t("client.src.transactions"),
    href: '/financial/transactions',
    icon: DollarSign
  }, {
    title: t("client.src.reports"),
    href: '/financial/reports',
    icon: FileText
  }, {
    title: t("client.src.invoices"),
    href: '/financial/invoices',
    icon: FileText
  }, {
    title: t("client.src.expenses"),
    href: '/financial/expenses',
    icon: TrendingUp
  }, {
    title: t("client.src.offers"),
    href: '/offers',
    icon: Tag
  }, {
    title: t("client.src.extra_charges"),
    href: '/extra-charges',
    icon: Tag
  }]
}, {
  title: t("client.src.tenants"),
  icon: Users,
  children: [{
    title: t("client.src.applications"),
    href: '/tenants/applications',
    icon: Users
  }, {
    title: t("client.src.leases"),
    href: '/leases',
    icon: FileText
  }]
}, {
  title: t("client.src.ai_analytics"),
  icon: Brain,
  children: [{
    title: t("client.src.ai_dashboard"),
    href: '/ai/dashboard',
    icon: Brain
  }, {
    title: t("client.src.analytics"),
    href: '/analytics',
    icon: BarChart3
  }, {
    title: t("client.src.models"),
    href: '/ai/models',
    icon: Brain
  }]
}, {
  title: t("client.src.legal_compliance"),
  icon: Shield,
  children: [{
    title: t("client.src.project_dashboard"),
    href: '/admin/projects',
    icon: BarChart3
  }, {
    title: t("client.src.compliance_dashboard"),
    href: '/admin/compliance',
    icon: ShieldCheck
  }, {
    title: t("client.src.property_inventory"),
    href: '/admin/inventory',
    icon: ClipboardCheck
  }, {
    title: t("client.src.documents"),
    href: '/documents',
    icon: FileText
  }, {
    title: t("client.src.signatures"),
    href: '/signatures',
    icon: Edit
  }]
}, {
  title: t("client.src.admin"),
  icon: Shield,
  requiredPermission: "ORG_MANAGE",
  children: [{
    title: t("client.src.dashboard"),
    href: '/admin/dashboard',
    icon: Home
  }, {
    title: t("client.src.users"),
    href: '/admin/users',
    icon: Users
  }, {
    title: t("client.src.organizations"),
    href: '/admin/organizations',
    icon: Building2
  }, {
    title: t("client.src.roles"),
    href: '/admin/roles',
    icon: Shield
  }, {
    title: t("client.src.plans"),
    href: '/admin/plans',
    icon: FileText
  }, {
    title: t("client.src.system"),
    href: '/admin/system-metrics',
    icon: Database
  }, {
    title: t("client.src.integrations"),
    href: '/admin/mls-integration',
    icon: RefreshCw
  }, {
    title: "B2B Hotel Integrations",
    href: '/admin/b2b-integrations',
    icon: Server
  }]
}, {
  title: t("client.src.crm_agency", "CRM & Acente"),
  icon: Users,
  requiredPermission: "ORG_MANAGE",
  children: [{
    title: t("client.src.contacts", "Kişiler & Lead"),
    href: '/admin/contacts',
    icon: Contact
  }, {
    title: t("client.src.agencies", "Acenteler"),
    href: '/admin/agencies',
    icon: Store
  }, {
    title: t("client.src.agents", "Temsilciler"),
    href: '/admin/agents',
    icon: BadgeCheck
  }, {
    title: t("client.src.vendors", "Satıcılar & Bakım"),
    href: '/admin/vendors',
    icon: Briefcase
  }]
}, {
  title: t("client.src.operations", "Operasyon & Tesis"),
  icon: Activity,
  requiredPermission: "ORG_MANAGE",
  children: [{
    title: t("client.src.tasks", "Görevler"),
    href: '/admin/tasks',
    icon: CheckSquare
  }, {
    title: t("client.src.facilities", "Tesis Yönetimi"),
    href: '/admin/facilities',
    icon: Building
  }, {
    title: t("client.src.maintenance", "Bakım & Onarım"),
    href: '/admin/maintenance',
    icon: Wrench
  }]
}, {
  title: t("client.src.advanced_operations", "Gelişmiş Operasyonlar"),
  icon: ShieldCheck,
  requiredPermission: "ORG_MANAGE",
  children: [{
    title: t("client.src.reservations", "Rezervasyonlar"),
    href: '/admin/bookings',
    icon: Calendar
  }, {
    title: t("client.src.payments", "Ödemeler"),
    href: '/admin/payments',
    icon: DollarSign
  }, {
    title: t("client.src.marketing", "Pazarlama"),
    href: '/admin/marketing',
    icon: TrendingUp
  }, {
    title: t("client.src.sales", "Satış & Komisyon"),
    href: '/admin/commission-distribution',
    icon: BarChart3
  }, {
    title: t("client.src.company", "Şirket Yönetimi"),
    href: '/admin/company',
    icon: Building2
  }, {
    title: t("client.src.membership", "Üyelikler"),
    href: '/admin/membership',
    icon: Users
  }, {
    title: t("client.src.security", "Güvenlik"),
    href: '/admin/security',
    icon: Shield
  }, {
    title: t("client.src.cloud", "Cloud Altyapı"),
    href: '/admin/cloud/manager',
    icon: Database
  }]
}, {
  title: t("client.src.communication"),
  icon: MessageSquare,
  badge: 3,
  children: [{
    title: t("client.src.messages"),
    href: '/messages',
    icon: MessageSquare
  }, {
    title: t("client.src.notifications"),
    href: '/notifications',
    icon: Bell
  }]
}];
export default function Sidebar() {
  const {
    t
  } = useTranslation();
  const [open, setOpen] = useState(true);
  const [expandedItems, setExpandedItems] = useState<string[]>(['Properties', 'Financial']);
  const location = useLocation();
  const {
    hasPermission,
    user
  } = useAuth();
  const toggleExpanded = (title: string) => {
    setExpandedItems(prev => prev.includes(title) ? prev.filter(item => item !== title) : [...prev, title]);
  };
  const isActive = (href?: string) => {
    if (!href) return false;
    return location.pathname === href;
  };
  const isParentActive = (children?: SidebarItem[]) => {
    if (!children) return false;
    return children.some(child => isActive(child.href));
  };
  return <div className={cn('relative bg-slate-900/95 backdrop-blur-xl border-r border-slate-800/50 transition-all duration-300', open ? 'w-64' : 'w-16')}>
      {/* Toggle Button */}
      <div className="absolute -right-3 top-6 z-10">
        <Button size="sm" variant="outline" className="bg-slate-800 border-slate-700 text-slate-200 shadow-lg hover:bg-slate-700" onClick={() => setOpen(!open)}>
          {open ? <X className="w-4 h-4" /> : <Menu className="w-4 h-4" />}
        </Button>
      </div>

      {/* Sidebar Header - Simplified without redundant logo */}
      <div className="p-4 flex items-center justify-end border-b border-slate-800/50 min-h-[65px]">
        {/* Toggle button moved here or just kept as is */}
      </div>

      {/* Search */}
      {open && <div className="p-4 border-b border-slate-800/50">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-slate-400" />
            <input type="text" placeholder={t("client.src.search")} className="w-full pl-10 pr-4 py-2 text-sm border border-slate-700/50 rounded-lg bg-slate-800/50 text-slate-200 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent" />
          </div>
        </div>}

      {/* Navigation */}
      <ScrollArea className="flex-1">
        <nav className="p-4 space-y-2">
          {sidebarItems.filter(item => !item.requiredPermission || hasPermission(item.requiredPermission)).map(item => {
          const Icon = item.icon;
          const isExpanded = expandedItems.includes(item.title);
          const visibleChildren = item.children?.filter(child => !child.requiredPermission || hasPermission(child.requiredPermission)) || [];
          const hasChildren = visibleChildren.length > 0;
          const isItemActive = isActive(item.href) || isParentActive(visibleChildren);
          if (!item.href && !hasChildren) return null;
          return <div key={item.title}>
                <Link to={item.href || '#'} onClick={e => {
              if (hasChildren) {
                e.preventDefault();
                toggleExpanded(item.title);
              }
            }} className={cn('flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors', isItemActive ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20' : 'text-slate-300 hover:bg-slate-800/50 hover:text-slate-100')}>
                  <Icon className="w-5 h-5 shrink-0" />
                  {open && <>
                      <span className="flex-1">{item.title}</span>
                      <div className="flex items-center gap-2">
                        {item.badge && <Badge variant="secondary" className="text-xs bg-emerald-500/20 text-emerald-300 border-emerald-500/30">
                            {item.badge}
                          </Badge>}
                        {hasChildren && (isExpanded ? <ChevronDown className="w-4 h-4" /> : <ChevronRight className="w-4 h-4" />)}
                      </div>
                    </>}
                </Link>

                {/* Sub-items */}
                {hasChildren && isExpanded && open && <div className="ml-4 mt-1 space-y-1">
                    {visibleChildren.map(child => {
                const ChildIcon = child.icon;
                return <Link key={child.title} to={child.href || '#'} className={cn('flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors', isActive(child.href) ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20' : 'text-slate-400 hover:bg-slate-800/50 hover:text-slate-200')}>
                          <ChildIcon className="w-4 h-4" />
                          <span>{child.title}</span>
                        </Link>;
              })}
                  </div>}
              </div>;
        })}
        </nav>
      </ScrollArea>

      {/* Footer */}
      {open && <div className="p-4 border-t border-slate-800/50">
          <div className="space-y-3">
            <Link to="/help" className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm text-slate-400 hover:bg-slate-800/50 hover:text-slate-200 transition-colors">
              <HelpCircle className="w-5 h-5" />
              <span>{t("client.src.help_support")}</span>
            </Link>
            <Link to="/settings" className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm text-slate-400 hover:bg-slate-800/50 hover:text-slate-200 transition-colors">
              <Settings className="w-5 h-5" />
              <span>{t("client.src.settings")}</span>
            </Link>
          </div>
        </div>}
    </div>;
}