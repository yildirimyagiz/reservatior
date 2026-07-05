import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Bell, Check, Trash2, ExternalLink, Activity } from "lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuTrigger, DropdownMenuSeparator, DropdownMenuLabel } from "@/components/ui/dropdown-menu";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { formatDistanceToNow } from "date-fns";
import { enUS } from "date-fns/locale";
import { Link } from "@/lib/react-router-shim";
import { notificationsApi } from "@/lib/api/notifications";
import { cn } from "@/lib/utils";
interface Notification {
  id: string;
  title: string;
  body: string;
  readAt: string | null;
  createdAt: string;
  type?: string;
}
export function NotificationRing() {
  const {
    t
  } = useTranslation();
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [unreadCount, setUnreadCount] = useState(0);
  useEffect(() => {
    const fetchNotifications = async () => {
      try {
        const response: any = await notificationsApi.getNotifications({
          limit: 10
        });
        if (response?.data) {
          setNotifications(response.data);
          setUnreadCount(response.data.filter((n: any) => !n.readAt).length);
        }
      } catch (error) {
        console.error("Failed to fetch notifications:", error);
      }
    };
    fetchNotifications();
    const interval = setInterval(fetchNotifications, 30000);
    return () => clearInterval(interval);
  }, []);
  const markAsRead = async (id: string) => {
    try {
      await notificationsApi.markAsRead(id);
      setNotifications(prev => prev.map(n => n.id === id ? {
        ...n,
        readAt: new Date().toISOString()
      } : n));
      setUnreadCount(prev => Math.max(0, prev - 1));
    } catch (error) {
      console.error("Failed to mark notification as read:", error);
    }
  };
  const markAllAsRead = async () => {
    try {
      await notificationsApi.markAllAsRead();
      setNotifications(prev => prev.map(n => ({
        ...n,
        readAt: new Date().toISOString()
      })));
      setUnreadCount(0);
    } catch (error) {
      console.error("Failed to mark all as read:", error);
    }
  };
  return <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" size="icon" className="relative h-10 w-10 rounded-full border border-border bg-muted/20 hover:bg-muted/40 transition-all duration-300 group">
          <Bell className="h-5 w-5 text-muted-foreground group-hover:text-primary transition-colors" />
          {unreadCount > 0 && <Badge className="absolute -top-1 -right-1 h-5 w-5 flex items-center justify-center p-0 text-[10px] animate-pulse bg-primary text-primary-foreground border-2 border-background font-black italic">
              {unreadCount}
            </Badge>}
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end" className="w-[380px] bg-card/95 border-border/50 rounded-2xl shadow-2xl shadow-black/20 p-0 overflow-hidden z-[100] backdrop-blur-xl">
        <DropdownMenuLabel className="p-6 flex items-center justify-between bg-muted/20 border-b border-border">
          <div className="flex items-center gap-3">
             <Activity className="w-4 h-4 text-primary" />
             <span className="text-sm font-black uppercase tracking-[0.2em] italic">{t("client.src.notifications")}</span>
          </div>
          {unreadCount > 0 && <Button variant="ghost" size="sm" onClick={markAllAsRead} className="text-[10px] font-black uppercase tracking-widest italic text-primary hover:bg-primary/5 h-8 px-3 rounded-lg">{t("client.src.mark_all_read")}</Button>}
        </DropdownMenuLabel>
        
        <ScrollArea className="h-[450px]">
          {notifications.length === 0 ? <div className="flex flex-col items-center justify-center h-full p-12 text-center text-muted-foreground opacity-60">
              <div className="w-16 h-16 bg-muted/30 rounded-3xl flex items-center justify-center mb-4 shadow-inner">
                <Bell className="w-8 h-8 opacity-20" />
              </div>
              <p className="text-[10px] font-black uppercase tracking-widest italic">{t("client.src.neural_log_empty")}</p>
            </div> : <div className="grid divide-y divide-border">
              {notifications.map(notification => <div key={notification.id} className={cn("p-6 flex gap-4 group transition-all duration-300 hover:bg-muted/30 cursor-pointer relative overflow-hidden", !notification.readAt ? "bg-primary/5" : "")} onClick={() => !notification.readAt && markAsRead(notification.id)}>
                  <div className={cn("mt-1.5 h-3 w-3 rounded-full shrink-0 border-2 border-background shadow-lg transition-transform group-hover:scale-125", notification.type === 'ai_staging' ? 'bg-purple-500 shadow-purple-500/30' : notification.type === 'sales_split' ? 'bg-emerald-500 shadow-emerald-500/30' : notification.type === 'escrow' ? 'bg-amber-500 shadow-amber-500/30' : 'bg-blue-500 shadow-blue-500/30', !notification.readAt ? 'animate-pulse' : 'opacity-40 grayscale-50')} />
                  <div className="flex-1 space-y-2 min-w-0">
                    <div className="flex items-center justify-between gap-4">
                      <p className={cn("text-[12px] font-black italic tracking-tight leading-none uppercase truncate", !notification.readAt ? 'text-foreground' : 'text-muted-foreground')}>
                        {notification.title}
                      </p>
                      <span className="text-[9px] font-bold text-muted-foreground/40 uppercase whitespace-nowrap">
                        {formatDistanceToNow(new Date(notification.createdAt), {
                    addSuffix: false,
                    locale: enUS
                  })}
                      </span>
                    </div>
                    <p className={cn("text-[11px] font-medium leading-relaxed line-clamp-2", !notification.readAt ? "text-foreground/80 font-bold" : "text-muted-foreground")}>
                      {notification.body}
                    </p>
                    
                    <div className="flex items-center justify-between pt-2">
                       <span className="text-[8px] font-black text-muted-foreground/30 uppercase tracking-[0.2em]">{t("client.src.type")}{notification.type || 'SYSTEM'}</span>
                       <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                          {!notification.readAt && <Button variant="ghost" size="icon" className="h-7 w-7 rounded-lg hover:bg-primary/20 text-primary border border-primary/20" onClick={e => {
                    e.stopPropagation();
                    markAsRead(notification.id);
                  }}>
                                <Check className="h-3 w-3" />
                             </Button>}
                          <Button variant="ghost" size="icon" className="h-7 w-7 rounded-lg hover:bg-red-500/20 text-red-500 border border-red-500/20" onClick={e => {
                    e.stopPropagation();
                  }}>
                             <Trash2 className="h-3 w-3" />
                          </Button>
                       </div>
                    </div>
                  </div>
                  {!notification.readAt && <div className="absolute left-0 top-0 bottom-0 w-1 bg-primary" />}
                </div>)}
            </div>}
        </ScrollArea>
        
        <DropdownMenuSeparator className="bg-border" />
        <div className="p-4 bg-muted/10">
          <Link to="/notifications">
            <Button variant="ghost" className="w-full h-10 text-[10px] font-black uppercase tracking-[0.2em] italic text-muted-foreground hover:text-foreground transition-all hover:bg-background border border-transparent hover:border-border" size="sm">{t("client.src.view_all_hub_activity")}<ExternalLink className="ml-3 w-3 h-3" />
            </Button>
          </Link>
        </div>
      </DropdownMenuContent>
    </DropdownMenu>;
}