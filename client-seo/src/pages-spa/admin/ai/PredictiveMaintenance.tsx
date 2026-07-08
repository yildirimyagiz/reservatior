"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { cn } from "@/lib/utils";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, AlertTriangle, CheckCircle, Clock, Wrench, DollarSign, Eye, Edit, RefreshCw } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Progress } from "@/components/ui/progress";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
interface MaintenancePrediction {
  id: string;
  orgId: string;
  propertyId: string;
  systemType: string;
  component: string;
  riskLevel: RiskLevel;
  probability: number;
  estimatedFailureDate: string;
  estimatedCost: number;
  urgency: Urgency;
  confidence: number;
  lastMaintenanceDate?: string;
  predictedIssue: string;
  recommendedAction: string;
  status: PredictionStatus;
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    name: string;
    addressLine1: string;
    city: string;
    state: string;
  };
}
enum RiskLevel {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  CRITICAL = "CRITICAL",
}
enum Urgency {
  ROUTINE = "ROUTINE",
  SCHEDULED = "SCHEDULED",
  URGENT = "URGENT",
  IMMEDIATE = "IMMEDIATE",
}
enum PredictionStatus {
  ACTIVE = "ACTIVE",
  ADDRESSED = "ADDRESSED",
  IGNORED = "IGNORED",
  COMPLETED = "COMPLETED",
}
const getRiskConfig = (t: any) => ({
  LOW: {
    label: t("admin.ai.low", "Düşük"),
    color: "bg-green-100 text-green-700",
    icon: CheckCircle
  },
  MEDIUM: {
    label: t("admin.ai.medium", "Orta"),
    color: "bg-yellow-100 text-yellow-700",
    icon: Clock
  },
  HIGH: {
    label: t("admin.ai.high", "Yüksek"),
    color: "bg-orange-100 text-orange-700",
    icon: AlertTriangle
  },
  CRITICAL: {
    label: t("admin.ai.critical", "Kritik"),
    color: "bg-red-100 text-red-700",
    icon: AlertTriangle
  }
});

const getUrgencyConfig = (t: any) => ({
  ROUTINE: {
    label: t("admin.ai.routine", "Rutin"),
    color: "bg-slate-100 text-slate-700"
  },
  SCHEDULED: {
    label: t("admin.ai.scheduled", "Planlı"),
    color: "bg-slate-100 text-slate-700"
  },
  URGENT: {
    label: t("admin.ai.urgent", "Acil"),
    color: "bg-orange-100 text-orange-700"
  },
  IMMEDIATE: {
    label: t("admin.ai.immediate", "Derhal"),
    color: "bg-red-100 text-red-700"
  }
});

const getLocalizedStatus = (status: string, t: any) => {
  const map: Record<string, string> = {
    'ACTIVE': t('admin.ai.status.active', 'Aktif'),
    'ADDRESSED': t('admin.ai.status.addressed', 'Ele Alındı'),
    'IGNORED': t('admin.ai.status.ignored', 'Görmezden Gelindi'),
    'COMPLETED': t('admin.ai.status.completed', 'Tamamlandı')
  };
  return map[status] || status;
};

