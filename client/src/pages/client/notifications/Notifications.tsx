import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "@/pages/client/layout/PageShell";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Bell, MessageSquare, CreditCard, CheckCircle2, Check, Shield, Activity, Trash2, RefreshCw, Search, Zap } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
const TYPE_CONFIG: Record<string, {
  label: string;
  icon: any;
  color: string;
}> = {
  message: {
    label: t("client.src.messages"),
    icon: MessageSquare,
    color: "text-blue-500 dark:text-blue-400 bg-blue-500/10 border-blue-500/20"
  },
  system: {
    label: t("client.src.updates"),
    icon: Bell,
    color: "text-emerald-500 dark:text-emerald-400 bg-emerald-500/10 border-emerald-500/20"
  },
  billing: {
    label: t("client.src.billing"),
    icon: CreditCard,
    color: "text-orange-500 dark:text-orange-400 bg-orange-500/10 border-orange-500/20"
  },
  ai_ops_audit: {
    label: "AI Ops Audit",
    icon: Zap,
    color: "text-purple-500 dark:text-purple-400 bg-purple-500/10 border-purple-500/20"
  }
};
export default function Notifications() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState<"all" | "unread" | "read">("all");
  const [search, setSearch] = useState("");
  const [notifications, setNotifications] = useState([{
    id: 1,
    title: t("client.src.new_message_received"),
    description: t("client.src.you_have_a_new"),
    time: "2 minutes ago",
    read: false,
    type: "message"
  }, {
    id: 2,
    title: t("client.src.profile_synchronized"),
    description: t("client.src.your_platform_profile_and"),
    time: "1 hour ago",
    read: true,
    type: "system"
  }, {
    id: 3,
    title: t("client.src.payment_invoice_reminder"),
    description: t("client.src.your_agency_subscription_renewal"),
    time: "2 days ago",
    read: false,
    type: "billing"
  }, {
    id: 4,
    title: "AI Audit Warning: Physical Inspection GPS Mismatch",
    description: "Inspection task 'Pre-Stay Physical Inspection' completed but inspector coordinates do not match property coordinates.",
    time: "5 minutes ago",
    read: false,
    type: "ai_ops_audit"
  }, {
    id: 5,
    title: "CRITICAL: KBS Identity Registration Failed",
    description: "Passport validation failed for guest John Doe. Update guest records immediately to resolve police/jandarma compliance warnings.",
    time: "20 minutes ago",
    read: false,
    type: "ai_ops_audit"
  }]);
  const markAsRead = (id: number) => {
    setNotifications(notifications.map(n => n.id === id ? {
      ...n,
      read: true
    } : n));
  };
  const markAllAsRead = () => {
    setNotifications(notifications.map(n => ({
      ...n,
      read: true
    })));
  };
  const deleteNotification = (id: number) => {
    setNotifications(notifications.filter(n => n.id !== id));
  };
  const unreadCount = notifications.filter(n => !n.read).length;
  const filtered = notifications.filter(n => {
    if (activeTab === "unread") return !n.read;
    if (activeTab === "read") return n.read;
    return true;
  }).filter(n => n.title.toLowerCase().includes(search.toLowerCase()) || n.description.toLowerCase().includes(search.toLowerCase()));
  const NotificationNode = ({
    sig,
    idx
  }: {
    sig: any;
    idx: number;
  }) => {
    const {
      t
    } = useTranslation();
    const config = TYPE_CONFIG[sig.type] || TYPE_CONFIG.system;
    return <motion.div layout initial={{
      opacity: 0,
      y: 15
    }} animate={{
      opacity: 1,
      y: 0
    }} transition={{
      delay: idx * 0.05
    }} className={cn("bg-card border border-border dark:border-white/5 rounded-2xl p-6 shadow-sm group hover:bg-accent/30 dark:hover:bg-white/5 transition-all relative overflow-hidden text-card-foreground", !sig.read && "border-blue-500/20 bg-blue-500/2")}>
        <div className="absolute top-0 right-0 p-8 opacity-5 pointer-events-none group-hover:scale-110 transition-transform">
           <config.icon className="w-24 h-24 text-blue-500" />
        </div>

        <div className="flex items-start justify-between relative z-10">
           <div className="flex items-start gap-4">
              <div className="h-12 w-12 rounded-xl bg-muted dark:bg-black/40 border border-border dark:border-white/10 flex items-center justify-center shadow-sm group-hover:border-blue-500/20 transition-colors shrink-0">
                 <config.icon className={cn("w-5 h-5", config.color.split(' ')[0])} />
              </div>
              <div className="space-y-1.5">
                 <div className="flex items-center flex-wrap gap-2.5">
                    <h3 className="text-base font-semibold text-foreground tracking-tight">{sig.title}</h3>
                    {!sig.read && <Badge className="bg-blue-600/10 text-blue-600 dark:text-blue-400 border border-blue-600/20 text-[9px] font-bold px-2 py-0.5 rounded-full">{t("client.src.new")}</Badge>}
                    <Badge className={cn("px-2.5 py-0.5 rounded-full border text-[9px] font-semibold tracking-wide", config.color)}>
                      {config.label}
                    </Badge>
                 </div>
                 <p className="text-sm text-muted-foreground leading-relaxed font-medium line-clamp-2">{sig.description}</p>
                 <div className="flex items-center gap-1.5 text-muted-foreground/75 pt-1">
                    <Activity className="w-3.5 h-3.5" />
                    <span className="text-[11px] font-medium">{sig.time}</span>
                 </div>
              </div>
           </div>

           <div className="flex items-center gap-2">
              {!sig.read && <Button onClick={() => markAsRead(sig.id)} size="sm" className="h-8 px-3 rounded-lg bg-primary hover:bg-primary/95 text-primary-foreground font-semibold text-[11px] gap-1 transition-all">
                    <Check className="w-3 h-3" />{t("client.src.mark_as_read")}</Button>}
              <Button variant="ghost" size="icon" onClick={() => deleteNotification(sig.id)} className="h-8 w-8 text-muted-foreground hover:text-red-500 hover:bg-red-500/10 rounded-lg">
                 <Trash2 className="w-4 h-4" />
              </Button>
           </div>
        </div>
      </motion.div>;
  };
  return <PageShell title={t("client.src.notification_center")} description={t("client.src.stay_updated_with_realtime")}>
      <div className="space-y-8">
        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
           {[{
          label: t("client.src.total_notifications"),
          value: notifications.length,
          icon: Bell
        }, {
          label: t("client.src.unread_updates"),
          value: unreadCount,
          icon: Zap
        }, {
          label: t("client.src.delivery_status"),
          value: "100%",
          icon: Shield
        }, {
          label: t("client.src.active_feeds"),
          value: "Normal",
          icon: Activity
        }].map((stat, idx) => <Card key={idx} className="bg-card border-border dark:border-white/5 rounded-2xl p-6 shadow-sm relative group hover:bg-accent/30 dark:hover:bg-white/5 transition-all text-card-foreground">
                <div className="absolute top-0 right-0 p-6 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-12 h-12" />
                </div>
                <p className="text-xs font-semibold text-muted-foreground mb-1 leading-none">{stat.label}</p>
                <h3 className="text-2xl font-bold text-foreground tracking-tight leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Filters and Control Bar */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 bg-card border border-border dark:border-white/5 p-6 rounded-2xl backdrop-blur-xl text-card-foreground">
           <div className="flex flex-wrap items-center gap-2 bg-muted dark:bg-black/20 p-1.5 rounded-xl border border-border dark:border-white/5 w-full lg:w-auto">
              {[{
            id: "all",
            label: t("client.src.all_updates"),
            icon: RefreshCw
          }, {
            id: "unread",
            label: t("client.src.unread"),
            icon: Zap
          }, {
            id: "read",
            label: t("client.src.archive"),
            icon: CheckCircle2
          }].map(tab => <Button key={tab.id} onClick={() => setActiveTab(tab.id as any)} variant="ghost" className={cn("h-10 px-5 rounded-lg text-xs font-semibold tracking-wide transition-all flex-1 lg:flex-initial", activeTab === tab.id ? "bg-blue-600 text-white shadow-md shadow-blue-600/10" : "text-muted-foreground hover:text-foreground")}>
                  <tab.icon className="w-3.5 h-3.5 mr-2" /> {tab.label}
                </Button>)}
           </div>
           
           <div className="flex flex-col sm:flex-row items-center gap-4 flex-1 max-w-xl w-full">
              <div className="relative group flex-1 w-full">
                 <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-blue-500 transition-colors" />
                 <input placeholder={t("client.src.search_notifications")} className="w-full h-11 pl-11 pr-4 bg-muted/50 border border-border dark:bg-black/20 dark:border-white/5 rounded-xl text-xs font-medium text-foreground placeholder:text-muted-foreground/60 outline-none focus:border-blue-500/20 focus:ring-1 focus:ring-blue-500/10 transition-all" value={search} onChange={e => setSearch(e.target.value)} />
              </div>
              {unreadCount > 0 && <Button onClick={markAllAsRead} variant="outline" className="h-11 px-5 rounded-xl border-border text-foreground hover:bg-accent font-semibold text-xs tracking-wide shadow-sm transition-all w-full sm:w-auto shrink-0">{t("client.src.mark_all_as_read")}</Button>}
           </div>
        </div>

        {/* Notifications Timeline */}
        <div className="min-h-[450px] relative">
           <div className="absolute left-10 top-0 bottom-0 w-px bg-linear-to-b from-blue-500/10 via-blue-500/5 to-transparent hidden lg:block" />
           <div className="space-y-4">
              <AnimatePresence mode="popLayout">
                 {filtered.map((sig, idx) => <NotificationNode key={sig.id} sig={sig} idx={idx} />)}
                 {filtered.length === 0 && <motion.div initial={{
              opacity: 0
            }} animate={{
              opacity: 1
            }} className="py-24 flex flex-col items-center gap-4 rounded-2xl border border-dashed border-border dark:border-white/5 bg-muted/10 dark:bg-black/10">
                       <Activity className="w-12 h-12 text-muted-foreground opacity-20" />
                       <p className="text-xs font-semibold text-muted-foreground tracking-wide">{t("client.src.no_notifications_found_in")}</p>
                    </motion.div>}
              </AnimatePresence>
           </div>
        </div>
      </div>
    </PageShell>;
}