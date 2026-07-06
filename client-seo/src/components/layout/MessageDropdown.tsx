import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Link } from "@/lib/react-router-shim";
import { MessageCircle, Search, MoreHorizontal, Activity, Inbox } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { cn } from "@/lib/utils";
import { motion, AnimatePresence } from "framer-motion";
import { useAuth } from "@/lib/auth/hooks";

interface Conversation {
  id: string;
  name: string;
  lastMessage: string;
  time: string;
  unread: boolean;
  online: boolean;
  avatarUrl?: string;
}

export function MessageDropdown() {
  const { t } = useTranslation();
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState<"all" | "unread">("all");
  const [conversations, setConversations] = useState<Conversation[]>([]);
  const [isLoading, setIsLoading] = useState(false);

  // Fetch real conversations from API when available
  useEffect(() => {
    if (!user) return;
    
    const fetchConversations = async () => {
      setIsLoading(true);
      try {
        const res = await fetch("/api/messages/conversations", {
          headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
        });
        if (res.ok) {
          const data = await res.json();
          setConversations(data);
        }
      } catch {
        // API not yet available — show empty state
      } finally {
        setIsLoading(false);
      }
    };

    fetchConversations();
  }, [user]);

  const filteredConversations = conversations.filter(
    (c) => activeTab === "all" || c.unread
  );
  const unreadCount = conversations.filter((c) => c.unread).length;

  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button
          variant="ghost"
          size="icon"
          className="relative h-10 w-10 rounded-full border border-blue-500/20 bg-blue-500/10 hover:bg-blue-500/20 transition-all group"
        >
          <MessageCircle className="h-5 w-5 text-blue-600 dark:text-blue-400 group-hover:text-blue-500 transition-colors" />
          {unreadCount > 0 && (
            <Badge className="absolute -top-1 -right-1 h-5 w-5 p-0 flex items-center justify-center rounded-full bg-primary text-[10px] ring-2 ring-background font-black italic shadow-lg animate-bounce">
              {unreadCount}
            </Badge>
          )}
        </Button>
      </PopoverTrigger>
      <PopoverContent
        align="end"
        className="w-[400px] p-0 bg-card/95 border-border/50 shadow-2xl shadow-black/20 rounded-3xl overflow-hidden z-[100] backdrop-blur-xl"
      >
        {/* Telegram Style Header */}
        <div className="p-6 bg-muted/10 border-b border-border">
          <div className="flex items-center justify-between mb-6">
            <div className="flex items-center gap-3">
              <Activity className="w-4 h-4 text-primary" />
              <h3 className="font-black text-sm text-foreground tracking-[0.2em] uppercase italic">
                {t("client.src.neural_messages")}
              </h3>
            </div>
            <div className="flex gap-2">
              <Button
                variant="ghost"
                size="icon"
                className="h-8 w-8 text-muted-foreground hover:text-foreground rounded-lg border border-transparent hover:border-border transition-all"
              >
                <Search className="h-4 w-4" />
              </Button>
              <Button
                variant="ghost"
                size="icon"
                className="h-8 w-8 text-muted-foreground hover:text-foreground rounded-lg border border-transparent hover:border-border transition-all"
              >
                <MoreHorizontal className="h-4 w-4" />
              </Button>
            </div>
          </div>

          <div className="flex gap-3 bg-background/50 p-1 rounded-2xl border border-border shadow-inner">
            <button
              onClick={() => setActiveTab("all")}
              className={cn(
                "flex-1 px-4 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-widest italic transition-all",
                activeTab === "all"
                  ? "bg-primary text-primary-foreground shadow-lg"
                  : "text-muted-foreground hover:text-foreground"
              )}
            >
              {t("client.src.all_chats")}
            </button>
            <button
              onClick={() => setActiveTab("unread")}
              className={cn(
                "flex-1 px-4 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-widest italic transition-all flex items-center justify-center gap-2",
                activeTab === "unread"
                  ? "bg-primary text-primary-foreground shadow-lg"
                  : "text-muted-foreground hover:text-foreground"
              )}
            >
              {t("client.src.unread")}
              {unreadCount > 0 && (
                <span
                  className={cn(
                    "px-2 py-0.5 rounded-md text-[9px] font-black shadow-sm",
                    activeTab === "unread"
                      ? "bg-white/20 text-white"
                      : "bg-primary/10 text-primary"
                  )}
                >
                  {unreadCount}
                </span>
              )}
            </button>
          </div>
        </div>

        {/* List */}
        <div className="max-h-[500px] overflow-y-auto py-2 custom-scrollbar">
          {isLoading ? (
            <div className="flex flex-col items-center justify-center py-16 gap-3">
              <div className="w-8 h-8 border-2 border-primary/30 border-t-primary rounded-full animate-spin" />
              <p className="text-xs text-muted-foreground font-medium italic">
                {t("loading", "Loading...")}
              </p>
            </div>
          ) : filteredConversations.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-16 gap-4">
              <div className="w-16 h-16 rounded-2xl bg-muted/30 flex items-center justify-center">
                <Inbox className="w-8 h-8 text-muted-foreground/40" />
              </div>
              <div className="text-center space-y-1">
                <p className="text-sm font-black text-foreground italic tracking-tight">
                  {t("client.src.no_messages_yet", "No messages yet")}
                </p>
                <p className="text-[10px] text-muted-foreground uppercase tracking-widest">
                  {t(
                    "client.src.conversations_appear_here",
                    "Your conversations will appear here"
                  )}
                </p>
              </div>
            </div>
          ) : (
            <AnimatePresence mode="popLayout">
              {filteredConversations.map((chat) => (
                <motion.div
                  key={chat.id}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  exit={{ opacity: 0, scale: 0.95 }}
                  className="px-3"
                >
                  <Link
                    to={`/messages/${chat.id}`}
                    className="flex items-center gap-4 p-4 rounded-2xl hover:bg-muted/30 group transition-all relative border border-transparent hover:border-border/50 mb-2 shadow-sm hover:shadow-md"
                  >
                    <div className="relative">
                      <Avatar className="h-14 w-14 rounded-2xl ring-2 ring-primary/0 group-hover:ring-primary/20 transition-all shadow-inner bg-background border border-border">
                        {chat.avatarUrl && (
                          <AvatarImage src={chat.avatarUrl} />
                        )}
                        <AvatarFallback className="bg-primary/5 text-primary font-black italic">
                          {chat.name.slice(0, 2).toUpperCase()}
                        </AvatarFallback>
                      </Avatar>
                      {chat.online && (
                        <span className="absolute -bottom-1 -right-1 h-4 w-4 rounded-full bg-emerald-500 ring-2 ring-card shadow-[0_0_10px_#10b981]" />
                      )}
                    </div>

                    <div className="flex-1 min-w-0">
                      <div className="flex items-center justify-between mb-1.5">
                        <span className="font-black text-sm text-foreground italic tracking-tight truncate group-hover:text-primary transition-colors">
                          {chat.name}
                        </span>
                        <span className="text-[9px] font-bold text-muted-foreground/40 uppercase">
                          {chat.time}
                        </span>
                      </div>
                      <p
                        className={cn(
                          "text-[11px] truncate leading-none",
                          chat.unread
                            ? "text-foreground font-bold"
                            : "text-muted-foreground"
                        )}
                      >
                        {chat.lastMessage}
                      </p>
                    </div>

                    {chat.unread && (
                      <div className="absolute right-4 bottom-4 h-2 w-2 rounded-full bg-primary shadow-[0_0_10px_rgba(var(--primary),0.5)] animate-pulse" />
                    )}
                  </Link>
                </motion.div>
              ))}
            </AnimatePresence>
          )}
        </div>

        <div className="p-4 bg-muted/10 border-t border-border">
          <Link to="/messages">
            <Button
              variant="ghost"
              className="w-full h-11 text-[10px] font-black uppercase tracking-[0.2em] italic text-muted-foreground hover:text-foreground transition-all hover:bg-background border border-transparent hover:border-border"
              size="sm"
            >
              {t("client.src.open_full_messenger_hub")}
            </Button>
          </Link>
        </div>
      </PopoverContent>
    </Popover>
  );
}