const getLocalizedSystemType = (type: string, t: any) => {
  const map: Record<string, string> = {
    'HVAC': t('admin.ai.system.hvac', 'İklimlendirme (HVAC)'),
    'PLUMBING': t('admin.ai.system.plumbing', 'Sıhhi Tesisat'),
    'ELECTRICAL': t('admin.ai.system.electrical', 'Elektrik'),
    'STRUCTURAL': t('admin.ai.system.structural', 'Yapısal'),
    'APPLIANCE': t('admin.ai.system.appliance', 'Eşya/Cihaz')
  };
  return map[type] || type;
};
export default function PredictiveMaintenance() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterRisk, setFilterRisk] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [predictions, setPredictions] = useState<MaintenancePrediction[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedPrediction, setSelectedPrediction] = useState<MaintenancePrediction | null>(null);

  // Fetch predictions from API
  useEffect(() => {
    const fetchPredictions = async () => {
      try {
        setLoading(true);
        const response = await apiClient.get('/ai/maintenance-predictions', {
          page: "1",
          limit: "50"
        });
        setPredictions((response as any).data || []);
      } catch (error) {
        console.error('Error fetching predictions:', error);
        toast({
          title: t("admin_ai_error"),
          description: t("admin_ai_failed_to_load_maintenance"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchPredictions();
  }, []);
  const filteredPredictions = predictions.filter(prediction => {
    const matchesSearch = prediction.property?.name?.toLowerCase().includes(search.toLowerCase()) || prediction.systemType.toLowerCase().includes(search.toLowerCase()) || prediction.component.toLowerCase().includes(search.toLowerCase());
    const matchesRisk = filterRisk === "all" || prediction.riskLevel === filterRisk;
    const matchesStatus = filterStatus === "all" || prediction.status === filterStatus;
    return matchesSearch && matchesRisk && matchesStatus;
  });
  const totalPredictions = filteredPredictions.length;
  const criticalPredictions = filteredPredictions.filter(p => p.riskLevel === "CRITICAL").length;
  const highPredictions = filteredPredictions.filter(p => p.riskLevel === "HIGH").length;
  const totalEstimatedCost = filteredPredictions.reduce((sum, p) => sum + p.estimatedCost, 0);
  const handleUpdateStatus = async (id: string, status: PredictionStatus) => {
    try {
      await apiClient.patch(`/ai/maintenance-predictions/${id}`, {
        status
      });
      setPredictions(predictions.map(p => p.id === id ? {
        ...p,
        status
      } : p));
      toast({
        title: t("admin_ai_status_updated"),
        description: t("admin_ai_prediction_status_has_been")
      });
    } catch (error) {
      console.error('Error updating status:', error);
    }
  };
  const handleRefreshPredictions = async () => {
    try {
      await apiClient.post('/ai/maintenance-predictions/refresh');
      toast({
        title: t("admin_ai_refresh_started"),
        description: t("admin_ai_ai_model_is_analyzing")
      });
    } catch (error) {
      console.error('Error refreshing predictions:', error);
    }
  };
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  };
  const getRiskIcon = (riskLevel: RiskLevel) => {
    const config = getRiskConfig(t)[riskLevel];
    return config ? <config.icon className="h-4 w-4" /> : null;
  };
  const getRiskColor = (riskLevel: RiskLevel) => {
    const config = getRiskConfig(t)[riskLevel];
    return config ? config.color : "bg-white/5 text-slate-300";
  };
  const getUrgencyColor = (urgency: Urgency) => {
    const config = getUrgencyConfig(t)[urgency];
    return config ? config.color : "bg-white/5 text-slate-300";
  };
  return <PageShell title={t("admin_ai_predictive_maintenance")} description={t("admin_ai_aipowered_maintenance_predictions_and")}>
      <div className="space-y-6">
        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_total_predictions")}</CardTitle>
              <AlertTriangle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalPredictions}</div>
              <p className="text-xs text-muted-foreground">{t("admin_ai_ai_predictions")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_critical")}</CardTitle>
              <AlertTriangle className="h-4 w-4 text-red-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-red-600">{criticalPredictions}</div>
              <p className="text-xs text-muted-foreground">{t("admin_ai_immediate_attention")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_high_risk")}</CardTitle>
              <AlertTriangle className="h-4 w-4 text-orange-500" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-orange-600">{highPredictions}</div>
              <p className="text-xs text-muted-foreground">{t("admin_ai_review_soon")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_est_cost")}</CardTitle>
              <DollarSign className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-slate-600">{formatCurrency(totalEstimatedCost)}</div>
              <p className="text-xs text-muted-foreground">{t("admin_ai_total_estimated")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-4">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-slate-500 dark:text-slate-400" />
              <Input placeholder={t("admin_ai_search_predictions")} value={search} onChange={e => setSearch(e.target.value)} className="pl-8 w-64" />
            </div>
            <Select value={filterRisk} onValueChange={setFilterRisk}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("admin_ai_risk_level")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin_ai_all_risks")}</SelectItem>
                {Object.values(RiskLevel).map(risk => <SelectItem key={risk} value={risk}>
                    {getRiskConfig(t)[risk]?.label || risk}
                  </SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("admin_ai_status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin_ai_all_status")}</SelectItem>
                {Object.values(PredictionStatus).map(status => <SelectItem key={status} value={status}>
                    {getLocalizedStatus(status, t)}
                  </SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <Button onClick={handleRefreshPredictions}>
            <RefreshCw className="h-4 w-4 mr-2" />{t("admin_ai_refresh_ai")}</Button>
        </div>

        {/* Predictions Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin_ai_maintenance_predictions")}</CardTitle>
            <CardDescription>{t("admin_ai_aipowered_predictions_for_equipment")}</CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? <div className="flex items-center justify-center py-8">
                <div className="text-sm text-muted-foreground">{t("admin_ai_loading_predictions")}</div>
              </div> : <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("admin_ai_property")}</TableHead>
                    <TableHead>{t("admin_ai_system")}</TableHead>
                    <TableHead>{t("admin_ai_component")}</TableHead>
                    <TableHead>{t("admin_ai_risk_level")}</TableHead>
                    <TableHead>{t("admin_ai_probability")}</TableHead>
                    <TableHead>{t("admin_ai_est_failure")}</TableHead>
                    <TableHead>{t("admin_ai_est_cost")}</TableHead>
                    <TableHead>{t("admin_ai_urgency")}</TableHead>
                    <TableHead>{t("admin_ai_status")}</TableHead>
                    <TableHead className="w-[50px]"></TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredPredictions.length === 0 ? <TableRow>
                      <TableCell colSpan={10} className="text-center py-8">{t("admin_ai_no_predictions_found")}</TableCell>
                    </TableRow> : filteredPredictions.map(prediction => <TableRow key={prediction.id}>
                        <TableCell>
                          <div>
                            <div className="font-medium">{prediction.property?.name}</div>
                            <div className="text-sm text-muted-foreground">
                              {prediction.property?.addressLine1}, {prediction.property?.city}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline">{getLocalizedSystemType(prediction.systemType, t)}</Badge>
                        </TableCell>
                        <TableCell className="font-medium">{prediction.component}</TableCell>
                        <TableCell>
                          <Badge className={getRiskColor(prediction.riskLevel)}>
                            <div className="flex items-center space-x-1">
                              {getRiskIcon(prediction.riskLevel)}
                              <span>{getRiskConfig(t)[prediction.riskLevel]?.label}</span>
                            </div>
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center space-x-2">
                            <Progress value={prediction.probability * 100} className="w-16" />
                            <span className="text-sm">{Math.round(prediction.probability * 100)}%</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">{formatDate(prediction.estimatedFailureDate)}</div>
                        </TableCell>
                        <TableCell className="font-medium">
                          {formatCurrency(prediction.estimatedCost)}
                        </TableCell>
                        <TableCell>
                          <Badge className={getUrgencyColor(prediction.urgency)}>
                            {getUrgencyConfig(t)[prediction.urgency]?.label}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <Select value={prediction.status} onValueChange={value => handleUpdateStatus(prediction.id, value as PredictionStatus)}>
                            <SelectTrigger className="w-32">
                              <SelectValue />
                            </SelectTrigger>
                            <SelectContent>
                              {Object.values(PredictionStatus).map(status => <SelectItem key={status} value={status}>
                                  {getLocalizedStatus(status, t)}
                                </SelectItem>)}
                            </SelectContent>
                          </Select>
                        </TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm">
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem onClick={() => setSelectedPrediction(prediction)}>
                                <Eye className="h-4 w-4 mr-2" />{t("admin_ai_view_details")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Wrench className="h-4 w-4 mr-2" />{t("admin_ai_schedule_maintenance")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Edit className="h-4 w-4 mr-2" />{t("admin_ai_edit_prediction")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <DollarSign className="h-4 w-4 mr-2" />{t("admin_ai_view_cost_breakdown")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>}
          </CardContent>
        </Card>

        {/* Prediction Details Dialog */}
        <Dialog open={!!selectedPrediction} onOpenChange={() => setSelectedPrediction(null)}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>{t("admin_ai_maintenance_prediction_details")}</DialogTitle>
              <DialogDescription>{t("admin_ai_detailed_analysis_and_recommendations")}</DialogDescription>
            </DialogHeader>
            {selectedPrediction && <div className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>{t("admin_ai_property")}</Label>
                    <div className="font-medium">{selectedPrediction.property?.name}</div>
                    <div className="text-sm text-muted-foreground">
                      {selectedPrediction.property?.addressLine1}
                    </div>
                  </div>
                  <div>
                    <Label>{t("admin_ai_system_component")}</Label>
                    <div className="font-medium">{selectedPrediction.systemType}</div>
                    <div className="text-sm text-muted-foreground">{selectedPrediction.component}</div>
                  </div>
                </div>
                
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>{t("admin_ai_risk_assessment")}</Label>
                    <div className="flex items-center space-x-2 mt-1">
                      <Badge className={getRiskColor(selectedPrediction.riskLevel)}>
                        {getRiskConfig(t)[selectedPrediction.riskLevel]?.label}
                      </Badge>
                      <span className="text-sm">({Math.round(selectedPrediction.probability * 100)}{t("admin_ai_confidence")}</span>
                    </div>
                  </div>
                  <div>
                    <Label>{t("admin_ai_urgency")}</Label>
                    <Badge className={cn(getUrgencyColor(selectedPrediction.urgency), "mt-1")}>
                      {getUrgencyConfig(t)[selectedPrediction.urgency]?.label}
                    </Badge>
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>{t("admin_ai_estimated_failure_date")}</Label>
                    <div className="font-medium">{formatDate(selectedPrediction.estimatedFailureDate)}</div>
                  </div>
                  <div>
                    <Label>{t("admin_ai_estimated_cost")}</Label>
                    <div className="font-medium">{formatCurrency(selectedPrediction.estimatedCost)}</div>
                  </div>
                </div>

                <div>
                  <Label>{t("admin_ai_predicted_issue")}</Label>
                  <div className="mt-1 p-3 bg-white/5 rounded-lg">
                    {selectedPrediction.predictedIssue}
                  </div>
                </div>

                <div>
                  <Label>{t("admin_ai_recommended_action")}</Label>
                  <div className="mt-1 p-3 bg-slate-50 rounded-lg">
                    {selectedPrediction.recommendedAction}
                  </div>
                </div>

                {selectedPrediction.lastMaintenanceDate && <div>
                    <Label>{t("admin_ai_last_maintenance")}</Label>
                    <div className="mt-1">{formatDate(selectedPrediction.lastMaintenanceDate)}</div>
                  </div>}

                <div className="flex justify-end space-x-2">
                  <Button variant="outline">
                    <Wrench className="h-4 w-4 mr-2" />{t("admin_ai_schedule_maintenance")}</Button>
                  <Button>
                    <DollarSign className="h-4 w-4 mr-2" />{t("admin_ai_create_work_order")}</Button>
                </div>
              </div>}
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}