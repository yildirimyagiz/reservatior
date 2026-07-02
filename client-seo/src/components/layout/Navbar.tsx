"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { motion } from "framer-motion";
import { Menu, X, Globe, Sparkles, User, Settings, LogOut } from "lucide-react";
import { UserMenu } from "@/components/layout/UserMenu";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useLanguage, LANGUAGES } from "@/lib/languages";
import { useAuth } from "@/lib/auth/hooks";
import RegionSelector from "./RegionSelector";

export function Navbar() {
  const [isOpen, setIsOpen] = useState(false);
  const {
    currentLang,
    setLanguage,
    t
  } = useLanguage();
  const pathname = usePathname();
  const {
    user,
    isAuthenticated,
    logout
  } = useAuth();
  const isActive = (path: string) => pathname === path;
  const handleLogout = async () => {
    await logout();
  };
  return <nav className="fixed top-0 inset-x-0 z-50 p-4 flex justify-center">
      <motion.div initial={{
      y: -100,
      opacity: 0
    }} animate={{
      y: 0,
      opacity: 1
    }} className="w-full max-w-6xl bg-background/80 backdrop-blur-md border border-border rounded-full px-6 py-3 flex items-center justify-between shadow-lg">
        <div className="flex items-center gap-8">
          <Link href="/" className="text-xl font-display font-bold bg-gradient-to-r from-blue-400 to-purple-600 bg-clip-text text-transparent">{t("client.src.stageai")}</Link>

          {/* Desktop Nav */}
          <div className="flex items-center gap-6">
            <Link href="/" className={`text-sm font-medium transition-colors ${isActive("/") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              {t("nav.features")}
            </Link>
            <Link href="/showcase" className={`text-sm font-medium transition-colors ${isActive("/showcase") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              {t("nav.showcase")}
            </Link>
            <Link href="/pricing" className={`text-sm font-medium transition-colors ${isActive("/pricing") ? "text-primary" : "text-muted-foreground hover:text-primary"}`}>
              {t("nav.pricing")}
            </Link>
            <Link href="/studio" className={`text-sm font-medium flex items-center gap-1 transition-colors ${isActive("/studio") ? "text-purple-400" : "text-purple-400/80 hover:text-purple-400"}`}>
              <Sparkles className="w-3 h-3" />{t("client.src.ai_studio")}</Link>
          </div>
        </div>

        <div className="flex items-center gap-4">
          {/* Region Selector */}
          <RegionSelector />

          {/* Language Switcher */}
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="ghost" size="sm" className="rounded-full h-8 px-3 gap-2 text-muted-foreground hover:text-foreground">
                <Globe className="w-3 h-3" />
                <span className="text-xs font-medium">
                  {currentLang.code.toUpperCase()}
                </span>
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="end" className="w-48 max-h-80 overflow-y-auto bg-card border-border">
              {LANGUAGES.map(lang => <DropdownMenuItem key={lang.code} onClick={() => setLanguage(lang.code)} className="gap-2 cursor-pointer">
                  <span className="text-base">{lang.flag}</span>
                  <span className="flex-1">{lang.name}</span>
                  {currentLang.code === lang.code && <span className="w-2 h-2 rounded-full bg-primary" />}
                </DropdownMenuItem>)}
            </DropdownMenuContent>
          </DropdownMenu>

          {/* Auth Section */}
          <UserMenu />

          <Button asChild size="sm" className="rounded-full bg-primary hover:bg-primary/90 text-primary-foreground">
            <Link href="/studio">{t("getStarted")}</Link>
          </Button>
        </div>

        {/* Mobile Toggle */}
        <button className="md:hidden text-foreground" onClick={() => setIsOpen(!isOpen)}>
          {isOpen ? <X size={24} /> : <Menu size={24} />}
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
          <Link href="/">
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("nav.features")}
            </span>
          </Link>
          <Link href="/showcase">
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("nav.showcase")}
            </span>
          </Link>
          <Link href="/pricing">
            <span className="text-lg font-medium cursor-pointer" onClick={() => setIsOpen(false)}>
              {t("nav.pricing")}
            </span>
          </Link>
          <Link href="/studio">
            <span className="text-lg font-medium text-purple-400 cursor-pointer" onClick={() => setIsOpen(false)}>{t("client.src.ai_studio")}</span>
          </Link>
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
              <Link href="/login" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />{t("client.src.sign_in")}</span>
              </Link>
              <Link href="/signup" onClick={() => setIsOpen(false)}>
                <span className="text-lg font-medium cursor-pointer flex items-center gap-2">
                  <User className="w-4 h-4" />{t("client.src.sign_up")}</span>
              </Link>
            </div>}

          <div className="h-px bg-border my-2" />

          <div className="grid grid-cols-4 gap-2">
            {LANGUAGES.map(lang => <button key={lang.code} onClick={() => setLanguage(lang.code)} className={`p-2 rounded-lg text-center text-xl hover:bg-white/5 ${currentLang.code === lang.code ? "bg-white/10" : ""}`}>
                {lang.flag}
              </button>)}
          </div>

            <Link href="/studio" onClick={() => setIsOpen(false)}>
            <Button className="w-full justify-center">
              {t("getStarted")}
            </Button>
          </Link>
        </motion.div>}
    </nav>;
}