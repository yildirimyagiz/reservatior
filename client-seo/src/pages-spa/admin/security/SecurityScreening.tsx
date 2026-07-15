"use client";

import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { useToast } from"@/hooks/use-toast";
import { useQuery } from"@tanstack/react-query";
import { Shield, Eye, ShieldCheck, ShieldAlert, Clock, AlertTriangle, Monitor, Globe, Activity, Zap } from"lucide-react";
import { apiClient } from"@/lib/api/client";
import { cn } from"@/lib/utils";
export default function SecurityScreening() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const { data: screenings = [], isLoading } = useQuery({
 queryKey: ['security-screenings'],
 queryFn: async () => {
 const res = await apiClient.get<any>("/booking-security-screening");
 return Array.isArray(res) ? res : (res as any).data || [];
 }
 });
 const getRiskStyle = (level: string) => {
 switch (level) {
 case 'HIGH': return"bg-rose-500/10 text-rose-400 border-rose-500/20";
 case 'MEDIUM': return"bg-orange-500/10 text-orange-400 border-orange-500/20";
 case 'LOW': return"bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
 default: return"bg-muted0/10 text-muted-foreground border-slate-500/20";
 }
 };
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_security_fraud_assessment_hub")}</h1>
 <p className="text-sm text-muted-foreground">{t("admin_security_realtime_behavioral_analysis_and")}</p>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 {[{ label: t("admin_security_total_screened"), val: screenings.length, icon: Shield, color:"text-muted-foreground" },
 { label: t("admin_security_critical_flags"), val: screenings.filter((s: any) => s.riskLevel === 'HIGH').length, icon: ShieldAlert, color:"text-rose-500" },
 { label: t("admin_security_manual_reviews"), val: screenings.filter((s: any) => s.manualReviewRequired).length, icon: Clock, color:"text-orange-400" },
 { label: t("admin_security_safe_entities"), val: screenings.filter((s: any) => s.riskLevel === 'LOW').length, icon: ShieldCheck, color:"text-emerald-400" }
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

 <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
 <CardHeader className="p-8 border-b border-border flex flex-row items-center justify-between">
 <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
 <Zap className="w-4 h-4 text-orange-500" />{t("admin_security_assessment_queue")}</CardTitle>
 <div className="flex gap-2">
 <Button variant="outline" className="h-10 rounded-xl border-border bg-card hover:bg-white/10 text-muted-foreground hover:text-white font-bold text-[9px] gap-2">
 <Monitor className="w-3.5 h-3.5" />{t("admin_security_behavioral_analysis")}</Button>
 <Button variant="outline" className="h-10 rounded-xl border-border bg-card hover:bg-white/10 text-muted-foreground hover:text-white font-bold text-[9px] gap-2">
 <Globe className="w-3.5 h-3.5" />{t("admin_security_ip_intel")}</Button>
 </div>
 </CardHeader>
 <CardContent className="p-0">
 {isLoading ? <div className="py-24 text-center">
 <Activity className="w-8 h-8 text-orange-500 animate-spin mx-auto mb-4 opacity-50" />
 <p className="text-xs font-bold text-muted-foreground animate-pulse">{t("admin_security_syncing_trust_matrix")}</p>
 </div> : <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin_security_entity_signature")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_asset_context")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_risk_profile")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_neural_score")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin_security_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {screenings.map((s: any) => <TableRow key={s.id} className="border-b border-border hover:bg-card transition-all group">
 <TableCell className="py-8 px-8">
 <div className="font-bold text-muted-foreground text-[9px] mb-2">{s.booking?.id?.slice(0, 8) || 'PRE-BOOKING'}</div>
 <div className="text-sm font-bold text-foreground leading-none">{s.contact?.fullName}</div>
 <div className="text-[10px] font-bold text-muted-foreground mt-1">{s.contact?.email}</div>
 </TableCell>
 <TableCell className="px-8">
 <div className="text-xs font-bold text-muted-foreground">{s.property?.name}</div>
 <div className="text-[10px] font-bold text-slate-600 mt-1">{s.property?.city}</div>
 </TableCell>
 <TableCell className="px-8">
 <Badge className={cn("text-[9px] font-bold px-2", getRiskStyle(s.riskLevel))}>{s.riskLevel}</Badge>
 </TableCell>
 <TableCell className="px-8">
 <div className="flex items-center gap-4">
 <div className="w-24 h-1.5 bg-card rounded-full overflow-hidden">
 <div className={cn("h-full rounded-full transition-all duration-1000", s.riskScore > 0.7 ? 'bg-rose-500' : s.riskScore > 0.4 ? 'bg-orange-500' : 'bg-emerald-500')} style={{ width: `${s.riskScore * 100}%` }} />
 </div>
 <span className="text-xs font-bold text-foreground">{(s.riskScore * 100).toFixed(0)}</span>
 </div>
 </TableCell>
 <TableCell className="px-8 text-right">
 <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-card text-muted-foreground hover:text-white">
 <Eye className="w-5 h-5" />
 </Button>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>}
 </CardContent>
 </Card>
 </div>
 </div>;
}
