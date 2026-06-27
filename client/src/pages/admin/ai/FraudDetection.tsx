import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Shield, AlertTriangle, CheckCircle, XCircle, MoreHorizontal, Eye, Activity, TrendingUp } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { Label } from "@/components/ui/label";
interface AIFraudDetection {
  id: string;
  orgId?: string;
  entityType: string;
  entityId: string;
  riskScore: number;
  riskFactors: any;
  riskCategory: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  recommendedActions: any[];
  detectedAt: Date;
  reviewedAt?: Date;
  reviewedBy?: string;
  resolution?: string;
  createdAt: Date;
}
export default function FraudDetection() {
  const {
    t
  } = useTranslation();
  const [fraudAlerts, setFraudAlerts] = useState<AIFraudDetection[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedAlert, setSelectedAlert] = useState<AIFraudDetection | null>(null);
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchFraudAlerts();
  }, []);
  const fetchFraudAlerts = async () => {
    try {
      setLoading(true);
      const response = await apiClient.get('/ai/fraud-detection/alerts');
      setFraudAlerts((response as any).data || []);
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_fetch_fraud"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const resolveAlert = async (alertId: string, resolution: string) => {
    try {
      await apiClient.put(`/ai/fraud-detection/alerts/${alertId}/resolve`, {
        resolution
      });
      setFraudAlerts(fraudAlerts.map(alert => alert.id === alertId ? {
        ...alert,
        resolution,
        reviewedAt: new Date()
      } : alert));
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.fraud_alert_resolved_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_resolve_fraud"),
        variant: "destructive"
      });
    }
  };
  const getRiskColor = (riskScore: number) => {
    if (riskScore >= 80) return 'text-red-600';
    if (riskScore >= 60) return 'text-orange-600';
    if (riskScore >= 40) return 'text-yellow-600';
    return 'text-green-600';
  };
  const getRiskBadgeVariant = (riskCategory: string) => {
    switch (riskCategory) {
      case 'CRITICAL':
        return 'destructive';
      case 'HIGH':
        return 'destructive';
      case 'MEDIUM':
        return 'secondary';
      case 'LOW':
        return 'default';
      default:
        return 'outline';
    }
  };
  const criticalAlerts = fraudAlerts.filter(a => a.riskCategory === 'CRITICAL').length;
  const unresolvedAlerts = fraudAlerts.filter(a => !a.resolution).length;
  const resolvedToday = fraudAlerts.filter(a => a.resolution && new Date(a.reviewedAt!).toDateString() === new Date().toDateString()).length;
  const avgRiskScore = fraudAlerts.length > 0 ? fraudAlerts.reduce((acc, a) => acc + a.riskScore, 0) / fraudAlerts.length : 0;
  if (loading) {
    return <PageShell title={t("admin.ai.ai_fraud_detection")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.ai.ai_fraud_detection")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.critical_alerts")}</CardTitle>
              <AlertTriangle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-red-600">{criticalAlerts}</div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.highpriority_fraud_alerts")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.unresolved_alerts")}</CardTitle>
              <Shield className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{unresolvedAlerts}</div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.require_manual_review")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.resolved_today")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{resolvedToday}</div>
              <p className="text-xs text-muted-foreground">{t("admin.ai.successfully_handled")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.avg_risk_score")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className={`text-2xl font-bold ${getRiskColor(avgRiskScore)}`}>
                {avgRiskScore.toFixed(1)}
              </div>
              <Progress value={avgRiskScore} className="mt-2" />
            </CardContent>
          </Card>
        </div>

        {/* Fraud Alerts Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.ai.fraud_detection_alerts")}</CardTitle>
            <p className="text-sm text-muted-foreground">{t("admin.ai.aipowered_fraud_detection_and")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.ai.entity")}</TableHead>
                  <TableHead>{t("admin.ai.risk_category")}</TableHead>
                  <TableHead>{t("admin.ai.risk_score")}</TableHead>
                  <TableHead>{t("admin.ai.detected_at")}</TableHead>
                  <TableHead>{t("admin.ai.status")}</TableHead>
                  <TableHead>{t("admin.ai.reviewed_by")}</TableHead>
                  <TableHead className="text-right">{t("admin.ai.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {fraudAlerts.map(alert => <TableRow key={alert.id}>
                    <TableCell className="font-medium">
                      <div>
                        <div className="font-medium">{alert.entityType}</div>
                        <div className="text-xs text-muted-foreground font-mono">{alert.entityId}</div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge variant={getRiskBadgeVariant(alert.riskCategory)}>
                        {alert.riskCategory}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <span className={`font-bold ${getRiskColor(alert.riskScore)}`}>
                          {alert.riskScore}
                        </span>
                        <Progress value={alert.riskScore} className="w-16" />
                      </div>
                    </TableCell>
                    <TableCell>
                      {new Date(alert.detectedAt).toLocaleString()}
                    </TableCell>
                    <TableCell>
                      {alert.resolution ? <Badge variant="default">
                          <CheckCircle className="h-3 w-3 mr-1" />{t("admin.ai.resolved")}</Badge> : <Badge variant="secondary">
                          <AlertTriangle className="h-3 w-3 mr-1" />{t("admin.ai.pending")}</Badge>}
                    </TableCell>
                    <TableCell>
                      {alert.reviewedBy || "Unassigned"}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin.ai.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem onClick={() => setSelectedAlert(alert)}>
                            <Eye className="h-4 w-4 mr-2" />{t("admin.ai.view_details")}</DropdownMenuItem>
                          {!alert.resolution && <>
                              <DropdownMenuSeparator />
                              <DropdownMenuItem onClick={() => resolveAlert(alert.id, 'APPROVED')} className="text-green-600">
                                <CheckCircle className="h-4 w-4 mr-2" />{t("admin.ai.mark_as_safe")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => resolveAlert(alert.id, 'BLOCKED')} className="text-red-600">
                                <XCircle className="h-4 w-4 mr-2" />{t("admin.ai.block_entity")}</DropdownMenuItem>
                            </>}
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Risk Factors Summary */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.ai.common_risk_factors")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.ai.suspicious_ip_address")}</span>
                  <span className="font-medium">45%</span>
                </div>
                <Progress value={45} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.ai.unusual_transaction_pattern")}</span>
                  <span className="font-medium">32%</span>
                </div>
                <Progress value={32} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.ai.new_device_fingerprint")}</span>
                  <span className="font-medium">28%</span>
                </div>
                <Progress value={28} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.ai.inconsistent_user_data")}</span>
                  <span className="font-medium">18%</span>
                </div>
                <Progress value={18} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.ai.velocity_check_failed")}</span>
                  <span className="font-medium">12%</span>
                </div>
                <Progress value={12} className="h-2" />
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.ai.fraud_prevention_metrics")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-green-600">98.7%</div>
                  <p className="text-sm text-muted-foreground">{t("admin.ai.detection_accuracy")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-blue-600">0.02%</div>
                  <p className="text-sm text-muted-foreground">{t("admin.ai.false_positive_rate")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-purple-600">{t("admin.ai.23s")}</div>
                  <p className="text-sm text-muted-foreground">{t("admin.ai.avg_response_time")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-orange-600">{t("admin.ai.24m")}</div>
                  <p className="text-sm text-muted-foreground">{t("admin.ai.fraud_prevented_monthly")}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Alert Details Modal would go here */}
        {selectedAlert && <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4">
            <Card className="max-w-2xl w-full max-h-[80vh] overflow-y-auto">
              <CardHeader>
                <CardTitle>{t("admin.ai.fraud_alert_details")}</CardTitle>
                <Button variant="ghost" className="absolute right-4 top-4" onClick={() => setSelectedAlert(null)}>
                  ×
                </Button>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>{t("admin.ai.entity_type")}</Label>
                    <p className="mt-1">{selectedAlert.entityType}</p>
                  </div>
                  <div>
                    <Label>{t("admin.ai.entity_id")}</Label>
                    <p className="mt-1 font-mono text-sm">{selectedAlert.entityId}</p>
                  </div>
                  <div>
                    <Label>{t("admin.ai.risk_score")}</Label>
                    <p className={`mt-1 font-bold ${getRiskColor(selectedAlert.riskScore)}`}>
                      {selectedAlert.riskScore}/100
                    </p>
                  </div>
                  <div>
                    <Label>{t("admin.ai.risk_category")}</Label>
                    <Badge variant={getRiskBadgeVariant(selectedAlert.riskCategory)} className="mt-1">
                      {selectedAlert.riskCategory}
                    </Badge>
                  </div>
                </div>

                <div>
                  <Label>{t("admin.ai.risk_factors")}</Label>
                  <div className="mt-2 space-y-2">
                    {selectedAlert.riskFactors && Object.entries(selectedAlert.riskFactors).map(([key, value]) => <div key={key} className="flex justify-between p-2 bg-gray-50 rounded">
                        <span className="text-sm">{key}</span>
                        <span className="text-sm font-medium">{String(value)}</span>
                      </div>)}
                  </div>
                </div>

                {selectedAlert.recommendedActions && selectedAlert.recommendedActions.length > 0 && <div>
                    <Label>{t("admin.ai.recommended_actions")}</Label>
                    <div className="mt-2 space-y-2">
                      {selectedAlert.recommendedActions.map((action, index) => <div key={index} className="p-2 border rounded">
                          <p className="text-sm">{action}</p>
                        </div>)}
                    </div>
                  </div>}

                {selectedAlert.resolution && <div>
                    <Label>{t("admin.ai.resolution")}</Label>
                    <p className="mt-1">{selectedAlert.resolution}</p>
                  </div>}
              </CardContent>
            </Card>
          </div>}
      </div>
    </PageShell>;
}