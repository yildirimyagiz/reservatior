"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Trophy, Award, Flame, Star } from "lucide-react";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { useGrowthEngineStore } from "@/lib/store/growth-engine-store";

const TIER_CLASS: Record<string, string> = {
  BRONZE: "bg-orange-500/20 text-orange-400", SILVER: "bg-slate-400/20 text-slate-300",
  GOLD: "bg-amber-500/20 text-amber-400", PLATINUM: "bg-violet-500/20 text-violet-400",
};

export function GamificationWidget() {
  const { t } = useTranslation();
  const { gamification } = useGrowthEngineStore();
  const g = gamification;

  if (!g) return null;

  const levelProgress = g.nextLevelPoints > 0 ? (g.totalPoints / g.nextLevelPoints) * 100 : 0;

  return (
    <Card className="bg-card border-border">
      <CardHeader>
        <CardTitle className="text-foreground flex items-center gap-2">
          <Trophy className="w-5 h-5 text-amber-400" />
          {t("widget_gamification_title", "Gamification")}
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="flex items-center gap-4">
          <div className="w-14 h-14 rounded-full bg-gradient-to-br from-amber-500 to-amber-700 flex items-center justify-center shrink-0">
            <span className="text-xl font-bold text-white">{g.level}</span>
          </div>
          <div className="flex-1">
            <p className="text-sm font-semibold text-foreground">{g.levelName}</p>
            <div className="flex items-center gap-2 mt-1">
              <div className="flex-1 h-2 bg-card rounded-full overflow-hidden">
                <div className="h-full bg-gradient-to-r from-amber-500 to-amber-700 rounded-full" style={{ width: `${levelProgress}%` }} />
              </div>
              <span className="text-xs text-muted-foreground">{g.totalPoints}/{g.nextLevelPoints}</span>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-3">
          <div className="p-3 bg-card rounded-xl border border-border text-center">
            <Award className="w-5 h-5 mx-auto text-violet-400 mb-1" />
            <p className="text-lg font-bold text-foreground">{g.unlockedCount}/{g.totalAchievements}</p>
            <p className="text-[10px] text-muted-foreground">{t("widget_achievements", "Achievements")}</p>
          </div>
          <div className="p-3 bg-card rounded-xl border border-border text-center">
            <Flame className="w-5 h-5 mx-auto text-rose-400 mb-1" />
            <p className="text-lg font-bold text-foreground">{g.streak}d</p>
            <p className="text-[10px] text-muted-foreground">{t("widget_streak", "Streak")}</p>
          </div>
        </div>

        <div className="space-y-2">
          {g.achievements.filter((a) => !a.unlocked).slice(0, 3).map((ach) => (
            <div key={ach.id} className="flex items-center gap-3 p-2 bg-card rounded-lg border border-border">
              <span className="text-lg shrink-0 opacity-50">{ach.emoji}</span>
              <div className="flex-1 min-w-0">
                <p className="text-xs font-medium text-foreground truncate">{ach.name}</p>
                <div className="flex items-center gap-2 mt-0.5">
                  <div className="flex-1 h-1 bg-card rounded-full overflow-hidden">
                    <div className="h-full bg-muted0 rounded-full" style={{ width: `${ach.target > 0 ? (ach.progress / ach.target) * 100 : 0}%` }} />
                  </div>
                  <span className="text-[10px] text-muted-foreground">{ach.progress}/{ach.target}</span>
                </div>
              </div>
              <Badge className={cn("border-0 text-[8px] shrink-0", TIER_CLASS[ach.tier] || "")}>{ach.tier}</Badge>
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  );
}
