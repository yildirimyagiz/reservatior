import { useState, useEffect, useRef, useCallback } from "react";
import { useTranslation } from "react-i18next";
import { motion, AnimatePresence } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import {
  Bell,
  X,
  Minimize2,
  Maximize2,
  Zap,
  Activity,
  CheckCircle2,
  AlertTriangle,
  AlertCircle,
  Info,
} from "lucide-react";

const SEVERITY_CONFIG: Record<string, { icon: any; color: string; bg: string; border: string }> = {
  INFO: {
    icon: Info,
    color: "text-blue-600",
    bg: "bg-blue-50",
    border: "border-blue-200",
  },
  WARNING: {
    icon: AlertTriangle,
    color: "text-yellow-600",
    bg: "bg-yellow-50",
    border: "border-yellow-200",
  },
  ERROR: {
    icon: AlertCircle,
    color: "text-red-600",
    bg: "bg-red-50",
    border: "border-red-200",
  },
  CRITICAL: {
    icon: AlertCircle,
    color: "text-purple-600",
    bg: "bg-purple-50",
    border: "border-purple-200",
  },
};

const API_BASE_URL = (import.meta.env.VITE_API_URL || "") + "/api/v1";

function getToken(): string | null {
  const stored = localStorage.getItem("user-storage");
  if (!stored) return null;
  try {
    return JSON.parse(stored).state?.token || null;
  } catch {
    return null;
  }
}

function getOrgId(): string | null {
  const stored = localStorage.getItem("user-storage");
  if (!stored) return null;
  try {
    return JSON.parse(stored).state?.user?.orgId || JSON.parse(stored).state?.orgId || null;
  } catch {
    return null;
  }
}

interface SystemEvent {
  id: string;
  eventType: string;
  severity: string;
  entityType?: string;
  entityId?: string;
  entityLabel?: string;
  source?: string;
  payload?: any;
  metadata?: any;
  createdAt: string;
}

