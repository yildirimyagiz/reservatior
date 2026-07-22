import { useBfcache } from "@/hooks/use-bfcache";
import { useEffect, useState, useRef } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { m, AnimatePresence } from "framer-motion";
import { apiClient } from "@/lib/api/client";
import { useAuth } from "@/lib/auth/hooks";
import { BrainCircuit, Loader2, Clock, Activity, Zap, Server, Car, Box, ShieldAlert, Wand2, Megaphone, RefreshCcw, Radar, AlertTriangle, FileText, CheckCircle2, UserPlus, TrendingUp, ShieldCheck } from "lucide-react";
import { useTranslation } from "react-i18next";

interface TriggerTask {
  id: string;
  source: "AI_SERVICE" | "SYSTEM_TASK" | "CONCIERGE";
  type: string;
  status: string;
  title: string;
  description: string;
  createdAt: string;
  progress: number;
}

interface LiveEvent {
  id: string;
  event: string;
  payload: any;
  timestamp: Date;
}

export function AIOperationsWidget() {
  const { t } = useTranslation();
  const { user } = useAuth();
  const [tasks, setTasks] = useState<TriggerTask[]>([]);
  const [liveEvents, setLiveEvents] = useState<LiveEvent[]>([]);
  const [loading, setLoading] = useState(true);
  const [isConnected, setIsConnected] = useState(false);

  const fetchTasks = async () => {
    const orgId = user?.orgId || "us_seattle_org";
    const userId = user?.id;

    try {
      const response = await apiClient.get(`/system/triggers?orgId=${orgId}&userId=${userId}`) as any;
      if (response.data?.success) {
        setTasks(response.data.data);
      }
    } catch (error) {
      console.error("Failed to fetch system triggers:", error);
    } finally {
      setLoading(false);
    }
  };

  const sseRef = useRef<EventSource | null>(null);

  useBfcache(() => {
    sseRef.current?.close();
    sseRef.current = null;
  });

  useEffect(() => {
    fetchTasks();
    const interval = setInterval(fetchTasks, 8000); // DB fallback polling

    // Connect to SSE Stream
    const baseURL = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000';
    const sse = new EventSource(`${baseURL}/api/v1/system/trigger-stream`);
    sseRef.current = sse;

    sse.onopen = () => setIsConnected(true);
    sse.onerror = () => setIsConnected(false);

    sse.onmessage = (msg) => {
      try {
        const data = JSON.parse(msg.data);
        if (data.event === "CONNECTED") return;

        // Add to live events feed
        const newEvent: LiveEvent = {
          id: Math.random().toString(36).substring(7),
          event: data.event,
          payload: data.payload,
          timestamp: new Date()
        };

        setLiveEvents(prev => [newEvent, ...prev].slice(0, 5)); // Keep last 5 events

        // Because a trigger just fired, background tasks are likely being created.
        // We fetch immediately, and then again after 1.5s to catch DB updates.
        fetchTasks();
        setTimeout(fetchTasks, 1500);

      } catch (err) {
        console.error("SSE Parse Error:", err);
      }
    };

    return () => {
      clearInterval(interval);
      sse.close();
      sseRef.current = null;
    };
  }, [user?.id]);

  const getTaskIcon = (type: string, source: string) => {
    if (source === "CONCIERGE") {
      if (type.includes("TRANSFER") || type.includes("TAXI")) return <Car className="w-5 h-5 text-indigo-400" />;
      if (type.includes("RELOCATION")) return <Box className="w-5 h-5 text-amber-400" />;
      return <Activity className="w-5 h-5 text-blue-400" />;
    }
    if (type.includes("PRICING") || type.includes("VALUATION")) return <Zap className="w-5 h-5 text-emerald-400" />;
    if (type.includes("MAINTENANCE") || type.includes("SECURITY")) return <ShieldAlert className="w-5 h-5 text-rose-400" />;
    if (type.includes("AI_PHOTO_STAGING")) return <Wand2 className="w-5 h-5 text-fuchsia-400" />;
    if (type.includes("MARKETING_BROCHURE_GEN") || type.includes("SOCIAL_MEDIA")) return <Megaphone className="w-5 h-5 text-orange-400" />;
    if (type.includes("MLS_SYNC")) return <RefreshCcw className="w-5 h-5 text-cyan-400 animate-spin-slow" />;
    return <Server className="w-5 h-5 text-violet-400" />;
  };

  const getLiveEventDetails = (eventName: string) => {
    switch (eventName) {
      case "LEASE_EXPIRY_APPROACHING": return { title: "Kira Yenileme Yaklaşıyor", icon: <Clock className="w-4 h-4 text-amber-400" />, color: "text-amber-400", bg: "bg-amber-400/10" };
      case "RENT_PAYMENT_OVERDUE": return { title: "Gecikmiş Kira Tespiti", icon: <AlertTriangle className="w-4 h-4 text-rose-400" />, color: "text-rose-400", bg: "bg-rose-400/10" };
      case "TENANT_APPLICATION_APPROVED": return { title: "Akıllı Sözleşme Üretimi", icon: <FileText className="w-4 h-4 text-blue-400" />, color: "text-blue-400", bg: "bg-blue-400/10" };
      case "INVOICE_UPLOADED": return { title: "Fatura OCR & Bütçe Kontrolü", icon: <CheckCircle2 className="w-4 h-4 text-emerald-400" />, color: "text-emerald-400", bg: "bg-emerald-400/10" };
      case "QUARTERLY_TAX_REVIEW": return { title: "Çeyreklik Vergi Taraması", icon: <Activity className="w-4 h-4 text-purple-400" />, color: "text-purple-400", bg: "bg-purple-400/10" };
      case "SECURITY_INCIDENT_CREATED": return { title: "Güvenlik İhlali Bildirimi", icon: <ShieldAlert className="w-4 h-4 text-rose-500" />, color: "text-rose-500", bg: "bg-rose-500/10" };
      case "DOCUMENT_EXPIRED": return { title: "Belge Süresi Doldu", icon: <AlertTriangle className="w-4 h-4 text-orange-500" />, color: "text-orange-500", bg: "bg-orange-500/10" };
      case "VIEWING_COMPLETED": return { title: "Gösterim Geri Bildirim Analizi", icon: <BrainCircuit className="w-4 h-4 text-cyan-400" />, color: "text-cyan-400", bg: "bg-cyan-400/10" };
      case "AI_TASK_STARTED": return { title: "Yapay Zeka Görevi Başladı", icon: <BrainCircuit className="w-4 h-4 text-blue-400" />, color: "text-blue-400", bg: "bg-blue-400/10" };
      case "AI_TASK_COMPLETED": return { title: "Yapay Zeka Görevi Tamamlandı", icon: <CheckCircle2 className="w-4 h-4 text-emerald-400" />, color: "text-emerald-400", bg: "bg-emerald-400/10" };
      case "AI_TASK_FAILED": return { title: "Yapay Zeka Görevi Başarısız", icon: <AlertTriangle className="w-4 h-4 text-rose-400" />, color: "text-rose-400", bg: "bg-rose-400/10" };
      case "STAGING_GENERATED": return { title: "Sanal Sahneleme Üretildi", icon: <Wand2 className="w-4 h-4 text-fuchsia-400" />, color: "text-fuchsia-400", bg: "bg-fuchsia-400/10" };
      case "LISTING_OPTIMIZED": return { title: "İlan Optimizasyonu Tamamlandı", icon: <Megaphone className="w-4 h-4 text-orange-400" />, color: "text-orange-400", bg: "bg-orange-400/10" };
      case "AGENT_ASSIGNED": return { title: "Acente İlana Atandı", icon: <UserPlus className="w-4 h-4 text-cyan-400" />, color: "text-cyan-400", bg: "bg-cyan-400/10" };
      case "AGENT_PERFORMANCE_UPDATED": return { title: "Acente Performansı Güncellendi", icon: <TrendingUp className="w-4 h-4 text-emerald-400" />, color: "text-emerald-400", bg: "bg-emerald-400/10" };
      case "AGENT_LICENSE_VERIFIED": return { title: "Acente Lisansı Doğrulandı", icon: <ShieldCheck className="w-4 h-4 text-blue-400" />, color: "text-blue-400", bg: "bg-blue-400/10" };
      case "COMPLIANCE_ALERT": return { title: "Yasal Mevzuat Uyum İhlali", icon: <ShieldAlert className="w-4 h-4 text-rose-500" />, color: "text-rose-500", bg: "bg-rose-500/10" };
      default: return { title: `Sistem Olayı: ${eventName}`, icon: <Radar className="w-4 h-4 text-slate-400" />, color: "text-slate-400", bg: "bg-slate-400/10" };
    }
  };

  const getStatusBadge = (status: string) => {
    switch (status) {
      case "PENDING":
      case "QUEUED": 
        return <Badge className="bg-slate-500/10 text-slate-400 border-slate-500/20 text-[9px] font-bold">KUYRUKTA</Badge>;
      case "IN_PROGRESS":
      case "PROCESSING":
        return <Badge className="bg-blue-500/10 text-blue-400 border-blue-500/20 text-[9px] font-bold animate-pulse">İŞLENİYOR</Badge>;
      case "FULFILLED":
      case "COMPLETED":
        return <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 text-[9px] font-bold">TAMAMLANDI</Badge>;
      default:
        return <Badge className="bg-slate-500/10 text-slate-400 border-slate-500/20 text-[9px] font-bold">{status}</Badge>;
    }
  };

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 col-span-full">
      {/* Sol Panel: İşlenen Arka Plan Görevleri */}
      <Card className="lg:col-span-2 border-border/50 bg-card/60 backdrop-blur-3xl rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t">
        <div className="absolute -top-24 -right-24 h-[300px] w-[300px] bg-blue-600/10 rounded-full blur-[80px] pointer-events-none opacity-50" />
        
        <CardHeader className="p-8 pb-4 border-b border-white/5">
          <div className="flex justify-between items-center relative z-10">
            <div className="space-y-1">
              <CardTitle className="text-xl font-bold text-white tracking-tight flex items-center gap-3">
                <BrainCircuit className="w-6 h-6 text-blue-500" />
                Yapay Zeka Operasyon Merkezi
              </CardTitle>
              <CardDescription className="text-slate-400 text-xs font-medium">
                Sistemdeki tüm otonom tetikleyiciler ve arka plan iş akışları
              </CardDescription>
            </div>
            {loading && tasks.length === 0 ? (
              <Loader2 className="w-5 h-5 text-slate-400 animate-spin" />
            ) : (
              <div className="flex items-center gap-2 px-3 py-1 bg-blue-500/10 rounded-full border border-blue-500/20 shadow-inner">
                <div className="h-2 w-2 rounded-full bg-blue-500 animate-ping" />
                <span className="text-[10px] font-bold text-blue-400 tracking-wider">SKIPPER AKTİF</span>
              </div>
            )}
          </div>
        </CardHeader>
        
        <CardContent className="p-8 space-y-4 relative z-10 h-[400px] overflow-y-auto custom-scrollbar">
          {!loading && tasks.length === 0 && (
            <div className="flex flex-col items-center justify-center h-full text-slate-500 gap-3">
              <Server className="w-10 h-10 opacity-20" />
              <p className="text-sm font-medium">Şu an aktif bir arka plan görevi bulunmuyor.</p>
            </div>
          )}
          <AnimatePresence>
            {tasks.map((task, index) => (
              <m.div
                key={task.id}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, scale: 0.95 }}
                transition={{ delay: index * 0.05 }}
                className="flex items-center gap-6 p-5 rounded-2xl bg-black/20 border border-white/5 hover:bg-black/40 transition-colors group"
              >
                <div className="p-4 rounded-xl bg-black/40 border border-white/10 shadow-inner shrink-0 group-hover:scale-110 transition-transform">
                  {getTaskIcon(task.type, task.source)}
                </div>
                
                <div className="flex-1 space-y-2">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-3">
                      <h4 className="text-sm font-bold text-white tracking-wide">{task.title}</h4>
                      <span className="text-[10px] font-mono text-slate-500">{task.id.slice(0, 8)}</span>
                    </div>
                    {getStatusBadge(task.status)}
                  </div>
                  
                  <p className="text-xs text-slate-400 font-medium">
                    {task.description}
                  </p>

                  {(task.status === "IN_PROGRESS" || task.status === "QUEUED" || task.status === "PROCESSING") && (
                    <div className="mt-3 space-y-1.5">
                      <div className="flex justify-between text-[10px] font-bold text-blue-400 tracking-wider">
                        <span>AĞ BAĞLANTISI VE HESAPLAMA...</span>
                        <span>{task.progress}%</span>
                      </div>
                      <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner border border-white/5">
                        <m.div
                          initial={{ width: 0 }}
                          animate={{ width: `${task.progress}%` }}
                          transition={{ duration: 2, ease: "easeOut" }}
                          className="h-full bg-blue-500 shadow-[0_0_10px_#3b82f6]"
                        />
                      </div>
                    </div>
                  )}
                </div>
                
                <div className="hidden md:flex flex-col items-end gap-1 shrink-0 ml-4">
                  <Clock className="w-4 h-4 text-slate-500" />
                  <span className="text-[10px] text-slate-400 font-medium">
                    {new Date(task.createdAt).toLocaleTimeString()}
                  </span>
                  <span className="text-[9px] text-slate-600 font-bold uppercase tracking-wider">
                    {task.source}
                  </span>
                </div>
              </m.div>
            ))}
          </AnimatePresence>
        </CardContent>
      </Card>

      {/* Sağ Panel: Canlı Olay Akışı (SSE) */}
      <Card className="border-border/50 bg-card/60 backdrop-blur-3xl rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t">
        <div className="absolute top-0 right-0 h-full w-[200px] bg-indigo-600/5 rounded-full blur-[80px] pointer-events-none opacity-50" />
        
        <CardHeader className="p-6 pb-4 border-b border-white/5">
          <div className="flex justify-between items-center relative z-10">
            <CardTitle className="text-lg font-bold text-white tracking-tight flex items-center gap-2">
              <Radar className={`w-5 h-5 ${isConnected ? "text-emerald-500 animate-pulse" : "text-slate-500"}`} />
              Canlı Akış
            </CardTitle>
            <Badge variant="outline" className={isConnected ? "text-emerald-400 border-emerald-400/20" : "text-slate-400"}>
              {isConnected ? "CANLI" : "BAĞLANTI BEKLENİYOR"}
            </Badge>
          </div>
        </CardHeader>
        
        <CardContent className="p-6 space-y-3 relative z-10 h-[400px] overflow-hidden">
          {liveEvents.length === 0 && (
             <div className="flex flex-col items-center justify-center h-full text-slate-500 gap-3">
               <Activity className="w-8 h-8 opacity-20" />
               <p className="text-xs font-medium text-center">Sistem olayları dinleniyor...<br/>Bir tetikleyici oluştuğunda burada belirecektir.</p>
             </div>
          )}
          <AnimatePresence>
            {liveEvents.map((evt) => {
              const details = getLiveEventDetails(evt.event);
              return (
                <m.div
                  key={evt.id}
                  initial={{ opacity: 0, y: -20, scale: 0.95 }}
                  animate={{ opacity: 1, y: 0, scale: 1 }}
                  exit={{ opacity: 0, x: 20 }}
                  className={`p-4 rounded-2xl border border-white/5 shadow-lg ${details.bg} backdrop-blur-sm relative overflow-hidden group`}
                >
                  <div className="absolute left-0 top-0 w-1 h-full bg-current opacity-50" style={{ color: details.color.replace('text-', '') }} />
                  <div className="flex items-start gap-3">
                    <div className={`mt-0.5 ${details.color}`}>
                      {details.icon}
                    </div>
                    <div className="flex-1 space-y-1">
                      <div className="flex items-center justify-between">
                        <span className={`text-xs font-bold ${details.color} tracking-wide`}>
                          {details.title}
                        </span>
                        <span className="text-[9px] font-mono text-slate-500">
                          {evt.timestamp.toLocaleTimeString()}
                        </span>
                      </div>
                      <p className="text-[10px] text-slate-300 font-medium truncate w-full max-w-[200px]">
                        Tetiklendi: {evt.event}
                      </p>
                    </div>
                  </div>
                </m.div>
              );
            })}
          </AnimatePresence>
        </CardContent>
      </Card>
    </div>
  );
}
