"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import dynamic from "next/dynamic";
import { Menu, X, Globe, Video, User, Settings, LogOut, Moon, Sun, Plus } from "lucide-react";
import { useTheme } from "next-themes";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useLanguage, LANGUAGES } from "@/lib/languages";
import { useAuth } from "@/lib/auth/hooks";
import { cn } from "@/lib/utils";

const UserMenu = dynamic(() => import("@/components/layout/UserMenu").then(m => m.UserMenu), { ssr: false });
const NotificationRing = dynamic(() => import("@/components/notifications/NotificationRing").then(m => m.NotificationRing), { ssr: false });
const MessageDropdown = dynamic(() => import("@/components/layout/MessageDropdown").then(m => m.MessageDropdown), { ssr: false });

const linkClass = (active: boolean) =>
  cn(
    "text-sm font-medium transition-colors whitespace-nowrap",
    active ? "text-brand font-bold" : "text-muted-foreground hover:text-brand"
  );

export function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const [isHovered, setIsHovered] = useState(false);
  const { theme, setTheme } = useTheme();
  const { currentLang, setLanguage, t } = useLanguage();
  const pathname = usePathname();
  const router = useRouter();
  const { user, isAuthenticated, logout } = useAuth();

  const pathWithoutLocale = (() => {
    const segments = pathname.split("/").filter(Boolean);
    if (segments[0] && LANGUAGES.some((l) => l.code === segments[0])) {
      return "/" + segments.slice(1).join("/");
    }
    return pathname || "/";
  })();

  const isActive = (path: string) => {
    if (path === "/") return pathWithoutLocale === "/" || pathWithoutLocale === "";
    return pathWithoutLocale === path || pathWithoutLocale.startsWith(path + "/");
  };

  const handleLogout = async () => {
    await logout();
  };

  const isVideosPage = pathname.includes("/videos");
  const isMinimized = isVideosPage && !isHovered && !isOpen;

  const handleLanguageChange = (code: string) => {
    const segments = pathname.split("/").filter(Boolean);
    const currentLocale = segments[0];
    const rest =
      currentLocale && LANGUAGES.some((l) => l.code === currentLocale)
        ? segments.slice(1).join("/")
        : segments.join("/");
    const newPath = rest ? `/${code}/${rest}` : `/${code}`;
    router.push(newPath);
    setLanguage(code);
  };

  const base = `/${currentLang.code}`;

  return (
    <nav
      className={cn(
        "fixed top-0 inset-x-0 z-50 p-4 flex pointer-events-none transition-all duration-500",
        isMinimized ? "justify-end" : "justify-center"
      )}
    >
      <div
        onMouseEnter={() => setIsHovered(true)}
        onMouseLeave={() => setIsHovered(false)}
        className={cn(
          "bg-card/80 backdrop-blur-xl border border-border shadow-[0_8px_32px_hsl(var(--brand)/0.12)] transition-all duration-500 ease-in-out pointer-events-auto flex items-center opacity-100",
          "absolute right-4 top-4 w-12 h-12 p-0 rounded-full justify-center",
          isMinimized
            ? "md:relative md:right-auto md:top-auto md:w-[404px] md:h-auto md:px-4 lg:px-6 md:py-3 md:rounded-full md:justify-between md:gap-4"
            : "md:relative md:right-auto md:top-auto md:w-full md:max-w-[1440px] md:h-auto md:px-4 lg:px-6 md:py-2 md:rounded-full md:justify-between md:gap-2 xl:gap-4"
        )}
      >
        <div className="hidden md:flex items-center md:gap-3 lg:gap-4 xl:gap-6 min-w-0">
          <div className="flex items-center gap-3 shrink-0">
            <Link
              href={base}
              className="text-3xl font-display font-bold bg-gradient-to-r from-brand to-info bg-clip-text text-transparent"
            >
              Reservatior
            </Link>
            <div
              className={cn(
                "hidden md:flex items-center justify-center overflow-hidden transition-all duration-500 ease-in-out",
                isMinimized ? "w-6 opacity-100" : "w-0 opacity-0"
              )}
            >
              <Menu className="w-5 h-5 text-muted-foreground" />
            </div>
          </div>

          <div
            className={cn(
              "hidden md:flex items-center md:gap-2 lg:gap-3 xl:gap-5 overflow-hidden transition-all duration-500 ease-in-out min-w-0",
              isMinimized ? "w-0 opacity-0 pointer-events-none" : "w-auto opacity-100"
            )}
          >
            <Link href={base} suppressHydrationWarning className={linkClass(isActive("/"))}>
              {t("public.nav.home")}
            </Link>
            <Link href={`${base}/features`} suppressHydrationWarning className={linkClass(isActive("/features"))}>
              {t("public.nav.features")}
            </Link>
            <Link
              href={`${base}/global-os`}
              suppressHydrationWarning
              className={cn(linkClass(isActive("/global-os")), "flex items-center gap-1")}
            >
              <Globe className="w-3 h-3 shrink-0" />
              {t("public.nav.global_os")}
              <span className="px-1.5 py-0.5 rounded-full bg-emerald-500/10 text-emerald-500 text-[10px] font-bold border border-emerald-500/20">
                NEW
              </span>
            </Link>
            <Link href={`${base}/property`} suppressHydrationWarning className={linkClass(isActive("/property"))}>
              {t("public.nav.listings")}
            </Link>
            <Link href={`${base}/pricing`} suppressHydrationWarning className={linkClass(isActive("/pricing"))}>
              {t("public.nav.pricing")}
            </Link>
            <Link
              href={`${base}/videos`}
              suppressHydrationWarning
              className={cn(linkClass(isActive("/videos")), "flex items-center gap-1")}
            >
              <Video className="w-3 h-3 shrink-0" />
              {t("public.nav.videos")}
            </Link>

            {isAuthenticated && (
              <>
                <Link
                  href={`${base}/client/lease-care`}
                  suppressHydrationWarning
                  className={cn(linkClass(isActive("/client/lease-care")), "flex items-center gap-1")}
                >
                  ReosCare+
                  <span className="px-1.5 py-0.5 rounded-full bg-success/10 text-success text-[10px] font-bold border border-success/20">
                    PRO
                  </span>
                </Link>
                <div className="w-px h-4 bg-border/60 md:mx-1 lg:mx-2 shrink-0 hidden md:block" />
                <Link
                  href={`${base}/client/property/new`}
                  className={cn(
                    linkClass(isActive("/client/property/new")),
                    "flex items-center gap-1 shrink-0"
                  )}
                >
                  <Plus className="w-3 h-3 shrink-0" />
                  {t("public.nav.add_listing")}
                </Link>
              </>
            )}
          </div>
        </div>

        <div
          className={cn(
            "hidden md:flex items-center md:gap-1.5 lg:gap-2.5 xl:gap-3.5 transition-all duration-500 ease-in-out shrink-0",
            isMinimized ? "w-0 opacity-0 pointer-events-none" : "w-auto opacity-100"
          )}
        >
          <Button
            variant="ghost"
            size="sm"
            suppressHydrationWarning
            aria-label={theme === "dark" ? "Switch to light mode" : "Switch to dark mode"}
            className="rounded-full h-8 w-8 p-0 shrink-0 bg-warning/10 hover:bg-warning/20 text-warning border border-warning/20 hover:border-warning/30 transition-all"
            onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
          >
            <Sun className="w-4 h-4 rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0" />
            <Moon className="absolute w-4 h-4 rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100" />
          </Button>

          {isAuthenticated && (
            <>
              <NotificationRing />
              <MessageDropdown />
            </>
          )}

          <div className="hidden md:block shrink-0">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button
                  variant="ghost"
                  size="sm"
                  aria-label={`Language: ${currentLang.code.toUpperCase()}`}
                  className="rounded-full h-8 px-3 gap-2 bg-success/10 hover:bg-success/20 text-success border border-success/20 hover:border-success/30 transition-all"
                >
                  <Globe className="w-3 h-3" />
                  <span className="text-xs font-medium">{currentLang.code.toUpperCase()}</span>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="w-48 max-h-80 overflow-y-auto bg-card border-border">
                {LANGUAGES.map((lang) => (
                  <DropdownMenuItem
                    key={lang.code}
                    onClick={() => handleLanguageChange(lang.code)}
                    className="gap-2 cursor-pointer"
                  >
                    <span className="text-base">{lang.flag}</span>
                    <span className="flex-1">{lang.name}</span>
                    {currentLang.code === lang.code && <span className="w-2 h-2 rounded-full bg-primary" />}
                  </DropdownMenuItem>
                ))}
              </DropdownMenuContent>
            </DropdownMenu>
          </div>

          <div className="hidden md:block shrink-0">
            <UserMenu />
          </div>

          {!isAuthenticated && (
            <Button
              asChild
              size="sm"
              className="rounded-full bg-primary hover:bg-primary/90 text-primary-foreground hidden md:inline-flex shrink-0"
            >
              <Link href={`${base}/client/signup`} suppressHydrationWarning>
                {t("public.cta.get_started")}
              </Link>
            </Button>
          )}
        </div>

        <button
          aria-label="Toggle menu"
          className="md:hidden text-foreground shrink-0 flex items-center justify-center w-full h-full"
          onClick={() => setIsOpen(!isOpen)}
        >
          {isOpen ? <X size={22} /> : <Menu size={22} />}
        </button>
      </div>

      {isOpen && (
        <div className="absolute top-20 inset-x-4 bg-card/95 backdrop-blur-3xl border border-border rounded-3xl p-6 flex flex-col gap-4 shadow-[0_20px_60px_-15px_hsl(var(--brand)/0.25)] md:hidden z-50 text-foreground transition-all duration-200 opacity-100 pointer-events-auto">
          <Link href={base} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("public.nav.home")}
            </span>
          </Link>
          <Link href={`${base}/features`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("public.nav.features")}
            </span>
          </Link>
          <Link href={`${base}/global-os`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer flex items-center gap-2" onClick={() => setIsOpen(false)}>
              <Globe className="w-4 h-4 text-emerald-400" />
              {t("public.nav.global_os")}
              <span className="px-1.5 py-0.5 rounded-full bg-emerald-500/10 text-emerald-500 text-[10px] font-bold border border-emerald-500/20">
                NEW
              </span>
            </span>
          </Link>
          <Link href={`${base}/property`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("public.nav.listings")}
            </span>
          </Link>
          <Link href={`${base}/pricing`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("public.nav.pricing")}
            </span>
          </Link>
          <Link href={`${base}/videos`} suppressHydrationWarning>
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("public.nav.videos")}
            </span>
          </Link>

          {isAuthenticated && (
            <>
              <Link href={`${base}/client/lease-care`} suppressHydrationWarning>
                <span
                  className="text-lg font-medium cursor-pointer flex items-center gap-2"
                  onClick={() => setIsOpen(false)}
                >
                  ReosCare+
                  <span className="px-1.5 py-0.5 rounded-full bg-success/10 text-success text-[10px] font-bold border border-success/20">
                    PRO
                  </span>
                </span>
              </Link>
              <Link href={`${base}/client/property/new`}>
                <span
                  className="text-lg font-medium cursor-pointer flex items-center gap-2"
                  onClick={() => setIsOpen(false)}
                >
                  <Plus className="w-4 h-4" />
                  {t("public.nav.add_listing")}
                </span>
              </Link>
            </>
          )}

          <div className="h-px bg-border my-2" />

          {isAuthenticated ? (
            <div className="space-y-2">
              <div className="text-sm text-muted-foreground mb-2">
                {t("client.src.welcome")} {user?.name || user?.email?.split("@")[0]}
              </div>
              <Link href="/profile" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />
                  {t("client.src.profile")}
                </span>
              </Link>
              <Link href="/settings" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <Settings className="w-4 h-4" />
                  {t("common.settings")}
                </span>
              </Link>
              <span
                className="text-lg font-medium cursor-pointer flex items-center gap-2"
                onClick={() => {
                  handleLogout();
                  setIsOpen(false);
                }}
              >
                <LogOut className="w-4 h-4" />
                {t("client.src.logout")}
              </span>
            </div>
          ) : (
            <div className="space-y-2">
              <div className="text-sm text-muted-foreground mb-2">{t("client.src.account")}</div>
              <Link href={`${base}/client/login`} onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />
                  {t("public.nav.login")}
                </span>
              </Link>
              <Link href={`${base}/client/signup`} onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />
                  {t("public.nav.signup")}
                </span>
              </Link>
            </div>
          )}

          <div className="h-px bg-border my-2" />

          <div className="flex overflow-x-auto gap-3 pb-2 scrollbar-hide snap-x">
            {LANGUAGES.map((lang) => (
              <button
                key={lang.code}
                aria-label={`Switch to ${lang.name}`}
                onClick={() => handleLanguageChange(lang.code)}
                className={cn(
                  "shrink-0 flex items-center justify-center w-12 h-12 rounded-full text-2xl transition-all snap-center",
                  currentLang.code === lang.code
                    ? "bg-primary/20 border border-primary/50 shadow-sm"
                    : "bg-muted hover:bg-muted/80"
                )}
              >
                {lang.flag}
              </button>
            ))}
          </div>

          {!isAuthenticated && (
            <Link href={`${base}/client/signup`} onClick={() => setIsOpen(false)}>
              <Button className="w-full justify-center ui-btn-primary">{t("public.cta.get_started")}</Button>
            </Link>
          )}
        </div>
      )}
    </nav>
  );
}