export default function AIOperationsWidget() {
  const { t } = useTranslation();
  const [events, setEvents] = useState<SystemEvent[]>([]);
  const [connected, setConnected] = useState(false);
  const [isMinimized, setIsMinimized] = useState(false);
  const [isOpen, setIsOpen] = useState(true);
  const [unreadCount, setUnreadCount] = useState(0);
  const esRef = useRef<EventSource | null>(null);
  const scrollRef = useRef<HTMLDivElement>(null);

  const connect = useCallback(() => {
    const token = getToken();
    const orgId = getOrgId();
    if (!orgId || !token) return;

    const url = `${API_BASE_URL}/system/events/stream?orgId=${orgId}&token=${encodeURIComponent(token)}`;
    const es = new EventSource(url);
    esRef.current = es;

    es.onopen = () => setConnected(true);

    es.onmessage = (event) => {
      try {
        const data: SystemEvent = JSON.parse(event.data);
        setEvents((prev) => [data, ...prev].slice(0, 100));
        setUnreadCount((prev) => prev + 1);
      } catch {
        // ignore parse errors
      }
    };

    es.onerror = () => {
      setConnected(false);
      es.close();
      setTimeout(() => {
        if (esRef.current === es) connect();
      }, 5000);
    };
  }, []);

  useEffect(() => {
    connect();
    return () => {
      esRef.current?.close();
    };
  }, [connect]);

  useEffect(() => {
    if (scrollRef.current) {
      scrollRef.current.scrollTop = 0;
    }
  }, [events]);

  const clearEvents = () => {
    setEvents([]);
    setUnreadCount(0);
  };

  const formatTime = (d: string) => {
    if (!d) return "";
    const date = new Date(d);
    return date.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit", second: "2-digit" });
  };

  const severityIcon = (sev: string) => {
    const cfg = SEVERITY_CONFIG[sev] || SEVERITY_CONFIG.INFO;
    const Icon = cfg.icon;
    return <Icon className={`w-3.5 h-3.5 ${cfg.color}`} />;
  };

  if (!isOpen) {
    return (
      <Button
        onClick={() => setIsOpen(true)}
        className="fixed bottom-4 right-4 rounded-full w-14 h-14 bg-indigo-600 hover:bg-indigo-700 shadow-xl border-none p-0 flex items-center justify-center group"
      >
        <Bell className="w-6 h-6 text-white group-hover:scale-110 transition-transform" />
        {unreadCount > 0 && (
          <Badge className="absolute -top-1 -right-1 bg-red-500 border-none min-w-[20px] h-5 px-1 flex items-center justify-center text-[10px]">
            {unreadCount > 99 ? "99+" : unreadCount}
          </Badge>
        )}
      </Button>
    );
  }

  return (
    <motion.div
      layoutId="ai-ops-widget"
      initial={{ opacity: 0, y: 20, scale: 0.95 }}
      animate={{ opacity: 1, y: 0, scale: 1 }}
      exit={{ opacity: 0, y: 20, scale: 0.95 }}
      className={`fixed bottom-4 right-4 z-50 bg-white rounded-2xl shadow-2xl border ring-1 ring-black/5 flex flex-col overflow-hidden ${
        isMinimized ? "w-72" : "w-[420px]"
      }`}
      style={{ height: isMinimized ? "auto" : "560px" }}
    >
      {/* Header */}
      <div className="p-3 bg-indigo-600 text-white flex items-center justify-between shrink-0">
        <div className="flex items-center gap-2">
          <div className="relative">
            <Avatar className="w-8 h-8 border-2 border-white/20">
              <AvatarFallback className="bg-indigo-500 text-white">
                <Zap className="w-4 h-4" />
              </AvatarFallback>
            </Avatar>
            <div
              className={`absolute -bottom-0.5 -right-0.5 w-2.5 h-2.5 border-2 border-indigo-600 rounded-full ${
                connected ? "bg-green-400" : "bg-red-400"
              }`}
            />
          </div>
          <div>
            <h3 className="font-bold text-sm leading-tight">AI Operations</h3>
            <p className="text-[9px] text-indigo-200 uppercase tracking-widest font-semibold">
              {connected ? t("admin.system.connected") || "Connected" : t("admin.system.disconnected") || "Disconnected"}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-1">
          <Button
            variant="ghost"
            size="icon"
            className="w-7 h-7 text-white hover:bg-white/10"
            onClick={() => setIsMinimized(!isMinimized)}
          >
            {isMinimized ? <Maximize2 className="w-3.5 h-3.5" /> : <Minimize2 className="w-3.5 h-3.5" />}
          </Button>
          <Button
            variant="ghost"
            size="icon"
            className="w-7 h-7 text-white hover:bg-white/10"
            onClick={() => setIsOpen(false)}
          >
            <X className="w-3.5 h-3.5" />
          </Button>
        </div>
      </div>

      {!isMinimized && (
        <>
          {/* Toolbar */}
          <div className="px-3 py-2 border-b bg-gray-50/50 flex items-center justify-between shrink-0">
            <div className="flex items-center gap-2 text-xs text-gray-500">
              <Activity className="w-3.5 h-3.5" />
              <span>
                {events.length} {t("admin.system.events") || "events"}
              </span>
              {unreadCount > 0 && (
                <Badge variant="secondary" className="text-[10px] h-4 px-1">
                  {unreadCount} new
                </Badge>
              )}
            </div>
            <div className="flex gap-1">
              {events.length > 0 && (
                <Button variant="ghost" size="sm" className="h-6 text-[10px] text-gray-500" onClick={clearEvents}>
                  {t("admin.system.clear") || "Clear"}
                </Button>
              )}
            </div>
          </div>

          {/* Events List */}
          <ScrollArea className="flex-1 p-2 bg-gray-50/30" ref={scrollRef}>
            <AnimatePresence initial={false}>
              {events.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-12 text-gray-400">
                  <Zap className="w-8 h-8 mb-2 opacity-50" />
                  <p className="text-sm">{t("admin.system.waiting_for_events") || "Waiting for events..."}</p>
                  {!connected && (
                    <p className="text-xs text-red-400 mt-1">
                      {t("admin.system.not_connected") || "Not connected"}
                    </p>
                  )}
                </div>
              ) : (
                events.map((event, i) => {
                  const cfg = SEVERITY_CONFIG[event.severity] || SEVERITY_CONFIG.INFO;
                  return (
                    <motion.div
                      key={event.id}
                      initial={i === 0 ? { opacity: 0, x: -20, height: 0 } : { opacity: 1 }}
                      animate={{ opacity: 1, x: 0, height: "auto" }}
                      exit={{ opacity: 0, height: 0 }}
                      transition={{ duration: 0.2 }}
                      className={`mb-1.5 p-2 rounded-lg border text-xs ${cfg.bg} ${cfg.border}`}
                    >
                      <div className="flex items-start gap-2">
                        <span className="mt-0.5">{severityIcon(event.severity)}</span>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-1.5">
                            <span className={`font-semibold ${cfg.color} truncate`}>{event.eventType}</span>
                            <span className="text-[10px] text-gray-400 shrink-0">{formatTime(event.createdAt)}</span>
                          </div>
                          {event.entityLabel && (
                            <p className="text-gray-500 truncate mt-0.5">{event.entityLabel}</p>
                          )}
                          {event.payload?.message && (
                            <p className="text-gray-600 truncate mt-0.5">{event.payload.message}</p>
                          )}
                        </div>
                        <Badge
                          variant="outline"
                          className={`text-[9px] h-4 px-1 shrink-0 ${cfg.color} ${cfg.border}`}
                        >
                          {event.severity}
                        </Badge>
                      </div>
                    </motion.div>
                  );
                })
              )}
            </AnimatePresence>
          </ScrollArea>
        </>
      )}
    </motion.div>
  );
}
