import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Link } from "react-router-dom";
import { Building, Search, Menu, X, Plus, Video, Zap, MessageSquare, LayoutDashboard, FileText, Calendar, CheckSquare, Users, CreditCard, Key, Building2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { NotificationRing } from "@/components/notifications/NotificationRing";
import { MessageDropdown } from "./MessageDropdown";
import { UserMenu } from "./UserMenu";
import { useAuth } from "@/lib/auth/hooks";
import { motion, AnimatePresence } from "framer-motion";
import { ThemeToggle } from "./ThemeToggle";
import GlobalPreferencesSelector from "@/components/ui/GlobalPreferencesSelector";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
export function AppHeader() {
  const {
    t
  } = useTranslation();
  const {
    isAuthenticated
  } = useAuth();
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  return <header className="sticky top-0 z-50 w-full border-b border-border bg-background transition-all duration-300">
      <div className="max-w-[1600px] w-full mx-auto px-4 md:px-6 2xl:px-12 h-16 flex items-center justify-between gap-4">
        {/* Logo & Mobile Menu Toggle */}
        <div className="flex items-center gap-2 lg:gap-4 shrink-0">
          <Button variant="ghost" size="icon" className="xl:hidden h-9 w-9 text-foreground" onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}>
            {isMobileMenuOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
          </Button>
          
          <Link to="/" className="flex items-center gap-2 group transition-all duration-300 hover:opacity-80">
            <div>
              <h1 className="text-xl font-bold tracking-tight leading-none bg-linear-to-r from-blue-600 via-blue-400 to-blue-600 bg-size-[200%_auto] animate-shimmer bg-clip-text text-transparent group-hover:scale-105 transition-transform">Reservatior</h1>
            </div>
          </Link>
        </div>

        {/* New Desktop Navigation Menus */}
        <nav className="hidden xl:flex items-center justify-center flex-1 gap-1 lg:gap-2 px-4">
          <Link to="/properties" className="text-xs font-semibold tracking-wide text-muted-foreground hover:text-foreground px-2.5 py-1.5 rounded-lg transition-colors">{t("client.src.properties")}</Link>
          <Link to="/explore" className="text-xs font-semibold tracking-wide text-muted-foreground hover:text-foreground px-2.5 py-1.5 rounded-lg transition-colors flex items-center gap-1.5">{t("client.src.explore")}<Badge variant="outline" className="h-4 px-1 text-[8px] border-primary/30 text-primary bg-primary/5 uppercase tracking-tighter shadow-sm">{t("client.src.new")}</Badge></Link>
          <Link to="/videos" className="text-xs font-semibold tracking-wide text-muted-foreground hover:text-foreground px-2.5 py-1.5 rounded-lg transition-colors flex items-center gap-1.5">Videos<Badge variant="outline" className="h-4 px-1 text-[8px] border-violet-500/30 text-violet-500 bg-violet-500/5 uppercase tracking-tighter shadow-sm">REELS</Badge></Link>
          <Link to="/leasecare" className="text-xs font-semibold tracking-wide text-muted-foreground hover:text-foreground px-2.5 py-1.5 rounded-lg transition-colors flex items-center gap-1.5">LeaseCare+<Badge variant="outline" className="h-4 px-1 text-[8px] border-emerald-500/30 text-emerald-500 bg-emerald-500/5 uppercase tracking-tighter shadow-sm">PRO</Badge></Link>
          <Link to="/pricing" className="text-xs font-semibold tracking-wide text-muted-foreground hover:text-foreground px-2.5 py-1.5 rounded-lg transition-colors">{t("client.src.pricing")}</Link>
          <Link to="/contact" className="text-xs font-semibold tracking-wide text-muted-foreground hover:text-foreground px-2.5 py-1.5 rounded-lg transition-colors">{t("client.src.contact")}</Link>
          
          <DropdownMenu>
            <DropdownMenuTrigger asChild>
              <Button variant="ghost" className="text-xs font-black tracking-wide text-emerald-500 hover:text-emerald-400 hover:bg-emerald-500/10 px-3 py-1.5 rounded-lg transition-colors flex items-center gap-1.5 uppercase italic">
                <Plus className="w-3.5 h-3.5" /> İlan Ekle
              </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent align="center" className="w-48 bg-background border-border">
              <DropdownMenuItem asChild className="cursor-pointer">
                <Link to="/host/new-listing?type=SALE" className="flex items-center gap-2">🏡 Satılık Mülk Ekle</Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild className="cursor-pointer">
                <Link to="/host/new-listing?type=RENT" className="flex items-center gap-2">🔑 Kiralık Mülk Ekle</Link>
              </DropdownMenuItem>
              <DropdownMenuItem asChild className="cursor-pointer">
                <Link to="/host/new-listing?type=BOOKING" className="flex items-center gap-2">🏨 Otel / Günlük Kiralık</Link>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </nav>


        {/* Action Buttons */}
        <div className="flex items-center gap-1 lg:gap-2 shrink-0">
          <GlobalPreferencesSelector />
          <AnimatePresence>
            {!isAuthenticated ? <motion.div initial={{
            opacity: 0,
            x: 20
          }} animate={{
            opacity: 1,
            x: 0
          }} className="flex items-center gap-2">
                <Link to="/login">
                  <Button variant="ghost" size="sm" className="hidden sm:inline-flex hover:bg-primary/5 font-black uppercase text-[10px] tracking-widest italic">{t("client.src.sign_in")}</Button>
                </Link>
                <Link to="/signup">
                  <Button size="sm" className="bg-primary hover:bg-primary/90 text-primary-foreground font-black uppercase text-[10px] tracking-widest italic shadow-lg shadow-primary/20">{t("client.src.sign_up")}</Button>
                </Link>
              </motion.div> : <motion.div initial={{
            opacity: 0,
            scale: 0.9
          }} animate={{
            opacity: 1,
            scale: 1
          }} className="flex items-center gap-1 lg:gap-2">
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="outline" size="sm" className="hidden lg:flex items-center gap-1.5 border-border hover:bg-muted/50 font-black uppercase text-[10px] tracking-widest italic shadow-sm px-2.5">
                      <Plus className="w-3.5 h-3.5 text-primary" />
                      <span className="hidden xl:inline-block">{t("client.src.create_new", "Yeni Oluştur")}</span>
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent className="w-56 bg-popover/95 dark:bg-[#14151a]/95 text-popover-foreground backdrop-blur-xl border border-border dark:border-white/10 rounded-2xl p-2 shadow-2xl mt-2 animate-in fade-in zoom-in-95 duration-200" align="end">
                    <DropdownMenuLabel className="px-3 py-2 text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] italic">
                      {t("client.src.quick_actions", "HIZLI İŞLEMLER")}
                    </DropdownMenuLabel>
                    <DropdownMenuSeparator className="bg-slate-100 dark:bg-white/5 mx-1" />
                    
                    <DropdownMenuItem asChild className="rounded-xl focus:bg-primary/10 focus:text-primary group cursor-pointer transition-all">
                      <Link to="/properties/new" className="flex items-center gap-2.5 p-2 text-xs font-black uppercase tracking-wider italic text-foreground hover:text-primary">
                        <Building className="w-4 h-4 text-primary group-focus:scale-110 transition-transform" />
                        <span>{t("client.src.new_property", "Yeni Mülk")}</span>
                      </Link>
                    </DropdownMenuItem>

                    <DropdownMenuItem asChild className="rounded-xl focus:bg-primary/10 focus:text-primary group cursor-pointer transition-all">
                      <Link to="/leases" className="flex items-center gap-2.5 p-2 text-xs font-black uppercase tracking-wider italic text-foreground hover:text-primary">
                        <FileText className="w-4 h-4 text-primary group-focus:scale-110 transition-transform" />
                        <span>{t("client.src.new_lease", "Yeni Sözleşme")}</span>
                      </Link>
                    </DropdownMenuItem>

                    <DropdownMenuItem asChild className="rounded-xl focus:bg-primary/10 focus:text-primary group cursor-pointer transition-all">
                      <Link to="/bookings" className="flex items-center gap-2.5 p-2 text-xs font-black uppercase tracking-wider italic text-foreground hover:text-primary">
                        <Calendar className="w-4 h-4 text-primary group-focus:scale-110 transition-transform" />
                        <span>{t("client.src.new_booking", "Yeni Rezervasyon")}</span>
                      </Link>
                    </DropdownMenuItem>

                    <DropdownMenuItem asChild className="rounded-xl focus:bg-primary/10 focus:text-primary group cursor-pointer transition-all">
                      <Link to="/tasks" className="flex items-center gap-2.5 p-2 text-xs font-black uppercase tracking-wider italic text-foreground hover:text-primary">
                        <CheckSquare className="w-4 h-4 text-primary group-focus:scale-110 transition-transform" />
                        <span>{t("client.src.new_task", "Yeni Görev")}</span>
                      </Link>
                    </DropdownMenuItem>

                    <DropdownMenuItem asChild className="rounded-xl focus:bg-primary/10 focus:text-primary group cursor-pointer transition-all">
                      <Link to="/contacts" className="flex items-center gap-2.5 p-2 text-xs font-black uppercase tracking-wider italic text-foreground hover:text-primary">
                        <Users className="w-4 h-4 text-primary group-focus:scale-110 transition-transform" />
                        <span>{t("client.src.new_contact", "Yeni İletişim")}</span>
                      </Link>
                    </DropdownMenuItem>

                    <DropdownMenuItem asChild className="rounded-xl focus:bg-primary/10 focus:text-primary group cursor-pointer transition-all">
                      <Link to="/payments" className="flex items-center gap-2.5 p-2 text-xs font-black uppercase tracking-wider italic text-foreground hover:text-primary">
                        <CreditCard className="w-4 h-4 text-primary group-focus:scale-110 transition-transform" />
                        <span>{t("client.src.new_payment", "Yeni Ödeme")}</span>
                      </Link>
                    </DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
                <MessageDropdown />
                <NotificationRing />
                <ThemeToggle />
                <UserMenu />
              </motion.div>}
          </AnimatePresence>
        </div>
      </div>

      {/* Mobile Menu Overlay */}
      <AnimatePresence>
        {isMobileMenuOpen && <motion.div initial={{
        opacity: 0,
        height: 0
      }} animate={{
        opacity: 1,
        height: "auto"
      }} exit={{
        opacity: 0,
        height: 0
      }} className="xl:hidden border-t border-border bg-background overflow-hidden shadow-2xl">
            <nav className="p-6 space-y-6">
              <ul className="grid gap-1">
                <MobileNavItem to="/properties" icon={<Search className="w-5 h-5" />} label={t("client.src.properties")} onClick={() => setIsMobileMenuOpen(false)} />
                <MobileNavItem to="/explore" icon={<Video className="w-5 h-5" />} label={t("client.src.explore_feed")} onClick={() => setIsMobileMenuOpen(false)} badge="New" />
                <MobileNavItem to="/pricing" icon={<Zap className="w-5 h-5" />} label={t("client.src.pricing")} onClick={() => setIsMobileMenuOpen(false)} />
                <MobileNavItem to="/contact" icon={<MessageSquare className="w-5 h-5" />} label={t("client.src.contact")} onClick={() => setIsMobileMenuOpen(false)} />
                {isAuthenticated && <MobileNavItem to="/dashboard" icon={<LayoutDashboard className="w-5 h-5" />} label={t("client.src.dashboard")} onClick={() => setIsMobileMenuOpen(false)} />}
                
                <div className="pt-4 mt-2 border-t border-border">
                  <h4 className="px-4 text-[10px] font-black tracking-widest text-emerald-500 uppercase italic mb-2">İlan Ekle</h4>
                  <MobileNavItem to="/host/new-listing?type=SALE" icon={<Building className="w-5 h-5 text-emerald-500" />} label="Satılık Mülk Ekle" onClick={() => setIsMobileMenuOpen(false)} />
                  <MobileNavItem to="/host/new-listing?type=RENT" icon={<Key className="w-5 h-5 text-emerald-500" />} label="Kiralık Mülk Ekle" onClick={() => setIsMobileMenuOpen(false)} />
                  <MobileNavItem to="/host/new-listing?type=BOOKING" icon={<Building2 className="w-5 h-5 text-emerald-500" />} label="Otel / Günlük Kiralık" onClick={() => setIsMobileMenuOpen(false)} />
                </div>
              </ul>
              {!isAuthenticated && <div className="grid grid-cols-2 gap-4 pt-6 border-t border-border">
                  <Link to="/login" className="w-full">
                    <Button variant="outline" className="w-full font-black uppercase text-[10px] tracking-widest italic" onClick={() => setIsMobileMenuOpen(false)}>{t("client.src.sign_in")}</Button>
                  </Link>
                  <Link to="/signup" className="w-full">
                    <Button className="w-full font-black uppercase text-[10px] tracking-widest italic" onClick={() => setIsMobileMenuOpen(false)}>{t("client.src.sign_up")}</Button>
                  </Link>
                </div>}
            </nav>
          </motion.div>}
      </AnimatePresence>
    </header>;
}
function MobileNavItem({
  to,
  icon,
  label,
  onClick,
  badge
}: {
  to: string;
  icon: React.ReactNode;
  label: string;
  onClick: () => void;
  badge?: string;
}) {
  return <li>
      <Link to={to} onClick={onClick} className="flex items-center justify-between p-4 rounded-xl hover:bg-muted/50 transition-all group">
        <div className="flex items-center gap-4">
          <div className="text-muted-foreground group-hover:text-primary transition-colors">
            {icon}
          </div>
          <span className="font-black uppercase text-[11px] tracking-widest italic text-muted-foreground group-hover:text-foreground">{label}</span>
        </div>
        {badge && <Badge variant="outline" className="h-5 border-primary/30 text-primary bg-primary/5 text-[10px] uppercase font-black tracking-widest px-2 italic">
            {badge}
          </Badge>}
      </Link>
    </li>;
}