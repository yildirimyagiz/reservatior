import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, Monitor, Shield, Activity, LogOut, Trash2, Eye, Globe, Smartphone, Tablet, Clock, AlertTriangle, Zap, Server } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { cn } from "@/lib/utils";
interface Session {
  id: string;
  userId: string;
  userAgent?: string;
  ipAddress?: string;
  deviceType?: string;
  isActive: boolean;
  lastActivityAt: string;
  expiresAt: string;
  user?: {
    name: string;
    email: string;
    role: string;
  };
  securityFlags?: {
    suspiciousActivity: boolean;
  };
}
export default function Sessions() {
  const {
    t
  } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [sessions, setSessions] = useState<Session[]>([]);
  const [loading, setLoading] = useState(true);
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchSessions();
  }, []);
  const fetchSessions = async () => {
    try {
      setLoading(true);
      const response = await apiClient.get('/sessions', {
        page: "1",
        limit: "50"
      });
      setSessions((response as any).data || []);
    } catch (error) {
      toast({
        title: t("admin.security.sync_failed"),
        description: t("admin.security.connection_matrix_unreachable"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getStatusStyle = (session: Session) => {
    if (!session.isActive) return "bg-rose-500/10 text-rose-400 border-rose-500/20";
    return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
  };
  const filteredSessions = sessions.filter(s => s.user?.name?.toLowerCase().includes(searchTerm.toLowerCase()) || s.ipAddress?.includes(searchTerm));
  return <PageShell title={t("admin.security.neural_session_monitor")} description={t("admin.security.active_handshake_surveillance_and")}>
      <div className="space-y-10 pb-20">
        
        {/* KPI NEURAL GRID */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
           {[{
          label: t("admin.security.total_handshakes"),
          val: sessions.length,
          icon: Monitor,
          color: "text-blue-400"
        }, {
          label: t("admin.security.active_links"),
          val: sessions.filter(s => s.isActive).length,
          icon: Activity,
          color: "text-emerald-400"
        }, {
          label: t("admin.security.suspicious"),
          val: sessions.filter(s => s.securityFlags?.suspiciousActivity).length,
          icon: AlertTriangle,
          color: "text-rose-500"
        }, {
          label: t("admin.security.system_load"),
          val: "Optimal",
          icon: Server,
          color: "text-purple-400"
        }].map((stat, i) => <Card key={i} className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
                <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                   <stat.icon className="w-12 h-12" />
                </div>
                <CardContent className="p-8">
                  <p className="text-[10px] font-bold text-muted-foreground mb-1">{stat.label}</p>
                  <h3 className="text-xl font-bold text-foreground leading-none">{stat.val}</h3>
                </CardContent>
             </Card>)}
        </div>

        {/* TACTICAL FILTERS */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
           <div className="relative flex-1 max-w-md group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-blue-500 transition-colors" />
              <Input placeholder={t("admin.security.search_link_logs")} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-blue-500/20 transition-all font-medium" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
           </div>
           <Button variant="outline" className="h-14 px-8 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground font-bold text-[10px] gap-2" onClick={fetchSessions}>
              <Activity className="w-4 h-4" />{t("admin.security.resync_monitor")}</Button>
        </div>

        {/* DATA TABLE */}
        <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
           <CardContent className="p-0">
              <Table>
                 <TableHeader className="bg-muted/50 border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                       <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin.security.entity_signature")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.node_context")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.temporal_state")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.link_status")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin.security.actions")}</TableHead>
                    </TableRow>
                 </TableHeader>
                 <TableBody>
                    {loading ? <TableRow>
                          <TableCell colSpan={5} className="py-20 text-center">
                             <Zap className="w-8 h-8 text-blue-500 animate-pulse mx-auto mb-4 opacity-50" />
                             <p className="text-xs font-bold text-muted-foreground">{t("admin.security.syncing_connection_matrix")}</p>
                          </TableCell>
                       </TableRow> : filteredSessions.map(session => <TableRow key={session.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                           <TableCell className="py-8 px-8">
                              <div className="flex items-center gap-6">
                                 <div className="p-3 bg-card border border-border rounded-2xl group-hover:scale-105 transition-all">
                                    <Shield className={cn("w-5 h-5", session.isActive ? "text-emerald-400" : "text-slate-600")} />
                                 </div>
                                 <div>
                                    <h6 className="text-sm font-bold text-foreground leading-none">{session.user?.name || "ANONYMOUS_ENTITY"}</h6>
                                    <p className="text-[10px] font-bold text-muted-foreground mt-1">{session.user?.role}</p>
                                 </div>
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <div className="space-y-1">
                                 <p className="text-[10px] font-bold text-blue-400 leading-none flex items-center gap-1"><Monitor className="w-3 h-3" /> {session.deviceType || "UNKNOWN_HARDWARE"}</p>
                                 <p className="text-[9px] font-bold text-slate-600 mt-1 flex items-center gap-1"><Globe className="w-3 h-3" /> {session.ipAddress}</p>
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <div className="space-y-1">
                                 <p className="text-[10px] font-bold text-muted-foreground">{t("admin.security.last_sync")}{new Date(session.lastActivityAt).toLocaleTimeString()}</p>
                                 <p className="text-[9px] font-bold text-slate-600">{t("admin.security.expires")}{new Date(session.expiresAt).toLocaleDateString()}</p>
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <Badge className={cn("text-[9px] font-bold   px-2", getStatusStyle(session))}>
                                 {session.isActive ? "ESTABLISHED" : "TERMINATED"}
                              </Badge>
                           </TableCell>
                           <TableCell className="px-8 text-right">
                              <DropdownMenu>
                                 <DropdownMenuTrigger asChild>
                                    <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground"><MoreHorizontal className="w-5 h-5" /></Button>
                                 </DropdownMenuTrigger>
                                 <DropdownMenuContent className="bg-[#1a1b1e] border-border text-muted-foreground">
                                    <DropdownMenuItem className="gap-2 font-bold text-[9px] hover:bg-muted/50 cursor-pointer"><Eye className="w-3.5 h-3.5" />{t("admin.security.node_details")}</DropdownMenuItem>
                                    {session.isActive && <DropdownMenuItem className="gap-2 font-bold text-[9px] hover:bg-rose-500/10 text-rose-500 cursor-pointer"><LogOut className="w-3.5 h-3.5" />{t("admin.security.terminate_link")}</DropdownMenuItem>}
                                 </DropdownMenuContent>
                              </DropdownMenu>
                           </TableCell>
                        </TableRow>)}
                 </TableBody>
              </Table>
           </CardContent>
        </Card>
      </div>
    </PageShell>;
}