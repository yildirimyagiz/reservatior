"use client";
import { useTranslation } from"react-i18next";
import { useState, useEffect, useCallback, useRef, useMemo } from"react";
import { Link, useLocation } from"@/lib/react-router-shim";
import { Avatar, AvatarFallback } from"@/components/ui/avatar";
import { LayoutDashboard, Building2, CalendarCheck, FileText, DollarSign, UsersRound, Settings, Brain, BarChart3, Shield, ChevronDown, ChevronRight, Receipt, Star, Globe, ShieldCheck, Gavel, Share2, FileDown, Megaphone, Search, AlertTriangle, Activity, Download, ArrowRightLeft, Zap, Sparkles, X, Clock, Filter, ArrowLeft } from"lucide-react";
import { NotificationRing } from"@/components/notifications/NotificationRing";
import { MessageDropdown } from"@/components/layout/MessageDropdown";
import { UserMenu } from"@/components/layout/UserMenu";
import { useLanguage, LANGUAGES } from"@/lib/languages";
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from"@/components/ui/dropdown-menu";
import { useTheme } from"next-themes";
import { usePathname, useRouter } from"next/navigation";
import { cn } from"@/lib/utils";
import { useAuth } from"@/lib/auth/hooks";
interface NavItem {
 title: string;
 href?: string;
 icon: React.ComponentType<{
 className?: string;
 }>;
 badge?: string;
 superOnly?: boolean;
 requiredPermission?: string;
 children?: NavItem[];
}
interface AdminLayoutProps {
 children: React.ReactNode;
 userRole?: string;
 userName?: string;
 userEmail?: string;
}

interface SearchResult {
 id: string;
 type: 'property' | 'user' | 'booking' | 'tenant' | 'guest' | 'contract' | 'page';
 title: string;
 subtitle?: string;
 href: string;
 icon: React.ComponentType<{ className?: string }>;
 category: string;
}

