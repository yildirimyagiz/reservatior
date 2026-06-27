import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Brain, Sparkles, Settings, Activity, Cpu, Network, ShieldCheck, Zap, BarChart3, Bot } from "lucide-react";
export default function AIDashboard() {
  const {
    t
  } = useTranslation();
  const models = [{
    name: "Property Valuation V4",
    type: "Regression",
    status: "Active",
    accuracy: "98.2%",
    latency: "145ms"
  }, {
    name: "Sentiment Analysis Llama-3",
    type: "NLP",
    status: "Active",
    accuracy: "94.5%",
    latency: "450ms"
  }, {
    name: "Image Enhancement Gen-2",
    type: "Diffusion",
    status: "Active",
    accuracy: "N/A",
    latency: "1.2s"
  }, {
    name: "Fraud Detection Guard",
    type: "Classification",
    status: "Monitoring",
    accuracy: "99.9%",
    latency: "85ms"
  }];
  return <div className="p-6 space-y-6 bg-background min-h-screen text-foreground font-sans">
      <div className="flex justify-between items-center bg-blue-600/5 p-6 rounded-2xl border border-blue-600/10 backdrop-blur-md">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-blue-600 rounded-xl shadow-lg shadow-blue-600/20">
            <Brain className="w-8 h-8 text-foreground" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight bg-linear-to-r from-foreground to-muted-foreground bg-clip-text text-transparent">{t("admin.ai.ai_central_intelligence")}</h1>
            <p className="text-muted-foreground">{t("admin.ai.monitoring_and_managing_reservatior")}</p>
          </div>
        </div>
        <div className="flex gap-3">
          <Button variant="outline" className="gap-2 bg-card border-border hover:bg-muted">
            <Settings className="w-4 h-4" />{t("admin.ai.global_config")}</Button>
          <Button className="gap-2 bg-blue-600 hover:bg-blue-700 shadow-lg shadow-blue-600/20">
            <Zap className="w-4 h-4" />{t("admin.ai.retrain_models")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-card/50 border-border shadow-xl">
          <CardHeader>
            <CardTitle className="text-foreground flex items-center gap-2">
              <Cpu className="w-4 h-4 text-purple-400" />{t("admin.ai.infrastructure_health")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex justify-between items-center text-sm p-3 bg-muted/50 rounded-lg">
              <span className="text-muted-foreground">{t("admin.ai.gpu_clusters_h100")}</span>
              <Badge className="bg-emerald-500/20 text-emerald-600 dark:text-emerald-400 border-emerald-500/20">{t("admin.ai.operational")}</Badge>
            </div>
            <div className="flex justify-between items-center text-sm p-3 bg-muted/50 rounded-lg">
              <span className="text-muted-foreground">{t("admin.ai.vector_storage_pinecone")}</span>
              <Badge className="bg-emerald-500/20 text-emerald-400 border-emerald-500/20">{t("admin.ai.9999_up")}</Badge>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-card/50 border-border shadow-xl">
          <CardHeader>
            <CardTitle className="text-foreground flex items-center gap-2">
              <Activity className="w-4 h-4 text-blue-400" />{t("admin.ai.usage_metrics")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex justify-between items-center text-sm p-3 bg-muted/50 rounded-lg">
              <span className="text-muted-foreground">{t("admin.ai.tokens_generated_24h")}</span>
              <span className="font-bold text-foreground">{t("admin.ai.42m")}</span>
            </div>
            <div className="flex justify-between items-center text-sm p-3 bg-muted/50 rounded-lg">
              <span className="text-muted-foreground">{t("admin.ai.api_requests_24h")}</span>
              <span className="font-bold text-foreground">142,400</span>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-card/50 border-border shadow-xl">
          <CardHeader>
            <CardTitle className="text-foreground flex items-center gap-2">
              <ShieldCheck className="w-4 h-4 text-emerald-400" />{t("admin.ai.ai_governance")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="flex justify-between items-center text-sm p-3 bg-muted/50 rounded-lg">
              <span className="text-muted-foreground">{t("admin.ai.pii_redaction_rate")}</span>
              <span className="font-bold text-foreground">100%</span>
            </div>
            <div className="flex justify-between items-center text-sm p-3 bg-muted/50 rounded-lg">
              <span className="text-muted-foreground">{t("admin.ai.hallucination_delta")}</span>
              <span className="font-bold text-emerald-600 dark:text-emerald-400">&lt; 0.12%</span>
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card className="bg-card/50 border-border shadow-xl overflow-hidden">
          <CardHeader className="bg-muted/30">
            <div className="flex justify-between items-center">
              <CardTitle className="flex items-center gap-2">
                 <Bot className="w-5 h-5 text-indigo-400" />{t("admin.ai.model_fleet_status")}</CardTitle>
              <Button variant="ghost" className="text-xs text-blue-400">{t("admin.ai.scale_clusters")}</Button>
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <table className="w-full text-left">
              <thead>
                <tr className="border-b border-border bg-muted/20">
                  <th className="px-6 py-4 font-medium text-xs tracking-wider text-muted-foreground">{t("admin.ai.model_name")}</th>
                  <th className="px-6 py-4 font-medium text-xs tracking-wider text-muted-foreground">{t("admin.ai.status")}</th>
                  <th className="px-6 py-4 font-medium text-xs tracking-wider text-muted-foreground">{t("admin.ai.metrics")}</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-border">
                {models.map((model, i) => <tr key={i} className="hover:bg-muted/50 transition-colors">
                    <td className="px-6 py-4">
                      <div className="flex flex-col">
                        <span className="text-sm font-medium text-muted-foreground">{model.name}</span>
                        <span className="text-xs text-muted-foreground">{model.type}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <Badge variant="outline" className="bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-500/20 text-[10px]">{model.status}</Badge>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex flex-col text-xs space-y-1">
                        <span className="text-muted-foreground">{t("admin.ai.acc")}<span className="text-muted-foreground">{model.accuracy}</span></span>
                        <span className="text-muted-foreground">{t("admin.ai.latency")}<span className="text-blue-400">{model.latency}</span></span>
                      </div>
                    </td>
                  </tr>)}
              </tbody>
            </table>
          </CardContent>
        </Card>

        <Card className="bg-card/50 border-border shadow-xl">
          <CardHeader>
            <CardTitle className="text-foreground flex items-center gap-2">
              <Zap className="w-5 h-5 text-amber-400" />{t("admin.ai.realtime_execution_stream")}</CardTitle>
          </CardHeader>
          <CardContent>
             <div className="space-y-4 font-mono text-[11px]">
                {[{
              time: '10:01:42',
              event: '[Property-Analyzer] Image processing completed for listing #4829',
              status: 'success'
            }, {
              time: '10:01:45',
              event: '[Lead-Score] New lead qualified. Score: 87/100',
              status: 'info'
            }, {
              time: '10:01:52',
              event: '[Sentiment-Guardian] Review #9401 processed. Sentiment: Positive',
              status: 'success'
            }, {
              time: '10:02:01',
              event: '[Valuation-Engine] Weekly market delta calculated for London SE1',
              status: 'info'
            }, {
              time: '10:02:15',
              event: '[Security-AI] Anomaly detected in login pattern - session flagged',
              status: 'warning'
            }].map((item, i) => <div key={i} className="flex gap-4 p-2 bg-muted/20 rounded border-l-2 border-border hover:border-blue-500 transition-colors">
                    <span className="text-muted-foreground">{item.time}</span>
                    <span className={cn(item.status === 'success' ? 'text-emerald-600 dark:text-emerald-400' : item.status === 'warning' ? 'text-rose-600 dark:text-rose-400' : 'text-blue-600 dark:text-blue-400')}>{item.event}</span>
                  </div>)}
             </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}
function cn(...classes: any[]) {
  return classes.filter(Boolean).join(' ');
}