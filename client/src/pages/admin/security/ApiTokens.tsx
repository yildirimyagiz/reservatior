import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Plus, Search, Key, Eye, Edit, Trash2, Copy, Shield, RefreshCw, AlertTriangle, Zap, Activity, Clock, Lock } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { cn } from "@/lib/utils";
interface ApiToken {
  id: string;
  name: string;
  description?: string;
  tokenPrefix: string;
  scopes: string[];
  lastUsedAt?: string;
  expiresAt?: string;
  isActive: boolean;
  createdAt: string;
  user?: {
    name: string;
    email: string;
  };
  usageStats?: {
    totalRequests: number;
    averageRequestsPerDay: number;
  };
}
export default function ApiTokens() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [loading, setLoading] = useState(true);
  const [tokens, setTokens] = useState<ApiToken[]>([]);
  useEffect(() => {
    fetchData();
  }, []);
  const fetchData = async () => {
    try {
      setLoading(true);
      const response = await apiClient.get('/api-tokens', {
        include: "user,usageStats"
      });
      setTokens((response as any).data || []);
    } catch (error) {
      toast({
        title: t("admin.security.sync_failed"),
        description: t("admin.security.credential_database_unreachable"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getStatusStyle = (token: ApiToken) => {
    if (!token.isActive) return "bg-slate-500/10 text-muted-foreground border-border";
    if (token.expiresAt && new Date(token.expiresAt) < new Date()) return "bg-rose-500/10 text-rose-400 border-rose-500/20";
    return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
  };
  const filteredTokens = tokens.filter(t => t.name.toLowerCase().includes(searchTerm.toLowerCase()));
  return <PageShell title={t("admin.security.credential_matrix")} description={t("admin.security.programmatic_entry_points_and")}>
      <div className="space-y-10 pb-20">
        
        {/* KPI GRID */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
           {[{
          label: t("admin.security.active_keys"),
          val: tokens.filter(t => t.isActive).length,
          icon: Key,
          color: "text-emerald-400"
        }, {
          label: t("admin.security.monthly_pulse"),
          val: tokens.reduce((acc, t) => acc + (t.usageStats?.totalRequests || 0), 0).toLocaleString(),
          icon: Activity,
          color: "text-blue-400"
        }, {
          label: t("admin.security.expired_nodes"),
          val: tokens.filter(t => t.expiresAt && new Date(t.expiresAt) < new Date()).length,
          icon: AlertTriangle,
          color: "text-rose-500"
        }, {
          label: t("admin.security.security_level"),
          val: "Elite",
          icon: Shield,
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

        {/* INTERFACE ACTIONS */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
           <div className="relative flex-1 max-w-md group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-blue-500 transition-colors" />
              <Input placeholder={t("admin.security.search_credential_string")} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-blue-500/20 transition-all font-medium" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
           </div>
           <Button className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-[10px] gap-2 shadow-xl shadow-blue-600/20">
              <Plus className="w-4 h-4" />{t("admin.security.generate_new_key")}</Button>
        </div>

        {/* TACTICAL TABLE */}
        <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
           <CardContent className="p-0">
              <Table>
                 <TableHeader className="bg-muted/50 border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                       <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin.security.key_identity")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.origin")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.permissions")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.security.state")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin.security.interrogate")}</TableHead>
                    </TableRow>
                 </TableHeader>
                 <TableBody>
                    {loading ? <TableRow>
                          <TableCell colSpan={5} className="py-20 text-center">
                             <Activity className="w-8 h-8 text-blue-500 animate-spin mx-auto mb-4 opacity-50" />
                             <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t("admin.security.syncing_credential_matrix")}</p>
                          </TableCell>
                       </TableRow> : filteredTokens.map(token => <TableRow key={token.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                           <TableCell className="py-8 px-8">
                              <div className="flex items-center gap-6">
                                 <div className="p-3 bg-card border border-border rounded-2xl group-hover:rotate-12 transition-all">
                                    <Key className="w-5 h-5 text-blue-400" />
                                 </div>
                                 <div className="space-y-1">
                                    <h4 className="text-sm font-bold text-foreground leading-none">{token.name}</h4>
                                    <p className="text-[10px] font-mono text-muted-foreground">{token.tokenPrefix}•••••••••</p>
                                 </div>
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <div className="text-xs font-bold text-muted-foreground">{token.user?.name}</div>
                              <div className="text-[9px] font-bold text-muted-foreground leading-none mt-1">{token.user?.email}</div>
                           </TableCell>
                           <TableCell className="px-8">
                              <div className="flex flex-wrap gap-1">
                                 {token.scopes.map(s => <Badge key={s} variant="outline" className="text-[8px] font-bold border-border text-muted-foreground px-2 py-0.5">
                                       {s}
                                    </Badge>)}
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <Badge className={cn("text-[9px] font-bold   px-3 py-1  border-none shadow-lg", getStatusStyle(token))}>
                                 {token.isActive ? token.expiresAt && new Date(token.expiresAt) < new Date() ? 'EXPIRED' : 'ACTIVE' : 'REVOKED'}
                              </Badge>
                           </TableCell>
                           <TableCell className="px-8 text-right text-nowrap">
                              <div className="flex justify-end gap-2">
                                 <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground" title={t("admin.security.copy_handshake")}>
                                    <Copy className="w-5 h-5" />
                                 </Button>
                                 <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground">
                                    <Eye className="w-5 h-5" />
                                 </Button>
                                 <DropdownMenu>
                                    <DropdownMenuTrigger asChild>
                                       <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground">
                                          <MoreHorizontal className="w-5 h-5" />
                                       </Button>
                                    </DropdownMenuTrigger>
                                    <DropdownMenuContent align="end" className="bg-[#14151a] border-border rounded-2xl p-2 min-w-[160px]">
                                       <DropdownMenuItem className="rounded-xl px-4 py-2 font-bold text-[10px] text-muted-foreground hover:text-foreground cursor-pointer gap-3">
                                          <RefreshCw className="w-3 h-3" />{t("admin.security.rotate_key")}</DropdownMenuItem>
                                       <DropdownMenuItem className="rounded-xl px-4 py-2 font-bold text-[10px] text-rose-500 hover:text-rose-400 cursor-pointer gap-3">
                                          <Trash2 className="w-3 h-3" />{t("admin.security.revoke_access")}</DropdownMenuItem>
                                    </DropdownMenuContent>
                                 </DropdownMenu>
                              </div>
                           </TableCell>
                        </TableRow>)}
                 </TableBody>
              </Table>
           </CardContent>
        </Card>
      </div>
    </PageShell>;
}