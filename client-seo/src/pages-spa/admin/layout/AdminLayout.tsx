"use client";
import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { useLocation } from "@/lib/react-router-shim";
import { Search, X, Clock, Filter, ArrowLeft, Building2, UsersRound, CalendarCheck } from "lucide-react";
import dynamic from "next/dynamic";
const NotificationRing = dynamic(() => import("@/components/notifications/NotificationRing").then(m => m.NotificationRing), { ssr: false });
const MessageDropdown = dynamic(() => import("@/components/layout/MessageDropdown").then(m => m.MessageDropdown), { ssr: false });
const UserMenu = dynamic(() => import("@/components/layout/UserMenu").then(m => m.UserMenu), { ssr: false });
import { useLanguage, LANGUAGES } from "@/lib/languages";
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from "@/components/ui/dropdown-menu";
import { useTheme } from "next-themes";
import { usePathname, useRouter } from "next/navigation";
import { cn } from "@/lib/utils";
import { useAuth } from "@/lib/auth/hooks";
import { AdminSidebar } from "./AdminSidebar";
import { getAdminNavigation, type NavItem } from "./admin-nav-config";
import { useAdminSearch, type SearchResult } from "./useAdminSearch";

interface AdminLayoutProps {
  children: React.ReactNode;
  userRole?: string;
  userName?: string;
  userEmail?: string;
}

