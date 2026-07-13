"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { motion } from "framer-motion";
import { Menu, X, Globe, Video, User, Settings, LogOut, Moon, Sun, Plus } from "lucide-react";
import { useTheme } from "next-themes";
import { UserMenu } from "@/components/layout/UserMenu";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useLanguage, LANGUAGES } from "@/lib/languages";
import { useAuth } from "@/lib/auth/hooks";
import { NotificationRing } from "@/components/notifications/NotificationRing";
import { MessageDropdown } from "@/components/layout/MessageDropdown";
import { cn } from "@/lib/utils";
export function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const [isHovered, setIsHovered] = useState(false);
  const { theme, setTheme } = useTheme();
  const {
    currentLang,
    setLanguage,
    t
  } = useLanguage();
  const pathname = usePathname();
  const router = useRouter();
  const {
    user,
    isAuthenticated,
    logout
  } = useAuth();
  const isActive = (path: string) => pathname === path;
  const handleLogout = async () => {
    await logout();
  };

  const isVideosPage = pathname.includes('/videos');
  const isMinimized = isVideosPage && !isHovered && !isOpen;

  const handleLanguageChange = (code: string) => {
    // Extract the current path without locale
    const segments = pathname.split('/').filter(Boolean);
    const currentLocale = segments[0];
    const pathWithoutLocale = currentLocale && LANGUAGES.some(l => l.code === currentLocale)
      ? segments.slice(1).join('/')
      : segments.join('/');

    // Navigate to new locale path
    const newPath = pathWithoutLocale ? `/${code}/${pathWithoutLocale}` : `/${code}`;
    router.push(newPath);
    setLanguage(code);
  };



  return <nav className={`fixed top-0 inset-x-0 z-50 p-4 flex pointer-events-none transition-all duration-500 ${isMinimized ? "justify-end" : "justify-center"}`}>
      <motion.div 
        layout
        onMouseEnter={() => setIsHovered(true)}
        onMouseLeave={() => setIsHovered(false)}
        initial={{ y: -100, opacity: 0 }} 
        animate={{ y: 0, opacity: 1 }} 
        className={cn(
          "bg-background/80 backdrop-blur-md border border-border shadow-lg transition-all duration-500 ease-in-out pointer-events-auto flex items-center",
          // Mobile state (default)
          "absolute right-4 top-4 w-12 h-12 p-0 rounded-full justify-center",
          // Desktop state
          isMinimized 
            ? "md:relative md:right-auto md:top-auto md:w-[404px] md:h-auto md:px-6 md:py-3 md:rounded-full md:justify-between md:gap-4" 
            : "md:relative md:right-auto md:top-auto md:w-full md:max-w-7xl md:h-auto md:px-6 md:py-3 md:rounded-full md:justify-between"
        )}
      >
        <div className="hidden md:flex items-center gap-8 shrink-0">
          <div className="flex items-center gap-3">
            <Link href={`/${currentLang.code}`} className="text-xl font-display font-bold bg-gradient-to-r from-blue-400 to-purple-600 bg-clip-text text-transparent">Reservatior</Link>
            {/* Visual cue for minimized state on desktop */}
            <div className={`hidden md:flex items-center justify-center overflow-hidden transition-all duration-500 ease-in-out ${isMinimized ? "w-6 opacity-100" : "w-0 opacity-0"}`}>
              <Menu className="w-5 h-5 text-muted-foreground" />
            </div>
          </div>
 
          <div className={`hidden md:flex items-center gap-6 overflow-hidden transition-all duration-500 ease-in-out
            ${isMinimized ? "w-0 opacity-0 pointer-events-none" : "w-auto opacity-100"}`}>
            <Link href={`/${currentLang.code}`} className={`text-sm font-medium transition-colors whitespace-nowrap ${isActive("/") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              {t("mobile.nav.home")}
            </Link>
            <Link href={`/${currentLang.code}/features`} suppressHydrationWarning className={`text-sm font-medium transition-colors whitespace-nowrap ${isActive("/features") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              {t("nav.features")}
            </Link>
            <Link href={`/${currentLang.code}/property`} suppressHydrationWarning className={`text-sm font-medium transition-colors whitespace-nowrap ${isActive("/property") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              {t("nav.listings")}
            </Link>
            <Link href={`/${currentLang.code}/pricing`} suppressHydrationWarning className={`text-sm font-medium transition-colors whitespace-nowrap ${isActive("/pricing") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              {t("nav.pricing")}
            </Link>
            <Link href={`/${currentLang.code}/videos`} suppressHydrationWarning className={`text-sm font-medium flex items-center gap-1 transition-colors whitespace-nowrap ${isActive("/videos") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              <Video className="w-3 h-3 shrink-0" />{t("nav.videos")}</Link>
            
            {/* ONLY FOR LOGGED IN USERS */}
            {isAuthenticated && (
              <>
                <Link href={`/${currentLang.code}/client/lease-care`} suppressHydrationWarning className={`text-sm font-medium transition-colors whitespace-nowrap ${isActive("/client/lease-care") ? "text-primary" : "text-muted-foreground hover:text-primary"} flex items-center gap-1`}>
                  LeaseCare+
                  <span className="px-1.5 py-0.5 rounded-full bg-emerald-500/10 text-emerald-500 text-[10px] font-bold border border-emerald-500/20">PRO</span>
                </Link>
                <div className="w-px h-4 bg-border/60 mx-2 shrink-0" />
                <Link href={`/${currentLang.code}/client/property/new`} className={`text-sm font-medium transition-colors whitespace-nowrap ${isActive("/client/property/new") ? "text-blue-500" : "text-blue-500/70 hover:text-blue-500"} flex items-center gap-1`}>
                  <Plus className="w-3 h-3 shrink-0" />
                  {t("nav.addListing")}
                </Link>
              </>
            )}
          </div>
        </div>
 
        <div className={cn(
          "hidden md:flex items-center gap-4 overflow-hidden transition-all duration-500 ease-in-out shrink-0",
          isMinimized ? "w-0 opacity-0 pointer-events-none" : "w-auto opacity-100"
        )}>
          {/* Theme Toggle */}
          <Button
            variant="ghost"
            size="sm"
            className="rounded-full h-8 w-8 p-0 shrink-0 bg-orange-500/10 hover:bg-orange-500/20 text-orange-600 dark:text-orange-400 border border-orange-500/20 hover:border-orange-500/30 transition-all"
            onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
          >
            <Sun className="w-4 h-4 rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0" />
            <Moon className="absolute w-4 h-4 rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100" />
          </Button>
 
          {/* Notifications & Messages (authenticated only) */}
          {isAuthenticated && (
            <>
              <NotificationRing />
              <MessageDropdown />
            </>
          )}
 
          {/* Language Switcher */}
          <div className="hidden md:block shrink-0">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="ghost" size="sm" className="rounded-full h-8 px-3 gap-2 bg-emerald-500/10 hover:bg-emerald-500/20 text-emerald-600 dark:text-emerald-400 border border-emerald-500/20 hover:border-emerald-500/30 transition-all">
                  <Globe className="w-3 h-3" />
                  <span className="text-xs font-medium">
                    {currentLang.code.toUpperCase()}
                  </span>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-48 max-h-80 overflow-y-auto bg-card border-border">
                {LANGUAGES.map(lang => <DropdownMenuItem key={lang.code} onClick={() => handleLanguageChange(lang.code)} className="gap-2 cursor-pointer">
                    <span className="text-base">{lang.flag}</span>
                    <span className="flex-1">{lang.name}</span>
                    {currentLang.code === lang.code && <span className="w-2 h-2 rounded-full bg-primary" />}
                  </DropdownMenuItem>)}
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
 
          {/* Auth Section */}
          <div className="hidden md:block shrink-0">
            <UserMenu />
          </div>
 
          {!isAuthenticated && (
            <Button asChild size="sm" className="rounded-full bg-primary hover:bg-primary/90 text-primary-foreground hidden md:inline-flex shrink-0">
              <Link href={`/${currentLang.code}/client/signup`} suppressHydrationWarning>{t("nav.getStarted")}</Link>
            </Button>
          )}
        </div>
 
        {/* Mobile Toggle */}
        <button className="md:hidden text-foreground shrink-0 flex items-center justify-center w-full h-full" onClick={() => setIsOpen(!isOpen)}>
          {isOpen ? <X size={22} /> : <Menu size={22} />}
        </button>
      </motion.div>

       {/* Mobile Menu */}
      {isOpen && <motion.div initial={{
      opacity: 0,
      y: -20
    }} animate={{
      opacity: 1,
      y: 0
    }} className="absolute top-20 inset-x-4 bg-card border border-border rounded-2xl p-6 flex flex-col gap-4 shadow-2xl md:hidden z-50">
          <Link href={`/${currentLang.code}`}>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("mobile.nav.home")}
            </span>
          </Link>
          <Link href={`/${currentLang.code}/features`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("nav.features")}
            </span>
          </Link>
          <Link href={`/${currentLang.code}/property`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("nav.listings")}
            </span>
          </Link>
          <Link href={`/${currentLang.code}/pricing`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("nav.pricing")}
            </span>
          </Link>
          <Link href={`/${currentLang.code}/videos`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>{t("nav.videos")}</span>
          </Link>
          
          {/* ONLY FOR LOGGED IN USERS */}
          {isAuthenticated && (
            <>
              <Link href={`/${currentLang.code}/client/lease-care`} suppressHydrationWarning>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2" onClick={() => setIsOpen(false)}>
                  LeaseCare+
                  <span className="px-1.5 py-0.5 rounded-full bg-emerald-500/10 text-emerald-500 text-[10px] font-bold border border-emerald-500/20">PRO</span>
                </span>
              </Link>
              <Link href={`/${currentLang.code}/client/property/new`}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2 uppercase" onClick={() => setIsOpen(false)}>
                  <Plus className="w-4 h-4" />
                  {t("nav.addListing")}
                </span>
              </Link>
            </>
          )}
          <div className="h-px bg-border my-2" />

          {/* Auth Section */}
          {isAuthenticated ? <div className="space-y-2">
              <div className="text-sm text-muted-foreground mb-2">{t("client.src.welcome")}{user?.name || user?.email?.split("@")[0]}
              </div>
              <Link href="/profile" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />{t("client.src.profile")}</span>
              </Link>
              <Link href="/settings" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <Settings className="w-4 h-4" />{t("client.src.settings")}</span>
              </Link>
              <Link href="/tags" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <span className="w-4 h-4 text-center">🏷️</span>{t("client.src.tags")}</span>
              </Link>
              <Link href="/analytics-dashboard" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <span className="w-4 h-4 text-center">📊</span>{t("client.src.analytics")}</span>
              </Link>
              <Link href="/subscriptions" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <span className="w-4 h-4 text-center">💳</span>{t("client.src.subscriptions")}</span>
              </Link>
              <Link href="/api-keys" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <span className="w-4 h-4 text-center">🔑</span>{t("client.src.api_keys")}</span>
              </Link>
              <Link href="/mobile-devices" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <span className="w-4 h-4 text-center">📱</span>{t("client.src.mobile_devices")}</span>
              </Link>
              <span className="text-lg font-medium cursor-pointer flex items-center gap-2" onClick={() => {
          handleLogout();
          setIsOpen(false);
        }}>
                <LogOut className="w-4 h-4" />{t("client.src.logout")}</span>
            </div> : <div className="space-y-2">
              <div className="text-sm text-muted-foreground mb-2">{t("client.src.account")}</div>
              <Link href={`/${currentLang.code}/client/login`} onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />{t("client.src.sign_in")}</span>
              </Link>
              <Link href={`/${currentLang.code}/client/signup`} onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />{t("client.src.sign_up")}</span>
              </Link>
            </div>}

          <div className="h-px bg-border my-2" />

          <div className="flex overflow-x-auto gap-3 pb-2 scrollbar-hide snap-x">
            {LANGUAGES.map(lang => (
              <button 
                key={lang.code} 
                onClick={() => setLanguage(lang.code)} 
                className={`shrink-0 flex items-center justify-center w-12 h-12 rounded-full text-2xl transition-all snap-center ${currentLang.code === lang.code ? "bg-primary/20 border border-primary/50 shadow-sm" : "bg-white/5 hover:bg-white/10"}`}
              >
                {lang.flag}
              </button>
            ))}
          </div>

          {!isAuthenticated && (
            <Link href={`/${currentLang.code}/client/signup`} onClick={() => setIsOpen(false)}>
              <Button className="w-full justify-center">
                {t("nav.getStarted")}
              </Button>
            </Link>
          )}
        </motion.div>}
    </nav>;
}