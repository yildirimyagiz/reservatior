"use client";

import { useState } from "react";
import Link from "next/link";
import { useTranslation } from "react-i18next";
import { Settings, LogOut, ChevronDown, UserCircle, CreditCard, Sparkles, ShieldCheck, Users, Building2, Database } from "lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useAuth } from "@/lib/auth/hooks";
import { cn } from "@/lib/utils";
export function UserMenu() {
  const {
    t
  } = useTranslation();
  const {
    user,
    logout,
    hasPermission
  } = useAuth();
  const [isOpen, setIsOpen] = useState(false);
  
  // Show login/signup buttons when user is not authenticated
  if (!user) {
    return (
      <div className="flex items-center gap-2">
        <Button asChild variant="ghost" size="sm" className="rounded-full">
          <Link href="/client/login">{t("public.nav.login", { defaultValue: "Log in" })}</Link>
        </Button>
        <Button asChild size="sm" className="rounded-full bg-primary hover:bg-primary/90 text-primary-foreground">
          <Link href="/client/signup">{t("public.nav.signup", { defaultValue: "Sign up" })}</Link>
        </Button>
      </div>
    );
  }
  const roleColorMap: Record<string, string> = {
    'ADMIN': 'text-brand bg-brand/10 border-brand/20',
    'AGENT': 'text-brand bg-brand/10 border-blue-500/20',
    'CLIENT': 'text-success bg-success/10 border-success/20'
  };
  const displayName = user.name || user.firstName ? `${user.firstName || ''} ${user.lastName || ''}`.trim() : user.email.split('@')[0];
  const displayRole = user.role || 'USER';
  return <DropdownMenu onOpenChange={setIsOpen}>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" className={cn("relative h-12 flex items-center gap-3 px-2 rounded-2xl transition-all duration-300", "hover:bg-muted dark:hover:bg-white/5 border border-transparent", isOpen && "bg-muted dark:bg-white/5 border-border dark:border-white/10")}>
          <div className="relative">
            <Avatar className="h-9 w-9 rounded-xl border border-border dark:border-white/10">
              <AvatarImage src={user.imageUrl || (user as any).picture || (user as any).avatar || `https://api.dicebear.com/7.x/avataaars/svg?seed=${user.email}`} />
              <AvatarFallback className="bg-blue-600/20 text-brand font-bold">
                {displayName.substring(0, 2).toUpperCase()}
              </AvatarFallback>
            </Avatar>
            <div className="absolute -bottom-1 -right-1 w-4 h-4 rounded-lg bg-success border-2 border-background flex items-center justify-center">
              <div className="w-1.5 h-1.5 rounded-full bg-card animate-pulse" />
            </div>
          </div>
          
          <div className="hidden xl:flex flex-col items-start gap-0.5">
            <span className="text-xs font-black text-foreground italic tracking-tighter uppercase whitespace-nowrap overflow-hidden max-w-[100px] text-ellipsis">
              {displayName}
            </span>
            <Badge variant="outline" className={cn("text-[8px] h-4 px-1.5 font-black uppercase tracking-widest border-0 transition-opacity", roleColorMap[displayRole] || 'text-muted-foreground bg-muted')}>
              {displayRole}
            </Badge>
          </div>
          <ChevronDown className={cn("hidden lg:block w-4 h-4 text-muted-foreground transition-transform duration-300", isOpen && "rotate-180")} />
        </Button>
      </DropdownMenuTrigger>

      <DropdownMenuContent className="w-72 bg-popover/95 dark:bg-background/95 text-popover-foreground backdrop-blur-xl border border-border dark:border-white/10 rounded-4xl p-3 shadow-2xl mt-2 animate-in fade-in zoom-in-95 duration-200" align="end">
        <DropdownMenuLabel className="p-4">
          <div className="flex flex-col gap-1">
            <p className="text-[10px] font-black text-muted-foreground uppercase tracking-[0.2em] italic">{t('activeSession', 'ACTIVE SESSION')}</p>
            <p className="text-sm font-black text-foreground italic tracking-tight truncate">{user.email}</p>
          </div>
        </DropdownMenuLabel>
        
        <DropdownMenuSeparator className="bg-muted dark:bg-white/5 mx-2" />
        
        <div className="grid grid-cols-1 gap-1 py-2">
          <DropdownMenuItem asChild className="rounded-xl focus:bg-blue-600/10 focus:text-brand group cursor-pointer transition-all">
            <Link href="/client/profile" className="flex items-center gap-3 p-3">
              <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-blue-600/20">
                <UserCircle className="w-5 h-5 text-foreground group-focus:text-brand" />
              </div>
              <div className="flex flex-col">
                <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-brand">{t("client.src.profile")}</span>
                <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t('viewDetails')}</span>
              </div>
            </Link>
          </DropdownMenuItem>

          {hasPermission("ORG_MANAGE") && (
            <>
              <DropdownMenuSeparator className="bg-muted dark:bg-white/5 mx-2 my-2" />
              <div className="px-3 pb-1">
                <span className="text-[10px] font-black text-amber-500/80 uppercase tracking-[0.2em] italic">{t("client.src.admin_modules", "Yönetici Modülleri")}</span>
              </div>
              <DropdownMenuItem asChild className="rounded-xl focus:bg-amber-600/10 focus:text-amber-400 group cursor-pointer transition-all">
                <Link href="/admin/dashboard" className="flex items-center gap-3 p-3">
                  <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-amber-600/20">
                    <ShieldCheck className="w-5 h-5 text-foreground group-focus:text-amber-400" />
                  </div>
                  <div className="flex flex-col">
                    <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-amber-400">{t("client.src.dashboard")}</span>
                    <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t("client.src.manage_system", "Merkezi Yönetim")}</span>
                  </div>
                </Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild className="rounded-xl focus:bg-amber-600/10 focus:text-amber-400 group cursor-pointer transition-all">
                <Link href="/admin/users" className="flex items-center gap-3 p-3">
                  <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-amber-600/20">
                    <Users className="w-5 h-5 text-foreground group-focus:text-amber-400" />
                  </div>
                  <div className="flex flex-col">
                    <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-amber-400">{t("client.src.users")}</span>
                    <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t("client.src.manage_users", "Kullanıcı Yönetimi")}</span>
                  </div>
                </Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild className="rounded-xl focus:bg-amber-600/10 focus:text-amber-400 group cursor-pointer transition-all">
                <Link href="/admin/organization" className="flex items-center gap-3 p-3">
                  <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-amber-600/20">
                    <Building2 className="w-5 h-5 text-foreground group-focus:text-amber-400" />
                  </div>
                  <div className="flex flex-col">
                    <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-amber-400">{t("client.src.organizations")}</span>
                    <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t("client.src.manage_orgs", "Kurum Yönetimi")}</span>
                  </div>
                </Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild className="rounded-xl focus:bg-amber-600/10 focus:text-amber-400 group cursor-pointer transition-all">
                <Link href="/admin/system-metrics" className="flex items-center gap-3 p-3">
                  <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-amber-600/20">
                    <Database className="w-5 h-5 text-foreground group-focus:text-amber-400" />
                  </div>
                  <div className="flex flex-col">
                    <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-amber-400">{t("client.src.system")}</span>
                    <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t("client.src.system_metrics", "Sistem Metrikleri")}</span>
                  </div>
                </Link>
              </DropdownMenuItem>
              <DropdownMenuSeparator className="bg-muted dark:bg-white/5 mx-2 my-2" />
            </>
          )}

          <DropdownMenuItem asChild className="rounded-xl focus:bg-brand/10 focus:text-brand group cursor-pointer transition-all">
            <Link href={hasPermission("ORG_MANAGE") ? "/admin/settings" : "/client/profile"} className="flex items-center gap-3 p-3">
              <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-brand/20">
                <Settings className="w-5 h-5 text-foreground group-focus:text-brand" />
              </div>
              <div className="flex flex-col">
                <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-brand">{t('settings')}</span>
                <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t('accountSettings', 'HESAP AYARLARI')}</span>
              </div>
            </Link>
          </DropdownMenuItem>

          <DropdownMenuItem asChild className="rounded-xl focus:bg-blue-600/10 focus:text-success group cursor-pointer transition-all">
            <Link href={hasPermission("ORG_MANAGE") ? "/admin/billing" : "/client/payments"} className="flex items-center gap-3 p-3">
              <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-blue-600/20">
                <CreditCard className="w-5 h-5 text-foreground group-focus:text-success" />
              </div>
              <div className="flex flex-col">
                <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-success">{t('invoicesTitle')}</span>
                <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t('transactionHistory')}</span>
              </div>
            </Link>
          </DropdownMenuItem>
        </div>

        <DropdownMenuSeparator className="bg-muted dark:bg-white/5 mx-2" />
        
        <DropdownMenuItem onClick={() => logout()} className="rounded-xl focus:bg-red-600/10 focus:text-red-400 group cursor-pointer p-3 mt-1 transition-all">
          <div className="flex items-center gap-3 w-full">
            <div className="w-10 h-10 rounded-xl bg-muted dark:bg-white/5 flex items-center justify-center group-focus:bg-red-600/20">
              <LogOut className="w-5 h-5 text-foreground group-focus:text-red-400" />
            </div>
            <div className="flex flex-col">
              <span className="text-xs font-black uppercase italic tracking-wider text-foreground group-focus:text-red-400">{t('logout')}</span>
              <span className="text-[9px] font-medium text-muted-foreground uppercase tracking-widest">{t('admin.killSignal')}</span>
            </div>
          </div>
        </DropdownMenuItem>

        <div className="mt-4 p-4 rounded-3xl bg-blue-600/5 border border-blue-600/10 relative overflow-hidden group/premium">
          <div className="absolute top-0 right-0 p-3 opacity-10 group-hover/premium:scale-110 transition-transform">
            <Sparkles className="w-12 h-12 text-brand" />
          </div>
          <p className="text-[10px] font-black text-brand uppercase tracking-widest italic mb-1">{t("client.src.premium_mission")}</p>
          <p className="text-[8px] font-medium text-muted-foreground uppercase tracking-widest leading-relaxed mb-3">{t("client.src.activate_neural_forecasting_engine")}</p>
          <Button className="w-full h-8 rounded-xl bg-blue-600 hover:bg-brand/100 text-white text-[9px] font-black uppercase italic tracking-widest">
            {t('upgrade')}
          </Button>
        </div>
      </DropdownMenuContent>
    </DropdownMenu>;
}