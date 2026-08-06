import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Sparkles, Video, FileText, TrendingUp, Brain } from "lucide-react";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";
export function AIWidget() {
  const {
    t
  } = useTranslation();
  return <Card className="border-primary/20 bg-gradient-to-br from-primary/5 to-purple-500/5 backdrop-blur-sm rounded-2xl overflow-hidden relative group">
      <div className="absolute -top-12 -right-12 p-4 opacity-5 group-hover:opacity-10 transition-opacity">
        <Brain className="h-48 w-48" />
      </div>
      <CardHeader className="pb-2">
        <CardTitle className="text-lg flex items-center gap-2">
          <Sparkles className="h-5 w-5 text-primary animate-pulse" />
          {t("widgetsAimarketingTitle")}
        </CardTitle>
        <CardDescription>{t("widgetsAimarketingDesc")}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-5">
        <div className="flex justify-between items-center text-sm">
          <div className="flex items-center gap-2">
            <Video className="w-4 h-4 text-purple-400" />
            <span className="font-medium">{t("videoTasks")}</span>
          </div>
          <Badge variant="secondary" className="bg-purple-500/10 text-purple-400 border-purple-500/20">{t("widgetsAimarketingPending", {
            count: 3
          })}</Badge>
        </div>
        
        <div className="space-y-2">
          <div className="flex justify-between text-xs font-medium">
            <span className="text-muted-foreground italic">{t("client.src.luxury_villa_reels_generation")}</span>
            <span>%74</span>
          </div>
          <Progress value={74} className="h-1.5 bg-slate-800" />
        </div>

        <div className="grid grid-cols-2 gap-4 pt-2">
          <div className="p-3 bg-background/40 border border-white/5 rounded-xl text-center">
            <p className="text-[10px] uppercase tracking-tighter text-slate-500 font-bold mb-1">{t("leadScore")}</p>
            <div className="flex items-center justify-center gap-1">
              <span className="text-xl font-bold">8.4</span>
              <TrendingUp className="w-3 h-3 text-blue-500" />
            </div>
          </div>
          <div className="p-3 bg-background/40 border border-white/5 rounded-xl text-center">
            <p className="text-[10px] uppercase tracking-tighter text-slate-500 font-bold mb-1">{t("brochures")}</p>
            <div className="flex items-center justify-center gap-1">
              <span className="text-xl font-bold">12</span>
              <FileText className="w-3 h-3 text-blue-400" />
            </div>
          </div>
        </div>
      </CardContent>
    </Card>;
}