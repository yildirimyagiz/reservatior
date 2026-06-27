import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { AlertTriangle, TrendingUp, DollarSign, Home, Activity, BarChart3, Zap } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
interface AIPredictiveMaintenance {
  id: string;
  orgId?: string;
  propertyId: string;
  componentType: string;
  failureProbability: number;
  predictedFailureDate?: Date;
  riskLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  estimatedCost?: number;
  contributingFactors: any;
  lastInspectionDate?: Date;
  recommendedAction?: string;
  generatedAt: Date;
  createdAt: Date;
}
interface AIPriceOptimization {
  id: string;
  orgId?: string;
  listingId: string;
  currentPrice: number;
  recommendedPrice: number;
  priceRange: any;
  factors: any;
  comparableData: any;
  marketTrends: any;
  confidence: number;
  generatedAt: Date;
  isApplied: boolean;
  appliedAt?: Date;
  createdAt: Date;
}
export default function PredictiveAnalytics() {
  const {
    t
  } = useTranslation();
  const [maintenancePredictions, setMaintenancePredictions] = useState<AIPredictiveMaintenance[]>([]);
  const [priceOptimizations, setPriceOptimizations] = useState<AIPriceOptimization[]>([]);
  const [loading, setLoading] = useState(true);
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchPredictions();
  }, []);
  const fetchPredictions = async () => {
    try {
      const [maintenanceRes, priceRes] = await Promise.all([apiClient.get('/ai/predictive/maintenance') as Promise<{
        data: AIPredictiveMaintenance[];
      }>, apiClient.get('/ai/predictive/price-optimization') as Promise<{
        data: AIPriceOptimization[];
      }>]);
      setMaintenancePredictions(maintenanceRes.data);
      setPriceOptimizations(priceRes.data);
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_fetch_predictive"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const applyPriceOptimization = async (optimizationId: string) => {
    try {
      await apiClient.post(`/ai/predictive/price-optimization/${optimizationId}/apply`);
      setPriceOptimizations(priceOptimizations.map(opt => opt.id === optimizationId ? {
        ...opt,
        isApplied: true,
        appliedAt: new Date()
      } : opt));
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.price_optimization_applied_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_apply_price"),
        variant: "destructive"
      });
    }
  };
  const getRiskBadgeVariant = (riskLevel: string) => {
    switch (riskLevel) {
      case 'LOW':
        return 'default';
      case 'MEDIUM':
        return 'secondary';
      case 'HIGH':
        return 'destructive';
      case 'CRITICAL':
        return 'destructive';
      default:
        return 'outline';
    }
  };
  const criticalMaintenance = maintenancePredictions.filter(p => p.riskLevel === 'CRITICAL').length;
  const pendingOptimizations = priceOptimizations.filter(p => !p.isApplied).length;
  const appliedOptimizations = priceOptimizations.filter(p => p.isApplied).length;
  const avgConfidence = priceOptimizations.length > 0 ? priceOptimizations.reduce((acc, p) => acc + p.confidence, 0) / priceOptimizations.length : 0;
  if (loading) {
    return <PageShell title={t("admin.ai.predictive_analytics")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.ai.predictive_analytics")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.critical_maintenance")}</CardTitle>
              <AlertTriangle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-red-600">{criticalMaintenance}</div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.highpriority_maintenance_predictions")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.pending_optimizations")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{pendingOptimizations}</div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.price_optimizations_ready_to")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.applied_optimizations")}</CardTitle>
              <DollarSign className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{appliedOptimizations}</div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.successfully_applied_optimizations")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.avg_confidence")}</CardTitle>
              <BarChart3 className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{avgConfidence.toFixed(1)}%</div>
              <Progress value={avgConfidence} className="mt-2" />
            </CardContent>
          </Card>
        </div>

        <Tabs defaultValue="maintenance" className="space-y-4">
          <TabsList>
            <TabsTrigger value="maintenance">{t("admin.ai.maintenance_predictions")}</TabsTrigger>
            <TabsTrigger value="pricing">{t("admin.ai.price_optimization")}</TabsTrigger>
          </TabsList>

          <TabsContent value="maintenance" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.ai.ai_maintenance_predictions")}</CardTitle>
                <p className="text-sm text-muted-foreground">{t("admin.ai.predictive_maintenance_alerts_for")}</p>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.ai.property")}</TableHead>
                      <TableHead>{t("admin.ai.component")}</TableHead>
                      <TableHead>{t("admin.ai.risk_level")}</TableHead>
                      <TableHead>{t("admin.ai.failure_probability")}</TableHead>
                      <TableHead>{t("admin.ai.predicted_date")}</TableHead>
                      <TableHead>{t("admin.ai.estimated_cost")}</TableHead>
                      <TableHead>{t("admin.ai.recommended_action")}</TableHead>
                      <TableHead>{t("admin.ai.last_inspection")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {maintenancePredictions.map(prediction => <TableRow key={prediction.id}>
                        <TableCell className="font-medium">
                          <div className="flex items-center gap-2">
                            <Home className="h-4 w-4" />{t("admin.ai.property")}{prediction.propertyId}
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline">{prediction.componentType}</Badge>
                        </TableCell>
                        <TableCell>
                          <Badge variant={getRiskBadgeVariant(prediction.riskLevel)}>
                            {prediction.riskLevel}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <Progress value={prediction.failureProbability} className="w-16" />
                            <span className="text-sm">{prediction.failureProbability}%</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          {prediction.predictedFailureDate ? new Date(prediction.predictedFailureDate).toLocaleDateString() : "Not predicted"}
                        </TableCell>
                        <TableCell>
                          {prediction.estimatedCost ? `$${prediction.estimatedCost.toLocaleString()}` : "N/A"}
                        </TableCell>
                        <TableCell className="max-w-xs">
                          <p className="text-sm truncate">
                            {prediction.recommendedAction || "No recommendation"}
                          </p>
                        </TableCell>
                        <TableCell>
                          {prediction.lastInspectionDate ? new Date(prediction.lastInspectionDate).toLocaleDateString() : "Never"}
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="pricing" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.ai.ai_price_optimization")}</CardTitle>
                <p className="text-sm text-muted-foreground">{t("admin.ai.smart_pricing_recommendations_based")}</p>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.ai.listing")}</TableHead>
                      <TableHead>{t("admin.ai.current_price")}</TableHead>
                      <TableHead>{t("admin.ai.recommended_price")}</TableHead>
                      <TableHead>{t("admin.ai.confidence")}</TableHead>
                      <TableHead>{t("admin.ai.potential_change")}</TableHead>
                      <TableHead>{t("admin.ai.status")}</TableHead>
                      <TableHead>{t("admin.ai.generated")}</TableHead>
                      <TableHead>{t("admin.ai.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {priceOptimizations.map(optimization => {
                    const priceChange = optimization.recommendedPrice - optimization.currentPrice;
                    const changePercent = priceChange / optimization.currentPrice * 100;
                    return <TableRow key={optimization.id}>
                          <TableCell className="font-medium">{t("admin.ai.listing")}{optimization.listingId}
                          </TableCell>
                          <TableCell>${optimization.currentPrice.toLocaleString()}</TableCell>
                          <TableCell>${optimization.recommendedPrice.toLocaleString()}</TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <Progress value={optimization.confidence} className="w-16" />
                              <span className="text-sm">{optimization.confidence}%</span>
                            </div>
                          </TableCell>
                          <TableCell>
                            <span className={`text-sm font-medium ${priceChange > 0 ? 'text-green-600' : priceChange < 0 ? 'text-red-600' : 'text-gray-600'}`}>
                              {priceChange > 0 ? '+' : ''}{changePercent.toFixed(1)}%
                            </span>
                          </TableCell>
                          <TableCell>
                            <Badge variant={optimization.isApplied ? "default" : "secondary"}>
                              {optimization.isApplied ? "Applied" : "Pending"}
                            </Badge>
                          </TableCell>
                          <TableCell>
                            {new Date(optimization.generatedAt).toLocaleDateString()}
                          </TableCell>
                          <TableCell>
                            {!optimization.isApplied && <button onClick={() => applyPriceOptimization(optimization.id)} className="inline-flex items-center px-3 py-1 rounded-md text-sm font-medium bg-blue-600 text-foreground hover:bg-blue-700">
                                <Zap className="h-3 w-3 mr-1" />{t("admin.ai.apply")}</button>}
                          </TableCell>
                        </TableRow>;
                  })}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>

            {/* Price Optimization Insights */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.ai.market_factors")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div className="flex justify-between items-center">
                      <span className="text-sm">{t("admin.ai.comparable_sales")}</span>
                      <span className="font-medium">+12.3%</span>
                    </div>
                    <div className="flex justify-between items-center">
                      <span className="text-sm">{t("admin.ai.seasonal_trends")}</span>
                      <span className="font-medium">+5.7%</span>
                    </div>
                    <div className="flex justify-between items-center">
                      <span className="text-sm">{t("admin.ai.location_premium")}</span>
                      <span className="font-medium">+8.9%</span>
                    </div>
                    <div className="flex justify-between items-center">
                      <span className="text-sm">{t("admin.ai.economic_indicators")}</span>
                      <span className="font-medium">-2.1%</span>
                    </div>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.ai.optimization_impact")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div className="text-center">
                      <div className="text-2xl font-bold text-green-600">+15.2%</div>
                      <p className="text-sm text-muted-foreground">{t("admin.ai.average_price_increase")}</p>
                    </div>
                    <div className="text-center">
                      <div className="text-2xl font-bold text-blue-600">+8.7%</div>
                      <p className="text-sm text-muted-foreground">{t("admin.ai.faster_time_to_sale")}</p>
                    </div>
                    <div className="text-center">
                      <div className="text-2xl font-bold text-purple-600">+23.1%</div>
                      <p className="text-sm text-muted-foreground">{t("admin.ai.increased_buyer_interest")}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}