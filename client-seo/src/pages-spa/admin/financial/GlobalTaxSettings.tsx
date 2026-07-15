"use client";

import { useTranslation } from"react-i18next";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Globe, ShieldCheck, Scale, AlertTriangle, RefreshCw, Landmark, Loader2 } from"lucide-react";
import { globalTaxApi } from"@/lib/api/global-tax-regulation";
import { useQuery } from"@tanstack/react-query";
import { cn } from"@/lib/utils";

export default function GlobalTaxSettings() {
 const { t } = useTranslation();
 const { data: ratesData, isLoading: loading, refetch: fetchRates } = useQuery({
 queryKey: ['globalTaxRates'],
 queryFn: async () => {
 const response = await globalTaxApi.getCountries();
 const countries = Array.isArray(response) ? response : (response as any).data || [];
 const allRates = await Promise.all(countries.map(async (c: string) => {
 const rateRes = await globalTaxApi.getDefaultRates(c);
 const data = Array.isArray(rateRes) ? rateRes : (rateRes as any).data || [];
 return data.map((r: any) => ({
 country: c, code: c, status:"ACTIVE",
 standard: `${r.rate}%`, reporting: r.reportingFrequency, authority: r.taxAuthority,
 }));
 }));
 return allRates.flat();
 }
 });

 const rates: any[] = ratesData || [];

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
 <Globe className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_financial_tax_compliance_engine","Tax Compliance Engine")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_financial_global_tax_regulation_management","Global tax regulation management")}
 </p>
 </div>
 </div>
 <Button variant="outline" onClick={() => fetchRates()} disabled={loading} className="bg-card border-border text-slate-300 hover:bg-white/10">
 <RefreshCw className={cn("w-4 h-4 mr-2", loading ? 'animate-spin' : '')} />
 {t("admin_financial_sync_global_rates","Sync Rates")}
 </Button>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_tax_coverage","Tax Coverage")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{rates.length} {t("admin_financial_regions","Regions")}</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><Globe className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_compliance_health","Compliance Health")}</p>
 <h3 className="text-2xl font-bold text-emerald-400 mt-1">98.2%</h3>
 </div>
 <div className="p-3 bg-emerald-500/20 rounded-lg"><ShieldCheck className="w-5 h-5 text-emerald-400" /></div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_pending_liabilities","Pending Liabilities")}</p>
 <h3 className="text-2xl font-bold text-orange-400 mt-1">$12,450</h3>
 </div>
 <div className="p-3 bg-orange-500/20 rounded-lg"><AlertTriangle className="w-5 h-5 text-orange-400" /></div>
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <div className="flex items-center justify-between">
 <CardTitle className="text-foreground flex items-center gap-2">
 <Landmark className="w-5 h-5 text-muted-foreground" />
 {t("admin_financial_active_regional_regulations","Regional Regulations")}
 </CardTitle>
 </div>
 <CardDescription className="text-muted-foreground">{t("admin_financial_manage_how_taxes_are","Manage tax regulations")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="border border-border rounded-xl overflow-hidden">
 <Table>
 <TableHeader className="bg-card">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-xs font-medium text-muted-foreground">{t("admin_financial_location","Location")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground">{t("admin_financial_tax_authority","Authority")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground">{t("admin_financial_standard_rate","Rate")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground">{t("admin_financial_reporting","Reporting")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground">{t("admin_financial_status","Status")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {loading ? (
 <TableRow><TableCell colSpan={5} className="text-center py-8"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow>
 ) : rates.length === 0 ? (
 <TableRow><TableCell colSpan={5} className="text-center py-8 text-slate-500">{t("admin_financial_no_rates","No rates found")}</TableCell></TableRow>
 ) : rates.map(rate => (
 <TableRow key={rate.code} className="border-b border-border hover:bg-card">
 <TableCell className="py-4 px-6">
 <div className="font-medium text-foreground">{rate.country}</div>
 <div className="text-xs text-muted-foreground font-mono">{rate.code}</div>
 </TableCell>
 <TableCell className="text-sm text-slate-300">{rate.authority}</TableCell>
 <TableCell className="text-sm font-semibold text-foreground">{rate.standard}</TableCell>
 <TableCell className="text-xs text-muted-foreground">{rate.reporting}</TableCell>
 <TableCell>
 <Badge className="bg-emerald-500/20 text-emerald-400 border-0">{rate.status}</Badge>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </div>
 </CardContent>
 </Card>

 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground flex items-center gap-2">
 <Scale className="w-5 h-5 text-muted-foreground" />
 {t("admin_financial_automation_rules","Automation Rules")}
 </CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_financial_configure_how_the_engine","Configure automation")}</CardDescription>
 </CardHeader>
 <CardContent className="space-y-4">
 {[
 { label: t("admin_financial_autoprovisioning","Auto-Provisioning"), desc: t("admin_financial_apply_regulation_on_property","Apply regulation on property"), status:"ON" },
 { label: t("admin_financial_transaction_hook","Transaction Hook"), desc: t("admin_financial_calculate_tax_on_eachcleared","Calculate tax on each transaction"), status:"ON" },
 { label: t("admin_financial_withholding_buffer","Withholding Buffer"), desc: t("admin_financial_hold_estimated_tax_in","Hold estimated tax in escrow"), status:"Manual" },
 ].map((rule, i) => (
 <div key={i} className="flex items-center justify-between p-3 bg-card rounded-lg">
 <div>
 <div className="font-medium text-foreground">{rule.label}</div>
 <div className="text-xs text-muted-foreground">{rule.desc}</div>
 </div>
 <Badge className={rule.status ==="ON" ?"bg-emerald-500/20 text-emerald-400 border-0" :"bg-amber-500/20 text-amber-400 border-0"}>{rule.status}</Badge>
 </div>
 ))}
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground flex items-center gap-2">
 <AlertTriangle className="w-5 h-5 text-orange-400" />
 {t("admin_financial_statutory_alerts","Statutory Alerts")}
 </CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_financial_upcoming_deadlines_and_regulation","Upcoming deadlines")}</CardDescription>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="p-3 border-l-4 border-orange-500 bg-orange-500/5 rounded-r-lg">
 <div className="font-bold text-sm text-foreground">{t("admin_financial_uk_vat_mtd_deadline","UK VAT MTD Deadline")}</div>
 <div className="text-xs text-muted-foreground mt-1">{t("admin_financial_submission_due_in_12","Submission due in 12 days")}</div>
 </div>
 <div className="p-3 border-l-4 border-slate-500 bg-muted0/5 rounded-r-lg">
 <div className="font-bold text-sm text-foreground">{t("admin_financial_new_regulation_uae_corporate","UAE Corporate Tax")}</div>
 <div className="text-xs text-muted-foreground mt-1">{t("admin_financial_reviewing_impact_on_crossborder","Reviewing cross-border impact")}</div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 );
}
