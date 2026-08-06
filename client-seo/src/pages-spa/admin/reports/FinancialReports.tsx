"use client";

import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { BarChart3, Download, TrendingUp, DollarSign, PieChart, ArrowUpRight, ArrowDownRight, FileText, Activity, Zap, Globe, MoreHorizontal, ChevronRight } from"lucide-react";
import { cn } from"@/lib/utils";
export default function FinancialReports() {
 const { t } = useTranslation();
 const stats = [
 { title: t("admin_reports_total_revenue_dna"), value:"$452,000", change:"+12.5%", trend:"up", icon: DollarSign, color:"text-success" },
 { title: t("admin_reports_entity_subsystems"), value:"2,450", change:"+4.3%", trend:"up", icon: Zap, color:"text-muted-foreground" },
 { title: t("admin_reports_payout_queue"), value:"$12,400", change:"-2.1%", trend:"down", icon: Activity, color:"text-warning" },
 { title: t("admin_reports_system_net_margin"), value:"$84,200", change:"+8.7%", trend:"up", icon: PieChart, color:"text-muted-foreground" }
 ];
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_reports_financial_neural_matrix")}</h1>
 <p className="text-sm text-muted-foreground">{t("admin_reports_systemwide_revenue_stream_analysis")}</p>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 {stats.map((stat, i) => <Card key={i} className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-2 border-l-transparent hover:border-l-slate-500/50 transition-all">
 <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
 <stat.icon className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{stat.title}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{stat.value}</h3>
 <div className="mt-4 flex items-center gap-2">
 <Badge className={cn("text-[9px] font-bold px-2 py-0.5 border-none", stat.trend ==="up" ?"bg-blue-500/10 text-success" :"bg-rose-500/10 text-rose-400")}>
 {stat.trend ==="up" ? <ArrowUpRight className="w-3 h-3 mr-1" /> : <ArrowDownRight className="w-3 h-3 mr-1" />}
 {stat.change}
 </Badge>
 <span className="text-[9px] font-bold text-muted-foreground">{t("admin_reports_vs_last_cycle")}</span>
 </div>
 </CardContent>
 </Card>)}
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
 <Card className="lg:col-span-8 bg-card backdrop-blur-xl border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative group">
 <CardHeader className="p-8 border-b border-border flex flex-row items-center justify-between">
 <div>
 <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
 <Activity className="w-4 h-4 text-muted-foreground" />{t("admin_reports_fiscal_handshake_velocity")}</CardTitle>
 <CardDescription className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin_reports_crosscluster_revenue_performance_metrics")}</CardDescription>
 </div>
 <Button variant="ghost" className="h-10 rounded-xl hover:bg-card text-muted-foreground font-bold text-[9px] gap-2">{t("admin_reports_synchronize_matrix")}<Download className="w-3.5 h-3.5" />
 </Button>
 </CardHeader>
 <CardContent className="p-12 h-[400px] flex items-center justify-center">
 <div className="text-center group-hover:scale-110 transition-all duration-700">
 <BarChart3 className="w-20 h-20 text-muted-foreground mx-auto mb-6 opacity-20" />
 <p className="text-[10px] font-bold text-muted-foreground tracking-[0.3em] animate-pulse">{t("admin_reports_neural_visualization_hub_offline")}</p>
 <p className="text-[9px] font-bold text-muted-foreground mt-2">{t("admin_reports_connecting_to_data_node")}</p>
 </div>
 </CardContent>
 </Card>

 <Card className="lg:col-span-4 bg-card backdrop-blur-xl border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t">
 <CardHeader className="p-8 border-b border-border">
 <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
 <Globe className="w-4 h-4 text-muted-foreground" />{t("admin_reports_revenue_verticals")}</CardTitle>
 </CardHeader>
 <CardContent className="p-8 space-y-8">
 {[{ name: t("admin_reports_entity_agencies","Varlık Acenteleri"), value:"$280k", pct: 62, color:"bg-muted0 shadow-slate-500/40" },
 { name: t("admin_reports_premium_nodes","Premium Düğümler"), value:"$94k", pct: 21, color:"bg-muted0 shadow-slate-500/40" },
 { name: t("admin_reports_api_stream_access","API Akış Erişimi"), value:"$52k", pct: 12, color:"bg-blue-500 shadow-blue-500/40" },
 { name: t("admin_reports_protocol_fees","Protokol Ücretleri"), value:"$26k", pct: 5, color:"bg-orange-500 shadow-orange-500/40" }
 ].map((item, i) => <div key={i} className="space-y-3">
 <div className="flex justify-between items-end">
 <span className="text-[10px] font-bold text-foreground tracking-tight">{item.name}</span>
 <span className="text-[10px] font-bold text-muted-foreground">{item.value}</span>
 </div>
 <div className="h-1.5 w-full bg-card rounded-full overflow-hidden">
 <div className={cn("h-full rounded-full transition-all duration-1000 shadow-[0_0_10px]", item.color)} style={{ width: `${item.pct}%` }} />
 </div>
 </div>)}
 <div className="pt-8 border-t border-border mt-auto">
 <div className="p-6 bg-card rounded-3xl border border-border group hover:bg-muted dark:hover:bg-card/10 transition-all cursor-pointer relative">
 <p className="text-[9px] font-bold text-muted-foreground mb-1">{t("admin_reports_projection_buffer")}</p>
 <p className="text-xl font-bold text-foreground whitespace-pre leading-none">{t("admin_reports_positive_cycle_forecast")}</p>
 <ArrowUpRight className="w-6 h-6 text-success absolute bottom-6 right-6 group-hover:translate-x-1 group-hover:-translate-y-1 transition-all" />
 </div>
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
 <CardHeader className="p-8 border-b border-border flex flex-row items-center justify-between">
 <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
 <FileText className="w-4 h-4 text-success" />{t("admin_reports_fiscal_audit_trail")}</CardTitle>
 <Button variant="ghost" className="h-10 px-4 rounded-xl hover:bg-card text-muted-foreground font-bold text-[9px] gap-2">{t("admin_reports_view_global_ledger")}<ChevronRight className="w-4 h-4" />
 </Button>
 </CardHeader>
 <CardContent className="p-0">
 <div className="overflow-x-auto">
 <table className="w-full text-left">
 <thead className="bg-card border-b border-border">
 <tr className="border-none hover:bg-transparent">
 <th className="py-6 px-8 text-[10px] font-bold text-muted-foreground">{t("admin_reports_temporal_hash")}</th>
 <th className="py-6 px-8 text-[10px] font-bold text-muted-foreground">{t("admin_reports_entity_origin")}</th>
 <th className="py-6 px-8 text-[10px] font-bold text-muted-foreground">{t("admin_reports_sync_date")}</th>
 <th className="py-6 px-8 text-[10px] font-bold text-muted-foreground">{t("admin_reports_type_class")}</th>
 <th className="py-6 px-8 text-[10px] font-bold text-muted-foreground text-right">{t("admin_reports_creditdebit")}</th>
 <th className="py-6 px-8 text-[10px] font-bold text-muted-foreground text-right">{t("admin_reports_node_state")}</th>
 </tr>
 </thead>
 <tbody className="divide-y divide-white/5">
 {[1, 2, 3, 4, 5, 6].map((_, i) => <tr key={i} className="group hover:bg-card transition-all">
 <td className="py-8 px-8 font-mono text-[10px] font-bold text-muted-foreground">{t("admin_reports_trx9482")}{i}{t("admin_reports_xls")}</td>
 <td className="py-8 px-8">
 <p className="text-sm font-bold text-foreground leading-none">{t("admin_reports_neural_realty_systems")}{i + 1}</p>
 <p className="text-[9px] font-bold text-muted-foreground mt-1">{t("admin_reports_orgclusterdelta")}</p>
 </td>
 <td className="py-8 px-8 text-[10px] font-bold text-muted-foreground">{t("admin_reports_mar")}{24 - i}, 2026</td>
 <td className="py-8 px-8">
 <Badge variant="outline" className="bg-card border-border text-[9px] font-bold px-2 py-0.5 text-muted-foreground">{t("admin_reports_systemsync")}</Badge>
 </td>
 <td className="py-8 px-8 text-right font-bold text-foreground">$1,250.00</td>
 <td className="py-8 px-8 text-right">
 <Badge className="bg-blue-500/10 text-success border-none font-bold text-[9px] px-2">{t("admin_reports_handshakecomplete")}</Badge>
 </td>
 </tr>)}
 </tbody>
 </table>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>;
}
