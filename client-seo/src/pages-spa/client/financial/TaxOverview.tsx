import { useTranslation } from "react-i18next";
import { useState, useEffect, Key } from "react";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { useQuery } from "@tanstack/react-query";
import { Landmark, ShieldAlert, FileText, Download, HelpCircle, HelpCircleIcon, Table as TableIcon, TrendingUp, Calculator, ExternalLink, Mail } from "lucide-react";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell } from "recharts";
const TAX_TREND_DATA = [{
  month: 'Jan',
  tax: 1200
}, {
  month: 'Feb',
  tax: 1450
}, {
  month: 'Mar',
  tax: 1100
}, {
  month: 'Apr',
  tax: 1600
}, {
  month: 'May',
  tax: 1350
}, {
  month: 'Jun',
  tax: 1800
}];
import { globalTaxApi } from "@/lib/api/global-tax-regulation";
import { financialsApi } from "@/lib/api/financials";
export default function TaxOverview() {
  const {
    t
  } = useTranslation();
  const { data: recordsData = [], isLoading: loading } = useQuery({
    queryKey: ['globalTaxRecords'],
    queryFn: async () => {
      const response = await globalTaxApi.getRecords({ limit: 10 });
      return Array.isArray(response) ? response : (response as any).data || [];
    }
  });

  const records = recordsData;
  const stats = {
    liability: records.reduce((sum: number, r: any) => sum + (r.profileData?.taxAmount || 0), 0),
    count: records.length
  };
  return <PageShell title={t("client.src.tax_compliance_center")} description={t("client.src.track_your_property_tax")}>
      <div className="space-y-6">
        {/* Top Status Banner */}
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-4">
          <Card className="bg-slate-900 border-slate-800 text-white col-span-1 lg:col-span-2">
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium opacity-70">{t("client.src.current_liability_q2_estimate")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex items-center justify-between">
                <div>
                  <div className="text-4xl font-black">${stats.liability.toLocaleString()}</div>
                  <p className="text-xs mt-1 text-slate-400">{t("client.src.calculated_automatically_across")}{stats.count}{t("client.src.records")}</p>
                </div>
                <div className="h-16 w-16 rounded-full bg-orange-500/10 flex items-center justify-center border border-orange-500/30">
                   <Landmark className="w-8 h-8 text-orange-500" />
                </div>
              </div>
              <div className="mt-6 space-y-2">
                <div className="flex justify-between text-xs">
                    <span>{t("client.src.withholding_progress")}</span>
                    <span className="font-bold">82%</span>
                </div>
                <Progress value={82} className="h-2 bg-slate-800" indicatorClassName="bg-emerald-500" />
              </div>
            </CardContent>
          </Card>

          <Card className="border-red-500/20 bg-red-500/5">
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-red-600 flex items-center gap-2">
                <ShieldAlert className="w-4 h-4" />{t("client.src.next_deadline")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{t("client.src.april_15_2026")}</div>
              <p className="text-xs mt-1 text-muted-foreground">{t("client.src.california_sales_tax_q1")}</p>
              <Button size="sm" className="mt-4 w-full bg-red-600 hover:bg-red-700 text-white border-0">{t("client.src.review_filing")}</Button>
            </CardContent>
          </Card>

          <Card className="border-indigo-500/20 bg-indigo-500/5">
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium text-indigo-600 flex items-center gap-2">
                <FileText className="w-4 h-4" />{t("client.src.tax_records")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{stats.count}{t("client.src.records")}</div>
              <p className="text-xs mt-1 text-muted-foreground">{t("client.src.certified_for_this_fiscal")}</p>
              <Button variant="outline" size="sm" className="mt-4 w-full border-indigo-200 text-indigo-700 hover:bg-indigo-50">{t("client.src.view_ledger")}</Button>
            </CardContent>
          </Card>
        </div>

        {/* Charts & Details */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <Card className="lg:col-span-2 shadow-sm">
            <CardHeader className="flex flex-row items-center justify-between">
              <div>
                <CardTitle className="flex items-center gap-2">
                    <TrendingUp className="w-5 h-5 text-emerald-500" />{t("client.src.tax_history")}</CardTitle>
                <CardDescription>{t("client.src.monthly_withholding_trends_across")}</CardDescription>
              </div>
              <Select defaultValue="6m">
                <option value="6m">{t("client.src.last_6_months")}</option>
                <option value="1y">{t("client.src.last_year")}</option>
              </Select>
            </CardHeader>
            <CardContent>
               <div className="h-[300px] w-full">
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={TAX_TREND_DATA} margin={{
                  top: 10,
                  right: 10,
                  left: -20,
                  bottom: 0
                }}>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                    <XAxis dataKey="month" stroke="#64748b" fontSize={12} tickLine={false} axisLine={false} />
                    <YAxis stroke="#64748b" fontSize={12} tickLine={false} axisLine={false} tickFormatter={v => `$${v}`} />
                    <Tooltip contentStyle={{
                    borderRadius: '12px',
                    border: 'none',
                    boxShadow: '0 4px 12px rgba(0,0,0,0.1)'
                  }} />
                    <Bar dataKey="tax" fill="#8b5cf6" radius={[6, 6, 0, 0]}>
                       {TAX_TREND_DATA.map((entry, index) => <Cell key={`cell-${index}`} fill={index === 5 ? '#f59e0b' : '#3b82f6'} />)}
                    </Bar>
                  </BarChart>
                </ResponsiveContainer>
               </div>
            </CardContent>
          </Card>

          <div className="space-y-6">
             <Card className="shadow-sm">
                <CardHeader>
                    <CardTitle className="text-sm font-bold flex items-center gap-2">
                        <Calculator className="w-4 h-4 text-slate-500" />{t("client.src.quick_tools")}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-3">
                    <Button variant="secondary" className="w-full justify-start text-sm" size="sm">
                        <Download className="w-4 h-4 mr-2" />{t("client.src.download_form_1099k")}</Button>
                    <Button variant="secondary" className="w-full justify-start text-sm" size="sm">
                        <Download className="w-4 h-4 mr-2" />{t("client.src.export_vat_summary_eu")}</Button>
                    <Button variant="secondary" className="w-full justify-start text-sm" size="sm">
                        <TableIcon className="w-4 h-4 mr-2" />{t("client.src.revenue_administration_vat_report")}</Button>
                </CardContent>
             </Card>

             <Card className="bg-indigo-600 text-white shadow-xl shadow-indigo-200">
                <CardContent className="pt-6">
                    <div className="flex flex-col items-center text-center space-y-4">
                        <div className="p-3 bg-white/20 rounded-2xl">
                            <HelpCircle className="w-8 h-8" />
                        </div>
                        <h4 className="font-bold text-lg">{t("client.src.need_tax_advice")}</h4>
                        <p className="text-xs opacity-80 leading-relaxed">{t("client.src.our_partner_cpas_can")}</p>
                        <Button className="bg-white text-indigo-700 hover:bg-slate-100 font-bold w-full">{t("client.src.request_consultation")}</Button>
                    </div>
                </CardContent>
             </Card>
          </div>
        </div>

        {/* Recent Transactions with Tax Details */}
        <Card className="shadow-sm">
          <CardHeader>
            <CardTitle>{t("client.src.recent_tax_log")}</CardTitle>
            <CardDescription>{t("client.src.individual_transactions_and_their")}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
               {loading ? <div className="text-center py-12 text-muted-foreground italic">{t("client.src.loading_records")}</div> : records.length === 0 ? <div className="text-center py-12 text-muted-foreground italic">{t("client.src.no_tax_records_found")}</div> : records.map((item: any, i: number) => <div key={item.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-xl hover:bg-muted/50 transition-all">
                          <div className="flex items-center gap-4">
                              <div className="w-10 h-10 rounded-lg bg-white flex items-center justify-center border border-border shadow-sm">
                                  <Landmark className="w-5 h-5 text-slate-400" />
                              </div>
                              <div>
                                   <div className="font-bold text-slate-900">{item.property?.name || 'Manual Settlement'}</div>
                                   <div className="text-[10px] text-muted-foreground font-mono">{String(item.id).slice(0, 8)} • {new Date(item.createdAt).toLocaleDateString()}</div>
                              </div>
                          </div>
                          <div className="text-right">
                              <div className="font-bold text-red-600">-${(item.profileData?.taxAmount || 0).toLocaleString()}</div>
                              <div className="text-[10px] text-muted-foreground">{t("client.src.rate")}{item.profileData?.appliedRate || 0}% • {item.categoryData?.taxAuthority || 'HMRC'}
                              </div>
                          </div>
                      </div>)}
            </div>
            <Button variant="ghost" className="w-full mt-4 text-xs font-bold text-slate-500">{t("client.src.view_full_transaction_history")}</Button>
          </CardContent>
        </Card>
      </div>
    </PageShell>;
}

// Minimal select for the demo
function Select({
  children,
  defaultValue
}: {
  children: React.ReactNode;
  defaultValue: string;
}) {
  return <select defaultValue={defaultValue} className="text-xs bg-slate-50 border border-slate-200 rounded-lg px-2 py-1 outline-none font-medium">
            {children}
        </select>;
}