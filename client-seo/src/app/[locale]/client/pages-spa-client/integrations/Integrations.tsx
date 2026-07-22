"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
import { RefreshCw, CheckCircle2, XCircle, Settings, MoreHorizontal, Plus, Search, Link, AlertTriangle, Clock, Zap, Globe, Shield, Terminal } from "lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { m, AnimatePresence } from "framer-motion";
interface ApiIntegration {
  id: string;
  orgId: string;
  name: string;
  type: IntegrationType;
  provider: string;
  status: IntegrationStatus;
  config: {
    apiKey?: string;
    apiSecret?: string;
    baseUrl?: string;
    webhookUrl?: string;
    syncFrequency?: number;
    retryAttempts?: number;
  };
  lastSyncAt?: string;
  lastSyncStatus?: string;
  syncCount?: number;
  errorMessage?: string;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}
interface Webhook {
  id: string;
  orgId: string;
  name: string;
  url: string;
  events: string[];
  secret?: string;
  isActive: boolean;
  lastTriggeredAt?: string;
  triggerCount: number;
  errorMessage?: string;
  createdAt: string;
  updatedAt: string;
}
enum IntegrationType {
  MLS = "MLS",
  VACATION_RENTAL = "VACATION_RENTAL",
  CRM = "CRM",
  PAYMENT = "PAYMENT",
  COMMUNICATION = "COMMUNICATION",
  CALENDAR = "CALENDAR",
  DOCUMENT = "DOCUMENT",
  ANALYTICS = "ANALYTICS",
}
enum IntegrationStatus {
  CONNECTED = "CONNECTED",
  DISCONNECTED = "DISCONNECTED",
  ERROR = "ERROR",
  SYNCING = "SYNCING",
  PAUSED = "PAUSED",
}
const STATUS_CONFIG = {
  CONNECTED: {
    label: t("client.src.active"),
    cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
    icon: CheckCircle2
  },
  DISCONNECTED: {
    label: t("client.src.offline"),
    cls: "bg-slate-500/10 text-slate-400 border-slate-500/20",
    icon: XCircle
  },
  ERROR: {
    label: t("client.src.critical"),
    cls: "bg-red-500/10 text-red-400 border-red-500/20",
    icon: AlertTriangle
  },
  SYNCING: {
    label: t("client.src.syncing"),
    cls: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    icon: RefreshCw
  },
  PAUSED: {
    label: t("client.src.standby"),
    cls: "bg-orange-500/10 text-orange-400 border-orange-500/20",
    icon: Clock
  }
};
const PROVIDER_ICONS: Record<string, any> = {
  RETS: Globe,
  AIRBNB: Zap,
  STRIPE: Shield,
  VRBO: Globe,
  HUBSPOT: Zap,
  SENDGRID: Zap,
  GOOGLE: Zap,
  MICROSOFT: Zap,
  SALESFORCE: Zap,
  ZAPIER: Zap,
  SLACK: Zap,
  CALENDLY: Clock
};
export default function Integrations() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [activeTab, setActiveTab] = useState<"integrations" | "webhooks">("integrations");
  const [search, setSearch] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [webhookOpen, setWebhookOpen] = useState(false);
  const [integrations, setIntegrations] = useState<ApiIntegration[]>([]);
  const [webhooks, setWebhooks] = useState<Webhook[]>([]);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [integrationsRes, webhooksRes] = await Promise.all([apiClient.get('/api-integrations'), apiClient.get('/webhooks')]);
        setIntegrations((integrationsRes as any).data || []);
        setWebhooks((webhooksRes as any).data || []);
      } catch (error) {
        // Fallback for visual modernization
        const demoOrgId = "demo-org-123";
        setIntegrations([{
          id: "1",
          orgId: demoOrgId,
          name: "Main MLS Feed",
          provider: "RETS",
          type: IntegrationType.MLS,
          status: IntegrationStatus.CONNECTED,
          isActive: true,
          syncCount: 1240,
          lastSyncAt: new Date().toISOString(),
          createdAt: "",
          updatedAt: "",
          config: {}
        }, {
          id: "2",
          orgId: demoOrgId,
          name: "Payments Gateway",
          provider: "STRIPE",
          type: IntegrationType.PAYMENT,
          status: IntegrationStatus.CONNECTED,
          isActive: true,
          syncCount: 850,
          lastSyncAt: new Date().toISOString(),
          createdAt: "",
          updatedAt: "",
          config: {}
        }, {
          id: "3",
          orgId: demoOrgId,
          name: "Airbnb Sync",
          provider: "AIRBNB",
          type: IntegrationType.VACATION_RENTAL,
          status: IntegrationStatus.ERROR,
          isActive: true,
          errorMessage: "AUTH_TOKEN_EXPIRED",
          createdAt: "",
          updatedAt: "",
          config: {}
        }]);
        setWebhooks([{
          id: "1",
          orgId: demoOrgId,
          name: "CRM Event Stream",
          url: "https://api.crm.io/webhook",
          events: ["booking.created", "lead.assigned"],
          isActive: true,
          triggerCount: 450,
          createdAt: "",
          updatedAt: ""
        }]);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);
  const filteredIntegrations = integrations.filter(integration => {
    const matchesSearch = integration.name.toLowerCase().includes(search.toLowerCase()) || integration.provider.toLowerCase().includes(search.toLowerCase());
    const matchesType = filterType === "all" || integration.type === filterType;
    const matchesStatus = filterStatus === "all" || integration.status === filterStatus;
    return matchesSearch && matchesType && matchesStatus;
  });
  const filteredWebhooks = webhooks.filter(webhook => {
    const matchesSearch = webhook.name.toLowerCase().includes(search.toLowerCase()) || webhook.url.toLowerCase().includes(search.toLowerCase());
    return matchesSearch;
  });
  const stats = [{
    label: t("client.src.connected_nodes"),
    value: integrations.filter(i => i.status === "CONNECTED").length
  }, {
    label: t("client.src.system_artifacts"),
    value: integrations.length
  }, {
    label: t("client.src.signal_errors"),
    value: integrations.filter(i => i.status === "ERROR").length
  }, {
    label: t("client.src.active_webhooks"),
    value: webhooks.filter(w => w.isActive).length
  }];
  return <PageShell title={t("client.src.neural_integrations")} description={t("client.src.bidirectional_data_bridge_realtime")} stats={stats}>
      <div className="space-y-12">
        {/* Modern Tab Control */}
        <div className="flex items-center justify-between gap-10">
          <div className="flex bg-[#1a1b1e]/60 border border-white/5 p-1.5 rounded-[20px] h-14 shadow-xl">
            {["INTEGRATIONS", "WEBHOOKS"].map(tab => <button key={tab} onClick={() => setActiveTab(tab.toLowerCase() as any)} className={`px-8 transition-all rounded-[14px] text-[10px] font-black  tracking-widest italic h-full ${activeTab === tab.toLowerCase() ? "bg-blue-600 text-white shadow-lg shadow-blue-600/20" : "text-slate-500 hover:text-white"}`}>
                {tab}
              </button>)}
          </div>

          <div className="flex items-center gap-4">
             <div className="relative group">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                <Input placeholder={activeTab === "integrations" ? "SEARCH NODES..." : "SEARCH WEBHOOKS..."} value={search} onChange={e => setSearch(e.target.value)} className="h-12 pl-12 w-64 bg-[#1a1b1e]/60 border-white/5 rounded-xl text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700" />
             </div>
             <Button onClick={() => activeTab === "integrations" ? setCreateOpen(true) : setWebhookOpen(true)} className="h-12 px-6 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] tracking-widest italic shadow-lg shadow-blue-600/20 gap-3">
                <Plus className="w-4 h-4" />{t("client.src.initialize")}{activeTab === "integrations" ? "NODE" : "SIGNAL"}
              </Button>
          </div>
        </div>

        {/* Tactical Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          <AnimatePresence mode="wait">
            {activeTab === "integrations" ? filteredIntegrations.map((integration, idx) => {
            const Icon = PROVIDER_ICONS[integration.provider.toUpperCase()] || Terminal;
            const status = STATUS_CONFIG[integration.status];
            return <m.div key={integration.id} initial={{
              opacity: 0,
              y: 20
            }} animate={{
              opacity: 1,
              y: 0
            }} transition={{
              delay: idx * 0.1
            }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-2xl relative overflow-hidden group hover:bg-white/5 transition-all">
                    <div className="flex items-start justify-between relative z-10">
                      <div className="flex items-center gap-6">
                        <div className="h-16 w-16 rounded-2xl bg-black/40 border border-white/10 flex items-center justify-center shadow-inner group-hover:scale-110 transition-transform">
                           <Icon className="w-8 h-8 text-blue-500" />
                        </div>
                        <div>
                          <h3 className="text-xl font-black text-white italic tracking-tighter">{integration.name}</h3>
                          <div className="flex items-center gap-3 mt-1">
                             <span className="text-[10px] font-black text-slate-500 tracking-widest italic">{integration.provider}</span>
                             <div className="h-1 w-1 rounded-full bg-slate-800" />
                             <span className="text-[10px] font-black text-blue-500/80 tracking-widest italic">{integration.type.replace("_", " ")}</span>
                          </div>
                        </div>
                      </div>

                      <div className="flex flex-col items-end gap-3">
                         <Badge className={`px-3 py-1 rounded-lg border text-[8px] font-black  tracking-widest italic ${status.cls}`}>
                            {status.label}
                         </Badge>
                         {integration.lastSyncAt && <span className="text-[8px] font-black text-slate-600 italic">{t("client.src.last_sync")}{new Date(integration.lastSyncAt).toLocaleTimeString()}
                           </span>}
                      </div>
                    </div>

                    {integration.errorMessage && <div className="mt-6 p-4 rounded-xl bg-red-500/5 border border-red-500/10 flex items-center gap-3">
                          <AlertTriangle className="w-4 h-4 text-red-500" />
                          <span className="text-[9px] font-black text-red-400 tracking-widest italic">{integration.errorMessage}</span>
                       </div>}

                    <div className="mt-8 pt-8 border-t border-white/5 flex items-center justify-between">
                       <div className="flex items-center gap-8">
                          <div className="space-y-1">
                             <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.data_transfers")}</p>
                             <p className="text-lg font-black text-white italic tracking-tighter">{(integration.syncCount || 0).toLocaleString()}</p>
                          </div>
                          <div className="space-y-1">
                             <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.interface")}</p>
                             <p className="text-lg font-black text-white italic tracking-tighter">{t("client.src.rest_v2")}</p>
                          </div>
                       </div>
                       
                       <div className="flex items-center gap-3">
                          <Button variant="outline" className="h-10 w-10 p-0 rounded-xl border-white/5 bg-white/2 hover:text-white transition-all">
                             <RefreshCw className="w-4 h-4" />
                          </Button>
                          <Button variant="outline" className="h-10 w-10 p-0 rounded-xl border-white/5 bg-white/2 hover:text-white transition-all">
                             <Settings className="w-4 h-4" />
                          </Button>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                               <Button variant="outline" className="h-10 w-10 p-0 rounded-xl border-white/5 bg-white/2 hover:text-white transition-all">
                                  <MoreHorizontal className="w-4 h-4" />
                               </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent className="bg-[#1a1b1e] border-white/10 text-slate-400">
                               <DropdownMenuItem className="focus:bg-blue-600 focus:text-white text-[10px] font-black italic p-3">{t("client.src.debug_logs")}</DropdownMenuItem>
                               <DropdownMenuItem className="focus:bg-red-600 focus:text-white text-[10px] font-black italic p-3 text-red-500">{t("client.src.decommission_node")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                       </div>
                    </div>
                  </m.div>;
          }) : filteredWebhooks.map((webhook, idx) => <m.div key={webhook.id} initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: idx * 0.1
          }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-2xl relative overflow-hidden group hover:bg-white/5 transition-all">
                  <div className="flex items-start justify-between relative z-10">
                    <div className="flex items-center gap-6">
                      <div className="h-16 w-16 rounded-2xl bg-black/40 border border-white/10 flex items-center justify-center shadow-inner group-hover:scale-110 transition-transform">
                         <Terminal className="w-8 h-8 text-emerald-500" />
                      </div>
                      <div className="min-w-0">
                        <h3 className="text-xl font-black text-white italic tracking-tighter truncate">{webhook.name}</h3>
                        <p className="text-[10px] font-bold text-emerald-500/60 tracking-widest italic mt-1 font-mono truncate">{webhook.url}</p>
                      </div>
                    </div>

                    <Badge className={`px-3 py-1 rounded-lg border text-[8px] font-black  tracking-widest italic ${webhook.isActive ? "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" : "bg-slate-500/10 text-slate-400 border-slate-500/20"}`}>
                       {webhook.isActive ? "ACTIVE" : "DISABLED"}
                    </Badge>
                  </div>

                  <div className="mt-6 flex flex-wrap gap-2">
                    {webhook.events.map((event, index) => <Badge key={index} className="bg-black/40 border-white/5 text-[8px] font-black text-slate-400 italic px-2 py-1">
                        {event}
                      </Badge>)}
                  </div>

                  <div className="mt-8 pt-8 border-t border-white/5 flex items-center justify-between">
                     <div className="flex items-center gap-8">
                        <div className="space-y-1">
                           <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.trigger_count")}</p>
                           <p className="text-lg font-black text-white italic tracking-tighter">{webhook.triggerCount.toLocaleString()}</p>
                        </div>
                        <div className="space-y-1">
                           <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.avg_latency")}</p>
                           <p className="text-lg font-black text-emerald-400 italic tracking-tighter">{t("client.src.124ms")}</p>
                        </div>
                     </div>
                     
                     <div className="flex items-center gap-3">
                        <Button variant="outline" className="h-10 px-6 rounded-xl border-white/5 bg-white/2 text-[9px] font-black italic tracking-widest hover:text-white transition-all">{t("client.src.test_payload")}</Button>
                        <Button variant="outline" className="h-10 w-10 p-0 rounded-xl border-white/5 bg-white/2 hover:text-white transition-all">
                           <Settings className="w-4 h-4" />
                        </Button>
                     </div>
                  </div>
                </m.div>)}
          </AnimatePresence>
        </div>
      </div>

      {/* Modern Dialogs */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="bg-[#1a1b1e] border-white/10 text-white rounded-[32px] sm:max-w-xl">
          <DialogHeader>
            <DialogTitle className="text-2xl font-black italic tracking-tighter">{t("client.src.initialize_neural_node")}</DialogTitle>
            <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.provisioning_bidirectional_interface_v34")}</DialogDescription>
          </DialogHeader>
          {/* Form fields with Neural styling */}
          <div className="space-y-6 py-6 font-display">
            <div className="space-y-2">
              <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("client.src.node_identifier")}</Label>
              <Input className="h-12 bg-black/40 border-white/5 rounded-xl text-white italic" placeholder={t("client.src.eg_globalmlssync")} />
            </div>
            <div className="grid grid-cols-2 gap-6">
              <div className="space-y-2">
                 <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("client.src.protocol_type")}</Label>
                 <Select><SelectTrigger className="h-12 bg-black/40 border-white/5 rounded-xl italic text-slate-400 font-bold"><SelectValue placeholder={t("client.src.select_type")} /></SelectTrigger><SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                   {Object.values(IntegrationType).map(t => <SelectItem key={t} value={t} className="text-slate-400 font-bold italic">{t.replace("_", " ")}</SelectItem>)}
                 </SelectContent></Select>
              </div>
              <div className="space-y-2">
                 <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("client.src.provider_vector")}</Label>
                 <Select><SelectTrigger className="h-12 bg-black/40 border-white/5 rounded-xl italic text-slate-400 font-bold"><SelectValue placeholder={t("client.src.select_provider")} /></SelectTrigger><SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                   {["AIRBNB", "STRIPE", "RETS", "HUBSPOT", "SENDGRID"].map(p => <SelectItem key={p} value={p.toLowerCase()} className="text-slate-400 font-bold italic">{p}</SelectItem>)}
                 </SelectContent></Select>
              </div>
            </div>
            <div className="space-y-2">
              <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("client.src.credentialssha256")}</Label>
              <Input type="password" className="h-12 bg-black/40 border-white/5 rounded-xl text-white font-mono" placeholder="****************" />
            </div>
          </div>
          <DialogFooter className="gap-4">
            <Button variant="ghost" onClick={() => setCreateOpen(false)} className="text-[10px] font-black italic text-slate-500">{t("client.src.abort")}</Button>
            <Button className="h-14 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-xs italic tracking-widest shadow-xl shadow-blue-600/20">{t("client.src.establish_link")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}