import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Progress } from "@/components/ui/progress";
import { Separator } from "@/components/ui/separator";
import { useToast } from "@/hooks/use-toast";
import { ArrowRight, Box, CheckCircle2, Clock, DollarSign, Gift, Home, Image, PenTool, Sparkles, Star, TrendingUp, Video, Zap } from "lucide-react";
import { apiClient } from "@/lib/api";
interface AIBenefit {
  title: string;
  description: string;
  value: string;
  free: boolean;
  icon: string;
}
interface MigrationAnalysis {
  type: string;
  priority: string;
  estimatedImpact: string;
}
interface MigrationResult {
  property: any;
  analysis: MigrationAnalysis[];
  migrationValue: {
    totalValue: number;
    savings: number;
    roi: string;
    timeSaved: string;
  };
  freeBenefits: string[];
  callToAction: string;
}
const AI_BENEFITS: AIBenefit[] = [{
  title: t("client.src.ai_virtual_staging"),
  description: t("client.src.transform_empty_rooms_into"),
  value: "$500",
  free: true,
  icon: "home"
}, {
  title: t("client.src.cinematic_video_tours"),
  description: t("client.src.aigenerated_professional_video_walkthroughs"),
  value: "$300",
  free: true,
  icon: "video"
}, {
  title: t("client.src.intelligent_pricing"),
  description: t("client.src.aipowered_market_comparison_and"),
  value: "$200",
  free: true,
  icon: "dollar-sign"
}, {
  title: t("client.src.ai_descriptions"),
  description: t("client.src.compelling_property_descriptions_written"),
  value: "$100",
  free: true,
  icon: "pen-tool"
}, {
  title: t("client.src.3d_virtual_tours"),
  description: t("client.src.neural_radiance_fields_for"),
  value: "$400",
  free: true,
  icon: "cube"
}, {
  title: t("client.src.smart_enhancement"),
  description: t("client.src.aipowered_image_quality_improvement"),
  value: "$150",
  free: true,
  icon: "image"
}];
export default function AIMigration() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [url, setUrl] = useState("");
  const [loading, setLoading] = useState(false);
  const [analysis, setAnalysis] = useState<MigrationResult | null>(null);
  const [migrationStatus, setMigrationStatus] = useState<any>(null);
  const [preferences, setPreferences] = useState({
    stagingStyle: "modern",
    videoLength: "medium",
    descriptionTone: "professional",
    enable3DTour: true,
    enablePricingAnalysis: true
  });
  const getIcon = (iconName: string) => {
    const icons: Record<string, any> = {
      home: <Home className="w-6 h-6" />,
      video: <Video className="w-6 h-6" />,
      "dollar-sign": <DollarSign className="w-6 h-6" />,
      "pen-tool": <PenTool className="w-6 h-6" />,
      cube: <Box className="w-6 h-6" />,
      image: <Image className="w-6 h-6" />
    };
    return icons[iconName] || <Sparkles className="w-6 h-6" />;
  };
  const handleAnalyze = async () => {
    if (!url.trim()) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.please_enter_a_property"),
        variant: "destructive"
      });
      return;
    }
    setLoading(true);
    try {
      const result = (await apiClient.post("/ai-migration/analyze", {
        url,
        userId: "current-user"
      })) as any;
      if (result.success) {
        setAnalysis(result);
        toast({
          title: t("client.src.analysis_complete"),
          description: `Found $${result.migrationValue.totalValue} in AI benefits`
        });
      } else {
        toast({
          title: t("client.src.analysis_failed"),
          description: result.error,
          variant: "destructive"
        });
      }
    } catch (e) {
      toast({
        title: t("client.src.analysis_failed"),
        description: t("client.src.network_error_occurred"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const handleMigrate = async () => {
    if (!url.trim()) return;
    setLoading(true);
    try {
      const result = (await apiClient.post("/ai-migration/execute", {
        url,
        userId: "current-user",
        preferences
      })) as any;
      if (result.success) {
        toast({
          title: t("client.src.migration_started"),
          description: t("client.src.your_property_is_being")
        });

        // Start polling for status
        startStatusPolling(result.propertyId);
      } else {
        toast({
          title: t("client.src.migration_failed"),
          description: result.error,
          variant: "destructive"
        });
      }
    } catch (e) {
      toast({
        title: t("client.src.migration_failed"),
        description: t("client.src.network_error_occurred"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const startStatusPolling = (propertyId: string) => {
    const pollStatus = async () => {
      try {
        const result = (await apiClient.get(`/ai-migration/status/${propertyId}`)) as any;
        if (result.success) {
          setMigrationStatus(result.status);
          if (result.status.progress < 100) {
            setTimeout(pollStatus, 5000); // Poll every 5 seconds
          }
        }
      } catch (e) {
        console.error("Status polling failed:", e);
      }
    };
    pollStatus();
  };
  return <div className="space-y-8">
      {/* Hero Section */}
      <div className="text-center space-y-4 py-8 bg-linear-to-r from-blue-50 to-purple-50 rounded-2xl">
        <div className="flex items-center justify-center gap-2 mb-2">
          <Gift className="w-8 h-8 text-purple-600" />
          <Badge className="bg-purple-100 text-purple-700 text-lg px-4 py-1">{t("client.src.free_ai_migration")}</Badge>
        </div>
        <h1 className="text-4xl font-bold bg-linear-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">{t("client.src.transform_your_property_listing")}</h1>
        <p className="text-xl text-muted-foreground max-w-2xl mx-auto">{t("client.src.move_your_property_to")}</p>
        <div className="flex items-center justify-center gap-4 text-sm">
          <div className="flex items-center gap-1">
            <CheckCircle2 className="w-4 h-4 text-green-500" />
            <span>{t("client.src.no_credit_card_required")}</span>
          </div>
          <div className="flex items-center gap-1">
            <CheckCircle2 className="w-4 h-4 text-green-500" />
            <span>{t("client.src.instant_setup")}</span>
          </div>
          <div className="flex items-center gap-1">
            <CheckCircle2 className="w-4 h-4 text-green-500" />
            <span>{t("client.src.cancel_anytime")}</span>
          </div>
        </div>
      </div>

      {/* AI Benefits Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {AI_BENEFITS.map((benefit, index) => <Card key={index} className="relative overflow-hidden">
            <CardHeader className="pb-3">
              <div className="flex items-center justify-between">
                <div className="p-2 bg-linear-to-r from-blue-500 to-purple-500 rounded-lg text-white">
                  {getIcon(benefit.icon)}
                </div>
                <div className="text-right">
                  <Badge className="bg-green-100 text-green-700">{t("client.src.free")}</Badge>
                  <div className="text-sm text-muted-foreground line-through">
                    {benefit.value}
                  </div>
                </div>
              </div>
              <CardTitle className="text-lg">{benefit.title}</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-sm text-muted-foreground">{benefit.description}</p>
            </CardContent>
          </Card>)}
      </div>

      {/* Migration Form */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Zap className="w-5 h-5" />{t("client.src.start_your_free_ai")}</CardTitle>
        </CardHeader>
        <CardContent className="space-y-6">
          <div>
            <label className="text-sm font-medium">{t("client.src.property_url")}</label>
            <Input placeholder={t("client.src.httpssahibindencomilan")} value={url} onChange={e => setUrl(e.target.value)} className="mt-1" />
          </div>

          {/* AI Preferences */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="text-sm font-medium">{t("client.src.staging_style")}</label>
              <select value={preferences.stagingStyle} onChange={e => setPreferences({
              ...preferences,
              stagingStyle: e.target.value
            })} className="w-full mt-1 p-2 border rounded-md">
                <option value="modern">{t("client.src.modern")}</option>
                <option value="traditional">{t("client.src.traditional")}</option>
                <option value="minimalist">{t("client.src.minimalist")}</option>
              </select>
            </div>
            <div>
              <label className="text-sm font-medium">{t("client.src.video_length")}</label>
              <select value={preferences.videoLength} onChange={e => setPreferences({
              ...preferences,
              videoLength: e.target.value
            })} className="w-full mt-1 p-2 border rounded-md">
                <option value="short">{t("client.src.short_12_min")}</option>
                <option value="medium">{t("client.src.medium_23_min")}</option>
                <option value="long">{t("client.src.long_35_min")}</option>
              </select>
            </div>
          </div>

          <div className="flex gap-2">
            <Button onClick={handleAnalyze} disabled={loading || !url.trim()} variant="outline">
              {loading ? <><Clock className="w-4 h-4 mr-2 animate-spin" />{t("client.src.analyzing")}</> : <><TrendingUp className="w-4 h-4 mr-2" />{t("client.src.analyze_benefits")}</>}
            </Button>
            <Button onClick={handleMigrate} disabled={loading || !url.trim()} className="flex-1">
              {loading ? <><Clock className="w-4 h-4 mr-2 animate-spin" />{t("client.src.migrating")}</> : <><ArrowRight className="w-4 h-4 mr-2" />{t("client.src.start_free_migration")}</>}
            </Button>
          </div>
        </CardContent>
      </Card>

      {/* Analysis Results */}
      {analysis && <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Star className="w-5 h-5 text-yellow-500" />{t("client.src.migration_analysis_results")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="text-center">
                <div className="text-3xl font-bold text-green-600">${analysis.migrationValue.totalValue}</div>
                <div className="text-sm text-muted-foreground">{t("client.src.total_ai_value")}</div>
              </div>
              <div className="text-center">
                <div className="text-3xl font-bold text-blue-600">{analysis.migrationValue.roi}</div>
                <div className="text-sm text-muted-foreground">{t("client.src.expected_roi")}</div>
              </div>
              <div className="text-center">
                <div className="text-3xl font-bold text-purple-600">{analysis.migrationValue.timeSaved}</div>
                <div className="text-sm text-muted-foreground">{t("client.src.time_saved")}</div>
              </div>
            </div>

            <Separator />

            <div>
              <h4 className="font-semibold mb-3">{t("client.src.ai_enhancements_found")}</h4>
              <div className="space-y-2">
                {analysis.analysis.map((item, index) => <div key={index} className="flex items-center justify-between p-3 bg-muted rounded-lg">
                    <div>
                      <div className="font-medium capitalize">{item.type.replace('_', ' ')}</div>
                      <div className="text-sm text-muted-foreground">{item.estimatedImpact}</div>
                    </div>
                    <Badge variant={item.priority === 'high' ? 'default' : 'secondary'}>
                      {item.priority}{t("client.src.priority")}</Badge>
                  </div>)}
              </div>
            </div>

            <div className="bg-linear-to-r from-green-50 to-blue-50 p-4 rounded-lg">
              <h4 className="font-semibold text-green-800 mb-2">{t("client.src.your_free_benefits")}</h4>
              <ul className="space-y-1 text-sm">
                {analysis.freeBenefits.map((benefit, index) => <li key={index} className="flex items-center gap-2">
                    <CheckCircle2 className="w-4 h-4 text-green-600" />
                    {benefit}
                  </li>)}
              </ul>
            </div>
          </CardContent>
        </Card>}

      {/* Migration Status */}
      {migrationStatus && <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Clock className="w-5 h-5" />{t("client.src.ai_processing_status")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm font-medium">{t("client.src.overall_progress")}</span>
                <span className="text-sm text-muted-foreground">{migrationStatus.progress}%</span>
              </div>
              <Progress value={migrationStatus.progress} className="w-full" />
            </div>
            
            <div className="text-sm text-muted-foreground">
              <div>{t("client.src.completed")}{migrationStatus.completedTasks || 0}/{migrationStatus.totalTasks || 0}{t("client.src.tasks")}</div>
              <div>{t("client.src.estimated_time_remaining")}{migrationStatus.estimatedTimeRemaining || "Calculating..."}</div>
              <div>{t("client.src.current_task")}{migrationStatus.currentTask || "Initializing..."}</div>
            </div>
          </CardContent>
        </Card>}

      {/* Trust Indicators */}
      <Alert>
        <Sparkles className="h-4 w-4" />
        <AlertDescription>
          <strong>{t("client.src.why_migrate_now")}</strong>{t("client.src.get_professional_ai_services")}</AlertDescription>
      </Alert>
    </div>;
}