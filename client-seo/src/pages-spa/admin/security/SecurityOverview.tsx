"use client";

import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { ShieldAlert, Lock, Key, AlertTriangle, ArrowRight, TrendingUp, Fingerprint, Zap, Activity, ShieldCheck, Eye } from"lucide-react";
import { XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, AreaChart, Area } from"recharts";
const data = [{
 name:"Mon",
 attacks: 12,
 logins: 400
}, {
 name:"Tue",
 attacks: 19,
 logins: 300
}, {
 name:"Wed",
 attacks: 3,
 logins: 200
}, {
 name:"Thu",
 attacks: 5,
 logins: 278
}, {
 name:"Fri",
 attacks: 2,
 logins: 189
}, {
 name:"Sat",
 attacks: 8,
 logins: 239
}, {
 name:"Sun",
 attacks: 9,
 logins: 349
}];
export default function SecurityOverview() {
 const { t } = useTranslation();
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_security_security_matrix_overview")}</h1>
 <p className="text-sm text-muted-foreground">{t("admin_security_monitor_neural_handshake_stability")}</p>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-emerald-500/30 border-l-2">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
 <Lock className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_security_mfa_adoption_dna")}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">68%</h3>
 <p className="text-[10px] font-bold text-emerald-400 mt-4 flex items-center gap-1">
 <TrendingUp className="w-3 h-3" />{t("admin_security_5_vs_last_cycle")}</p>
 <div className="mt-4 h-1.5 w-full bg-card rounded-full overflow-hidden">
 <div className="h-full bg-emerald-600 rounded-full" style={{ width:"68%" }}></div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
 <Fingerprint className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_security_biometric_sync")}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">42%</h3>
 <p className="text-[10px] font-bold text-muted-foreground mt-4 flex items-center gap-1">{t("admin_security_mobile_entity_links")}</p>
 <div className="mt-4 h-1.5 w-full bg-card rounded-full overflow-hidden">
 <div className="h-full bg-slate-600 rounded-full" style={{ width:"42%" }}></div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-rose-500/30 border-l-2">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-rose-500">
 <ShieldAlert className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_security_active_anomalies")}</p>
 <h3 className="text-xl font-bold text-rose-500 leading-none">{t("client.pricing.tiers.enterprise.2", "2")}</h3>
 <div className="mt-4 flex gap-2">
 <Badge className="bg-rose-500/20 text-rose-400 border-none text-[8px] font-bold">{t("admin_security_high_risk_detected")}</Badge>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
 <AlertTriangle className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_security_auth_failures_24h")}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">124</h3>
 <p className="text-[10px] font-bold text-orange-400 mt-4 flex items-center gap-1">
 <TrendingUp className="w-3 h-3" />{t("admin_security_12_velocity_increase")}</p>
 </CardContent>
 </Card>
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
 <Card className="lg:col-span-8 bg-card backdrop-blur-xl border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
 <CardHeader className="p-8 border-b border-border">
 <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
 <Activity className="w-4 h-4 text-slate-500" />{t("admin_security_neural_handshake_velocity")}</CardTitle>
 </CardHeader>
 <CardContent className="p-8 h-[400px]">
 <ResponsiveContainer width="100%" height={300} minWidth={0}>
 <AreaChart data={data}>
 <defs>
 <linearGradient id="colorLogins" x1="0" y1="0" x2="0" y2="1">
 <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.2} />
 <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
 </linearGradient>
 <linearGradient id="colorAttacks" x1="0" y1="0" x2="0" y2="1">
 <stop offset="5%" stopColor="#ef4444" stopOpacity={0.2} />
 <stop offset="95%" stopColor="#ef4444" stopOpacity={0} />
 </linearGradient>
 </defs>
 <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.05)" />
 <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{ fill: 'rgba(255,255,255,0.3)', fontSize: 10, fontWeight: 'bold' }} />
 <YAxis axisLine={false} tickLine={false} tick={{ fill: 'rgba(255,255,255,0.3)', fontSize: 10, fontWeight: 'bold' }} />
 <Tooltip contentStyle={{ backgroundColor: '#14151a', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '12px' }} itemStyle={{ fontSize: '10px', fontWeight: '900' }} />
 <Area type="monotone" dataKey="logins" stroke="#3b82f6" strokeWidth={3} fillOpacity={1} fill="url(#colorLogins)" />
 <Area type="monotone" dataKey="attacks" stroke="#ef4444" strokeWidth={3} fillOpacity={1} fill="url(#colorAttacks)" />
 </AreaChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>

 <Card className="lg:col-span-4 bg-card backdrop-blur-xl border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t">
 <CardHeader className="p-8 border-b border-border">
 <CardTitle className="text-xs font-bold text-rose-500 flex items-center gap-2">
 <ShieldAlert className="w-4 h-4" />{t("admin_security_priority_anomalies")}</CardTitle>
 </CardHeader>
 <CardContent className="p-6 space-y-4">
 <div className="p-6 rounded-3xl bg-rose-500/5 border border-rose-500/10 flex items-start gap-4 hover:bg-rose-500/10 transition-all cursor-pointer group">
 <div className="p-3 bg-card border border-rose-500/20 rounded-2xl group-hover:scale-110 transition-all">
 <ShieldAlert className="w-5 h-5 text-rose-500" />
 </div>
 <div className="flex-1">
 <p className="text-[10px] font-bold text-foreground tracking-tight">{t("admin_security_bruteforce_blocked")}</p>
 <p className="text-[10px] text-muted-foreground font-bold mt-1">{t("admin_security_ip_1852241102_15m_ago")}</p>
 </div>
 <Button variant="ghost" size="sm" className="h-8 w-8 rounded-xl hover:bg-card text-muted-foreground hover:text-foreground"><Eye className="w-4 h-4" /></Button>
 </div>

 <div className="p-6 rounded-3xl bg-orange-500/5 border border-orange-500/10 flex items-start gap-4 hover:bg-orange-500/10 transition-all cursor-pointer group">
 <div className="p-3 bg-card border border-orange-500/20 rounded-2xl group-hover:scale-110 transition-all">
 <AlertTriangle className="w-5 h-5 text-orange-400" />
 </div>
 <div className="flex-1">
 <p className="text-[10px] font-bold text-foreground tracking-tight">{t("admin_security_multiple_mfa_fails")}</p>
 <p className="text-[10px] text-muted-foreground font-bold mt-1">{t("admin_security_user_adminpropos_2h_ago")}</p>
 </div>
 <Button variant="ghost" size="sm" className="h-8 w-8 rounded-xl hover:bg-card text-muted-foreground hover:text-foreground"><Eye className="w-4 h-4" /></Button>
 </div>

 <div className="p-6 rounded-3xl bg-card border border-border flex items-start gap-4 hover:bg-slate-100 dark:hover:bg-white/10 transition-all cursor-pointer group">
 <div className="p-3 bg-card border border-border rounded-2xl group-hover:scale-110 transition-all">
 <Key className="w-5 h-5 text-muted-foreground" />
 </div>
 <div className="flex-1">
 <p className="text-[10px] font-bold text-foreground tracking-tight">{t("admin_security_token_handshake_revealed")}</p>
 <p className="text-[10px] text-muted-foreground font-bold mt-1">{t("admin_security_system_log_5h_ago")}</p>
 </div>
 <Button variant="ghost" size="sm" className="h-8 w-8 rounded-xl hover:bg-card text-muted-foreground hover:text-foreground"><Eye className="w-4 h-4" /></Button>
 </div>

 <Button variant="outline" className="w-full mt-4 h-14 rounded-2xl border-border bg-card hover:bg-slate-100 dark:hover:bg-white/10 text-muted-foreground hover:text-foreground font-bold text-[10px] gap-2">{t("admin_security_synchronize_security_logs")}<ArrowRight className="w-4 h-4" />
 </Button>
 </CardContent>
 </Card>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card className="bg-card border-border rounded-3xl p-8 hover:bg-slate-100 dark:hover:bg-white/10 transition-all cursor-pointer group">
 <div className="flex items-center gap-6">
 <div className="p-4 bg-slate-600/10 border border-slate-500/20 rounded-2xl group-hover:scale-110 transition-all">
 <ShieldCheck className="w-8 h-8 text-muted-foreground" />
 </div>
 <div>
 <h4 className="text-sm font-bold text-foreground">{t("admin_security_protocol_audit")}</h4>
 <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin_security_deep_neural_scan_of")}</p>
 </div>
 </div>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-8 hover:bg-slate-100 dark:hover:bg-white/10 transition-all cursor-pointer group">
 <div className="flex items-center gap-6">
 <div className="p-4 bg-slate-600/10 border border-slate-500/20 rounded-2xl group-hover:scale-110 transition-all">
 <Zap className="w-8 h-8 text-muted-foreground" />
 </div>
 <div>
 <h4 className="text-sm font-bold text-foreground">{t("admin_security_key_rotation")}</h4>
 <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin_security_symmetric_encryption_update")}</p>
 </div>
 </div>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-8 hover:bg-slate-100 dark:hover:bg-white/10 transition-all cursor-pointer group">
 <div className="flex items-center gap-6">
 <div className="p-4 bg-orange-600/10 border border-orange-500/20 rounded-2xl group-hover:scale-110 transition-all">
 <Activity className="w-8 h-8 text-orange-400" />
 </div>
 <div>
 <h4 className="text-sm font-bold text-foreground">{t("admin_security_health_snapshot")}</h4>
 <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin_security_generate_system_pulse_report")}</p>
 </div>
 </div>
 </Card>
 </div>
 </div>
 </div>;
}
