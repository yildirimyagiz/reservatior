"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Clock, TrendingDown, Zap, ThumbsUp, ThumbsDown, Brain } from "lucide-react";

interface VacancyIntelligenceWidgetProps {
  listingId: string;
  listingTitle: string;
  currentPrice: number;
  currency: string;
  vacancyDays: number;
  marketPosition?: string;
  suggestedDiscount?: number;
  projectedOccupancy?: number;
  estimatedMonthlyGain?: number;
  onAccept?: (listingId: string) => void;
  onReject?: (listingId: string) => void;
}

export function VacancyIntelligenceWidget({
  listingId,
  listingTitle,
  currentPrice,
  currency,
  vacancyDays,
  marketPosition = "Below Average",
  suggestedDiscount = 0.06,
  projectedOccupancy = 72,
  estimatedMonthlyGain = 1250,
  onAccept,
  onReject,
}: VacancyIntelligenceWidgetProps) {
  const [actionTaken, setActionTaken] = useState<string | null>(null);

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat("en-US", { style: "currency", currency, maximumFractionDigits: 0 }).format(val);

  const severityColor =
    vacancyDays > 60 ? "text-red-400" : vacancyDays > 30 ? "text-amber-400" : "text-blue-400";

  return (
    <Card className="bg-gradient-to-br from-slate-900 to-slate-800 border-white/10">
      <CardHeader className="pb-3">
        <CardTitle className="text-lg font-black italic text-white flex items-center gap-2">
          <Brain className="w-5 h-5 text-purple-400" />
          Vacancy Intelligence
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex items-center justify-between">
          <span className="text-sm text-slate-400">{listingTitle}</span>
          <Badge variant="outline" className={severityColor}>
            <Clock className="w-3 h-3 mr-1" />
            {vacancyDays} days vacant
          </Badge>
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div className="bg-white/5 rounded-lg p-3">
            <p className="text-xs text-slate-400 mb-1">Market Position</p>
            <p className="text-sm font-semibold text-white">{marketPosition}</p>
          </div>
          <div className="bg-white/5 rounded-lg p-3">
            <p className="text-xs text-slate-400 mb-1">Current Price</p>
            <p className="text-sm font-semibold text-white">{formatCurrency(currentPrice)}</p>
          </div>
          <div className="bg-white/5 rounded-lg p-3">
            <p className="text-xs text-slate-400 mb-1">Suggested Discount</p>
            <p className="text-lg font-black text-emerald-400">-{(suggestedDiscount * 100).toFixed(0)}%</p>
          </div>
          <div className="bg-white/5 rounded-lg p-3">
            <p className="text-xs text-slate-400 mb-1">New Price</p>
            <p className="text-sm font-semibold text-white">
              {formatCurrency(currentPrice * (1 - suggestedDiscount))}
            </p>
          </div>
        </div>

        <div className="space-y-2">
          <div className="flex justify-between text-sm">
            <span className="text-slate-400">Projected Occupancy</span>
            <span className="text-white font-semibold">{projectedOccupancy}%</span>
          </div>
          <Progress value={projectedOccupancy} className="h-2 bg-white/10" />
        </div>

        <div className="bg-emerald-500/10 border border-emerald-500/20 rounded-lg p-3">
          <p className="text-xs text-emerald-300 mb-1">Estimated Monthly Gain</p>
          <p className="text-xl font-black text-emerald-400">
            +{formatCurrency(estimatedMonthlyGain)}
          </p>
          <p className="text-xs text-emerald-300/70 mt-1">
            Projected additional income after optimization
          </p>
        </div>

        {!actionTaken ? (
          <div className="flex gap-2">
            <Button
              onClick={() => {
                setActionTaken("accepted");
                onAccept?.(listingId);
              }}
              className="flex-1 h-11 bg-emerald-500 hover:bg-emerald-600 text-white font-bold text-xs gap-2"
            >
              <ThumbsUp className="w-4 h-4" /> Accept Suggestion
            </Button>
            <Button
              onClick={() => {
                setActionTaken("rejected");
                onReject?.(listingId);
              }}
              variant="outline"
              className="flex-1 h-11 border-white/10 text-slate-300 hover:bg-white/5 font-bold text-xs gap-2"
            >
              <ThumbsDown className="w-4 h-4" /> Reject
            </Button>
          </div>
        ) : (
          <div className="text-center py-2 text-sm text-emerald-400 font-semibold">
            {actionTaken === "accepted"
              ? "✅ Optimization Accepted — Your listing is now boosted!"
              : "Suggestion dismissed. You can revisit this anytime."}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
