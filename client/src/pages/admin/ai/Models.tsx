import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Settings, Play, Pause, RefreshCw } from "lucide-react";
export default function AIModels() {
  const {
    t
  } = useTranslation();
  return <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("admin.ai.ai_models")}</h1>
          <p className="text-muted-foreground">{t("admin.ai.manage_and_monitor_artificial")}</p>
        </div>
        <Button>
          <RefreshCw className="w-4 h-4 mr-2" />{t("admin.ai.refresh_models")}</Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {[{
        name: "Property Valuation Model",
        type: "Regression",
        status: "active",
        accuracy: "97.2%",
        lastTrained: "2 days ago",
        predictions: "12,543"
      }, {
        name: "Lead Scoring Engine",
        type: "Classification",
        status: "active",
        accuracy: "94.8%",
        lastTrained: "1 week ago",
        predictions: "8,234"
      }, {
        name: "Market Prediction Model",
        type: "Time Series",
        status: "training",
        accuracy: "92.1%",
        lastTrained: "3 days ago",
        predictions: "5,678"
      }, {
        name: "Recommendation System",
        type: "Collaborative Filtering",
        status: "active",
        accuracy: "96.5%",
        lastTrained: "5 days ago",
        predictions: "15,892"
      }, {
        name: "Image Recognition",
        type: "Computer Vision",
        status: "inactive",
        accuracy: "89.3%",
        lastTrained: "2 weeks ago",
        predictions: "3,456"
      }, {
        name: "Natural Language Processor",
        type: "NLP",
        status: "active",
        accuracy: "91.7%",
        lastTrained: "4 days ago",
        predictions: "7,234"
      }].map((model, i) => <Card key={i}>
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle className="text-lg">{model.name}</CardTitle>
                <Badge variant={model.status === "active" ? "default" : model.status === "training" ? "secondary" : "outline"}>
                  {model.status}
                </Badge>
              </div>
              <p className="text-sm text-muted-foreground">{model.type}</p>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-2 gap-4 text-sm">
                <div>
                  <p className="font-medium">{t("admin.ai.accuracy")}</p>
                  <p className="text-muted-foreground">{model.accuracy}</p>
                </div>
                <div>
                  <p className="font-medium">{t("admin.ai.predictions")}</p>
                  <p className="text-muted-foreground">{model.predictions}</p>
                </div>
              </div>
              
              <div className="text-sm">
                <p className="font-medium">{t("admin.ai.last_trained")}</p>
                <p className="text-muted-foreground">{model.lastTrained}</p>
              </div>

              <div className="flex gap-2">
                <Button size="sm" variant="outline">
                  <Settings className="w-4 h-4 mr-2" />{t("admin.ai.configure")}</Button>
                <Button size="sm" variant="outline">
                  {model.status === "active" ? <>
                      <Pause className="w-4 h-4 mr-2" />{t("admin.ai.pause")}</> : <>
                      <Play className="w-4 h-4 mr-2" />{t("admin.ai.start")}</>}
                </Button>
              </div>
            </CardContent>
          </Card>)}
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("admin.ai.model_training_queue")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {[{
            model: "Market Prediction Model",
            progress: 75,
            status: "training"
          }, {
            model: "Customer Segmentation",
            progress: 100,
            status: "completed"
          }, {
            model: "Fraud Detection Model",
            progress: 30,
            status: "queued"
          }].map((training, i) => <div key={i} className="space-y-2">
                <div className="flex items-center justify-between">
                  <p className="font-medium">{training.model}</p>
                  <Badge variant={training.status === "completed" ? "default" : "secondary"}>
                    {training.status}
                  </Badge>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-2">
                  <div className="bg-blue-600 h-2 rounded-full" style={{
                width: `${training.progress}%`
              }}></div>
                </div>
              </div>)}
          </div>
        </CardContent>
      </Card>
    </div>;
}