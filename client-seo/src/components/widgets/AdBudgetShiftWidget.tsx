"use client";

import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { ArrowRightLeft, Zap, TrendingDown, Clock } from "lucide-react";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

interface AdBudgetShiftWidgetProps {
  fromNetwork: string;
  toNetwork: string;
  amount: number;
  cpetBefore: number;
  cpetAfter: number;
  triggeredBy: string;
  timestamp: string;
  reason: string;
}

const NETWORK_LABELS: Record<string, string> = {
  GOOGLE_ADS: "Google Ads", META_CAPI: "Meta CAPI", TIKTOK: "TikTok",
  LINKEDIN: "LinkedIn", BAIDU_MARKETING: "Baidu", NAVER_SEARCH_ADS: "Naver",
  YANDEX_DIRECT: "Yandex", MICROSOFT_BING: "Bing",
};

export function AdBudgetShiftWidget({
  fromNetwork,
  toNetwork,
  amount,
  cpetBefore,
  cpetAfter,
  triggeredBy,
  timestamp,
  reason,
}: AdBudgetShiftWidgetProps) {
  const { t } = useTranslation();
  const cpetImprovement = cpetBefore - cpetAfter;
  const improvementPercent = cpetBefore > 0 ? ((cpetImprovement / cpetBefore) * 100) : 0;

  return (
    <Card className="bg-card border-border hover:border-cyan-500/30 transition-all">
      <CardContent className="p-4">
        <div className="flex items-center gap-3 mb-3">
          <div className="p-2 bg-cyan-500/20 rounded-lg">
            <ArrowRightLeft className="w-4 h-4 text-cyan-400" />
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center gap-2">
              <Badge className="border-0 bg-blue-500/20 text-blue-400 text-[10px]">{NETWORK_LABELS[fromNetwork] || fromNetwork}</Badge>
              <span className="text-muted-foreground">→</span>
              <Badge className="border-0 bg-emerald-500/20 text-emerald-400 text-[10px]">{NETWORK_LABELS[toNetwork] || toNetwork}</Badge>
            </div>
          </div>
          <span className="text-sm font-bold text-foreground">${amount.toLocaleString()}</span>
        </div>
        <p className="text-xs text-muted-foreground mb-2 truncate">{reason}</p>
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-1">
            <TrendingDown className="w-3 h-3 text-emerald-400" />
            <span className="text-xs font-bold text-emerald-400">
              CPET -{improvementPercent.toFixed(0)}%
            </span>
          </div>
          <div className="flex items-center gap-1">
            <Clock className="w-3 h-3 text-muted-foreground" />
            <span className="text-xs text-muted-foreground">{new Date(timestamp).toLocaleTimeString()}</span>
          </div>
        </div>
        {triggeredBy === "AI_ARBITRAGE" && (
          <Badge className="mt-2 border-0 bg-cyan-500/20 text-cyan-400 text-[10px]">
            <Zap className="w-2 h-2 mr-1" /> AI Arbitrage
          </Badge>
        )}
      </CardContent>
    </Card>
  );
}
