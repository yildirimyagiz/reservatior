import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Sparkles, Video, FileText, PlayCircle, Download } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { aiExtendedApi, type AiServiceTask } from "@/lib/api/ai-extended";
import { listingsApi } from "@/lib/api/listings";
export function AiStudioTab() {
  const {
    t
  } = useTranslation();
  const [tasks, setTasks] = useState<AiServiceTask[]>([]);
  const [listings, setListings] = useState<any[]>([]);
  const {
    toast
  } = useToast();
  const fetchTasks = async () => {
    try {
      const response = await aiExtendedApi.getTasks();
      setTasks((response as any).data || []);
    } catch (e) {
      console.error(e);
    }
  };
  const fetchListings = async () => {
    try {
      const response = await listingsApi.getListings();
      setListings((response as any).data || []);
    } catch (e) {
      console.error(e);
    }
  };
  useEffect(() => {
    fetchTasks();
    fetchListings();
    const interval = setInterval(fetchTasks, 5000);
    return () => clearInterval(interval);
  }, []);
  const handleGenerate = async (listingId: string, type: "REELS_VIDEO_GEN" | "BROCHURE_GEN") => {
    try {
      if (type === "REELS_VIDEO_GEN") {
        await aiExtendedApi.generateVideo(listingId);
      } else {
        await aiExtendedApi.generateBrochure(listingId);
      }
      toast({
        title: t("client.src.ai_task_started"),
        description: t("client.src.your_content_is_being")
      });
      fetchTasks();
    } catch (e) {
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_start_ai"),
        variant: "destructive"
      });
    }
  };
  return <div className="space-y-6">
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <Card className="border-primary/20 bg-gradient-to-br from-primary/5 to-purple-500/5">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Sparkles className="h-5 w-5 text-primary" />{t("client.src.ai_reels_generator")}</CardTitle>
            <CardDescription>{t("client.src.generate_viralready_vertical_videos")}</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="p-4 bg-background/50 rounded-xl border border-white/5 text-sm">{t("client.src.ai_will_analyze_your")}</div>
            {listings.slice(0, 3).map(l => <div key={l.id} className="flex items-center justify-between p-3 bg-white/5 rounded-lg border">
                <span className="text-sm font-medium truncate max-w-[150px]">{l.title || "Untitled"}</span>
                <Button size="sm" onClick={() => handleGenerate(l.id, "REELS_VIDEO_GEN")}>
                   <Video className="w-4 h-4 mr-2" />{t("client.src.generate_video")}</Button>
              </div>)}
          </CardContent>
        </Card>

        <Card className="border-blue-500/20 bg-gradient-to-br from-blue-500/5 to-indigo-500/5">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <FileText className="h-5 w-5 text-blue-500" />{t("client.src.ai_boutique_brochure")}</CardTitle>
            <CardDescription>{t("client.src.create_stunning_pdf_brochures")}</CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="p-4 bg-background/50 rounded-xl border border-white/5 text-sm">{t("client.src.multilingual_highend_brochures_with")}</div>
            {listings.slice(0, 3).map(l => <div key={l.id} className="flex items-center justify-between p-3 bg-white/5 rounded-lg border">
                <span className="text-sm font-medium truncate max-w-[150px]">{l.title || "Untitled"}</span>
                <Button variant="outline" size="sm" onClick={() => handleGenerate(l.id, "BROCHURE_GEN")}>
                   <FileText className="w-4 h-4 mr-2" />{t("client.src.create_pdf")}</Button>
              </div>)}
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("client.src.ai_studio_tasks")}</CardTitle>
          <CardDescription>{t("client.src.realtime_progress_of_your")}</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {tasks.length === 0 && <div className="text-center py-8 text-muted-foreground">{t("client.src.no_active_ai_tasks")}</div>}
            {tasks.map(task => <div key={task.id} className="p-4 border rounded-xl space-y-3">
                <div className="flex justify-between items-center">
                  <div className="flex items-center gap-3">
                    {task.taskType === "REELS_VIDEO_GEN" ? <Video className="w-4 h-4" /> : <FileText className="w-4 h-4" />}
                    <span className="text-sm font-bold">{task.taskType.replace('_', ' ')}</span>
                  </div>
                  <Badge variant={task.status === "COMPLETED" ? "default" : task.status === "FAILED" ? "destructive" : "secondary"}>
                    {task.status}
                  </Badge>
                </div>
                
                {task.status === "PROCESSING" && <div className="space-y-1.5">
                    <div className="flex justify-between text-[10px] font-bold uppercase text-slate-500">
                      <span>{t("client.src.analyzing_assets")}</span>
                      <span>{task.progress}%</span>
                    </div>
                    <Progress value={task.progress} className="h-1.5" />
                  </div>}

                {task.status === "COMPLETED" && <div className="flex gap-2">
                    <Button size="sm" variant="outline" className="h-8">
                       {task.taskType === "REELS_VIDEO_GEN" ? <PlayCircle className="w-4 h-4 mr-2" /> : <Download className="w-4 h-4 mr-2" />}{t("client.src.view_result")}</Button>
                  </div>}
              </div>)}
          </div>
        </CardContent>
      </Card>
    </div>;
}