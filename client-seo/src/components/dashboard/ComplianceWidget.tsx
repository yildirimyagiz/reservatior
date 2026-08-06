
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { ShieldCheck, Gavel, Globe, CheckCircle2, AlertTriangle } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";

export function ComplianceWidget() {
  const { t } = useTranslation();
  const regions = [
    { code: "TR", status: "PENDING", tax: "VAT", report: "KBS" },
    { code: "AE", status: "COMPLIANT", tax: "TOT", report: "GIYKIMBIL" },
    { code: "UK", status: "COMPLIANT", tax: "GST", report: "AUDIT" }
  ];

  return (
    <Card className="border-white/5 bg-secondary/5 rounded-2xl overflow-hidden relative">
      <CardHeader className="pb-4">
        <CardTitle className="text-lg flex items-center gap-2">
          <Globe className="h-4 w-4 text-blue-400" />
          {t("widgetsComplianceTitle")}
        </CardTitle>
        <CardDescription>{t("widgetsComplianceDesc")}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="grid grid-cols-3 gap-2">
          {regions.map((reg) => (
            <div key={reg.code} className="p-3 bg-background/50 border border-white/5 rounded-xl text-center flex flex-col items-center gap-1.5 group cursor-pointer hover:border-blue-500/30 transition-all">
              <span className="text-xs font-bold text-slate-500">{reg.code}</span>
              {reg.status === "COMPLIANT" ? <CheckCircle2 className="w-4 h-4 text-blue-500" /> : <AlertTriangle className="w-4 h-4 text-amber-500 animate-pulse" />}
              <span className="text-[10px] text-slate-400">{t("taxStatus", { tax: reg.tax })}</span>
            </div>
          ))}
        </div>

        <div className="pt-2 space-y-3">
          <div className="flex items-center gap-3 p-3 bg-secondary/20 rounded-xl border border-white/5">
            <Gavel className="w-5 h-5 text-purple-400" />
            <div className="flex-1">
              <p className="text-xs font-bold">{t("audit")}</p>
              <p className="text-[10px] text-slate-500 italic">{t("nextCheck", { date: "12 April 2026" })}</p>
            </div>
            <Badge className="bg-blue-500/10 text-blue-500 border-blue-500/20 text-[10px] uppercase font-bold">{t("admin.verification.labels.status")}</Badge>
          </div>
          
          <div className="flex items-center gap-3 p-3 bg-secondary/20 rounded-xl border border-white/5">
            <ShieldCheck className="w-5 h-5 text-blue-400" />
            <div className="flex-1">
              <p className="text-xs font-bold">{t("policeReporting")}</p>
              <p className="text-[10px] text-slate-500 italic">{t("pendingReports", { count: 2, city: "Manhattan" })}</p>
            </div>
            <Badge variant="outline" className="text-amber-500 border-amber-500/20 text-[10px] animate-pulse lowercase">{t("financialPayoutsStatusPending")}</Badge>
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
