import { useTranslation } from "react-i18next";
import { Link, useLocation } from "@/lib/react-router-shim";
import { Building, Search, Home, Users, Calendar, Phone, Menu, X, Shield } from "lucide-react";
import { UserMenu } from "@/components/layout/UserMenu";
import { MessageDropdown } from "@/components/layout/MessageDropdown";
import { NotificationRing } from "@/components/notifications/NotificationRing";
import { useAuth } from "@/lib/auth/hooks";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { ListingManagementDialog } from "./ListingManagementDialog";
import { ThemeToggle } from "@/components/layout/ThemeToggle";
import GlobalPreferencesSelector from "@/components/ui/GlobalPreferencesSelector";
export function Header() {
  const {
    t
  } = useTranslation();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const {
    isAuthenticated
  } = useAuth();
  const location = useLocation();
  const isAuthPage = location?.pathname?.startsWith("/auth/") || false;
  const navigationItems = [{
    name: "Home",
    href: "/",
    icon: Home
  }, {
    name: "Listings",
    href: "/listings",
    icon: Building
  }, {
    name: "Search",
    href: "/property",
    icon: Search
  }, {
    name: "Management",
    href: "/property-management",
    icon: Users
  }, {
    name: "Calendar",
    href: "/calendar",
    icon: Calendar
  }, {
    name: "Trust Center",
    href: "/trust",
    icon: Shield
  }, {
    name: "Contact",
    href: "/contact",
    icon: Phone
  }];
  const filteredNavigationItems = navigationItems.filter(item => {
    if (!isAuthenticated) {
      return item.href !== "/property-management" && item.href !== "/calendar";
    }
    return true;
  });
  return <nav className="fixed top-0 w-full z-50 border-b border-white/5 bg-background/50 backdrop-blur-xl">
      <div className="container mx-auto px-4 h-16 flex items-center justify-between">
        <Link to="/" className="flex items-center gap-2 group">
          <div>
            <h1 className="text-xl font-bold tracking-tight bg-gradient-to-r from-blue-400 via-blue-200 to-blue-400 bg-size-[200%_auto] animate-shimmer bg-clip-text text-transparent">Reservatior</h1>
            <p className="text-[10px] text-slate-400 font-medium tracking-widest uppercase mt-0.5">Premium Property IQ</p>
          </div>
        </Link>

        {/* Desktop Navigation */}
        {!isAuthPage && (
          <div className="hidden lg:flex items-center gap-1">
            {filteredNavigationItems.map(item => {
              const Icon = item.icon;
              return <Link key={item.name} to={item.href} className="flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium text-muted-foreground hover:text-foreground hover:bg-accent/50 transition-all duration-200">
                    <Icon className="w-4 h-4" />
                    <span>{item.name}</span>
                  </Link>;
            })}
          </div>
        )}

        <div className="flex items-center gap-4">
          {isAuthenticated && <div className="hidden sm:flex items-center gap-2">
              <MessageDropdown />
              <NotificationRing />
            </div>}
          {!isAuthPage && <ListingManagementDialog />}
          <GlobalPreferencesSelector />
          <ThemeToggle />
          <UserMenu />
          
          {/* Mobile Menu Toggle */}
          {!isAuthPage && (
            <Button variant="ghost" size="sm" className="lg:hidden" onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}>
              {isMobileMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
            </Button>
          )}
        </div>
      </div>

      {/* Mobile Navigation */}
      {!isAuthPage && isMobileMenuOpen && <div className="lg:hidden border-t border-white/5 bg-background/95 backdrop-blur-xl">
          <div className="container mx-auto px-4 py-4">
            <div className="flex flex-col gap-2">
              {filteredNavigationItems.map(item => {
                const Icon = item.icon;
                return <Link key={item.name} to={item.href} className="flex items-center gap-3 px-4 py-3 rounded-lg text-sm font-medium text-muted-foreground hover:text-foreground hover:bg-accent/50 transition-all duration-200" onClick={() => setIsMobileMenuOpen(false)}>
                        <Icon className="w-5 h-5" />
                        <span>{item.name}</span>
                      </Link>;
              })}
            </div>
          </div>
        </div>}
    </nav>;
}