export function AdminLayout({
 children,
 userRole ="ADMIN",
 userName ="Admin",
 userEmail =""
}: AdminLayoutProps) {
 const {
 t
 } = useTranslation();
 
 const [searchQuery, setSearchQuery] = useState("");
 const [searchOpen, setSearchOpen] = useState(false);
 const [searchResults, setSearchResults] = useState<SearchResult[]>([]);
 const [searchHistory, setSearchHistory] = useState<string[]>([]);
 const [selectedIndex, setSelectedIndex] = useState(0);
 const searchRef = useRef<HTMLDivElement>(null);
 const inputRef = useRef<HTMLInputElement>(null);
 
 const location = useLocation();
 const [sidebarOpen, setSidebarOpen] = useState(true);
 const [mobileSidebarOpen, setMobileSidebarOpen] = useState(false);
 const [expandedGroups, setExpandedGroups] = useState<string[]>(["Users & Security","Financials"]);
 const { user: authUser, hasPermission } = useAuth();
 const isSuper = userRole ==="SUPER_ADMIN" || authUser?.role ==="SUPER_ADMIN";
 
 const { theme, setTheme } = useTheme();
 const { currentLang, setLanguage } = useLanguage();
 const pathname = usePathname();
 const router = useRouter();
 
 const adminNavigation: NavItem[] = useMemo(() => [{
 title: t("admin_layout_switch_to_client_app"),
 href:"/dashboard",
 icon: ArrowRightLeft
 }, {
 title: t("admin_layout_admin_dashboard"),
 href:"/admin/dashboard",
 icon: LayoutDashboard
 }, {
 title: t("admin_layout_property_inventory"),
 icon: Building2,
 requiredPermission:"PROPERTIES_VIEW_ALL",
 children: [{
 title: t("admin_layout_portfolio_neural_hub"),
 href:"/admin/properties",
 icon: Zap,
 badge:"AI"
 }, {
 title: t("admin_layout_all_properties"),
 href:"/admin/inventory",
 icon: Building2
 }, {
 title: t("admin_layout_ownership_verifications"),
 href:"/admin/ownership-verification",
 icon: ShieldCheck,
 requiredPermission:"PROPERTIES_MANAGE_ALL"
 }, {
 title: t("admin_layout_channel_manager"),
 href:"/admin/channels",
 icon: Share2,
 requiredPermission:"ORG_MANAGE"
 }, {
 title: t("admin_layout_facilities_management"),
 href:"/admin/inventory/facilities",
 icon: Globe
 }]
 }, {
 title: t("admin_layout_bookings_guests"),
 icon: CalendarCheck,
 requiredPermission:"BOOKINGS_VIEW_ALL",
 children: [{
 title: t("admin_layout_all_bookings"),
 href:"/admin/bookings",
 icon: CalendarCheck
 }, {
 title: t("admin_layout_guest_database"),
 href:"/admin/guests",
 icon: UsersRound,
 requiredPermission:"USERS_MANAGE"
 }]
 }, {
 title: t("admin_layout_users_security"),
 icon: Shield,
 requiredPermission:"USERS_MANAGE",
 children: [{
 title: t("admin_layout_system_users"),
 href:"/admin/users",
 icon: UsersRound
 }, {
 title: t("admin_layout_agent_directory"),
 href:"/admin/agents",
 icon: Star
 }, {
 title:"Organizations/Agencies",
 href:"/admin/organizations",
 icon: Building2,
 superOnly: true
 }, {
 title: t("admin_layout_roles_access"),
 href:"/admin/roles",
 icon: Shield,
 superOnly: true
 }, {
 title: t("admin_layout_security_screenings"),
 href:"/admin/security-screening",
 icon: ShieldCheck
 }, {
 title: t("admin_layout_security_events"),
 href:"/admin/security",
 icon: AlertTriangle,
 superOnly: true
 }, {
 title: t("admin_layout_advanced_security"),
 href:"/admin/advanced-security",
 icon: Shield,
 superOnly: true
 }, {
 title: t("admin_layout_audit_logs"),
 href:"/admin/audit-logs",
 icon: FileText,
 superOnly: true
 }, {
 title: t("admin_layout_api_tokens"),
 href:"/admin/api-tokens",
 icon: Zap,
 superOnly: true
 }, {
 title: t("admin_layout_active_sessions"),
 href:"/admin/sessions",
 icon: UsersRound,
 superOnly: true
 }]
 }, {
 title: t("admin_layout_legal_compliance"),
 icon: Gavel,
 requiredPermission:"GOV_INTEGRATIONS_MANAGE",
 children: [{
 title: t("admin_layout_compliance_center"),
 href:"/admin/compliance",
 icon: ShieldCheck
 }, {
 title: t("admin_layout_solicitor_management"),
 href:"/admin/solicitors",
 icon: UsersRound
 }, {
 title: t("admin_layout_immigration_checks"),
 href:"/admin/immigration",
 icon: Globe
 }, {
 title: t("admin_layout_right_to_rent"),
 href:"/admin/right-to-rent",
 icon: FileText
 }]
 }, {
 title: t("admin_layout_tenants_leases"),
 icon: FileText,
 requiredPermission:"LEASES_MANAGE_ALL",
 children: [{
 title: t("admin_layout_tenant_directory"),
 href:"/admin/tenants",
 icon: UsersRound
 }, {
 title: t("admin_layout_lease_management"),
 href:"/admin/leases",
 icon: FileText
 }]
 }, {
 title: t("admin_layout_financials"),
 icon: DollarSign,
 requiredPermission:"FINANCE_MANAGE",
 children: [{
 title: t("admin_layout_financial_reports"),
 href:"/admin/financial-reports",
 icon: DollarSign
 }, {
 title: t("admin_layout_payouts"),
 href:"/admin/payouts",
 icon: Receipt
 }, {
 title: t("admin_layout_investor_hub"),
 href:"/admin/investors",
 icon: Brain
 }, {
 title: t("admin_layout_escrow"),
 href:"/admin/escrow",
 icon: Shield
 }, {
 title: t("admin_layout_plans_tiers"),
 href:"/admin/plans",
 icon: Star,
 superOnly: true
 }]
 }, {
 title: t("admin_layout_ai_automations"),
 icon: Brain,
 requiredPermission:"REPORTS_VIEW",
 children: [{
 title: t("admin_layout_ai_dashboard"),
 href:"/admin/ai-dashboard",
 icon: LayoutDashboard
 }, {
 title: t("client.src.ai_studio","AI Studio"),
 href:"/client/ai/studio",
 icon: Sparkles
 }, {
 title: t("admin_layout_ai_models"),
 href:"/admin/ai-models",
 icon: Brain,
 superOnly: true
 }, {
 title: t("admin_layout_marketing_automation"),
 href:"/admin/marketing",
 icon: Megaphone
 }, {
 title: t("admin_layout_scraping_status"),
 href:"/admin/scraping",
 icon: Search
 }]
 }, {
 title: t("admin_layout_integrations_export"),
 icon: Download,
 requiredPermission:"EXPORTS_MANAGE",
 children: [{
 title: t("admin_layout_mls_rules"),
 href:"/admin/mls",
 icon: Globe,
 superOnly: true
 }, {
 title: t("admin_layout_export_jobs"),
 href:"/admin/export-jobs",
 icon: Download
 }, {
 title: t("admin_layout_data_exports"),
 href:"/admin/exports",
 icon: FileDown
 }]
 }, {
 title: t("admin_layout_system_setup"),
 icon: Settings,
 requiredPermission:"SETTINGS_MANAGE",
 children: [{
 title: t("admin_layout_documents_admin"),
 href:"/admin/document-management",
 icon: FileText
 }, {
 title: t("admin_layout_communication_logs"),
 href:"/admin/communication-logs",
 icon: Activity
 }, {
 title: t("admin_layout_location_db"),
 href:"/admin/location",
 icon: Globe
 }, {
 title: t("admin_layout_metrics"),
 href:"/admin/metrics",
 icon: BarChart3,
 superOnly: true
 }, {
 title: t("admin_layout_system_settings"),
 href:"/admin/system-settings",
 icon: Settings,
 superOnly: true
 }, {
 title: t("admin_layout_audit_trail"),
 href:"/admin/audit-logs",
 icon: Activity
 }]
 }], [t]);
 
 // Load search history from localStorage
 useEffect(() => {
 const savedHistory = localStorage.getItem('admin_search_history');
 if (savedHistory) {
 setSearchHistory(JSON.parse(savedHistory));
 }
 }, []);
 
 // Save search history to localStorage
 const saveToHistory = useCallback((query: string) => {
 if (!query.trim()) return;
 setSearchHistory(prev => {
 const newHistory = [query, ...prev.filter(q => q !== query)].slice(0, 10);
 localStorage.setItem('admin_search_history', JSON.stringify(newHistory));
 return newHistory;
 });
 }, []);
 
 // Perform search
 const performSearch = useCallback((query: string) => {
 if (!query.trim()) {
 setSearchResults([]);
 return;
 }
 
 const q = query.toLowerCase();
 const results: SearchResult[] = [];
 
 // Search in navigation pages
 const searchInNav = (items: NavItem[], category: string) => {
 items.forEach(item => {
 if (item.title.toLowerCase().includes(q)) {
 if (item.href) {
 results.push({
 id: item.href,
 type: 'page',
 title: item.title,
 href: item.href,
 icon: item.icon,
 category
 });
 }
 }
 if (item.children) {
 searchInNav(item.children, category);
 }
 });
 };
 
 searchInNav(adminNavigation, 'Navigation');
 
 // Mock data for other types (replace with actual API calls)
 if (q.includes('property') || q.includes('mülk') || q.includes('ev')) {
 results.push(
 { id: 'p1', type: 'property', title: 'Luxury Apartment Istanbul', subtitle: 'Beyoğlu, İstanbul', href: '/admin/properties/1', icon: Building2, category: 'Properties' },
 { id: 'p2', type: 'property', title: 'Villa Antalya', subtitle: 'Kaleiçi, Antalya', href: '/admin/properties/2', icon: Building2, category: 'Properties' }
 );
 }
 
 if (q.includes('user') || q.includes('kullanıcı') || q.includes('müşteri')) {
 results.push(
 { id: 'u1', type: 'user', title: 'John Doe', subtitle: 'john@example.com', href: '/admin/users/1', icon: UsersRound, category: 'Users' },
 { id: 'u2', type: 'user', title: 'Jane Smith', subtitle: 'jane@example.com', href: '/admin/users/2', icon: UsersRound, category: 'Users' }
 );
 }
 
 if (q.includes('booking') || q.includes('rezervasyon')) {
 results.push(
 { id: 'b1', type: 'booking', title: 'Booking #12345', subtitle: 'Jan 15 - Jan 20, 2024', href: '/admin/bookings/12345', icon: CalendarCheck, category: 'Bookings' }
 );
 }
 
 if (q.includes('tenant') || q.includes('kiracı')) {
 results.push(
 { id: 't1', type: 'tenant', title: 'Ahmet Yılmaz', subtitle: 'Verified', href: '/admin/tenants/1', icon: UsersRound, category: 'Tenants' }
 );
 }
 
 if (q.includes('guest') || q.includes('misafir')) {
 results.push(
 { id: 'g1', type: 'guest', title: 'Maria Garcia', subtitle: '5 bookings', href: '/admin/guests/1', icon: UsersRound, category: 'Guests' }
 );
 }
 
 if (q.includes('contract') || q.includes('sözleşme')) {
 results.push(
 { id: 'c1', type: 'contract', title: 'Contract #789', subtitle: 'Active', href: '/admin/contracts/789', icon: FileText, category: 'Contracts' }
 );
 }
 
 setSearchResults(results.slice(0, 10));
 setSelectedIndex(0);
 }, [adminNavigation]);
 
 // Debounced search
 useEffect(() => {
 const timer = setTimeout(() => {
 performSearch(searchQuery);
 }, 300);
 
 return () => clearTimeout(timer);
 }, [searchQuery, performSearch]);
 
 // Handle keyboard navigation
 const handleKeyDown = useCallback((e: React.KeyboardEvent) => {
 if (!searchOpen || searchResults.length === 0) return;
 
 switch (e.key) {
 case 'ArrowDown':
 e.preventDefault();
 setSelectedIndex(prev => (prev + 1) % searchResults.length);
 break;
 case 'ArrowUp':
 e.preventDefault();
 setSelectedIndex(prev => (prev - 1 + searchResults.length) % searchResults.length);
 break;
 case 'Enter':
 e.preventDefault();
 if (searchResults[selectedIndex]) {
 router.push(searchResults[selectedIndex].href);
 setSearchOpen(false);
 saveToHistory(searchQuery);
 setSearchQuery('');
 }
 break;
 case 'Escape':
 e.preventDefault();
 setSearchOpen(false);
 break;
 }
 }, [searchOpen, searchResults, selectedIndex, router, searchQuery, saveToHistory]);
 
 // Close search when clicking outside
 useEffect(() => {
 const handleClickOutside = (event: MouseEvent) => {
 if (searchRef.current && !searchRef.current.contains(event.target as Node)) {
 setSearchOpen(false);
 }
 };
 
 document.addEventListener('mousedown', handleClickOutside);
 return () => document.removeEventListener('mousedown', handleClickOutside);
 }, []);
 
 const handleSearchClick = (result: SearchResult) => {
 router.push(result.href);
 setSearchOpen(false);
 saveToHistory(searchQuery);
 setSearchQuery('');
 };
 
 const clearHistory = () => {
 setSearchHistory([]);
 localStorage.removeItem('admin_search_history');
 };

 const handleBack = () => {
 const pathParts = pathname.split('/').filter(Boolean);
 // Eğer admin alt modülündeysek, ana admin modülüne geri dön
 if (pathParts.length > 2 && pathParts[0] === 'admin') {
 const parentPath = '/' + pathParts.slice(0, 2).join('/');
 router.push(parentPath);
 } else {
 // Ana admin dashboard'a geri dön
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
 const SidebarContent = () => <div className="flex flex-col h-full">
 <div 
 className={cn("flex items-center h-[69px] border-b border-border transition-all duration-300", 
 sidebarOpen ?"justify-between px-4" :"justify-center px-0 cursor-pointer hover:bg-muted/30"
 )}
 onClick={() => !sidebarOpen && setSidebarOpen(true)}
 >
 <div className="flex items-center overflow-hidden">
 <img src="/logo-r.jpeg" alt="Reservatior Logo" className="w-8 h-8 shrink-0 rounded-lg object-contain bg-background" />
 <span className={cn("text-lg font-bold text-foreground tracking-tight whitespace-nowrap transition-all duration-300",
 sidebarOpen ?"ml-2 opacity-100 max-w-[150px]" :"ml-0 opacity-0 max-w-0"
 )}>
 Reservatior
 </span>
 </div>
 {sidebarOpen && (
 <button className="h-7 w-7 shrink-0 text-muted-foreground hover:text-foreground ml-auto" onClick={(e) => { e.stopPropagation(); setSidebarOpen(false); }}>
 <ChevronRight className="w-3.5 h-3.5 rotate-180 transition-transform duration-300" />
 </button>
 )}
 </div>

 <nav className="flex-1 overflow-y-auto py-3 px-2 space-y-0.5">
 {filteredNav.map(item => {
 if (item.children) {
 const visibleChildren = item.children.filter(c => (!c.superOnly || isSuper) && (!c.requiredPermission || isSuper || hasPermission(c.requiredPermission)));
 if (!visibleChildren.length) return null;
 const isExpanded = expandedGroups.includes(item.title);
 const anyChildActive = visibleChildren.some(c => isActive(c.href));
 return <div key={item.title}>
 <button onClick={() => toggleGroup(item.title)} className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", anyChildActive ?"text-primary bg-primary/10 border border-primary/20" :"text-muted-foreground hover:text-foreground hover:bg-muted/50")}>
 <item.icon className="w-4 h-4 shrink-0" />
 {sidebarOpen && <>
 <span className="flex-1 text-left">{item.title}</span>
 {isExpanded ? <ChevronDown className="w-3 h-3" /> : <ChevronRight className="w-3 h-3" />}
 </>}
 </button>
 {isExpanded && sidebarOpen && <div className="ml-4 mt-0.5 space-y-0.5 border-l border-border pl-2">
 {visibleChildren.map(child => <Link key={child.href} to={child.href!}>
 <button className={cn("w-full flex items-center gap-2 px-3 py-1.5 rounded-lg text-sm transition-colors", isActive(child.href) ?"text-primary font-medium bg-primary/10 border border-primary/20" :"text-muted-foreground hover:text-foreground hover:bg-muted/50")}>
 <child.icon className="w-3.5 h-3.5 shrink-0" />
 <span className="flex-1 text-left">{child.title}</span>
 </button>
 </Link>)}
 </div>}
 </div>;
 }
 return <Link key={item.href} to={item.href!}>
 <button className={cn("w-full flex items-center gap-2 px-3 py-2 rounded-lg text-sm font-medium transition-colors", isActive(item.href) ?"text-primary bg-primary/20 border border-primary/20" :"text-muted-foreground hover:text-foreground hover:bg-muted/50")}>
 <item.icon className="w-4 h-4 shrink-0" />
 {sidebarOpen && <span className="flex-1 text-left">{item.title}</span>}
 </button>
 </Link>;
 })}
 </nav>

 <div className="border-t border-border p-3">
 {/* We can use UserMenu here or keep it clean, user requested UserMenu in Navbar, so let's keep this as a simple profile summary or remove it. Let's keep it. */}
 <div className="flex items-center gap-2">
 <Avatar className="h-8 w-8 shrink-0">
 <AvatarFallback className="text-xs bg-primary/20 text-primary border border-primary/30">
 {userName.slice(0, 2).toUpperCase()}
 </AvatarFallback>
 </Avatar>
 {sidebarOpen && <div className="flex-1 min-w-0">
 <p className="text-sm font-medium truncate text-foreground">{userName}</p>
 <p className="text-xs text-muted-foreground truncate">{userRole}</p>
 </div>}
 </div>
 </div>
 </div>;
 return <div className="flex h-screen bg-background text-foreground overflow-hidden transition-colors duration-300 p-4 gap-4">
 {/* Desktop Sidebar (Floating & Rounded) */}
 <aside className={cn("hidden md:flex flex-col bg-card/50 backdrop-blur-xl border border-border transition-all duration-300 shrink-0 rounded-[2rem] overflow-hidden", sidebarOpen ?"w-64" :"w-16")}>
 <SidebarContent />
 </aside>

 {/* Mobile Sidebar */}
 {mobileSidebarOpen && <div className="fixed inset-0 z-50 md:hidden">
 <div className="absolute inset-0 bg-black/80 backdrop-blur-sm" onClick={() => setMobileSidebarOpen(false)} />
 <aside className="absolute left-4 top-4 bottom-4 w-64 bg-card rounded-[2rem] flex flex-col overflow-hidden border border-border shadow-2xl">
 <SidebarContent />
 </aside>
 </div>}

 <div className="flex-1 flex flex-col overflow-hidden gap-4">
 {/* Floating Oval Top Navbar */}
 <header className="h-16 shrink-0 bg-card/50 backdrop-blur-xl border border-border rounded-full flex items-center justify-between px-6 shadow-sm">
 <div className="flex items-center gap-4">
 {showBackButton && (
 <button 
 onClick={handleBack}
 className="text-muted-foreground hover:text-foreground transition-colors flex items-center gap-2 text-sm"
 >
 <ArrowLeft className="w-4 h-4" />
 <span className="hidden sm:inline">{t('admin_back', 'Back')}</span>
 </button>
 )}
 <button className="md:hidden text-muted-foreground hover:text-foreground transition-colors" onClick={() => setMobileSidebarOpen(true)}>
 <LayoutDashboard className="w-5 h-5" />
 </button>
 <div className="hidden md:block relative" ref={searchRef}>
 <div 
 className={cn("flex items-center bg-muted/30 border border-border rounded-full px-4 py-2 w-64 md:w-96 transition-all duration-200",
 searchOpen ?"bg-muted/50 border-primary/50 ring-2 ring-primary/20" :"focus-within:bg-muted/50 focus-within:border-border"
 )}
 >
 <Search className="w-4 h-4 text-muted-foreground mr-2 shrink-0" />
 <input 
 ref={inputRef}
 type="text" 
 placeholder={t("admin_search_placeholder","Search properties, users, bookings...")}
 value={searchQuery}
 onChange={(e) => {
 setSearchQuery(e.target.value);
 setSearchOpen(true);
 }}
 onFocus={() => setSearchOpen(true)}
 onKeyDown={handleKeyDown}
 className="bg-transparent border-none outline-none text-sm text-foreground w-full placeholder:text-muted-foreground"
 />
 {searchQuery && (
 <button 
 onClick={() => {
 setSearchQuery('');
 setSearchResults([]);
 }}
 className="text-muted-foreground hover:text-foreground transition-colors"
 >
 <X className="w-4 h-4" />
 </button>
 )}
 </div>
 
 {/* Search Results Dropdown */}
 {searchOpen && (
 <div className="absolute top-full left-0 right-0 mt-2 bg-card border border-border rounded-xl shadow-2xl overflow-hidden z-50 max-h-[500px] overflow-y-auto">
 {searchQuery && searchResults.length > 0 ? (
 <>
 {/* Results */}
 <div className="p-2">
 {searchResults.map((result, index) => (
 <button
 key={result.id}
 onClick={() => handleSearchClick(result)}
 className={cn("w-full flex items-center gap-3 p-3 rounded-lg transition-colors text-left",
 index === selectedIndex ?"bg-primary/10 border border-primary/20" :"hover:bg-muted/50"
 )}
 >
 <div className={cn("p-2 rounded-lg", 
 result.type === 'property' ?"bg-muted0/10 text-slate-500" :
 result.type === 'user' ?"bg-blue-500/10 text-blue-500" :
 result.type === 'booking' ?"bg-emerald-500/10 text-emerald-500" :
 result.type === 'tenant' ?"bg-purple-500/10 text-purple-500" :
 result.type === 'guest' ?"bg-pink-500/10 text-pink-500" :
 result.type === 'contract' ?"bg-amber-500/10 text-amber-500" :"bg-cyan-500/10 text-cyan-500"
 )}>
 <result.icon className="w-4 h-4" />
 </div>
 <div className="flex-1 min-w-0">
 <div className="text-sm font-medium text-foreground truncate">{result.title}</div>
 {result.subtitle && (
 <div className="text-xs text-muted-foreground truncate">{result.subtitle}</div>
 )}
 </div>
 <div className="text-xs text-muted-foreground bg-muted/50 px-2 py-1 rounded-full">
 {result.category}
 </div>
 </button>
 ))}
 </div>
 
 {/* Footer */}
 <div className="border-t border-border p-2 flex items-center justify-between text-xs text-muted-foreground">
 <div className="flex items-center gap-2">
 <kbd className="px-1.5 py-0.5 bg-muted rounded border border-border">↑↓</kbd>
 <span>to navigate</span>
 <kbd className="px-1.5 py-0.5 bg-muted rounded border border-border">↵</kbd>
 <span>to select</span>
 </div>
 <div className="flex items-center gap-2">
 <kbd className="px-1.5 py-0.5 bg-muted rounded border border-border">esc</kbd>
 <span>to close</span>
 </div>
 </div>
 </>
 ) : searchQuery ? (
 /* No Results */
 <div className="p-8 text-center">
 <Search className="w-12 h-12 text-muted-foreground mx-auto mb-3 opacity-50" />
 <div className="text-sm text-muted-foreground">No results found for &quot;{searchQuery}&quot;</div>
 <div className="text-xs text-muted-foreground mt-1">Try different keywords</div>
 </div>
 ) : (
 /* Search History */
 <div className="p-2">
 {searchHistory.length > 0 && (
 <>
 <div className="flex items-center justify-between px-3 py-2 mb-2">
 <div className="text-xs font-medium text-muted-foreground flex items-center gap-2">
 <Clock className="w-3 h-3" />
 Recent Searches
 </div>
 <button 
 onClick={clearHistory}
 className="text-xs text-muted-foreground hover:text-foreground transition-colors"
 >
 Clear
 </button>
 </div>
 {searchHistory.map((query, index) => (
 <button
 key={index}
 onClick={() => {
 setSearchQuery(query);
 performSearch(query);
 inputRef.current?.focus();
 }}
 className="w-full flex items-center gap-3 p-3 rounded-lg hover:bg-muted/50 transition-colors text-left"
 >
 <Clock className="w-4 h-4 text-muted-foreground" />
 <span className="text-sm text-foreground">{query}</span>
 </button>
 ))}
 </>
 )}
 
 {/* Quick Actions */}
 <div className="border-t border-border mt-2 pt-2">
 <div className="text-xs font-medium text-muted-foreground px-3 py-2 mb-2 flex items-center gap-2">
 <Filter className="w-3 h-3" />
 Quick Filters
 </div>
 <div className="grid grid-cols-2 gap-1">
 {[
 { label: 'Properties', icon: Building2, query: 'property' },
 { label: 'Users', icon: UsersRound, query: 'user' },
 { label: 'Bookings', icon: CalendarCheck, query: 'booking' },
 { label: 'Tenants', icon: UsersRound, query: 'tenant' },
 ].map((filter) => (
 <button
 key={filter.label}
 onClick={() => {
 setSearchQuery(filter.query);
 performSearch(filter.query);
 inputRef.current?.focus();
 }}
 className="flex items-center gap-2 p-2 rounded-lg hover:bg-muted/50 transition-colors text-left"
 >
 <filter.icon className="w-4 h-4 text-muted-foreground" />
 <span className="text-xs text-foreground">{filter.label}</span>
 </button>
 ))}
 </div>
 </div>
 </div>
 )}
 </div>
 )}
 </div>
 </div>
 
 <div className="flex items-center gap-4">
 {/* Theme Toggle */}
 <button
 className="relative w-10 h-10 rounded-full bg-muted/30 border border-border flex items-center justify-center text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-colors"
 onClick={() => setTheme(theme ==="dark" ?"light" :"dark")}
 >
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
 <Globe className="w-4 h-4" />
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
 </div>;
}