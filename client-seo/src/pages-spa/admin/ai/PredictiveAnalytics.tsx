"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Progress } from"@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { AlertTriangle, TrendingUp, DollarSign, Home, Activity, BarChart3, Zap } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { useQuery } from"@tanstack/react-query";
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
 const {
 toast
 } = useToast();

 const { data: maintenancePredictions = [], isLoading: maintenanceLoading } = useQuery({
 queryKey: ['predictive-maintenance'],
 queryFn: async () => {
 const res = await apiClient.get('/ai/predictive/maintenance') as { data: AIPredictiveMaintenance[] };
 return res.data || [];
 },
 });

 const { data: priceOptimizations = [], isLoading: priceLoading } = useQuery({
 queryKey: ['price-optimization'],
 queryFn: async () => {
 const res = await apiClient.get('/ai/predictive/price-optimization') as { data: AIPriceOptimization[] };
 return res.data || [];
 },
 });

 const loading = maintenanceLoading || priceLoading;

 const applyPriceOptimization = async (optimizationId: string) => {
 try {
 await apiClient.post(`/ai/predictive/price-optimization/${optimizationId}/apply`);
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_price_optimization_applied_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_apply_price"),
 variant:"destructive"
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
 return <div className="flex items-center justify-center h-64 min-h-screen">
 <Activity className="h-8 w-8 animate-spin text-foreground" />
 </div>;
 }
 return <div className="min-h-screen p-4 md:p-8 space-y-6">
 <div className="space-y-6">
 {/* Header */}
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-3xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_ai_predictive_analytics")}</h1>
 <p className="text-muted-foreground mt-1">{t("admin_ai_deep_insights_from_artificial")}</p>
 </div>

 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_critical_maintenance")}</CardTitle>
 <AlertTriangle className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-red-600">{criticalMaintenance}</div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_highpriority_maintenance_predictions")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_pending_optimizations")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{pendingOptimizations}</div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_price_optimizations_ready_to")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_applied_optimizations")}</CardTitle>
 <DollarSign className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-blue-600">{appliedOptimizations}</div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_successfully_applied_optimizations")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_avg_confidence")}</CardTitle>
 <BarChart3 className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{avgConfidence.toFixed(1)}%</div>
 <Progress value={avgConfidence} className="mt-2" />
 </CardContent>
 </Card>
 </div>

 <Tabs defaultValue="maintenance" className="space-y-4">
 <TabsList className="bg-card border border-border p-1">
 <TabsTrigger value="maintenance" className="data-[state=active]:bg-primary data-[state=active]:text-white text-muted-foreground rounded-lg">{t("admin_ai_maintenance_predictions")}</TabsTrigger>
 <TabsTrigger value="pricing" className="data-[state=active]:bg-primary data-[state=active]:text-white text-muted-foreground rounded-lg">{t("admin_ai_price_optimization")}</TabsTrigger>
 </TabsList>

 <TabsContent value="maintenance" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_ai_maintenance_predictions")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_ai_predictive_maintenance_alerts_for")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_ai_property")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_component")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_risk_level")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_failure_probability")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_predicted_date")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_estimated_cost")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_recommended_action")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_last_inspection")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {maintenancePredictions.map(prediction => <TableRow key={prediction.id} className="border-border">
 <TableCell className="font-medium text-foreground">
 <div className="flex items-center gap-2">
 <Home className="h-4 w-4 text-muted-foreground" />{t("admin_ai_property")}{prediction.propertyId}
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="text-muted-foreground">{prediction.componentType}</Badge>
 </TableCell>
 <TableCell>
 <Badge variant={getRiskBadgeVariant(prediction.riskLevel)}>
 {prediction.riskLevel}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <Progress value={prediction.failureProbability} className="w-16" />
 <span className="text-sm text-foreground">{prediction.failureProbability}%</span>
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">
 {prediction.predictedFailureDate ? new Date(prediction.predictedFailureDate).toLocaleDateString() :"Not predicted"}
 </TableCell>
 <TableCell className="text-foreground">
 {prediction.estimatedCost ? `$${prediction.estimatedCost.toLocaleString()}` :"N/A"}
 </TableCell>
 <TableCell className="max-w-xs">
 <p className="text-sm truncate text-muted-foreground">
 {prediction.recommendedAction ||"No recommendation"}
 </p>
 </TableCell>
 <TableCell className="text-muted-foreground">
 {prediction.lastInspectionDate ? new Date(prediction.lastInspectionDate).toLocaleDateString() :"Never"}
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="pricing" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_ai_price_optimization")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_ai_smart_pricing_recommendations_based")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_ai_listing")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_current_price")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_recommended_price")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_confidence")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_potential_change")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_generated")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {priceOptimizations.map(optimization => {
 const priceChange = optimization.recommendedPrice - optimization.currentPrice;
 const changePercent = priceChange / optimization.currentPrice * 100;
 return <TableRow key={optimization.id} className="animate-in fade-in slide-in-from-bottom-4 duration-700 border-border">
 <TableCell className="font-medium text-foreground">{t("admin_ai_listing")}{optimization.listingId}
 </TableCell>
 <TableCell className="text-foreground">{t("currency_symbol", "$")}{optimization.currentPrice.toLocaleString()}</TableCell>
 <TableCell className="text-foreground">{t("currency_symbol", "$")}{optimization.recommendedPrice.toLocaleString()}</TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <Progress value={optimization.confidence} className="w-16" />
 <span className="text-sm text-foreground">{optimization.confidence}%</span>
 </div>
 </TableCell>
 <TableCell>
 <span className={`text-sm font-medium ${priceChange > 0 ? 'text-blue-600' : priceChange < 0 ? 'text-red-600' : 'text-muted-foreground'}`}>
 {priceChange > 0 ? '+' : ''}{changePercent.toFixed(1)}%
 </span>
 </TableCell>
 <TableCell>
 <Badge variant={optimization.isApplied ?"default" :"secondary"}>
 {optimization.isApplied ?"Applied" :"Pending"}
 </Badge>
 </TableCell>
 <TableCell className="text-muted-foreground">
 {new Date(optimization.generatedAt).toLocaleDateString()}
 </TableCell>
 <TableCell>
 {!optimization.isApplied && <button onClick={() => applyPriceOptimization(optimization.id)} className="inline-flex items-center px-3 py-1 rounded-xl text-sm font-medium bg-muted text-foreground hover:bg-muted">
 <Zap className="h-3 w-3 mr-1" />{t("admin_ai_apply")}</button>}
 </TableCell>
 </TableRow>;
 })}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Price Optimization Insights */}
 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_market_factors")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="flex justify-between items-center">
 <span className="text-sm text-muted-foreground">{t("admin_ai_comparable_sales")}</span>
 <span className="font-medium text-foreground">+12.3%</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-muted-foreground">{t("admin_ai_seasonal_trends")}</span>
 <span className="font-medium text-foreground">+5.7%</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-muted-foreground">{t("admin_ai_location_premium")}</span>
 <span className="font-medium text-foreground">+8.9%</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-muted-foreground">{t("admin_ai_economic_indicators")}</span>
 <span className="font-medium text-foreground">-2.1%</span>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_optimization_impact")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="text-center">
 <div className="text-2xl font-bold text-blue-600">+15.2%</div>
 <p className="text-sm text-muted-foreground">{t("admin_ai_average_price_increase")}</p>
 </div>
 <div className="text-center">
 <div className="text-2xl font-bold text-muted-foreground">+8.7%</div>
 <p className="text-sm text-muted-foreground">{t("admin_ai_faster_time_to_sale")}</p>
 </div>
 <div className="text-center">
 <div className="text-2xl font-bold text-muted-foreground">+23.1%</div>
 <p className="text-sm text-muted-foreground">{t("admin_ai_increased_buyer_interest")}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </TabsContent>
 </Tabs>
 </div>
 </div>;
}