export function AdminLayout({
  children,
  userRole = "ADMIN",
  userName = "Admin",
  userEmail = ""
}: AdminLayoutProps) {
  const { t } = useTranslation();

  const location = useLocation();
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [mobileSidebarOpen, setMobileSidebarOpen] = useState(false);
  const [expandedGroups, setExpandedGroups] = useState<string[]>(["Users & Security", "Financials", t("admin_layout_financial_operations", "Financial Operations")]);
  const { user: authUser, hasPermission } = useAuth();
  const isSuper = userRole === "SUPER_ADMIN" || authUser?.role === "SUPER_ADMIN";

  const { theme, setTheme } = useTheme();
  const { currentLang, setLanguage } = useLanguage();
  const pathname = usePathname();
  const router = useRouter();

  const adminNavigation: NavItem[] = useMemo(() => getAdminNavigation(t), [t]);

  const {
    searchQuery, setSearchQuery, searchOpen, setSearchOpen,
    searchResults, searchHistory, selectedIndex,
    searchRef, inputRef, handleKeyDown, handleSearchClick, clearHistory,
  } = useAdminSearch(adminNavigation);

  const handleBack = () => {
    const pathParts = pathname.split('/').filter(Boolean);
    if (pathParts.length > 2 && pathParts[0] === 'admin') {
      const parentPath = '/' + pathParts.slice(0, 2).join('/');
      router.push(parentPath);
    } else {
      router.push('/admin/dashboard');
    }
  };

  const showBackButton = pathname !== '/admin/dashboard' && pathname !== '/admin';

  const handleLanguageChange = (code: string) => {
    const segments = pathname.split('/').filter(Boolean);
    const currentLocale = segments[0];
    const pathWithoutLocale = currentLocale && LANGUAGES.some(l => l.code === currentLocale)
      ? segments.slice(1).join('/')
      : segments.join('/');
    const newPath = pathWithoutLocale ? `/${code}/${pathWithoutLocale}` : `/${code}`;
    router.push(newPath);
    setLanguage(code);
  };

  const toggleGroup = (title: string) => {
    setExpandedGroups(prev => prev.includes(title) ? prev.filter(t => t !== title) : [...prev, title]);
  };

  const isActive = (href?: string) => {
    if (!href) return false;
    return location.pathname.startsWith(href);
  };

  const filteredNav = adminNavigation.filter(item => {
    if (item.superOnly && !isSuper) return false;
    if (item.requiredPermission && !isSuper && !hasPermission(item.requiredPermission)) return false;
    return true;
  });

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex h-screen bg-background text-foreground overflow-hidden transition-colors p-4 gap-4">
      {/* Desktop Sidebar (Floating & Rounded) */}
      <aside className={cn("hidden md:flex flex-col bg-card/50 backdrop-blur-xl border border-border transition-all duration-300 shrink-0 rounded-[2rem] overflow-hidden", sidebarOpen ? "w-64" : "w-16")}>
        <AdminSidebar
          navItems={filteredNav}
          sidebarOpen={sidebarOpen}
          expandedGroups={expandedGroups}
          isSuper={isSuper}
          hasPermission={hasPermission}
          userName={userName}
          userRole={userRole}
          onToggleGroup={toggleGroup}
          onToggleSidebar={() => setSidebarOpen(!sidebarOpen)}
          isActive={isActive}
        />
      </aside>

      {/* Mobile Sidebar */}
      {mobileSidebarOpen && (
        <div className="fixed inset-0 z-50 md:hidden">
          <div className="absolute inset-0 bg-black/80 backdrop-blur-sm" onClick={() => setMobileSidebarOpen(false)} />
          <aside className="absolute left-4 top-4 bottom-4 w-64 bg-card rounded-[2rem] flex flex-col overflow-hidden border border-border shadow-2xl">
            <AdminSidebar
              navItems={filteredNav}
              sidebarOpen={true}
              expandedGroups={expandedGroups}
              isSuper={isSuper}
              hasPermission={hasPermission}
              userName={userName}
              userRole={userRole}
              onToggleGroup={toggleGroup}
              onToggleSidebar={() => setMobileSidebarOpen(false)}
              isActive={isActive}
            />
          </aside>
        </div>
      )}

      <div className="flex-1 flex flex-col overflow-hidden gap-4">
        {/* Floating Oval Top Navbar */}
        <header className="relative z-50 h-16 shrink-0 bg-card/50 backdrop-blur-xl border border-border rounded-full flex items-center justify-between px-6 shadow-sm">
          <div className="flex items-center gap-4">
            {showBackButton && (
              <button onClick={handleBack} className="text-muted-foreground hover:text-foreground transition-colors flex items-center gap-2 text-sm">
                <ArrowLeft className="w-4 h-4" />
                <span className="hidden sm:inline">{t('admin_back', 'Back')}</span>
              </button>
            )}
            <button className="md:hidden text-muted-foreground hover:text-foreground transition-colors" onClick={() => setMobileSidebarOpen(true)} aria-label="Search">
              <Search className="w-5 h-5" />
            </button>
            <div className="hidden md:block relative" ref={searchRef}>
              <div className={cn("flex items-center bg-muted/30 border border-border rounded-full px-4 py-2 w-64 md:w-96 transition-all duration-200", searchOpen ? "bg-muted/50 border-primary/50 ring-2 ring-primary/20" : "focus-within:bg-muted/50 focus-within:border-border")}>
                <Search className="w-4 h-4 text-muted-foreground mr-2 shrink-0" />
                <input ref={inputRef} type="text" aria-label="Search" placeholder={t("admin_search_placeholder", "Search properties, users, bookings...")} value={searchQuery} onChange={(e) => { setSearchQuery(e.target.value); setSearchOpen(true); }} onFocus={() => setSearchOpen(true)} onKeyDown={handleKeyDown} className="bg-transparent border-none outline-none text-sm text-foreground w-full placeholder:text-muted-foreground" />
                {searchQuery && (
                  <button onClick={() => { setSearchQuery(''); }} className="text-muted-foreground hover:text-foreground transition-colors" aria-label="Clear search">
                    <X className="w-4 h-4" />
                  </button>
                )}
              </div>

              {searchOpen && (
                <div className="absolute top-full left-0 right-0 mt-2 bg-card border border-border rounded-xl shadow-2xl overflow-hidden z-50 max-h-[500px] overflow-y-auto">
                  {searchQuery && searchResults.length > 0 ? (
                    <>
                      <div className="p-2">
                        {searchResults.map((result, index) => (
                          <button key={result.id} onClick={() => handleSearchClick(result)} className={cn("w-full flex items-center gap-3 p-3 rounded-lg transition-colors text-left", index === selectedIndex ? "bg-primary/10 border border-primary/20" : "hover:bg-muted/50")}>
                            <div className="flex-1 min-w-0">
                              <div className="text-sm font-medium text-foreground truncate">{result.title}</div>
                              {result.subtitle && <div className="text-xs text-muted-foreground truncate">{result.subtitle}</div>}
                            </div>
                            <div className="text-xs text-muted-foreground bg-muted/50 px-2 py-1 rounded-full">{result.category}</div>
                          </button>
                        ))}
                      </div>
                      <div className="border-t border-border p-2 flex items-center justify-between text-xs text-muted-foreground">
                        <div className="flex items-center gap-2">
                          <kbd className="px-1.5 py-0.5 bg-muted rounded border border-border">↑↓</kbd>
                          <span>{t("admin_auto_to_navigate", "to navigate")}</span>
                          <kbd className="px-1.5 py-0.5 bg-muted rounded border border-border">↵</kbd>
                          <span>{t("admin_auto_to_select", "to select")}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <kbd className="px-1.5 py-0.5 bg-muted rounded border border-border">{t("admin_auto_esc", "esc")}</kbd>
                          <span>{t("admin_auto_to_close", "to close")}</span>
                        </div>
                      </div>
                    </>
                  ) : searchQuery ? (
                    <div className="p-8 text-center">
                      <Search className="w-12 h-12 text-muted-foreground mx-auto mb-3 opacity-50" />
                      <div className="text-sm text-muted-foreground">{t("admin_auto_no_results_found_for_quot", "No results found for &quot;")}{searchQuery}{t("admin_auto_quot", "&quot;")}</div>
                    </div>
                  ) : (
                    <div className="p-2">
                      {searchHistory.length > 0 && (
                        <>
                          <div className="flex items-center justify-between px-3 py-2 mb-2">
                            <div className="text-xs font-medium text-muted-foreground flex items-center gap-2"><Clock className="w-3 h-3" />{t("mobile.auto.recent_searches", "Recent Searches")}</div>
                            <button onClick={clearHistory} className="text-xs text-muted-foreground hover:text-foreground transition-colors">{t("admin_auto_clear", "Clear")}</button>
                          </div>
                          {searchHistory.map((query, index) => (
                            <button key={index} onClick={() => { setSearchQuery(query); inputRef.current?.focus(); }} className="w-full flex items-center gap-3 p-3 rounded-lg hover:bg-muted/50 transition-colors text-left">
                              <Clock className="w-4 h-4 text-muted-foreground" />
                              <span className="text-sm text-foreground">{query}</span>
                            </button>
                          ))}
                        </>
                      )}
                    </div>
                  )}
                </div>
              )}
            </div>
          </div>

          <div className="flex items-center gap-4">
            <button className="relative w-10 h-10 rounded-full bg-muted/30 border border-border flex items-center justify-center text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-colors" onClick={() => setTheme(theme === "dark" ? "light" : "dark")}>
              <div className="w-4 h-4 flex items-center justify-center">
                <span className="block dark:hidden">🌙</span>
                <span className="hidden dark:block">☀️</span>
              </div>
            </button>

            <NotificationRing />
            <MessageDropdown />

            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <button className="relative h-10 px-3 rounded-full bg-muted/30 border border-border flex items-center justify-center gap-2 text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-colors">
                  <span className="text-xs font-medium uppercase">{currentLang.code}</span>
                </button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-48 max-h-80 overflow-y-auto bg-card border-border">
                {LANGUAGES.map(lang => (
                  <DropdownMenuItem key={lang.code} onClick={() => handleLanguageChange(lang.code)} className="gap-2 cursor-pointer">
                    <span className="text-base">{lang.flag}</span>
                    <span className="flex-1">{lang.name}</span>
                    {currentLang.code === lang.code && <span className="w-2 h-2 rounded-full bg-primary" />}
                  </DropdownMenuItem>
                ))}
              </DropdownMenuContent>
            </DropdownMenu>

            <div className="flex items-center gap-3 pl-4 border-l border-border">
              <UserMenu />
            </div>
          </div>
        </header>

        {/* Main Content Area */}
        <main className="flex-1 overflow-auto bg-card/30 backdrop-blur-sm border border-border rounded-[2rem] flex flex-col transition-colors duration-300 shadow-inner relative">
          <div className="flex-1">
            {children}
          </div>
        </main>
      </div>
    </div>
  );
}
