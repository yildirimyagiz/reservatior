import { Home, Building2, Users, Calendar, FileText, DollarSign, Shield, Database, Brain, TrendingUp, Package, MessageSquare, Bell, Search, Edit, Tag, ShieldCheck, ClipboardCheck, BarChart3, RefreshCw, Contact, Store, BadgeCheck, Briefcase, Activity, Building, Wrench, CheckSquare, Server, Video, Wand2, Clapperboard } from 'lucide-react';

export enum MemberRoleKey {
  OWNER = 'OWNER',
  VENDOR_MANAGER = 'VENDOR_MANAGER',
  AGENCY_ADMIN = 'AGENCY_ADMIN',
  AGENT = 'AGENT',
  ACCOUNTANT = 'ACCOUNTANT',
  MAINTENANCE = 'MAINTENANCE',
  TENANT_GUEST = 'TENANT_GUEST',
  ORG_ADMIN = 'ORG_ADMIN',
  READ_ONLY = 'READ_ONLY'
}

interface SidebarItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{ className?: string }>;
  badge?: string | number;
  children?: SidebarItem[];
}

// Role-based menu configurations
export const roleBasedMenus: Record<MemberRoleKey, SidebarItem[]> = {
  [MemberRoleKey.OWNER]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Properties',
      icon: Building2,
      children: [
        { title: 'Portfolio Hub', href: '/admin/properties', icon: ShieldCheck },
        { title: 'All Properties', href: '/admin/properties', icon: Building2 },
        { title: 'Listings', href: '/client/listings', icon: Package }
      ]
    },
    {
      title: 'Financial',
      icon: DollarSign,
      children: [
        { title: 'Transactions', href: '/client/financial', icon: DollarSign },
        { title: 'Reports', href: '/admin/reports', icon: FileText },
        { title: 'Invoices', href: '/admin/invoices', icon: FileText },
        { title: 'Expenses', href: '/admin/expenses', icon: TrendingUp },
        { title: 'Offers', href: '/client/deals', icon: Tag },
        { title: 'Extra Charges', href: '/admin/payments', icon: Tag }
      ]
    },
    {
      title: 'Tenants',
      icon: Users,
      children: [
        { title: 'Applications', href: '/client/tenants', icon: Users },
        { title: 'Leases', href: '/client/leases', icon: FileText }
      ]
    },
    {
      title: 'Media Studio',
      icon: Video,
      children: [
        { title: 'Videos', href: '/client/videos', icon: Video },
        { title: 'Video Studio', href: '/client/videos', icon: Clapperboard },
        { title: 'Agent Workspace', href: '/client/ai/studio', icon: Wand2 }
      ]
    },
    {
      title: 'AI Analytics',
      icon: Brain,
      children: [
        { title: 'AI Dashboard', href: '/admin/ai', icon: Brain },
        { title: 'Analytics', href: '/admin/analytics', icon: BarChart3 },
        { title: 'Models', href: '/admin/ai', icon: Brain }
      ]
    },
    {
      title: 'Legal & Compliance',
      icon: Shield,
      children: [
        { title: 'Project Dashboard', href: '/admin/projects', icon: BarChart3 },
        { title: 'Compliance Dashboard', href: '/admin/compliance', icon: ShieldCheck },
        { title: 'Property Inventory', href: '/admin/inventory', icon: ClipboardCheck },
        { title: 'Documents', href: '/client/file-management', icon: FileText },
        { title: 'Signatures', href: '/client/contracts', icon: Edit }
      ]
    },
    {
      title: 'Admin',
      icon: Shield,
      children: [
        { title: 'Dashboard', href: '/admin/dashboard', icon: Home },
        { title: 'Users', href: '/admin/users', icon: Users },
        { title: 'Organizations', href: '/admin/organizations', icon: Building2 },
        { title: 'Roles', href: '/admin/roles', icon: Shield },
        { title: 'Plans', href: '/admin/plans', icon: FileText },
        { title: 'System', href: '/admin/system-metrics', icon: Database },
        { title: 'Integrations', href: '/admin/mls-integration', icon: RefreshCw },
        { title: 'B2B Hotel Integrations', href: '/admin/b2b-integrations', icon: Server }
      ]
    },
    {
      title: 'CRM & Agency',
      icon: Users,
      children: [
        { title: 'Contacts & Leads', href: '/admin/contacts', icon: Contact },
        { title: 'Agencies', href: '/admin/agencies', icon: Store },
        { title: 'Agents', href: '/admin/agents', icon: BadgeCheck },
        { title: 'Vendors & Maintenance', href: '/admin/vendors', icon: Briefcase }
      ]
    },
    {
      title: 'Operations',
      icon: Activity,
      children: [
        { title: 'Tasks', href: '/admin/tasks', icon: CheckSquare },
        { title: 'Facilities', href: '/admin/facilities', icon: Building },
        { title: 'Maintenance', href: '/admin/maintenance', icon: Wrench }
      ]
    },
    {
      title: 'Advanced Operations',
      icon: ShieldCheck,
      children: [
        { title: 'Reservations', href: '/admin/bookings', icon: Calendar },
        { title: 'Payments', href: '/admin/payments', icon: DollarSign },
        { title: 'Marketing', href: '/admin/marketing', icon: TrendingUp },
        { title: 'Sales & Commission', href: '/admin/commission-distribution', icon: BarChart3 },
        { title: 'Company Management', href: '/admin/company', icon: Building2 },
        { title: 'Memberships', href: '/admin/membership', icon: Users },
        { title: 'Security', href: '/admin/security', icon: Shield },
        { title: 'Cloud Infrastructure', href: '/admin/cloud/manager', icon: Database }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.VENDOR_MANAGER]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Properties',
      icon: Building2,
      children: [
        { title: 'Portfolio Hub', href: '/admin/properties', icon: ShieldCheck },
        { title: 'Listings', href: '/client/listings', icon: Package }
      ]
    },
    {
      title: 'Financial',
      icon: DollarSign,
      children: [
        { title: 'Transactions', href: '/client/financial', icon: DollarSign },
        { title: 'Reports', href: '/admin/reports', icon: FileText },
        { title: 'Invoices', href: '/admin/invoices', icon: FileText },
        { title: 'Expenses', href: '/admin/expenses', icon: TrendingUp }
      ]
    },
    {
      title: 'Tenants',
      icon: Users,
      children: [
        { title: 'Applications', href: '/client/tenants', icon: Users },
        { title: 'Leases', href: '/client/leases', icon: FileText }
      ]
    },
    {
      title: 'Media Studio',
      icon: Video,
      children: [
        { title: 'Videos', href: '/client/videos', icon: Video },
        { title: 'Video Studio', href: '/client/videos', icon: Clapperboard },
        { title: 'Agent Workspace', href: '/client/ai/studio', icon: Wand2 }
      ]
    },
    {
      title: 'Operations',
      icon: Activity,
      children: [
        { title: 'Tasks', href: '/admin/tasks', icon: CheckSquare },
        { title: 'Facilities', href: '/admin/facilities', icon: Building },
        { title: 'Maintenance', href: '/admin/maintenance', icon: Wrench }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.AGENCY_ADMIN]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Properties',
      icon: Building2,
      children: [
        { title: 'Portfolio Hub', href: '/admin/properties', icon: ShieldCheck },
        { title: 'Listings', href: '/client/listings', icon: Package }
      ]
    },
    {
      title: 'CRM & Agency',
      icon: Users,
      children: [
        { title: 'Contacts & Leads', href: '/admin/contacts', icon: Contact },
        { title: 'Agencies', href: '/admin/agencies', icon: Store },
        { title: 'Agents', href: '/admin/agents', icon: BadgeCheck },
        { title: 'Vendors & Maintenance', href: '/admin/vendors', icon: Briefcase }
      ]
    },
    {
      title: 'Media Studio',
      icon: Video,
      children: [
        { title: 'Videos', href: '/client/videos', icon: Video },
        { title: 'Video Studio', href: '/client/videos', icon: Clapperboard },
        { title: 'Agent Workspace', href: '/client/ai/studio', icon: Wand2 }
      ]
    },
    {
      title: 'Financial',
      icon: DollarSign,
      children: [
        { title: 'Transactions', href: '/client/financial', icon: DollarSign },
        { title: 'Reports', href: '/admin/reports', icon: FileText },
        { title: 'Invoices', href: '/admin/invoices', icon: FileText },
        { title: 'Offers', href: '/client/deals', icon: Tag }
      ]
    },
    {
      title: 'Tenants',
      icon: Users,
      children: [
        { title: 'Applications', href: '/client/tenants', icon: Users },
        { title: 'Leases', href: '/client/leases', icon: FileText }
      ]
    },
    {
      title: 'Operations',
      icon: Activity,
      children: [
        { title: 'Tasks', href: '/admin/tasks', icon: CheckSquare },
        { title: 'Reservations', href: '/admin/bookings', icon: Calendar },
        { title: 'Sales & Commission', href: '/admin/commission-distribution', icon: BarChart3 }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.AGENT]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Properties',
      icon: Building2,
      children: [
        { title: 'Listings', href: '/client/listings', icon: Package }
      ]
    },
    {
      title: 'CRM & Agency',
      icon: Users,
      children: [
        { title: 'Contacts & Leads', href: '/admin/contacts', icon: Contact },
        { title: 'My Profile', href: '/admin/agents', icon: BadgeCheck }
      ]
    },
    {
      title: 'Media Studio',
      icon: Video,
      children: [
        { title: 'Videos', href: '/client/videos', icon: Video },
        { title: 'Video Studio', href: '/client/videos', icon: Clapperboard },
        { title: 'Agent Workspace', href: '/client/ai/studio', icon: Wand2 }
      ]
    },
    {
      title: 'Financial',
      icon: DollarSign,
      children: [
        { title: 'My Commission', href: '/admin/reports', icon: BarChart3 },
        { title: 'Offers', href: '/client/deals', icon: Tag }
      ]
    },
    {
      title: 'Tenants',
      icon: Users,
      children: [
        { title: 'Applications', href: '/client/tenants', icon: Users },
        { title: 'Leases', href: '/client/leases', icon: FileText }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.ACCOUNTANT]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Financial',
      icon: DollarSign,
      children: [
        { title: 'Transactions', href: '/client/financial', icon: DollarSign },
        { title: 'Reports', href: '/admin/reports', icon: FileText },
        { title: 'Invoices', href: '/admin/invoices', icon: FileText },
        { title: 'Expenses', href: '/admin/expenses', icon: TrendingUp }
      ]
    },
    {
      title: 'Legal & Compliance',
      icon: Shield,
      children: [
        { title: 'Documents', href: '/client/file-management', icon: FileText },
        { title: 'Signatures', href: '/client/contracts', icon: Edit }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.MAINTENANCE]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Properties',
      icon: Building2,
      children: [
        { title: 'Portfolio Hub', href: '/admin/properties', icon: ShieldCheck }
      ]
    },
    {
      title: 'Operations',
      icon: Activity,
      children: [
        { title: 'Tasks', href: '/admin/tasks', icon: CheckSquare },
        { title: 'Facilities', href: '/admin/facilities', icon: Building },
        { title: 'Maintenance', href: '/admin/maintenance', icon: Wrench }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.TENANT_GUEST]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'My Properties',
      icon: Building2,
      children: [
        { title: 'My Leases', href: '/client/leases', icon: FileText },
        { title: 'Payments', href: '/client/financial', icon: DollarSign }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.ORG_ADMIN]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Properties',
      icon: Building2,
      children: [
        { title: 'Portfolio Hub', href: '/admin/properties', icon: ShieldCheck },
        { title: 'All Properties', href: '/admin/properties', icon: Building2 },
        { title: 'Listings', href: '/client/listings', icon: Package }
      ]
    },
    {
      title: 'Financial',
      icon: DollarSign,
      children: [
        { title: 'Transactions', href: '/client/financial', icon: DollarSign },
        { title: 'Reports', href: '/admin/reports', icon: FileText },
        { title: 'Invoices', href: '/admin/invoices', icon: FileText },
        { title: 'Expenses', href: '/admin/expenses', icon: TrendingUp },
        { title: 'Offers', href: '/client/deals', icon: Tag }
      ]
    },
    {
      title: 'Tenants',
      icon: Users,
      children: [
        { title: 'Applications', href: '/client/tenants', icon: Users },
        { title: 'Leases', href: '/client/leases', icon: FileText }
      ]
    },
    {
      title: 'Admin',
      icon: Shield,
      children: [
        { title: 'Dashboard', href: '/admin/dashboard', icon: Home },
        { title: 'Users', href: '/admin/users', icon: Users },
        { title: 'Organizations', href: '/admin/organizations', icon: Building2 },
        { title: 'Roles', href: '/admin/roles', icon: Shield },
        { title: 'Plans', href: '/admin/plans', icon: FileText }
      ]
    },
    {
      title: 'CRM & Agency',
      icon: Users,
      children: [
        { title: 'Contacts & Leads', href: '/admin/contacts', icon: Contact },
        { title: 'Agencies', href: '/admin/agencies', icon: Store },
        { title: 'Agents', href: '/admin/agents', icon: BadgeCheck },
        { title: 'Vendors & Maintenance', href: '/admin/vendors', icon: Briefcase }
      ]
    },
    {
      title: 'Operations',
      icon: Activity,
      children: [
        { title: 'Tasks', href: '/admin/tasks', icon: CheckSquare },
        { title: 'Facilities', href: '/admin/facilities', icon: Building },
        { title: 'Maintenance', href: '/admin/maintenance', icon: Wrench }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ],

  [MemberRoleKey.READ_ONLY]: [
    {
      title: 'Dashboard',
      href: '/',
      icon: Home
    },
    {
      title: 'Properties',
      icon: Building2,
      children: [
        { title: 'Listings', href: '/client/listings', icon: Package }
      ]
    },
    {
      title: 'Financial',
      icon: DollarSign,
      children: [
        { title: 'Reports', href: '/admin/reports', icon: FileText }
      ]
    },
    {
      title: 'Communication',
      icon: MessageSquare,
      badge: 3,
      children: [
        { title: 'Messages', href: '/client/messages', icon: MessageSquare },
        { title: 'Notifications', href: '/client/messages', icon: Bell }
      ]
    }
  ]
};

// Fallback menu for users without specific roles
export const defaultMenu: SidebarItem[] = [
  {
    title: 'Dashboard',
    href: '/',
    icon: Home
  },
  {
    title: 'Properties',
    icon: Building2,
    children: [
      { title: 'Portfolio Hub', href: '/admin/properties', icon: ShieldCheck },
      { title: 'Listings', href: '/client/listings', icon: Package }
    ]
  },
  {
    title: 'Communication',
    icon: MessageSquare,
    badge: 3,
    children: [
      { title: 'Messages', href: '/client/messages', icon: MessageSquare },
      { title: 'Notifications', href: '/client/messages', icon: Bell }
    ]
  }
];
