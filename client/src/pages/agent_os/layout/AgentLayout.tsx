import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { LayoutDashboard, Users, Activity, ArrowRightLeft, ChevronDown, ChevronRight, Briefcase } from "lucide-react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { cn } from "@/lib/utils";
import { useAuth } from "@/lib/auth/hooks";

interface NavItem {
  title: string;
  href?: string;
  icon: React.ComponentType<{ className?: string }>;
}

export function AgentLayout({ children }: { children: React.ReactNode }) {
  const { t } = useTranslation();
  const location = useLocation();
  const { user } = useAuth();
  const [sidebarOpen, setSidebarOpen] = useState(true);

  const navItems: NavItem[] = [
    {
      title: "Switch to Booking OS",
      href: "/dashboard",
      icon: ArrowRightLeft
    },
    {
      title: "Agent Dashboard",
      href: "/agent-os/dashboard",
      icon: LayoutDashboard
    },
    {
      title: "My Leads",
      href: "/agent-os/leads",
      icon: Users
    },
    {
      title: "Performance",
      href: "/agent-os/performance",
      icon: Activity
    },
    {
      title: "Client Relationships",
      href: "/agent-os/clients",
      icon: Briefcase
    }
  ];

  const isActive = (href?: string) => {
    if (!href) return false;
    return location.pathname.startsWith(href);
  };

  const SidebarContent = () => (
    <div className="flex flex-col h-full">
      <div className="flex items-center justify-end px-4 py-5 border-b border-border min-h-[69px]">
        <button className="h-7 w-7 shrink-0 text-muted-foreground hover:text-foreground" onClick={() => setSidebarOpen(!sidebarOpen)}>
          <ChevronRight className={`w-3.5 h-3.5 transition-transform ${sidebarOpen ? 'rotate-180' : ''}`} />
        </button>
      </div>

      <nav className="flex-1 overflow-y-auto py-3 px-2 space-y-0.5">
        {navItems.map(item => (
          <Link key={item.href} to={item.href!}>
            <button className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", isActive(item.href) ? "text-primary bg-primary/20 border border-primary/20" : "text-muted-foreground hover:text-foreground hover:bg-accent/50")}>
              <item.icon className="w-4 h-4 shrink-0" />
              {sidebarOpen && <span className="flex-1 text-left">{item.title}</span>}
            </button>
          </Link>
        ))}
      </nav>

      <div className="border-t border-border p-3">
        <div className="flex items-center gap-2">
          <Avatar className="h-8 w-8 shrink-0">
            <AvatarFallback className="text-xs bg-primary/20 text-primary border border-primary/30">
              {user?.firstName?.slice(0, 2).toUpperCase() || "AG"}
            </AvatarFallback>
          </Avatar>
          {sidebarOpen && (
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium truncate text-foreground">{user?.firstName || "Agent"}</p>
              <p className="text-xs text-muted-foreground truncate">{user?.email}</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );

  return (
    <div className="flex flex-col h-screen bg-background text-foreground overflow-hidden">
      <AppHeader />
      <div className="flex flex-1 overflow-hidden">
        <aside className={cn("hidden md:flex flex-col border-r border-border bg-card transition-all duration-300 shrink-0", sidebarOpen ? "w-64" : "w-16")}>
          <SidebarContent />
        </aside>
        <main className="flex-1 overflow-auto bg-background flex flex-col">
          <div className="flex-1 p-6">
            {children}
          </div>
          <Footer />
        </main>
      </div>
    </div>
  );
}
