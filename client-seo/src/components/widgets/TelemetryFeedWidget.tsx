"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Bell, CheckCircle2, AlertTriangle, Zap, Shield, DollarSign, Target, Activity } from "lucide-react";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { useGrowthEngineStore } from "@/lib/store/growth-engine-store";

const EVENT_EMOJI: Record<string, string> = {
  AD_BUDGET_SHIFTED: "⚡", PROPERTY_ANALYZED: "🔍", DEFECT_DETECTED: "⚠️",
  INSURANCE_ATTACHED: "🛡️", LEAD_CAPTURED: "💬", DEPOSIT_SECURED: "🔒",
  BROCHURE_GENERATED: "📄", VIDEO_LOCALIZED: "🎬", CAMPAIGN_LAUNCHED: "🚀",
  CREATIVE_OPTIMIZED: "✨", CONVERSION_TRACKED: "📈", ESCROW_FUNDED: "💰",
  PAYOUT_PROCESSED: "💳", ARBITRAGE_COMPLETED: "🔀", REBATE_APPLIED: "🎁",
  STAGE_GENERATED: "🏠", HEALTH_REPORT_CREATED: "📋", OFFLINE_CONVERSION_SYNCED: "🔄",
};

const SEVERITY_CLASS: Record<string, string> = {
  INFO: "bg-blue-500/20 text-blue-400", SUCCESS: "bg-emerald-500/20 text-emerald-400",
  WARNING: "bg-amber-500/20 text-amber-400", ERROR: "bg-red-500/20 text-red-400",
};

export function TelemetryFeedWidget({ maxItems = 10 }: { maxItems?: number }) {
  const { t } = useTranslation();
  const { liveEvents, acknowledgeEvent } = useGrowthEngineStore();

  const events = liveEvents.slice(0, maxItems);

  return (
    <Card className="bg-card border-border">
      <CardHeader>
        <CardTitle className="text-foreground flex items-center gap-2">
          <Bell className="w-5 h-5 text-amber-400" />
          {t("widget_telemetry_title", "Live Execution Trace")}
        </CardTitle>
      </CardHeader>
      <CardContent>
        <ScrollArea className="h-[400px]">
          <div className="space-y-2">
            {events.length === 0 ? (
              <div className="text-center py-8">
                <Activity className="w-8 h-8 mx-auto text-muted-foreground mb-2" />
                <p className="text-xs text-muted-foreground">{t("widget_telemetry_empty", "Waiting for events...")}</p>
              </div>
            ) : events.map((event, idx) => (
              <div
                key={event.id || idx}
                className={cn(
                  "flex items-center gap-3 p-3 rounded-lg border transition-all",
                  event.acknowledged ? "border-border opacity-50" : "border-border hover:bg-card/50"
                )}
              >
                <span className="text-lg shrink-0">{event.emoji || EVENT_EMOJI[event.type] || "📌"}</span>
                <div className="flex-1 min-w-0">
                  <p className="text-sm font-medium text-foreground truncate">{event.title}</p>
                  <p className="text-xs text-muted-foreground truncate">{event.description}</p>
                </div>
                <Badge className={cn("border-0 text-[10px] shrink-0", SEVERITY_CLASS[event.severity] || SEVERITY_CLASS.INFO)}>
                  {event.severity}
                </Badge>
                {!event.acknowledged && (
                  <button
                    onClick={() => acknowledgeEvent(event.id)}
                    className="text-muted-foreground hover:text-foreground transition-colors"
                  >
                    <CheckCircle2 className="w-4 h-4" />
                  </button>
                )}
              </div>
            ))}
          </div>
        </ScrollArea>
      </CardContent>
    </Card>
  );
}
