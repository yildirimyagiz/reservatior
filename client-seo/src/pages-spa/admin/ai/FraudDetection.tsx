"use client";

import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Shield, AlertTriangle, CheckCircle, XCircle, MoreHorizontal, Eye, Activity, TrendingUp } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { useQuery, useMutation } from "@tanstack/react-query";

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
  const { t } = useTranslation();
  const { toast } = useToast();
  const [selectedAlert, setSelectedAlert] = useState<AIFraudDetection | null>(null);
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [newAlert, setNewAlert] = useState({
    entityType: 'USER',
    entityId: 'USR-1234',
    riskScore: 85,
    riskCategory: 'HIGH'
  });

  const { data: fraudAlerts = [], isLoading } = useQuery<AIFraudDetection[]>({
    queryKey: ['fraud-detection'],
    queryFn: async () => {
      const response = await apiClient.get('/ai/fraud-detection/alerts');
      return (response as any).data || [];
    },
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await apiClient.post('/ai-fraud-detections', {
        ...data,
        riskFactors: { "ip_mismatch": true },
        recommendedActions: ["Block IP"],
        detectedAt: new Date().toISOString()
      });
      return res;
    },
    onSuccess: () => {
      setIsAddOpen(false);
      toast({ title: "Success", description: "Simulated Alert created" });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    }
  });

  const resolveAlert = async (alertId: string, resolution: string) => {
    try {
      await apiClient.put(`/ai/fraud-detection/alerts/${alertId}/resolve`, { resolution });
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
  if (isLoading) {
    return <div className="flex items-center justify-center h-64 min-h-screen">
      <Activity className="h-8 w-8 animate-spin text-white" />
    </div>;
  }
  return <div className="space-y-6 min-h-screen p-4 md:p-8">
      <div className="space-y-6">
        <div className="flex justify-between items-center mb-6">
          <div>
            <h2 className="text-2xl font-bold tracking-tight text-white">Fraud Alerts</h2>
            <p className="text-slate-400">Manage and review AI-detected anomalies.</p>
          </div>
          <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
            <DialogTrigger asChild>
              <Button className="bg-red-600 hover:bg-red-700 text-white">Simulate Alert</Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[500px] bg-white/5 border-white/10 text-white">
              <DialogHeader>
                <DialogTitle>Simulate Fraud Alert</DialogTitle>
                <DialogDescription className="text-slate-400">
                  Manually trigger a fraud detection alert for testing or manual logging.
                </DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Entity Type</Label>
                  <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newAlert.entityType} onChange={e => setNewAlert({...newAlert, entityType: e.target.value})} placeholder="USER" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Entity ID</Label>
                  <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newAlert.entityId} onChange={e => setNewAlert({...newAlert, entityId: e.target.value})} placeholder="USR-1234" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Risk Score</Label>
                  <Input type="number" className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newAlert.riskScore} onChange={e => setNewAlert({...newAlert, riskScore: parseInt(e.target.value)})} placeholder="85" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Category</Label>
                  <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newAlert.riskCategory} onChange={e => setNewAlert({...newAlert, riskCategory: e.target.value})} placeholder="HIGH" />
                </div>
              </div>
              <DialogFooter>
                <Button variant="outline" className="border-white/10 text-slate-400" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                <Button onClick={() => createMutation.mutate(newAlert)} disabled={createMutation.isPending}>
                  {createMutation.isPending ? "Running..." : "Trigger"}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.ai.critical_alerts")}</CardTitle>
              <AlertTriangle className="h-4 w-4 text-slate-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-red-600">{criticalAlerts}</div>
              <p className="text-xs text-slate-400">{t("admin.ai.highpriority_fraud_alerts")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.ai.unresolved_alerts")}</CardTitle>
              <Shield className="h-4 w-4 text-slate-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-white">{unresolvedAlerts}</div>
              <p className="text-xs text-slate-400">{t("admin.ai.require_manual_review")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.ai.resolved_today")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-slate-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{resolvedToday}</div>
              <p className="text-xs text-slate-400">{t("admin.ai.successfully_handled")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.ai.avg_risk_score")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-slate-400" />
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
        <Card className="bg-white/5 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">{t("admin.ai.fraud_detection_alerts")}</CardTitle>
            <p className="text-sm text-slate-400">{t("admin.ai.aipowered_fraud_detection_and")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow className="border-white/10">
                  <TableHead className="text-slate-400">{t("admin.ai.entity")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.risk_category")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.risk_score")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.detected_at")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.status")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.reviewed_by")}</TableHead>
                  <TableHead className="text-right text-slate-400">{t("admin.ai.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {fraudAlerts.map(alert => <TableRow key={alert.id} className="border-white/10">
                    <TableCell className="font-medium text-white">
                      <div>
                        <div className="font-medium">{alert.entityType}</div>
                        <div className="text-xs text-slate-400 font-mono">{alert.entityId}</div>
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
                    <TableCell className="text-slate-400">
                      {new Date(alert.detectedAt).toLocaleString()}
                    </TableCell>
                    <TableCell>
                      {alert.resolution ? <Badge variant="default">
                          <CheckCircle className="h-3 w-3 mr-1" />{t("admin.ai.resolved")}</Badge> : <Badge variant="secondary">
                          <AlertTriangle className="h-3 w-3 mr-1" />{t("admin.ai.pending")}</Badge>}
                    </TableCell>
                    <TableCell className="text-slate-400">
                      {alert.reviewedBy || "Unassigned"}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0 text-slate-400">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="bg-white/5 border-white/10 text-white">
                          <DropdownMenuLabel className="text-slate-400">{t("admin.ai.actions")}</DropdownMenuLabel>
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
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.ai.common_risk_factors")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-sm text-slate-400">{t("admin.ai.suspicious_ip_address")}</span>
                  <span className="font-medium text-white">45%</span>
                </div>
                <Progress value={45} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm text-slate-400">{t("admin.ai.unusual_transaction_pattern")}</span>
                  <span className="font-medium text-white">32%</span>
                </div>
                <Progress value={32} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm text-slate-400">{t("admin.ai.new_device_fingerprint")}</span>
                  <span className="font-medium text-white">28%</span>
                </div>
                <Progress value={28} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm text-slate-400">{t("admin.ai.inconsistent_user_data")}</span>
                  <span className="font-medium text-white">18%</span>
                </div>
                <Progress value={18} className="h-2" />

                <div className="flex justify-between items-center">
                  <span className="text-sm text-slate-400">{t("admin.ai.velocity_check_failed")}</span>
                  <span className="font-medium text-white">12%</span>
                </div>
                <Progress value={12} className="h-2" />
              </div>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.ai.fraud_prevention_metrics")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-green-600">98.7%</div>
                  <p className="text-sm text-slate-400">{t("admin.ai.detection_accuracy")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-slate-600">0.02%</div>
                  <p className="text-sm text-slate-400">{t("admin.ai.false_positive_rate")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-slate-600">{t("admin.ai.23s")}</div>
                  <p className="text-sm text-slate-400">{t("admin.ai.avg_response_time")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-orange-600">{t("admin.ai.24m")}</div>
                  <p className="text-sm text-slate-400">{t("admin.ai.fraud_prevented_monthly")}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Alert Details Modal would go here */}
        {selectedAlert && <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4">
            <Card className="max-w-2xl w-full max-h-[80vh] overflow-y-auto bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">{t("admin.ai.fraud_alert_details")}</CardTitle>
                <Button variant="ghost" className="absolute right-4 top-4 text-slate-400" onClick={() => setSelectedAlert(null)}>
                  ×
                </Button>
              </CardHeader>
              <CardContent className="space-y-4 text-white">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label className="text-slate-400">{t("admin.ai.entity_type")}</Label>
                    <p className="mt-1">{selectedAlert.entityType}</p>
                  </div>
                  <div>
                    <Label className="text-slate-400">{t("admin.ai.entity_id")}</Label>
                    <p className="mt-1 font-mono text-sm">{selectedAlert.entityId}</p>
                  </div>
                  <div>
                    <Label className="text-slate-400">{t("admin.ai.risk_score")}</Label>
                    <p className={`mt-1 font-bold ${getRiskColor(selectedAlert.riskScore)}`}>
                      {selectedAlert.riskScore}/100
                    </p>
                  </div>
                  <div>
                    <Label className="text-slate-400">{t("admin.ai.risk_category")}</Label>
                    <Badge variant={getRiskBadgeVariant(selectedAlert.riskCategory)} className="mt-1">
                      {selectedAlert.riskCategory}
                    </Badge>
                  </div>
                </div>

                <div>
                  <Label className="text-slate-400">{t("admin.ai.risk_factors")}</Label>
                  <div className="mt-2 space-y-2">
                    {selectedAlert.riskFactors && Object.entries(selectedAlert.riskFactors).map(([key, value]) => <div key={key} className="flex justify-between p-2 bg-white/5 rounded-lg">
                        <span className="text-sm text-slate-400">{key}</span>
                        <span className="text-sm font-medium text-white">{String(value)}</span>
                      </div>)}
                  </div>
                </div>

                {selectedAlert.recommendedActions && selectedAlert.recommendedActions.length > 0 && <div>
                    <Label className="text-slate-400">{t("admin.ai.recommended_actions")}</Label>
                    <div className="mt-2 space-y-2">
                      {selectedAlert.recommendedActions.map((action, index) => <div key={index} className="p-2 border border-white/10 rounded-lg">
                          <p className="text-sm text-slate-400">{action}</p>
                        </div>)}
                    </div>
                  </div>}

                {selectedAlert.resolution && <div>
                    <Label className="text-slate-400">{t("admin.ai.resolution")}</Label>
                    <p className="mt-1">{selectedAlert.resolution}</p>
                  </div>}
              </CardContent>
            </Card>
          </div>}
      </div>
    </div>;
}
