import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { complianceApi, RightToRentCheck, ImmigrationStatusCheck, PropertyCompliance } from "@/lib/api/compliance";
import { orchestrationApi, GlobalTaxRegulation, LegalCompliance } from "@/lib/api/orchestration";
import { identityComplianceApi, PoliceReport } from "@/lib/api/identity-compliance";
import { ShieldCheck, AlertTriangle, CheckCircle2, Users, Globe, Building2, Gavel } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Activity } from "lucide-react";
import { cn } from "@/lib/utils";
export default function ComplianceDashboard() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [loading, setLoading] = useState(true);
  const [rtrChecks, setRtrChecks] = useState<RightToRentCheck[]>([]);
  const [immigrationChecks, setImmigrationChecks] = useState<ImmigrationStatusCheck[]>([]);
  const [propertyCompliance, setPropertyCompliance] = useState<PropertyCompliance[]>([]);
  const [taxRegulations, setTaxRegulations] = useState<GlobalTaxRegulation[]>([]);
  const [policeReports, setPoliceReports] = useState<PoliceReport[]>([]);
  const [legalCompliance, setLegalCompliance] = useState<LegalCompliance[]>([]);
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [rtrRes, immRes, propRes, taxRes, policeRes, legalRes]: any[] = await Promise.all([complianceApi.getRightToRentChecks(), complianceApi.getImmigrationChecks(), complianceApi.getPropertyCompliance(), orchestrationApi.getTaxRegulations(), identityComplianceApi.getPoliceReports(), orchestrationApi.getComplianceRecords()]);
        setRtrChecks(rtrRes.data || []);
        setImmigrationChecks(immRes.data || []);
        setPropertyCompliance(propRes.data || []);
        setTaxRegulations(taxRes || []);
        setPoliceReports(policeRes || []);
        setLegalCompliance(legalRes || []);
      } catch (error) {
        console.error("Error fetching compliance data:", error);
        toast({
          title: t("admin.compliance.error"),
          description: t("admin.compliance.failed_to_load_compliance"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [toast]);
  if (loading) {
    return <PageShell title={t("admin.compliance.neurocompliance_matrix")} description={t("admin.compliance.synchronizing_legal_authority_nodes")}>
        <div className="flex flex-col items-center justify-center h-[60vh]">
          <Activity className="w-12 h-12 text-purple-500 animate-spin mb-4 opacity-50" />
          <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t("admin.compliance.aligning_regulatory_parameters")}</p>
        </div>
      </PageShell>;
  }
  const getLocalizedStatus = (status: string) => {
    const map: Record<string, string> = {
      'completed': t('admin.compliance.status.completed', 'Tamamlandı'),
      'approved': t('admin.compliance.status.approved', 'Onaylandı'),
      'verified': t('admin.compliance.status.verified', 'Doğrulandı'),
      'pending': t('admin.compliance.status.pending', 'Bekliyor'),
      'queued': t('admin.compliance.status.queued', 'Sırada'),
      'expired': t('admin.compliance.status.expired', 'Süresi Doldu'),
      'failed': t('admin.compliance.status.failed', 'Başarısız')
    };
    return map[status.toLowerCase()] || status;
  };

  const getStatusBadge = (status: string) => {
    const s = status.toLowerCase();
    const isVerified = ["completed", "approved", "verified"].includes(s);
    const isPending = ["pending", "queued"].includes(s);
    const isCritical = ["expired", "failed"].includes(s);
    return <Badge className={cn("text-[8px] font-bold   px-3 py-0.5 rounded-full  border-none shadow-lg", isVerified ? 'bg-emerald-500/20 text-emerald-400' : isPending ? 'bg-orange-500/20 text-orange-400' : isCritical ? 'bg-red-500/20 text-red-500' : 'bg-slate-500/20 text-muted-foreground')}>
        {getLocalizedStatus(status)}
      </Badge>;
  };
  return <PageShell title={t("admin.compliance.neurocompliance_matrix")} description={t("admin.compliance.unified_audit_gateway_for")}>
      <div className="space-y-10 pb-20">
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
              <Users className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.compliance.pending_authority_checks")}</p>
              <h3 className="text-xl font-bold text-foreground leading-none">{rtrChecks.filter(c => c.status === "pending").length}</h3>
              <p className="text-[9px] font-bold text-slate-600 mt-4">{t("admin.compliance.awaiting_document_matrix_sync")}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500">
                <ShieldCheck className="w-12 h-12" />
              </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.compliance.active_immigration_pulses")}</p>
              <h3 className="text-xl font-bold text-blue-400 leading-none">{immigrationChecks.filter(c => c.checkStatus === "PENDING").length}</h3>
              <p className="text-[9px] font-bold text-blue-500/60 mt-4">{t("admin.compliance.verification_flow_active")}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-red-500/20 rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-20 group-hover:opacity-40 transition-all text-red-500">
              <AlertTriangle className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-red-500/70 mb-1">{t("admin.compliance.entity_violations")}</p>
              <h3 className="text-xl font-bold text-red-500 leading-none">{propertyCompliance.filter(c => c.status === "failed").length}</h3>
              <p className="text-[9px] font-bold text-red-400/60 mt-4 animate-pulse">{t("admin.compliance.critical_intervention_required")}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
                <CheckCircle2 className="w-12 h-12" />
              </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.compliance.optimization_index")}</p>
              <h3 className="text-xl font-bold text-foreground leading-none">94%</h3>
              <p className="text-[9px] font-bold text-emerald-500/60 mt-4 leading-tight">{t("admin.compliance.global_alignment_success_rate")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Audit Tactical Center */}
        <Tabs defaultValue="right-to-rent" className="space-y-10 focus-visible:ring-0">
          <TabsList className="bg-card border border-border p-1.5 rounded-2xl h-16 w-full max-w-3xl mx-auto flex">
            <TabsTrigger value="right-to-rent" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all">{t("admin.compliance.lease_authority")}</TabsTrigger>
            <TabsTrigger value="immigration" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all">{t("admin.compliance.border_logic")}</TabsTrigger>
            <TabsTrigger value="property" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all">{t("admin.compliance.node_health")}</TabsTrigger>
            <TabsTrigger value="global-iq" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all flex items-center gap-2">
               <Globe className="w-3 h-3" />{t("admin.compliance.regulatory_hub")}</TabsTrigger>
          </TabsList>

          <TabsContent value="right-to-rent" className="space-y-6 focus-visible:ring-0">
             <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8 border-b border-border">
                   <div className="flex items-center justify-between">
                      <div className="space-y-1">
                        <CardTitle className="text-xs font-bold text-foreground">{t("admin.compliance.right_to_rent_pulse")}</CardTitle>
                        <p className="text-[9px] font-bold text-muted-foreground">{t("admin.compliance.tenant_authority_synchronization_logs")}</p>
                      </div>
                      <Button className="bg-muted/50 hover:bg-muted/50 text-foreground rounded-xl h-10 px-6 font-bold text-[10px] border border-border">{t("admin.compliance.start_new_sync")}</Button>
                   </div>
                </CardHeader>
                <CardContent className="p-0">
                   <Table>
                      <TableHeader className="bg-muted/50">
                        <TableRow className="border-none">
                           <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin.compliance.reference_id")}</TableHead>
                           <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.compliance.check_type")}</TableHead>
                           <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.compliance.status_arc")}</TableHead>
                           <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin.compliance.interrogate")}</TableHead>
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {rtrChecks.map(check => <TableRow key={check.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                            <TableCell className="py-6 px-8 text-sm font-bold text-foreground">{check.reference || 'N/A'}</TableCell>
                            <TableCell className="px-8 text-[10px] font-bold text-muted-foreground">{check.checkType || 'N/A'}</TableCell>
                            <TableCell className="px-8">{getStatusBadge(check.status || 'pending')}</TableCell>
                            <TableCell className="px-8 text-right">
                               <Button variant="ghost" className="h-10 px-4 rounded-xl hover:bg-muted/50 text-muted-foreground hover:text-foreground transition-all font-bold text-[9px] border border-border hover:border-border">{t("admin.compliance.audit_matrix")}</Button>
                            </TableCell>
                          </TableRow>)}
                      </TableBody>
                   </Table>
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="immigration" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.compliance.immigration_status_checks")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.compliance.tenant_id")}</TableHead>
                      <TableHead>{t("admin.compliance.visa_type")}</TableHead>
                      <TableHead>{t("admin.compliance.status")}</TableHead>
                      <TableHead>{t("admin.compliance.document_no")}</TableHead>
                      <TableHead>{t("admin.compliance.verified")}</TableHead>
                      <TableHead className="text-right">{t("admin.compliance.expires")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {immigrationChecks.map(check => <TableRow key={check.id}>
                        <TableCell className="font-medium">{check.tenantId ? check.tenantId.substring(0, 8) + '...' : 'N/A'}</TableCell>
                        <TableCell>{check.visaType || "N/A"}</TableCell>
                        <TableCell>{getStatusBadge(check.checkStatus || 'pending')}</TableCell>
                        <TableCell>{check.documentNumber || "-"}</TableCell>
                        <TableCell>{check.documentVerified ? t('admin.compliance.yes', 'Evet') : t('admin.compliance.no', 'Hayır')}</TableCell>
                        <TableCell className="text-right">
                          {check.validUntil ? new Date(check.validUntil).toLocaleDateString() : t('admin.compliance.permanent', 'Kalıcı')}
                        </TableCell>
                      </TableRow>)}
                    {immigrationChecks.length === 0 && <TableRow>
                        <TableCell colSpan={6} className="text-center py-8 text-gray-500">{t("admin.compliance.no_immigration_check_records")}</TableCell>
                      </TableRow>}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="property" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.compliance.property_compliance_audits")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.compliance.property_id")}</TableHead>
                      <TableHead>{t("admin.compliance.type")}</TableHead>
                      <TableHead>{t("admin.compliance.status")}</TableHead>
                      <TableHead>{t("admin.compliance.last_audit")}</TableHead>
                      <TableHead>{t("admin.compliance.inspector")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {propertyCompliance.map(compliance => <TableRow key={compliance.id}>
                        <TableCell className="font-medium">{compliance.propertyId ? compliance.propertyId.substring(0, 8) + '...' : 'N/A'}</TableCell>
                        <TableCell>{compliance.type || 'N/A'}</TableCell>
                        <TableCell>{getStatusBadge(compliance.status || 'pending')}</TableCell>
                        <TableCell>{compliance.createdAt ? new Date(compliance.createdAt).toLocaleDateString() : 'N/A'}</TableCell>
                        <TableCell>{compliance.inspectorId || "N/A"}</TableCell>
                      </TableRow>)}
                    {propertyCompliance.length === 0 && <TableRow>
                        <TableCell colSpan={5} className="text-center py-8 text-gray-500">{t("admin.compliance.no_property_compliance_records")}</TableCell>
                      </TableRow>}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="global-iq" className="space-y-4">
            <div className="grid md:grid-cols-2 gap-4">
              <Card>
                <CardHeader>
                  <CardTitle className="text-sm font-bold flex items-center gap-2">
                    <Building2 className="w-4 h-4 text-blue-500" />{t("admin.compliance.regional_tax_regulations")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>{t("admin.compliance.authority")}</TableHead>
                        <TableHead>{t("admin.compliance.type")}</TableHead>
                        <TableHead>{t("admin.compliance.rate")}</TableHead>
                        <TableHead>{t("admin.compliance.status")}</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {taxRegulations.map(tax => <TableRow key={tax.id}>
                          <TableCell className="font-medium">{tax.taxAuthority || 'N/A'}</TableCell>
                          <TableCell>{tax.taxType || 'N/A'}</TableCell>
                          <TableCell>%{tax.taxRate || 0}</TableCell>
                          <TableCell>
                            <Badge variant={tax.isAutomated ? "default" : "outline"}>
                              {tax.isAutomated ? t('admin.compliance.auto', 'Oto') : t('admin.compliance.manual', 'Manuel')}
                            </Badge>
                          </TableCell>
                        </TableRow>)}
                    </TableBody>
                  </Table>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="text-sm font-bold flex items-center gap-2">
                    <Gavel className="w-4 h-4 text-purple-500" />{t("admin.compliance.legal_compliance_gdprkvkk")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <Table>
                    <TableHeader>
                      <TableRow>
                        <TableHead>{t("admin.compliance.region")}</TableHead>
                        <TableHead>{t("admin.compliance.type")}</TableHead>
                        <TableHead>{t("admin.compliance.status")}</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {legalCompliance.map(legal => <TableRow key={legal.id}>
                          <TableCell>{legal.countryCode || 'N/A'}</TableCell>
                          <TableCell>{legal.complianceType || 'N/A'}</TableCell>
                          <TableCell>{getStatusBadge(legal.status || 'pending')}</TableCell>
                        </TableRow>)}
                    </TableBody>
                  </Table>
                </CardContent>
              </Card>
            </div>

            <Card>
              <CardHeader>
                <CardTitle className="text-sm font-bold">{t("admin.compliance.police_guest_reporting_kbsgiykimbil")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.compliance.report_type")}</TableHead>
                      <TableHead>{t("admin.compliance.reservation")}</TableHead>
                      <TableHead>{t("admin.compliance.submitted_at")}</TableHead>
                      <TableHead>{t("admin.compliance.status")}</TableHead>
                      <TableHead className="text-right">{t("admin.compliance.action")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {policeReports.map(report => <TableRow key={report.id}>
                        <TableCell className="font-bold text-blue-400">{report.reportType || 'N/A'}</TableCell>
                        <TableCell className="text-xs font-mono">{report.reservationId || 'N/A'}</TableCell>
                        <TableCell>{report.submittedAt ? new Date(report.submittedAt).toLocaleString() : "-"}</TableCell>
                        <TableCell>{getStatusBadge(report.status || 'pending')}</TableCell>
                        <TableCell className="text-right">
                          <Button variant="outline" size="sm">{t("admin.compliance.view_log")}</Button>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}