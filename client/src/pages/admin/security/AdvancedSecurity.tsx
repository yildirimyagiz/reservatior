import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Switch } from "@/components/ui/switch";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Shield, ShieldAlert, Fingerprint, AlertTriangle, CheckCircle, XCircle, Clock, Users, Mail, Smartphone, Monitor, Eye, EyeOff, RefreshCw, Settings, Download, MoreHorizontal, Copy, QrCode, Zap, Activity, Lock, ArrowRight } from "lucide-react";
import { Progress } from "@/components/ui/progress";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { securityApi } from "@/lib/api/security";
import { apiClient } from "@/lib/api/client";
interface SecurityPolicy {
  id: string;
  name: string;
  description: string;
  enabled: boolean;
  severity: "LOW" | "MEDIUM" | "HIGH" | "CRITICAL";
  category: string;
  lastUpdated: string;
  violations: number;
}
interface SecurityEvent {
  id: string;
  type: string;
  severity: "INFO" | "WARNING" | "ERROR" | "CRITICAL";
  description: string;
  userId?: string;
  ipAddress: string;
  userAgent: string;
  timestamp: string;
  resolved: boolean;
}
interface SecuritySession {
  id: string;
  userId: string;
  ipAddress: string;
  userAgent: string;
  deviceType: string;
  location: string;
  createdAt: string;
  lastActivity: string;
  isActive: boolean;
  riskScore: number;
}
const MOCK_POLICIES: SecurityPolicy[] = [{
  id: "1",
  name: "Neural Password DNA",
  description: t("admin.security.require_complex_alphanumeric_sequences"),
  enabled: true,
  severity: "HIGH",
  category: "Authentication",
  lastUpdated: "2024-03-28",
  violations: 0
}, {
  id: "2",
  name: "Multi-Node Handshake (2FA)",
  description: t("admin.security.mandatory_secondary_node_verification"),
  enabled: true,
  severity: "CRITICAL",
  category: "Authentication",
  lastUpdated: "2024-03-28",
  violations: 3
}, {
  id: "3",
  name: "Temporal Session Decay",
  description: t("admin.security.automated_session_termination_after"),
  enabled: true,
  severity: "MEDIUM",
  category: "Session Management",
  lastUpdated: "2024-03-27",
  violations: 0
}];
const MOCK_EVENTS: SecurityEvent[] = [{
  id: "1",
  type: "LOGIN_SUCCESS",
  severity: "INFO",
  description: t("admin.security.successful_neural_link_established"),
  userId: "user-1",
  ipAddress: "192.168.1.100",
  userAgent: "Mozilla/5.0 (Windows NT 10.0)",
  timestamp: "2024-03-28T10:30:00Z",
  resolved: true
}];
const MOCK_SESSIONS: SecuritySession[] = [{
  id: "1",
  userId: "ADMIN_CORE_X",
  ipAddress: "192.168.1.100",
  userAgent: "Chrome/NeuroNode",
  deviceType: "Desktop",
  location: "Istanbul, TR",
  createdAt: "2024-03-28T09:00:00Z",
  lastActivity: "2024-03-28T10:30:00Z",
  isActive: true,
  riskScore: 12
}];
export default function AdvancedSecurity() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/security/policies/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const [activeTab, setActiveTab] = useState("policies");
  const [policyDialogOpen, setPolicyDialogOpen] = useState(false);
  const [twoFactorDialogOpen, setTwoFactorDialogOpen] = useState(false);
  const [showSecret, setShowSecret] = useState(false);

  // Queries
  const { data: policiesData } = useQuery<SecurityPolicy[]>({
    queryKey: ['securityPolicies'],
    queryFn: async () => {
      try {
        const res = await apiClient.get('/security/policies');
        const apiPolicies = Array.isArray(res) ? res : ((res as any).data || []);
        return apiPolicies.length > 0 ? apiPolicies : MOCK_POLICIES;
      } catch (e) {
        return MOCK_POLICIES;
      }
    }
  });

  const { data: eventsData } = useQuery<SecurityEvent[]>({
    queryKey: ['securityEvents'],
    queryFn: async () => {
      try {
        const res = await apiClient.get('/security/events');
        const apiEvents = Array.isArray(res) ? res : ((res as any).data || []);
        return apiEvents.length > 0 ? apiEvents : MOCK_EVENTS;
      } catch (e) {
        return MOCK_EVENTS;
      }
    }
  });

  const { data: sessionsData } = useQuery<SecuritySession[]>({
    queryKey: ['securitySessions'],
    queryFn: async () => {
      try {
        const res = await securityApi.getSessions();
        const apiSessions = Array.isArray(res) ? res : ((res as any).data || []);
        return apiSessions.length > 0 ? apiSessions : MOCK_SESSIONS;
      } catch (e) {
        return MOCK_SESSIONS;
      }
    }
  });

  const policies = policiesData || MOCK_POLICIES;
  const events = eventsData || MOCK_EVENTS;
  const sessions = sessionsData || MOCK_SESSIONS;
  const getSeverityBadge = (severity: string) => {
    switch (severity) {
      case "LOW":
        return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
      case "MEDIUM":
        return "bg-blue-500/10 text-blue-400 border-blue-500/20";
      case "HIGH":
        return "bg-orange-500/10 text-orange-400 border-orange-500/20";
      case "CRITICAL":
        return "bg-rose-500/10 text-rose-400 border-rose-500/20";
      default:
        return "bg-slate-500/10 text-muted-foreground border-slate-500/20";
    }
  };
  const getEventIcon = (type: string) => {
    switch (type) {
      case "LOGIN_SUCCESS":
        return <CheckCircle className="w-4 h-4 text-emerald-400" />;
      case "LOGIN_FAILED":
        return <XCircle className="w-4 h-4 text-rose-400" />;
      case "SUSPICIOUS_ACTIVITY":
        return <AlertTriangle className="w-4 h-4 text-orange-400" />;
      default:
        return <Clock className="w-4 h-4 text-muted-foreground" />;
    }
  };
  return <PageShell title={t("admin.security.advanced_security_lab")} description={t("admin.security.deep_neural_firewall_and")}>
      <div className="space-y-10 pb-20">
        
        {/* KPI NEURAL GRID */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {[{
          label: t("admin.security.policy_sync"),
          val: "92%",
          sub: "6 Active Protocols",
          icon: Shield,
          color: "text-blue-400"
        }, {
          label: t("admin.security.threat_level"),
          val: "Minimal",
          sub: "0 Anomalies Detected",
          icon: ShieldAlert,
          color: "text-emerald-400"
        }, {
          label: t("admin.security.active_links"),
          val: "14",
          sub: "Neural Handshakes",
          icon: Users,
          color: "text-purple-400"
        }, {
          label: t("admin.security.alert_velocity"),
          val: "Low",
          sub: "Normal Cycle",
          icon: Activity,
          color: "text-orange-400"
        }].map((stat, i) => <Card key={i} className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
              <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                 <stat.icon className="w-12 h-12" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{stat.label}</p>
                <h3 className="text-xl font-bold text-foreground leading-none">{stat.val}</h3>
                <p className="text-[10px] font-bold text-muted-foreground mt-4">{stat.sub}</p>
              </CardContent>
            </Card>)}
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-10">
          <TabsList className="bg-card border border-border p-1.5 rounded-2xl h-18 w-full flex overflow-x-auto gap-1">
             <TabsTrigger value="policies" className="flex-1 min-w-[120px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2"><Shield className="w-4 h-4" />{t("admin.security.policies")}</TabsTrigger>
             <TabsTrigger value="events" className="flex-1 min-w-[120px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2"><Activity className="w-4 h-4" />{t("admin.security.neural_logs")}</TabsTrigger>
             <TabsTrigger value="sessions" className="flex-1 min-w-[120px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2"><Monitor className="w-4 h-4" />{t("admin.security.link_state")}</TabsTrigger>
             <TabsTrigger value="2fa" className="flex-1 min-w-[120px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2"><Fingerprint className="w-4 h-4" />{t("admin.security.biohandshake")}</TabsTrigger>
          </TabsList>

          <TabsContent value="policies" className="space-y-6">
             <div className="flex justify-between items-center px-4">
                <h4 className="text-xl font-bold text-foreground">{t("admin.security.security_protocols")}</h4>
                <Button onClick={() => setPolicyDialogOpen(true)} className="h-12 bg-blue-600 hover:bg-blue-500 text-foreground rounded-2xl font-bold text-[10px] px-8 shadow-xl shadow-blue-600/20 gap-2">
                   <Settings className="w-4 h-4" />{t("admin.security.configure_matrix")}</Button>
             </div>
             
             <div className="grid grid-cols-1 gap-4">
                {policies.map(policy => <Card key={policy.id} className="bg-card border-border rounded-4xl p-8 shadow-2xl relative overflow-hidden group">
                     <div className="flex items-center justify-between relative z-10">
                        <div className="flex-1">
                           <div className="flex items-center gap-4 mb-4">
                              <h5 className="text-lg font-bold text-foreground leading-none">{policy.name}</h5>
                              <Badge className={cn("text-[9px] font-bold   px-2", getSeverityBadge(policy.severity))}>
                                 {policy.severity}
                              </Badge>
                              <Badge variant="outline" className="text-[9px] font-bold text-muted-foreground border-border px-2">{policy.category}</Badge>
                           </div>
                           <p className="text-xs text-muted-foreground font-medium leading-relaxed mb-4 max-w-2xl">{policy.description}</p>
                           <div className="flex items-center gap-6 text-[10px] font-bold text-slate-600">
                              <span className="flex items-center gap-1"><Clock className="w-3 h-3" />{t("admin.security.sync")}{policy.lastUpdated}</span>
                              {policy.violations > 0 && <span className="text-rose-500 flex items-center gap-1 font-bold"><ShieldAlert className="w-3 h-3" /> {policy.violations}{t("admin.security.anomalies")}</span>}
                           </div>
                        </div>
                        <div className="flex items-center gap-4">
                           <Switch checked={policy.enabled} className="data-[state=checked]:bg-emerald-500" />
                           <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground"><MoreHorizontal className="w-5 h-5" /></Button>
                        </div>
                     </div>
                  </Card>)}
             </div>
          </TabsContent>

          <TabsContent value="events" className="focus-visible:ring-0">
             <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardContent className="p-0">
                   <Table>
                      <TableHeader className="bg-muted/50 border-b border-border">
                         <TableRow className="hover:bg-transparent border-none">
                            <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin.security.neural_event")}</TableHead>
                            <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.node_identity")}</TableHead>
                            <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.temporal_sync")}</TableHead>
                            <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin.security.actions")}</TableHead>
                         </TableRow>
                      </TableHeader>
                      <TableBody>
                         {events.map(event => <TableRow key={event.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                              <TableCell className="py-8 px-8">
                                 <div className="flex items-center gap-6">
                                    <div className="p-3 bg-card border border-border rounded-2xl">
                                       {getEventIcon(event.type)}
                                    </div>
                                    <div>
                                       <h6 className="text-sm font-bold text-foreground leading-none">{event.type.replace('_', ' ')}</h6>
                                       <p className="text-[10px] font-bold text-muted-foreground mt-1">{event.description}</p>
                                    </div>
                                 </div>
                              </TableCell>
                              <TableCell className="px-8">
                                 <div className="space-y-1">
                                    <p className="text-xs font-bold text-blue-400 leading-none">{event.userId || 'SYSTEM_DAEMON'}</p>
                                    <p className="text-[9px] font-bold text-slate-600 mt-1">{event.ipAddress}</p>
                                 </div>
                              </TableCell>
                              <TableCell className="px-8">
                                 <span className="text-[10px] font-bold text-muted-foreground">{new Date(event.timestamp).toLocaleTimeString()}</span>
                              </TableCell>
                              <TableCell className="px-8 text-right">
                                 <Button variant="ghost" className="h-10 rounded-xl hover:bg-muted/50 text-muted-foreground hover:text-foreground font-bold text-[9px]">{t("admin.security.details")}</Button>
                              </TableCell>
                           </TableRow>)}
                      </TableBody>
                   </Table>
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="2fa" className="focus-visible:ring-0">
             <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <Card className="bg-card border-border rounded-4xl p-10 overflow-hidden shadow-2xl border-l border-t relative group">
                   <div className="space-y-8 relative z-10">
                      <div className="flex items-center gap-6">
                         <div className="p-4 bg-emerald-600/10 border border-emerald-500/20 rounded-3xl">
                            <Fingerprint className="w-10 h-10 text-emerald-400" />
                         </div>
                         <div>
                            <h3 className="text-2xl font-bold text-foreground leading-none">{t("admin.security.biohandshake_status")}</h3>
                            <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin.security.multinode_authentication_matrix")}</p>
                         </div>
                      </div>
                      <div className="space-y-6">
                         {[{
                    label: t("admin.security.neural_auth_app"),
                    sub: "Synced via secondary hardware",
                    icon: Smartphone,
                    check: true
                  }, {
                    label: t("admin.security.secondary_comm_code"),
                    sub: "Encrypted email dispatch",
                    icon: Mail,
                    check: false
                  }, {
                    label: t("admin.security.symmetric_sms_node"),
                    sub: "Legacy telco handshake",
                    icon: PhoneIcon,
                    check: false
                  }].map((node, i) => <div key={i} className="flex items-center gap-6 p-6 rounded-3xl bg-muted/50 border border-border hover:border-border hover:bg-muted/50 transition-all">
                              <div className="w-12 h-12 rounded-2xl bg-[#14151a] flex items-center justify-center text-blue-400 border border-border">
                                 <node.icon className="w-6 h-6" />
                              </div>
                              <div className="flex-1">
                                 <h5 className="font-bold text-foreground text-xs leading-none">{node.label}</h5>
                                 <p className="text-[10px] font-bold text-muted-foreground mt-1">{node.sub}</p>
                              </div>
                              <Switch checked={node.check} className="data-[state=checked]:bg-emerald-500" />
                           </div>)}
                      </div>
                   </div>
                   <Zap className="absolute -right-20 -bottom-20 w-64 h-64 text-emerald-500/5 group-hover:scale-110 transition-all duration-1000" />
                </Card>

                <Card className="bg-linear-to-br from-[#14151a]/60 to-transparent border-border rounded-4xl p-10 overflow-hidden shadow-2xl relative">
                   <div className="space-y-8">
                      <div className="flex items-center justify-between">
                         <div>
                           <h3 className="text-2xl font-bold text-foreground leading-none">{t("admin.security.neural_recovery_codes")}</h3>
                           <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin.security.backup_handshake_bypass_tokens")}</p>
                         </div>
                         <Button variant="ghost" className="h-10 rounded-xl hover:bg-muted/50 text-muted-foreground" onClick={() => setShowSecret(!showSecret)}>
                            {showSecret ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
                         </Button>
                      </div>

                      <div className="p-8 bg-card/80 border border-border rounded-3xl relative overflow-hidden">
                         <div className={cn("grid grid-cols-2 gap-4 transition-all duration-500", !showSecret && "blur-xl opacity-20")}>
                            {['NX82-Y92K', 'L2P0-M10V', 'K7W3-R49X', 'Q5Z9-B12H', 'T8N1-P63L', 'D4G7-V82M'].map((code, i) => <div key={i} className="p-4 bg-muted/50 border border-border rounded-2xl font-mono text-xs text-foreground text-center">{code}</div>)}
                         </div>
                         {!showSecret && <div className="absolute inset-0 flex items-center justify-center">
                               <Lock className="w-12 h-12 text-slate-700" />
                            </div>}
                      </div>

                      <div className="flex gap-4">
                         <Button className="flex-1 h-14 bg-muted/50 hover:bg-muted/50 text-foreground border border-border rounded-2xl font-bold text-[10px] transition-all">{t("admin.security.download_keys")}</Button>
                         <Button variant="ghost" className="flex-1 h-14 border border-border text-muted-foreground hover:text-foreground rounded-2xl font-bold text-[10px] transition-all">{t("admin.security.regenerate_all")}</Button>
                      </div>
                   </div>
                </Card>
             </div>
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}