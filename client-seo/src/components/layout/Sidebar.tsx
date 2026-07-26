"use client";

import { useTranslation } from "react-i18next";
import { useState } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { cn } from '@/lib/utils';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Menu, X, ChevronDown, ChevronRight, Search, HelpCircle, Settings } from 'lucide-react';
import { useAuth } from "@/lib/auth";
import { roleBasedMenus, defaultMenu, MemberRoleKey } from "@/lib/roles/sidebarConfig";

interface SidebarItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{
    className?: string;
  }>;
  badge?: string | number;
  children?: SidebarItem[];
}

const sidebarKeyMap: Record<string, string> = {
  'Dashboard': 'sidebar.dashboard',
  'Properties': 'sidebar.properties',
  'Portfolio Hub': 'sidebar.portfolio_hub',
  'All Properties': 'sidebar.all_properties',
  'Listings': 'sidebar.listings',
  'Financial': 'sidebar.financial',
  'Transactions': 'sidebar.transactions',
  'Reports': 'sidebar.reports',
  'Invoices': 'sidebar.invoices',
  'Expenses': 'sidebar.expenses',
  'Offers': 'sidebar.offers',
  'Extra Charges': 'sidebar.extra_charges',
  'Tenants': 'sidebar.tenants',
  'Applications': 'sidebar.applications',
  'Leases': 'sidebar.leases',
  'Media Studio': 'sidebar.media_studio',
  'Videos': 'sidebar.videos',
  'Video Studio': 'sidebar.video_studio',
  'Agent Workspace': 'sidebar.agent_workspace',
  'AI Analytics': 'sidebar.ai_analytics',
  'AI Dashboard': 'sidebar.ai_dashboard',
  'Analytics': 'sidebar.analytics',
  'Models': 'sidebar.models',
  'Legal & Compliance': 'sidebar.legal_compliance',
  'Project Dashboard': 'sidebar.project_dashboard',
  'Compliance Dashboard': 'sidebar.compliance_dashboard',
  'Property Inventory': 'sidebar.property_inventory',
  'Documents': 'sidebar.documents',
  'Signatures': 'sidebar.signatures',
  'Admin': 'sidebar.admin',
  'Users': 'sidebar.users',
  'Organizations': 'sidebar.organizations',
  'Roles': 'sidebar.roles',
  'Plans': 'sidebar.plans',
  'System': 'sidebar.system',
  'Integrations': 'sidebar.integrations',
  'B2B Hotel Integrations': 'sidebar.b2b_hotel_integrations',
  'CRM & Agency': 'sidebar.crm_agency',
  'Contacts & Leads': 'sidebar.contacts_leads',
  'Agencies': 'sidebar.agencies',
  'Agents': 'sidebar.agents',
  'Vendors & Maintenance': 'sidebar.vendors_maintenance',
  'Operations': 'sidebar.operations',
  'Tasks': 'sidebar.tasks',
  'Facilities': 'sidebar.facilities',
  'Maintenance': 'sidebar.maintenance',
  'Advanced Operations': 'sidebar.advanced_operations',
  'Reservations': 'sidebar.reservations',
  'Payments': 'sidebar.payments',
  'Marketing': 'sidebar.marketing',
  'Sales & Commission': 'sidebar.sales_commission',
  'Company Management': 'sidebar.company_management',
  'Memberships': 'sidebar.memberships',
  'Security': 'sidebar.security',
  'Cloud Infrastructure': 'sidebar.cloud_infrastructure',
  'Communication': 'sidebar.communication',
  'Messages': 'sidebar.messages',
  'Notifications': 'sidebar.notifications',
  'My Properties': 'sidebar.my_properties',
  'My Leases': 'sidebar.my_leases',
  'My Commission': 'sidebar.my_commission',
  'My Profile': 'sidebar.my_profile',
};

export default function Sidebar() {
  const { t } = useTranslation();
  const [open, setOpen] = useState(true);
  const [expandedItems, setExpandedItems] = useState<string[]>(['Properties', 'Financial']);
  const pathname = usePathname();
  const { getUserRole } = useAuth();
  
  const userRole = getUserRole();
  const sidebarItems: SidebarItem[] = (userRole && roleBasedMenus[userRole as MemberRoleKey]) || defaultMenu || [];

  const tSidebar = (title: string) => {
    const key = sidebarKeyMap[title];
    return key ? t(key, title) : title;
  };

  const toggleExpanded = (title: string) => {
    setExpandedItems(prev => prev.includes(title) ? prev.filter(item => item !== title) : [...prev, title]);
  };
  
  const isActive = (href?: string) => {
    if (!href) return false;
    return pathname === href;
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
            <input type="text" aria-label="Search" placeholder={t("client.src.search")} className="w-full pl-10 pr-4 py-2 text-sm border border-slate-700/50 rounded-lg bg-slate-800/50 text-slate-200 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent" />
          </div>
        </div>}

      {/* Navigation */}
      <ScrollArea className="flex-1">
        <nav className="p-4 space-y-2">
          {sidebarItems.map(item => {
          const Icon = item.icon;
          const isExpanded = expandedItems.includes(item.title);
          const hasChildren = item.children && item.children.length > 0;
          const isItemActive = isActive(item.href) || isParentActive(item.children);
          if (!item.href && !hasChildren) return null;
          return <div key={item.title}>
                <Link href={item.href || '#'} onClick={e => {
              if (hasChildren) {
                e.preventDefault();
                toggleExpanded(item.title);
              }
            }} className={cn('flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors', isItemActive ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20' : 'text-slate-300 hover:bg-slate-800/50 hover:text-slate-100')}>
                  <Icon className="w-5 h-5 shrink-0" />
                  {open && <>
                      <span className="flex-1">{tSidebar(item.title)}</span>
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
                    {item.children?.map(child => {
                const ChildIcon = child.icon;
                return <Link key={child.title} href={child.href || '#'} className={cn('flex items-center gap-3 px-3 py-2 rounded-lg text-sm transition-colors', isActive(child.href) ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20' : 'text-slate-400 hover:bg-slate-800/50 hover:text-slate-200')}>
                          <ChildIcon className="w-4 h-4" />
                          <span>{tSidebar(child.title)}</span>
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
            <Link href="/help" className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm text-slate-400 hover:bg-slate-800/50 hover:text-slate-200 transition-colors">
              <HelpCircle className="w-5 h-5" />
              <span>{t("client.src.help_support")}</span>
            </Link>
            <Link href="/settings" className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm text-slate-400 hover:bg-slate-800/50 hover:text-slate-200 transition-colors">
              <Settings className="w-5 h-5" />
              <span>{t("client.src.settings")}</span>
            </Link>
          </div>
        </div>}
    </div>;
}