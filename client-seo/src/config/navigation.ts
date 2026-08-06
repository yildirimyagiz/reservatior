export interface NavigationItem {
  title: string;
  href?: string;
  icon?: string;
  badge?: string;
  children?: NavigationItem[];
  external?: boolean;
}

export const mainNavigation: NavigationItem[] = [
  {
    title: "Dashboard",
    href: "/",
    icon: "LayoutDashboard",
  },
  {
    title: "Analytics",
    href: '/admin/analytics',
    icon: "BarChart3",
  },
  {
    title: "Property Management",
    icon: "Building",
    children: [
      {
        title: "Properties",
        href: "/admin/properties",
        icon: "Home",
      },
      {
        title: "Property Inventory",
        href: "/admin/inventory", 
        icon: "Building",
      },
      {
        title: "Listings",
        href: "/admin/listings",
        icon: "List",
      },
      {
        title: "Bookings",
        href: "/admin/bookings",
        icon: "Calendar",
      },
      {
        title: "Reservations",
        href: "/admin/reservations",
        icon: "CalendarCheck",
      },
      {
        title: "Maintenance",
        href: "/admin/maintenance",
        icon: "Wrench",
      },
    ],
  },
  {
    title: "Leases & Tenants",
    icon: "FileText",
    children: [
      {
        title: "Leases",
        href: '/client/leases',
        icon: "FileContract",
      },
      {
        title: "Tenants",
        href: '/client/tenants',
        icon: "Users",
      },
      {
        title: "Applications",
        href: '/client/tenants',
        icon: "UserPlus",
      },
      {
        title: "Rent Schedule",
        href: '/client/leases',
        icon: "CalendarDays",
      },
    ],
  },
  {
    title: "Financial Management",
    icon: "DollarSign",
    children: [
      {
        title: "Financial Records",
        href: '/client/financial',
        icon: "Receipt",
      },
      {
        title: "Tax Records",
        href: '/admin/financial',
        icon: "Calculator",
      },
      {
        title: "Budgets",
        href: '/admin/financial',
        icon: "PieChart",
      },
      {
        title: "Commissions",
        href: "/financial/commissions",
        icon: "Percent",
      },
      {
        title: "Transactions",
        href: "/transactions",
        icon: "ArrowRightLeft",
      },
    ],
  },
  {
    title: "Contacts & Relationships",
    icon: "AddressBook",
    children: [
      {
        title: "Contacts",
        href: '/client/contacts',
        icon: "Users",
      },
      {
        title: "Leads",
        href: '/client/contacts',
        icon: "Target",
      },
      {
        title: "Referrals",
        href: '/client/contacts',
        icon: "Share2",
      },
      {
        title: "Client Relationships",
        href: '/client/crm',
        icon: "Handshake",
      },
    ],
  },
  {
    title: "Deals Pipeline",
    icon: "TrendingUp",
    children: [
      {
        title: "All Deals",
        href: '/client/deals',
        icon: "Briefcase",
      },
      {
        title: "Active Deals",
        href: "/deals?status=active",
        icon: "Activity",
      },
      {
        title: "Closed Deals",
        href: "/deals?status=closed",
        icon: "CheckCircle",
      },
      {
        title: "Lost Deals",
        href: "/deals?status=lost",
        icon: "XCircle",
      },
    ],
  },
  {
    title: "Projects & Tasks",
    icon: "CheckSquare",
    children: [
      {
        title: "Tasks",
        href: '/client/tasks',
        icon: "CheckList",
      },
      {
        title: "Kanban Board",
        href: "/tasks/kanban",
        icon: "LayoutGrid",
      },
      {
        title: "Projects",
        href: "/projects",
        icon: "FolderKanban",
      },
      {
        title: "Appointments",
        href: "/appointments",
        icon: "CalendarClock",
      },
    ],
  },
  {
    title: "Contracts & Legal",
    icon: "FileSignature",
    children: [
      {
        title: "Contracts",
        href: '/client/contracts',
        icon: "FileText",
      },
      {
        title: "Documents",
        href: '/client/file-management',
        icon: "File",
      },
      {
        title: "Signatures",
        href: '/client/contracts',
        icon: "PenTool",
      },
      {
        title: "Templates",
        href: "/document-templates",
        icon: "LayoutTemplate",
      },
    ],
  },
  {
    title: "Users & Organizations",
    icon: "UsersRound",
    children: [
      {
        title: "Users",
        href: "/users",
        icon: "User",
      },
      {
        title: "Organizations",
        href: "/organizations",
        icon: "Building2",
      },
      {
        title: "Roles & Permissions",
        href: "/roles",
        icon: "Shield",
      },
      {
        title: "Teams",
        href: "/teams",
        icon: "Users2",
      },
    ],
  },
  {
    title: "Reports & Analytics",
    icon: "ChartBar",
    children: [
      {
        title: "Reports",
        href: "/reports",
        icon: "FileBarChart",
      },
      {
        title: "Dashboards",
        href: "/dashboards",
        icon: "LayoutDashboard",
      },
      {
        title: "Exports",
        href: "/exports",
        icon: "Download",
      },
      {
        title: "Audit Logs",
        href: "/audit-logs",
        icon: "ScrollText",
      },
    ],
  },
  {
    title: "Integrations & Automation",
    icon: "PlugZap",
    children: [
      {
        title: "Integrations",
        href: "/integrations",
        icon: "Puzzle",
      },
      {
        title: "API Integrations",
        href: "/integrations/api",
        icon: "Code",
      },
      {
        title: "Webhooks",
        href: "/webhooks",
        icon: "Webhook",
      },
      {
        title: "Automation Rules",
        href: "/automation",
        icon: "Bot",
      },
    ],
  },
  {
    title: "AI & Analytics",
    icon: "Brain",
    children: [
      {
        title: "AI Studio",
        href: "/ai-studio",
        icon: "Sparkles",
      },
      {
        title: "Lead Scoring",
        href: "/ai/lead-scoring",
        icon: "Target",
      },
      {
        title: "Property Valuation",
        href: "/ai/valuation",
        icon: "TrendingUp",
      },
      {
        title: "Recommendations",
        href: "/ai/recommendations",
        icon: "Lightbulb",
      },
    ],
  },
  {
    title: "System",
    icon: "Settings",
    children: [
      {
        title: "Triggers & Automation",
        href: "/admin/system/triggers",
        icon: "Zap",
      },
      {
        title: "Worker Pool",
        href: "/admin/system/workers",
        icon: "Bot",
      },
      {
        title: "Event Log",
        href: "/admin/system/event-log",
        icon: "ScrollText",
      },
      {
        title: "Notification Templates",
        href: "/admin/system/notification-templates",
        icon: "Bell",
      },
    ],
  },
  {
    title: "Settings",
    href: '/admin/settings',
    icon: "Settings",
  },
];

export const secondaryNavigation: NavigationItem[] = [
  {
    title: "Help Center",
    href: '/client/support',
    icon: "HelpCircle",
  },
  {
    title: "Documentation",
    href: "/docs",
    icon: "BookOpen",
    external: true,
  },
  {
    title: "API Reference",
    href: "/api/docs",
    icon: "Code",
    external: true,
  },
];

export const mobileNavigation: NavigationItem[] = [
  {
    title: "Dashboard",
    href: "/",
    icon: "LayoutDashboard",
  },
  {
    title: "Properties",
    href: "/admin/properties",
    icon: "Home",
  },
  {
    title: "Contacts",
    href: '/client/contacts',
    icon: "Users",
  },
  {
    title: "Leads",
    href: '/client/contacts',
    icon: "Target",
  },
  {
    title: "Deals",
    href: '/client/deals',
    icon: "Briefcase",
  },
  {
    title: "Tasks",
    href: '/client/tasks',
    icon: "CheckList",
  },
  {
    title: "Settings",
    href: '/admin/settings',
    icon: "Settings",
  },
];
