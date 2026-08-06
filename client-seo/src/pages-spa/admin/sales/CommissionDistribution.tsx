"use client";

import { useTranslation } from"react-i18next";
import { tEnum } from"@/lib/admin-enums";
import { useState } from"react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Input } from"@/components/ui/input";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { PieChart, Pie, Cell, ResponsiveContainer, Tooltip, Legend, BarChart, Bar, XAxis, YAxis, CartesianGrid } from"recharts";
import { Wallet, TrendingUp, Users, Building, Percent, RefreshCw, Banknote, ArrowRightLeft, Loader2 } from"lucide-react";
import { useQuery } from"@tanstack/react-query";
import { adminNeuralApi, CommissionSummary } from"@/lib/api/admin-neural";

const COMMISSION_TRANSACTIONS = [{
 id:"TRX-8291", deal:"Villa Azura - 14 Days", gross: 12500, platform: 1250, agency:"Luxury Homes Co", agencyCut: 3375, agent:"Sarah J.", agentCut: 7875, status:"PENDING"
}, {
 id:"TRX-8292", deal:"Sunset Apt - 7 Days", gross: 3200, platform: 320, agency:"Coastal Estates", agencyCut: 864, agent:"Mike D.", agentCut: 2016, status:"CLEARED"
}, {
 id:"TRX-8293", deal:"Downtown Loft - 30 Days", gross: 8500, platform: 850, agency:"Urban Living", agencyCut: 2295, agent:"Elena R.", agentCut: 5355, status:"CLEARED"
}, {
 id:"TRX-8294", deal:"Marina Villa - Project Sale", gross: 450000, platform: 9000, agency:"Platinum Real Estate", agencyCut: 22000, agent:"David T.", agentCut: 14000, status:"ESCROW"
}];
const PERFORMANCE_DATA = [{
 month:"Jan", agency: 45000, agent: 120000
}, {
 month:"Feb", agency: 52000, agent: 145000
}, {
 month:"Mar", agency: 48000, agent: 132000
}, {
 month:"Apr", agency: 61000, agent: 168000
}];
export default function CommissionDistribution() {
 const { t } = useTranslation();
 const [filter, setFilter] = useState("all");
 const { data: statsData, isLoading: loading, refetch } = useQuery({
 queryKey: ['commissionSummary'],
 queryFn: async () => {
 const response = await adminNeuralApi.getCommissionSummary();
 return response as any;
 }
 });
 const stats: CommissionSummary | null = statsData || null;
 if (loading) {
 return <div className="min-h-screen bg-background p-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_sales_sales_commission_distribution")}</h1>
 </div>
 <div className="flex h-[400px] items-center justify-center">
 <Loader2 className="h-12 w-12 animate-spin text-primary" />
 </div>
 </div>;
 }
 const splitModel = [{
 name:"Platform", value: stats?.platformShare || 10, color:"#8b5cf6"
 }, {
 name:"Agency", value: stats?.agencyShare || 30, color:"#3b82f6"
 }, {
 name:"Agent", value: stats?.agentShare || 60, color:"#3b82f6"
 }];
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground">{t("admin_sales_sales_commission_distribution")}</h1>
 <p className="text-sm text-muted-foreground mt-1">{t("admin_sales_manage_hierarchical_commission_splits")}</p>
 </div>

 <div className="flex justify-between items-center bg-card p-4 rounded-xl border border-border shadow-sm">
 <div className="flex gap-4 items-center">
 <Select value={filter} onValueChange={setFilter}>
 <SelectTrigger className="w-[180px] bg-card border-border text-foreground">
 <SelectValue placeholder={t("admin_sales_transaction_type")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="all">{t("admin_sales_all_deals")}</SelectItem>
 <SelectItem value="vacation">{t("admin_sales_vacation_rentals")}</SelectItem>
 <SelectItem value="projects">{t("admin_sales_project_sales")}</SelectItem>
 </SelectContent>
 </Select>
 <div className="relative">
 <Input placeholder={t("admin_sales_search_agency_or_agent")} className="w-[300px] bg-card border-border text-foreground placeholder:text-muted-foreground" />
 </div>
 </div>
 <Button variant="outline" className="border-border text-foreground bg-card" onClick={() => refetch()}>
 <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("admin_sales_recalculate_splits")}
 </Button>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
 <Card className="bg-card border-border">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_sales_total_net_earnings")}</CardTitle>
 <TrendingUp className="w-4 h-4 text-success" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-foreground">{t("currency_symbol", "$")}{stats?.totalEarnings?.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_sales_platform_revenue_share")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_sales_pending_payouts")}</CardTitle>
 <Wallet className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-muted-foreground">{t("currency_symbol", "$")}{stats?.pendingPayouts?.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_sales_across_all_entities")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_sales_agency_weight")}</CardTitle>
 <Building className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-muted-foreground">{stats?.agencyShare}%</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_sales_default_platform_rate")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_sales_agent_weight")}</CardTitle>
 <Users className="w-4 h-4 text-success" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-success">{stats?.agentShare}%</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_sales_default_platform_rate")}</p>
 </CardContent>
 </Card>
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
 <Card className="lg:col-span-1 bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2 text-foreground">
 <Percent className="w-5 h-5 text-muted-foreground" />{t("admin_sales_global_split_model")}
 </CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_sales_default_hierarchical_distribution_weight")}</CardDescription>
 </CardHeader>
 <CardContent className="flex flex-col items-center justify-center">
 <div className="h-[250px] w-full">
 <ResponsiveContainer width="100%" height={300} minWidth={0}>
 <PieChart>
 <Pie data={splitModel} cx="50%" cy="50%" innerRadius={60} outerRadius={80} paddingAngle={5} dataKey="value">
 {splitModel.map((entry, index) => <Cell key={`cell-${index}`} fill={entry.color} />)}
 </Pie>
 <Tooltip contentStyle={{ borderRadius: '8px', background: '#1a1b1e', border: '1px solid rgba(255,255,255,0.1)', color: '#fff' }} />
 <Legend wrapperStyle={{ color: '#94a3b8' }} />
 </PieChart>
 </ResponsiveContainer>
 </div>
 </CardContent>
 </Card>

 <Card className="lg:col-span-2 bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2 text-foreground">
 <Banknote className="w-5 h-5 text-success" />{t("admin_sales_payout_trending_agency_vs")}
 </CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_sales_monthly_cleared_commissions_routed")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="h-[250px] w-full">
 <ResponsiveContainer width="100%" height={300} minWidth={0}>
 <BarChart data={stats?.payoutTrends} margin={{ top: 10, right: 10, left: -20, bottom: 0 }}>
 <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.1)" />
 <XAxis dataKey="month" stroke="#64748b" fontSize={12} tickLine={false} axisLine={false} />
 <YAxis stroke="#64748b" fontSize={12} tickLine={false} axisLine={false} tickFormatter={v => `$${v / 1000}k`} />
 <Tooltip cursor={{ fill: '#1a1b1e' }} contentStyle={{ background: '#1a1b1e', border: '1px solid rgba(255,255,255,0.1)', color: '#fff' }} />
 <Legend wrapperStyle={{ color: '#94a3b8' }} />
 <Bar dataKey="amount" name="Total Commissions" fill="#3b82f6" radius={[4, 4, 0, 0]} />
 </BarChart>
 </ResponsiveContainer>
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2 text-foreground">
 <ArrowRightLeft className="w-5 h-5 text-muted-foreground" />{t("admin_sales_recent_deal_splits")}
 </CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_sales_realtime_viewing_of_how")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="rounded-xl border border-border overflow-hidden">
 <Table>
 <TableHeader className="bg-card">
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_sales_deal_info")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_sales_gross_revenue")}</TableHead>
 <TableHead className="bg-red-500/5 text-muted-foreground">{t("admin_sales_tax_deducted")}</TableHead>
 <TableHead className="bg-muted0/5 text-muted-foreground">{t("admin_sales_platform_10")}</TableHead>
 <TableHead className="bg-muted0/5 text-muted-foreground">{t("admin_sales_agency_split")}</TableHead>
 <TableHead className="bg-blue-500/5 text-muted-foreground">{t("admin_sales_agent_split")}</TableHead>
 <TableHead className="text-right text-muted-foreground">{t("admin_sales_status")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {stats?.distributions?.map(trx => <TableRow key={trx.id} className="border-border">
 <TableCell>
 <div className="font-medium text-foreground">{trx.entity}</div>
 <div className="text-xs text-muted-foreground font-mono mt-0.5">{trx.id}</div>
 </TableCell>
 <TableCell className="font-bold text-foreground">{t("currency_symbol", "$")}{trx.amount.toLocaleString()}</TableCell>
 <TableCell className="font-semibold text-red-400 bg-red-500/5">
 {t("currency_symbol", "$")}{(trx.amount * 0.18).toLocaleString()} <span className="text-[10px] opacity-70">{t("admin_sales_18_avg")}</span>
 </TableCell>
 <TableCell className="font-semibold text-muted-foreground bg-muted0/5">
 {trx.shares[0]?.value}{t("admin_sales_platform")}
 </TableCell>
 <TableCell className="bg-muted0/5">
  <div className="font-semibold text-muted-foreground">{tEnum(t, trx.type)}</div>
 <div className="text-xs text-muted-foreground">{t("admin_sales_entity_type")}</div>
 </TableCell>
 <TableCell className="bg-blue-500/5">
 <div className="font-semibold text-success">{t("admin_sales_detailed")}</div>
 <div className="text-xs text-muted-foreground">{t("admin_sales_split_breakdown")}</div>
 </TableCell>
 <TableCell className="text-right">
 <Badge variant={trx.status === 'Cleared' ? 'default' : trx.status === 'Escrow' ? 'secondary' : 'outline'} className={trx.status === 'Cleared' ? 'bg-blue-600 hover:bg-blue-700 text-foreground' : ''}>
  {tEnum(t, trx.status)}
  </Badge>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>;
}
