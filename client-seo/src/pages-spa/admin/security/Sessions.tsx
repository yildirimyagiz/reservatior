"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, Monitor, Shield, Activity, LogOut, Trash2, Eye, Globe, Smartphone, Tablet, Clock, AlertTriangle, Zap, Server } from"lucide-react";
import { Input } from"@/components/ui/input";
import { useToast } from"@/hooks/use-toast";
import { useQuery } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { cn } from"@/lib/utils";

interface Session {
 id: string;
 userId: string;
 userAgent?: string;
 ipAddress?: string;
 deviceType?: string;
 isActive: boolean;
 lastActivityAt: string;
 expiresAt: string;
 user?: { name: string; email: string; role: string };
 securityFlags?: { suspiciousActivity: boolean };
}
export default function Sessions() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const [searchTerm, setSearchTerm] = useState("");
 const { data: sessions = [], isLoading } = useQuery({
 queryKey: ['sessions'],
 queryFn: async () => {
 const response = await apiClient.get('/sessions', { page:"1", limit:"50" });
 return (response as any).data || [];
 }
 });
 const getStatusStyle = (session: Session) => {
 if (!session.isActive) return"bg-rose-500/10 text-rose-400 border-rose-500/20";
 return"bg-blue-500/10 text-success border-blue-500/20";
 };
 const filteredSessions = sessions.filter((s: { user: { name: string; }; ipAddress: string | string[]; }) => s.user?.name?.toLowerCase().includes(searchTerm.toLowerCase()) || s.ipAddress?.includes(searchTerm));
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_security_neural_session_monitor")}</h1>
 <p className="text-sm text-muted-foreground">{t("admin_security_active_handshake_surveillance_and")}</p>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 {[{ label: t("admin_security_total_handshakes"), val: sessions.length, icon: Monitor, color:"text-muted-foreground" },
 { label: t("admin_security_active_links"), val: sessions.filter((s: { isActive: any; }) => s.isActive).length, icon: Activity, color:"text-success" },
 { label: t("admin_security_suspicious"), val: sessions.filter((s: { securityFlags: { suspiciousActivity: any; }; }) => s.securityFlags?.suspiciousActivity).length, icon: AlertTriangle, color:"text-rose-500" },
 { label: t("admin_security_system_load"), val:"Optimal", icon: Server, color:"text-muted-foreground" }
 ].map((stat, i) => <Card key={i} className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
 <stat.icon className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{stat.label}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{stat.val}</h3>
 </CardContent>
 </Card>)}
 </div>

 <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
 <div className="relative flex-1 max-w-md group">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-muted-foreground transition-colors" />
 <Input placeholder={t("admin_security_search_link_logs")} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-slate-500/20 transition-all font-medium" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
 </div>
 </div>

 <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin_security_entity_signature")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_node_context")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_temporal_state")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_link_status")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin_security_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? <TableRow>
 <TableCell colSpan={5} className="py-20 text-center">
 <Zap className="w-8 h-8 text-muted-foreground animate-pulse mx-auto mb-4 opacity-50" />
 <p className="text-xs font-bold text-muted-foreground">{t("admin_security_syncing_connection_matrix")}</p>
 </TableCell>
 </TableRow> : filteredSessions.map((session: any) => <TableRow key={session.id} className="border-b border-border hover:bg-card transition-all group">
 <TableCell className="py-8 px-8">
 <div className="flex items-center gap-6">
 <div className="p-3 bg-card border border-border rounded-2xl group-hover:scale-105 transition-all">
 <Shield className={cn("w-5 h-5", session.isActive ?"text-success" :"text-muted-foreground")} />
 </div>
 <div>
 <h6 className="text-sm font-bold text-foreground leading-none">{session.user?.name ||"ANONYMOUS_ENTITY"}</h6>
 <p className="text-[10px] font-bold text-muted-foreground mt-1">{session.user?.role}</p>
 </div>
 </div>
 </TableCell>
 <TableCell className="px-8">
 <div className="space-y-1">
 <p className="text-[10px] font-bold text-muted-foreground leading-none flex items-center gap-1"><Monitor className="w-3 h-3" /> {session.deviceType ||"UNKNOWN_HARDWARE"}</p>
 <p className="text-[9px] font-bold text-muted-foreground mt-1 flex items-center gap-1"><Globe className="w-3 h-3" /> {session.ipAddress}</p>
 </div>
 </TableCell>
 <TableCell className="px-8">
 <div className="space-y-1">
 <p className="text-[10px] font-bold text-muted-foreground">{t("admin_security_last_sync")}{new Date(session.lastActivityAt).toLocaleTimeString()}</p>
 <p className="text-[9px] font-bold text-muted-foreground">{t("admin_security_expires")}{new Date(session.expiresAt).toLocaleDateString()}</p>
 </div>
 </TableCell>
 <TableCell className="px-8">
 <Badge className={cn("text-[9px] font-bold px-2", getStatusStyle(session))}>
 {session.isActive ?"ESTABLISHED" :"TERMINATED"}
 </Badge>
 </TableCell>
 <TableCell className="px-8 text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-card text-muted-foreground hover:text-foreground" aria-label={t("common.more")}><MoreHorizontal className="w-5 h-5" /></Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent className="bg-card border-border text-muted-foreground">
 <DropdownMenuItem className="gap-2 font-bold text-[9px] hover:bg-card cursor-pointer"><Eye className="w-3.5 h-3.5" />{t("admin_security_node_details")}</DropdownMenuItem>
 {session.isActive && <DropdownMenuItem className="gap-2 font-bold text-[9px] hover:bg-rose-500/10 text-rose-500 cursor-pointer"><LogOut className="w-3.5 h-3.5" />{t("admin_security_terminate_link")}</DropdownMenuItem>}
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </div>
 </div>;
}
