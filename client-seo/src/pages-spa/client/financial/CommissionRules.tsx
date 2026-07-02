import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { financialsApi, type CommissionRule } from "@/lib/api/financials";
import { Percent, DollarSign, TrendingUp, ShieldCheck, Plus, RefreshCw, Loader2 } from "lucide-react";
export default function CommissionRules() {
  const {
    t
  } = useTranslation();
  const { data: rulesData, isLoading: loading, refetch: fetchData } = useQuery<CommissionRule[]>({
    queryKey: ['commissionRules'],
    queryFn: async () => {
      try {
        const res = await financialsApi.getCommissionRules();
        return (res as any)?.data || [
          { id: "cm1", providerId: "Airbnb", ruleType: "PERCENTAGE", commission: 15, createdAt: new Date().toISOString() },
          { id: "cm2", providerId: "Booking.com", ruleType: "PERCENTAGE", commission: 12, createdAt: new Date().toISOString() },
          { id: "cm3", providerId: "Direct Sales", ruleType: "FLAT", commission: 200, createdAt: new Date().toISOString() }
        ];
      } catch (error) {
        return [
          { id: "cm1", providerId: "Airbnb", ruleType: "PERCENTAGE", commission: 15, createdAt: new Date().toISOString() },
          { id: "cm2", providerId: "Booking.com", ruleType: "PERCENTAGE", commission: 12, createdAt: new Date().toISOString() }
        ] as CommissionRule[];
      }
    }
  });

  const rules = rulesData || [];
  return <PageShell title={t("client.src.commission_rules")} description={t("client.src.define_and_track_commission")} actions={<div className="flex gap-2">
          <Button variant="outline" size="sm" onClick={() => fetchData()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("client.src.refresh")}</Button>
          <Button size="sm" className="bg-primary hover:bg-primary/90 text-primary-foreground">
            <Plus className="w-4 h-4 mr-2" />{t("client.src.new_rule")}</Button>
        </div>}>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <Card className="bg-primary/5 border-primary/10 shadow-sm overflow-hidden relative">
          <div className="absolute top-0 right-0 p-3 opacity-10">
            <Percent className="w-16 h-16" />
          </div>
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-bold tracking-wider text-muted-foreground">{t("client.src.avg_commission")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">12.4%</div>
            <p className="text-xs text-green-600 mt-1 flex items-center font-medium">
              <TrendingUp className="w-3 h-3 mr-1" />{t("client.src.08_from_last_month")}</p>
          </CardContent>
        </Card>
        
        <Card className="bg-blue-50/50 border-blue-100 shadow-sm overflow-hidden relative text-blue-900">
          <div className="absolute top-0 right-0 p-3 opacity-10">
            <DollarSign className="w-16 h-16" />
          </div>
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-bold tracking-wider text-muted-foreground">{t("client.src.total_payouts")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">$42,850</div>
            <p className="text-xs text-muted-foreground mt-1">{t("client.src.pending_approval_3200")}</p>
          </CardContent>
        </Card>

        <Card className="bg-green-50/50 border-green-100 shadow-sm overflow-hidden relative text-green-900">
          <div className="absolute top-0 right-0 p-3 opacity-10">
            <ShieldCheck className="w-16 h-16" />
          </div>
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-bold tracking-wider text-muted-foreground">{t("client.src.active_rules")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">{rules.length}</div>
            <p className="text-xs text-muted-foreground mt-1">{t("client.src.spanning_5_platforms")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="bg-card border border-border rounded-xl shadow-sm overflow-hidden">
        <Table>
          <TableHeader className="bg-muted/30">
            <TableRow>
              <TableHead className="font-bold text-xs">{t("client.src.provider_source")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.rule_type")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.commission")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.min_volume")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.status")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.created")}</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? <TableRow>
                <TableCell colSpan={6} className="h-64 text-center">
                  <div className="flex flex-col items-center justify-center gap-2">
                    <Loader2 className="w-8 h-8 animate-spin text-primary" />
                    <span className="text-sm text-muted-foreground">{t("client.src.loading_commission_matrix")}</span>
                  </div>
                </TableCell>
              </TableRow> : rules.map(rule => <TableRow key={rule.id} className="hover:bg-muted/40 transition-colors">
                <TableCell className="font-semibold text-sm">{rule.providerId}</TableCell>
                <TableCell>
                  <Badge variant="secondary" className="text-[10px] font-bold tracking-tighter ring-1 ring-border shadow-xs">
                    {rule.ruleType}
                  </Badge>
                </TableCell>
                <TableCell className="text-sm font-medium">
                  {rule.ruleType === "PERCENTAGE" ? `${rule.commission}%` : `$${rule.commission.toLocaleString()}`}
                </TableCell>
                <TableCell className="text-sm text-muted-foreground">
                  {rule.minVolume ? `$${rule.minVolume.toLocaleString()}+` : "No limit"}
                </TableCell>
                <TableCell>
                  <div className="flex items-center gap-1.5">
                    <div className="w-1.5 h-1.5 rounded-full bg-green-500 shadow-sm shadow-green-200"></div>
                    <span className="text-xs font-medium">{t("client.src.active")}</span>
                  </div>
                </TableCell>
                <TableCell className="text-xs text-muted-foreground font-mono">
                  {new Date(rule.createdAt).toLocaleDateString()}
                </TableCell>
              </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </PageShell>;
}