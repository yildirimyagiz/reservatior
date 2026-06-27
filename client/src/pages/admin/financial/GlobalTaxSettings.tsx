import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Globe, ShieldCheck, Scale, AlertTriangle, Save, RefreshCw, Landmark } from "lucide-react";
import { globalTaxApi } from "@/lib/api/global-tax-regulation";
import { useQuery } from "@tanstack/react-query";

export default function GlobalTaxSettings() {
  const {
    t
  } = useTranslation();
  const { data: ratesData, isLoading: loading, refetch: fetchRates } = useQuery({
    queryKey: ['globalTaxRates'],
    queryFn: async () => {
      const response = await globalTaxApi.getCountries();
      const countries = Array.isArray(response) ? response : (response as any).data || [];
      const allRates = await Promise.all(countries.map(async (c: string) => {
        const rateRes = await globalTaxApi.getDefaultRates(c);
        const data = Array.isArray(rateRes) ? rateRes : (rateRes as any).data || [];
        return data.map((r: any) => ({
          country: c,
          code: c,
          status: "ACTIVE",
          standard: `${r.rate}%`,
          reporting: r.reportingFrequency,
          authority: r.taxAuthority
        }));
      }));
      return allRates.flat();
    }
  });

  const rates: any[] = ratesData || [];
  return <PageShell title={t("admin.financial.tax_compliance_engine")} description={t("admin.financial.global_tax_regulation_management")}>
      <div className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card className="bg-indigo-900 border-indigo-800 text-foreground">
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium opacity-70">{t("admin.financial.tax_coverage")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold flex items-center gap-2">
                <Globe className="w-6 h-6 text-indigo-400" />{t("admin.financial.84_regions")}</div>
              <p className="text-xs mt-1 opacity-70">{t("admin.financial.automated_rate_updates_active")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin.financial.compliance_health")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold text-emerald-600 flex items-center gap-2">
                <ShieldCheck className="w-6 h-6" /> 98.2%
              </div>
              <p className="text-xs mt-1 text-muted-foreground">{t("admin.financial.successfully_filed_reports")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin.financial.pending_liabilities")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-3xl font-bold text-orange-600 flex items-center gap-2">
                <AlertTriangle className="w-6 h-6" /> $12,450
              </div>
              <p className="text-xs mt-1 text-muted-foreground">{t("admin.financial.estimated_tax_to_be")}</p>
            </CardContent>
          </Card>
        </div>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <div>
              <CardTitle className="flex items-center gap-2">
                <Landmark className="w-5 h-5 text-muted-foreground" />{t("admin.financial.active_regional_regulations")}</CardTitle>
              <CardDescription>{t("admin.financial.manage_how_taxes_are")}</CardDescription>
            </div>
            <Button variant="outline" size="sm" onClick={() => fetchRates()} disabled={loading}>
              <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("admin.financial.sync_global_rates")}</Button>
          </CardHeader>
          <CardContent>
            <div className="rounded-xl border border-border">
              <Table>
                <TableHeader className="bg-muted/50">
                  <TableRow>
                    <TableHead>{t("admin.financial.location")}</TableHead>
                    <TableHead>{t("admin.financial.tax_authority")}</TableHead>
                    <TableHead>{t("admin.financial.standard_rate")}</TableHead>
                    <TableHead>{t("admin.financial.reporting")}</TableHead>
                    <TableHead>{t("admin.financial.status")}</TableHead>
                    <TableHead className="text-right">{t("admin.financial.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {rates.map(rate => <TableRow key={rate.code}>
                      <TableCell>
                        <div className="font-bold text-foreground">{rate.country}</div>
                        <div className="text-xs text-muted-foreground font-mono">{rate.code}</div>
                      </TableCell>
                      <TableCell className="text-sm">{rate.authority}</TableCell>
                      <TableCell className="text-sm font-semibold text-foreground">{rate.standard}</TableCell>
                      <TableCell className="text-xs">{rate.reporting}</TableCell>
                      <TableCell>
                        <Badge variant={rate.status === 'ACTIVE' ? 'default' : 'outline'} className={rate.status === 'ACTIVE' ? 'bg-emerald-600/20 text-emerald-400 border-emerald-500/20' : ''}>
                          {rate.status}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-right">
                        <Button variant="ghost" size="sm">{t("admin.financial.manage")}</Button>
                      </TableCell>
                    </TableRow>)}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-primary">
                <Scale className="w-5 h-5" />{t("admin.financial.automation_rules")}</CardTitle>
              <CardDescription>{t("admin.financial.configure_how_the_engine")}</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="flex items-center justify-between p-3 bg-muted/30 rounded-lg">
                <div>
                  <div className="font-medium text-foreground">{t("admin.financial.autoprovisioning")}</div>
                  <div className="text-xs text-muted-foreground">{t("admin.financial.apply_regulation_on_property")}</div>
                </div>
                <Badge className="bg-emerald-600">{t("admin.financial.on")}</Badge>
              </div>
              <div className="flex items-center justify-between p-3 bg-muted/30 rounded-lg">
                <div>
                  <div className="font-medium text-foreground">{t("admin.financial.transaction_hook")}</div>
                  <div className="text-xs text-muted-foreground">{t("admin.financial.calculate_tax_on_eachcleared")}</div>
                </div>
                <Badge className="bg-emerald-600">{t("admin.financial.on")}</Badge>
              </div>
              <div className="flex items-center justify-between p-3 bg-muted/30 rounded-lg">
                <div>
                  <div className="font-medium text-foreground">{t("admin.financial.withholding_buffer")}</div>
                  <div className="text-xs text-muted-foreground">{t("admin.financial.hold_estimated_tax_in")}</div>
                </div>
                <Badge variant="outline">{t("admin.financial.manual")}</Badge>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-orange-500">
                <AlertTriangle className="w-5 h-5" />{t("admin.financial.statutory_alerts")}</CardTitle>
              <CardDescription>{t("admin.financial.upcoming_deadlines_and_regulation")}</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="p-3 border-l-4 border-orange-500 bg-orange-500/5">
                <div className="font-bold text-sm text-foreground">{t("admin.financial.uk_vat_mtd_deadline")}</div>
                <div className="text-xs text-muted-foreground mt-1">{t("admin.financial.submission_due_in_12")}</div>
              </div>
              <div className="p-3 border-l-4 border-blue-500 bg-blue-500/5">
                <div className="font-bold text-sm text-foreground">{t("admin.financial.new_regulation_uae_corporate")}</div>
                <div className="text-xs text-muted-foreground mt-1">{t("admin.financial.reviewing_impact_on_crossborder")}</div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>;
}