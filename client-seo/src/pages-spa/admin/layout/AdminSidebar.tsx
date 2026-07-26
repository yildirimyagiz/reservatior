"use client";

import { Link } from "@/lib/react-router-shim";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { ChevronDown, ChevronRight, ChevronLeft } from "lucide-react";
import Image from "next/image";
import { cn } from "@/lib/utils";
import type { NavItem } from "./admin-nav-config";

interface AdminSidebarProps {
  navItems: NavItem[];
  sidebarOpen: boolean;
  expandedGroups: string[];
  isSuper: boolean;
  hasPermission: (perm: string) => boolean;
  userName: string;
  userRole: string;
  onToggleGroup: (title: string) => void;
  onToggleSidebar: () => void;
  isActive: (href?: string) => boolean;
}

export function AdminSidebar({
  navItems,
  sidebarOpen,
  expandedGroups,
  isSuper,
  hasPermission,
  userName,
  userRole,
  onToggleGroup,
  onToggleSidebar,
  isActive,
}: AdminSidebarProps) {
  return (
    <div className="flex flex-col h-full">
      <div
        className={cn(
          "flex items-center h-[69px] border-b border-border transition-all duration-300",
          sidebarOpen ? "justify-between px-4" : "justify-center px-0 cursor-pointer hover:bg-muted/30"
        )}
        onClick={() => !sidebarOpen && onToggleSidebar()}
      >
        <div className="flex items-center overflow-hidden">
          <Image src="/logo-r.jpeg" alt="Reservatior Logo" width={32} height={32} loading="lazy" sizes="32px" className="w-8 h-8 shrink-0 rounded-lg object-contain bg-background" />
          <span className={cn("text-lg font-bold text-foreground tracking-tight whitespace-nowrap transition-all duration-300", sidebarOpen ? "ml-2 opacity-100 max-w-[150px]" : "ml-0 opacity-0 max-w-0")}>
            Reservatior</span>
        </div>
        {sidebarOpen && (
          <button className="min-h-12 min-w-12 shrink-0 text-muted-foreground hover:text-foreground ml-auto" onClick={(e) => { e.stopPropagation(); onToggleSidebar(); }}>
            <ChevronLeft className="w-3.5 h-3.5 transition-transform duration-300" />
          </button>
        )}
      </div>

      <nav className="flex-1 overflow-y-auto py-3 px-2 space-y-0.5">
        {navItems.map(item => {
          if (item.children) {
            const visibleChildren = item.children.filter(c => (!c.superOnly || isSuper) && (!c.requiredPermission || isSuper || hasPermission(c.requiredPermission)));
            if (!visibleChildren.length) return null;
            const isExpanded = expandedGroups.includes(item.title);
            const anyChildActive = visibleChildren.some(c => isActive(c.href));
            return (
              <div key={item.title}>
                <button onClick={() => onToggleGroup(item.title)} className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", anyChildActive ? "text-primary bg-primary/10 border border-primary/20" : "text-muted-foreground hover:text-foreground hover:bg-muted/50")}>
                  <item.icon className="w-4 h-4 shrink-0" />
                  {sidebarOpen && <>
                    <span className="flex-1 text-left">{item.title}</span>
                    {isExpanded ? <ChevronDown className="w-3 h-3" /> : <ChevronRight className="w-3 h-3" />}
                  </>}
                </button>
                {isExpanded && sidebarOpen && (
                  <div className="ml-4 mt-0.5 space-y-0.5 border-l border-border pl-2">
                    {visibleChildren.map(child => (
                      <Link key={child.href} to={child.href!}>
                        <button className={cn("w-full flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm transition-colors", isActive(child.href) ? "text-primary font-medium bg-primary/10 border border-primary/20" : "text-muted-foreground hover:text-foreground hover:bg-muted/50")}>
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
          return (
            <Link key={item.href} to={item.href!}>
              <button className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", isActive(item.href) ? "text-primary bg-primary/20 border border-primary/20" : "text-muted-foreground hover:text-foreground hover:bg-muted/50")}>
                <item.icon className="w-4 h-4 shrink-0" />
                {sidebarOpen && <span className="flex-1 text-left">{item.title}</span>}
              </button>
            </Link>
          );
        })}
      </nav>

      <div className="border-t border-border p-3">
        <div className="flex items-center gap-2">
          <Avatar className="h-8 w-8 shrink-0">
            <AvatarFallback className="text-xs bg-primary/20 text-primary border border-primary/30">
              {userName.slice(0, 2).toUpperCase()}
            </AvatarFallback>
          </Avatar>
          {sidebarOpen && (
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium truncate text-foreground">{userName}</p>
              <p className="text-xs text-muted-foreground truncate">{userRole}</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
