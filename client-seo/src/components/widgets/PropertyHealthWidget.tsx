"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { ShieldCheck, Lock, AlertTriangle, CheckCircle2, DollarSign, TrendingUp } from "lucide-react";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

interface PropertyHealthWidgetProps {
  overallScore: number;
  structuralIntegrity: number;
  cosmeticCondition: number;
  totalDefects: number;
  criticalDefects: number;
  estimatedRepairCost: number;
  comparisonMode?: string;
  conditionDelta?: number;
}

export function PropertyHealthWidget({
  overallScore,
  structuralIntegrity,
  cosmeticCondition,
  totalDefects,
  criticalDefects,
  estimatedRepairCost,
  comparisonMode,
  conditionDelta,
}: PropertyHealthWidgetProps) {
  const { t } = useTranslation();

  const scoreColor = overallScore >= 80 ? "text-emerald-400" : overallScore >= 50 ? "text-amber-400" : "text-red-400";
  const scoreBg = overallScore >= 80 ? "from-emerald-500 to-emerald-700" : overallScore >= 50 ? "from-amber-500 to-amber-700" : "from-red-500 to-red-700";

  return (
    <Card className="bg-card border-border overflow-hidden">
      <div className={cn("h-1.5 bg-gradient-to-r", scoreBg)} />
      <CardContent className="p-6">
        <div className="flex items-center gap-4 mb-4">
          <div className="w-16 h-16 rounded-full bg-gradient-to-br from-slate-500 to-slate-700 flex items-center justify-center">
            <span className={cn("text-2xl font-bold", scoreColor)}>{overallScore}</span>
          </div>
          <div>
            <h4 className="text-lg font-bold text-foreground">{t("widget_health_title", "Property Health")}</h4>
            <p className="text-xs text-muted-foreground">{t("widget_health_score", "Overall Score")}</p>
          </div>
        </div>
        <div className="space-y-3">
          <div>
            <div className="flex justify-between text-xs mb-1">
              <span className="text-muted-foreground">{t("widget_health_structural", "Structural Integrity")}</span>
              <span className="font-bold text-foreground">{structuralIntegrity}/100</span>
            </div>
            <Progress value={structuralIntegrity} className="h-2" />
          </div>
          <div>
            <div className="flex justify-between text-xs mb-1">
              <span className="text-muted-foreground">{t("widget_health_cosmetic", "Cosmetic Condition")}</span>
              <span className="font-bold text-foreground">{cosmeticCondition}/100</span>
            </div>
            <Progress value={cosmeticCondition} className="h-2" />
          </div>
          <div className="flex items-center justify-between pt-2 border-t border-border">
            <div className="flex items-center gap-2">
              <AlertTriangle className={cn("w-4 h-4", criticalDefects > 0 ? "text-red-400" : "text-emerald-400")} />
              <span className="text-xs text-foreground">{totalDefects} {t("widget_health_defects", "defects")}{criticalDefects > 0 ? ` (${criticalDefects}!)" : ""}</span>
            </div>
            <span className="text-sm font-bold text-foreground">${estimatedRepairCost.toLocaleString()}</span>
          </div>
          {conditionDelta !== undefined && (
            <div className="flex items-center gap-2">
              <TrendingUp className={cn("w-3 h-3", conditionDelta >= 0 ? "text-emerald-400" : "text-red-400")} />
              <span className="text-xs text-foreground">{conditionDelta >= 0 ? "+" : ""}{conditionDelta} {t("widget_health_delta", "since baseline")}</span>
            </div>
          )}
        </div>
      </CardContent>
    </Card>
  );
}
