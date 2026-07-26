"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { ShieldCheck, Lock, AlertTriangle, CheckCircle2, ExternalLink } from "lucide-react";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

interface DepositProtectionWidgetProps {
  propertyId: string;
  attachedProducts: { id: string; name: string; type: string; provider: string; status: string }[];
  riskScore?: number;
  onAttach?: () => void;
}

export function DepositProtectionWidget({
  propertyId,
  attachedProducts,
  riskScore,
  onAttach,
}: DepositProtectionWidgetProps) {
  const { t } = useTranslation();

  const hasProtection = attachedProducts.some((p) => p.type === "DEPOSIT_PROTECTION");
  const hasLiability = attachedProducts.some((p) => p.type === "LIABILITY");

  return (
    <Card className="bg-card border-border">
      <CardHeader>
        <CardTitle className="text-foreground flex items-center gap-2">
          <ShieldCheck className="w-5 h-5 text-emerald-400" />
          {t("widget_insurance_title", "Deposit Protection & Insurance")}
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex items-center gap-3 p-3 bg-card rounded-xl border border-border">
          <div className={cn("w-10 h-10 rounded-full flex items-center justify-center", hasProtection ? "bg-emerald-500/20" : "bg-amber-500/20")}>
            {hasProtection ? <CheckCircle2 className="w-5 h-5 text-emerald-400" /> : <AlertTriangle className="w-5 h-5 text-amber-400" />}
          </div>
          <div className="flex-1">
            <p className="text-sm font-medium text-foreground">{t("widget_deposit_protection", "Deposit Protection")}</p>
            <p className="text-xs text-muted-foreground">{hasProtection ? t("widget_protection_active", "Active") : t("widget_protection_missing", "Not attached")}</p>
          </div>
          <Badge className={cn("border-0 text-[10px]", hasProtection ? "bg-emerald-500/20 text-emerald-400" : "bg-amber-500/20 text-amber-400")}>
            {hasProtection ? "✓" : "!"}
          </Badge>
        </div>

        <div className="flex items-center gap-3 p-3 bg-card rounded-xl border border-border">
          <div className={cn("w-10 h-10 rounded-full flex items-center justify-center", hasLiability ? "bg-emerald-500/20" : "bg-blue-500/20")}>
            {hasLiability ? <CheckCircle2 className="w-5 h-5 text-emerald-400" /> : <Lock className="w-5 h-5 text-blue-400" />}
          </div>
          <div className="flex-1">
            <p className="text-sm font-medium text-foreground">{t("widget_liability_insurance", "Liability Insurance")}</p>
            <p className="text-xs text-muted-foreground">{hasLiability ? t("widget_liability_active", "Active") : t("widget_liability_missing", "Not attached")}</p>
          </div>
          <Badge className={cn("border-0 text-[10px]", hasLiability ? "bg-emerald-500/20 text-emerald-400" : "bg-muted0/20 text-muted-foreground")}>
            {hasLiability ? "✓" : "—"}
          </Badge>
        </div>

        {attachedProducts.length > 0 && (
          <div className="space-y-2">
            {attachedProducts.map((p) => (
              <div key={p.id} className="flex items-center justify-between p-2 bg-card rounded-lg">
                <span className="text-xs text-foreground">{p.name}</span>
                <Badge className="border-0 bg-violet-500/20 text-violet-400 text-[10px]">{p.provider}</Badge>
              </div>
            ))}
          </div>
        )}

        {riskScore !== undefined && (
          <div className="flex items-center justify-between p-3 bg-card rounded-xl border border-border">
            <span className="text-xs text-muted-foreground">{t("widget_risk_score", "Property Risk Score")}</span>
            <span className={cn("text-sm font-bold", riskScore < 30 ? "text-emerald-400" : riskScore < 60 ? "text-amber-400" : "text-red-400")}>
              {riskScore}/100
            </span>
          </div>
        )}

        {!hasProtection && onAttach && (
          <Button
            className="w-full bg-emerald-600 hover:bg-emerald-700 text-white"
            size="sm"
            onClick={onAttach}
          >
            <ShieldCheck className="w-4 h-4 mr-1" />
            {t("widget_attach_protection", "Attach Deposit Protection")}
          </Button>
        )}
      </CardContent>
    </Card>
  );
}
