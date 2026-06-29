import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { complianceApi, RightToRentCheck, ImmigrationStatusCheck, PropertyCompliance } from "@/lib/api/compliance";
import { orchestrationApi, GlobalTaxRegulation, LegalCompliance } from "@/lib/api/orchestration";
import { identityComplianceApi, PoliceReport } from "@/lib/api/identity-compliance";
import { ShieldCheck, AlertTriangle, CheckCircle2, Users, Globe, Building2, Gavel, Activity } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";

interface ComplianceDashboardData {
  rtrChecks: RightToRentCheck[];
  immigrationChecks: ImmigrationStatusCheck[];
  propertyCompliance: PropertyCompliance[];
  taxRegulations: GlobalTaxRegulation[];
  policeReports: PoliceReport[];
  legalCompliance: LegalCompliance[];
}

export default function ComplianceDashboard() {
  const { t } = useTranslation();
  const { toast } = useToast();

  const { data, isLoading } = useQuery<ComplianceDashboardData>({
    queryKey: ['complianceDashboard'],
    queryFn: async () => {
      const [rtrRes, immRes, propRes, taxRes, policeRes, legalRes] = await Promise.all([
        complianceApi.getRightToRentChecks(),
        complianceApi.getImmigrationChecks(),
        complianceApi.getPropertyCompliance(),
        orchestrationApi.getTaxRegulations(),
        identityComplianceApi.getPoliceReports(),
        orchestrationApi.getComplianceRecords()
      ]);
      return {
        rtrChecks: rtrRes.data || [],
        immigrationChecks: immRes.data || [],
        propertyCompliance: propRes.data || [],
        taxRegulations: taxRes || [],
        policeReports: policeRes || [],
        legalCompliance: legalRes || []
      };
    }
  });

  const rtrChecks = data?.rtrChecks || [];
  const immigrationChecks = data?.immigrationChecks || [];
  const propertyCompliance = data?.propertyCompliance || [];
  const taxRegulations = data?.taxRegulations || [];
  const policeReports = data?.policeReports || [];
  const legalCompliance = data?.legalCompliance || [];

  if (isLoading) {
    return (
      <div className="flex flex-col items-center justify-center h-[60vh]">
        <Activity className="w-12 h-12 text-purple-500 animate-spin mb-4 opacity-50" />
        <p className="text-[10px] font-bold text-slate-400 animate-pulse">{t("admin.compliance.aligning_regulatory_parameters")}</p>
      </div>
    );
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
    return (
      <Badge className={cn("text-[8px] font-bold px-3 py-0.5 rounded-full border-none shadow-lg",
        isVerified ? 'bg-emerald-500/20 text-emerald-400' :
        isPending ? 'bg-orange-500/20 text-orange-400' :
        isCritical ? 'bg-red-500/20 text-red-500' : 'bg-slate-500/20 text-slate-400')}>
        {getLocalizedStatus(status)}
      </Badge>
    );
  };

  return (
    <div className="p-6 space-y-6">
      {/* KPI Neural Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <Card className="bg-white/5 border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border">
          <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-400">
            <Users className="w-12 h-12" />
          </div>
          <CardContent className="p-8">
            <p className="text-[10px] font-bold text-slate-400 mb-1">{t("admin.compliance.pending_authority_checks")}</p>
            <h3 className="text-xl font-bold text-white leading-none">{rtrChecks.filter((c: RightToRentCheck) => c.status === "pending").length}</h3>
            <p className="text-[9px] font-bold text-slate-600 mt-4">{t("admin.compliance.awaiting_document_matrix_sync")}</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border">
          <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500">
            <ShieldCheck className="w-12 h-12" />
          </div>
          <CardContent className="p-8">
            <p className="text-[10px] font-bold text-slate-400 mb-1">{t("admin.compliance.active_immigration_pulses")}</p>
            <h3 className="text-xl font-bold text-blue-400 leading-none">{immigrationChecks.filter((c: ImmigrationStatusCheck) => c.checkStatus === "PENDING").length}</h3>
            <p className="text-[9px] font-bold text-blue-500/60 mt-4">{t("admin.compliance.verification_flow_active")}</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-red-500/20 rounded-3xl overflow-hidden shadow-2xl relative group border">
          <div className="absolute top-0 right-0 p-6 opacity-20 group-hover:opacity-40 transition-all text-red-500">
            <AlertTriangle className="w-12 h-12" />
          </div>
          <CardContent className="p-8">
            <p className="text-[10px] font-bold text-red-500/70 mb-1">{t("admin.compliance.entity_violations")}</p>
            <h3 className="text-xl font-bold text-red-500 leading-none">{propertyCompliance.filter((c: PropertyCompliance) => c.status === "failed").length}</h3>
            <p className="text-[9px] font-bold text-red-400/60 mt-4 animate-pulse">{t("admin.compliance.critical_intervention_required")}</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border">
          <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
            <CheckCircle2 className="w-12 h-12" />
          </div>
          <CardContent className="p-8">
            <p className="text-[10px] font-bold text-slate-400 mb-1">{t("admin.compliance.optimization_index")}</p>
            <h3 className="text-xl font-bold text-white leading-none">94%</h3>
            <p className="text-[9px] font-bold text-emerald-500/60 mt-4 leading-tight">{t("admin.compliance.global_alignment_success_rate")}</p>
          </CardContent>
        </Card>
      </div>

      {/* Audit Tactical Center */}
      <Tabs defaultValue="right-to-rent" className="space-y-10 focus-visible:ring-0">
        <TabsList className="bg-white/5 border border-white/10 p-1.5 rounded-2xl h-16 w-full max-w-3xl mx-auto flex">
          <TabsTrigger value="right-to-rent" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-400 transition-all">{t("admin.compliance.lease_authority")}</TabsTrigger>
          <TabsTrigger value="immigration" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-400 transition-all">{t("admin.compliance.border_logic")}</TabsTrigger>
          <TabsTrigger value="property" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-400 transition-all">{t("admin.compliance.node_health")}</TabsTrigger>
          <TabsTrigger value="global-iq" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-400 transition-all flex items-center gap-2">
            <Globe className="w-3 h-3" />{t("admin.compliance.regulatory_hub")}</TabsTrigger>
        </TabsList>

        <TabsContent value="right-to-rent" className="space-y-6 focus-visible:ring-0">
          <Card className="bg-white/5 border-white/10 rounded-3xl overflow-hidden shadow-2xl border relative">
            <CardHeader className="pt-8 px-8 border-b border-white/10">
              <div className="flex items-center justify-between">
                <div className="space-y-1">
                  <CardTitle className="text-xs font-bold text-white">{t("admin.compliance.right_to_rent_pulse")}</CardTitle>
                  <p className="text-[9px] font-bold text-slate-400">{t("admin.compliance.tenant_authority_synchronization_logs")}</p>
                </div>
                <Button className="bg-white/5 hover:bg-white/10 text-white rounded-xl h-10 px-6 font-bold text-[10px] border border-white/10">{t("admin.compliance.start_new_sync")}</Button>
              </div>
            </CardHeader>
            <CardContent className="p-0">
              <Table>
                <TableHeader className="bg-white/5">
                  <TableRow className="border-none">
                    <TableHead className="text-[10px] font-bold text-slate-400 py-6 px-8">{t("admin.compliance.reference_id")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.compliance.check_type")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.compliance.status_arc")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-slate-400 px-8 text-right">{t("admin.compliance.interrogate")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {rtrChecks.map((check: RightToRentCheck) => (
                    <TableRow key={check.id} className="border-b border-white/10 hover:bg-white/5 transition-all group">
                      <TableCell className="py-6 px-8 text-sm font-bold text-white">{check.reference || 'N/A'}</TableCell>
                      <TableCell className="px-8 text-[10px] font-bold text-slate-400">{check.checkType || 'N/A'}</TableCell>
                      <TableCell className="px-8">{getStatusBadge(check.status || 'pending')}</TableCell>
                      <TableCell className="px-8 text-right">
                        <Button variant="ghost" className="h-10 px-4 rounded-xl hover:bg-white/10 text-slate-400 hover:text-white transition-all font-bold text-[9px] border border-white/10">{t("admin.compliance.audit_matrix")}</Button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="immigration" className="space-y-4">
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.compliance.immigration_status_checks")}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10">
                    <TableHead className="text-slate-400">{t("admin.compliance.tenant_id")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.visa_type")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.status")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.document_no")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.verified")}</TableHead>
                    <TableHead className="text-right text-slate-400">{t("admin.compliance.expires")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {immigrationChecks.map((check: ImmigrationStatusCheck) => (
                    <TableRow key={check.id} className="border-white/10">
                      <TableCell className="font-medium text-white">{check.tenantId ? check.tenantId.substring(0, 8) + '...' : 'N/A'}</TableCell>
                      <TableCell className="text-slate-400">{check.visaType || "N/A"}</TableCell>
                      <TableCell>{getStatusBadge(check.checkStatus || 'pending')}</TableCell>
                      <TableCell className="text-slate-400">{check.documentNumber || "-"}</TableCell>
                      <TableCell className="text-slate-400">{check.documentVerified ? t('admin.compliance.yes', 'Evet') : t('admin.compliance.no', 'Hayır')}</TableCell>
                      <TableCell className="text-right text-slate-400">
                        {check.validUntil ? new Date(check.validUntil).toLocaleDateString() : t('admin.compliance.permanent', 'Kalıcı')}
                      </TableCell>
                    </TableRow>
                  ))}
                  {immigrationChecks.length === 0 && (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center py-8 text-slate-500">{t("admin.compliance.no_immigration_check_records")}</TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="property" className="space-y-4">
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.compliance.property_compliance_audits")}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10">
                    <TableHead className="text-slate-400">{t("admin.compliance.property_id")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.type")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.status")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.last_audit")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.inspector")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {propertyCompliance.map((compliance: PropertyCompliance) => (
                    <TableRow key={compliance.id} className="border-white/10">
                      <TableCell className="font-medium text-white">{compliance.propertyId ? compliance.propertyId.substring(0, 8) + '...' : 'N/A'}</TableCell>
                      <TableCell className="text-slate-400">{compliance.type || 'N/A'}</TableCell>
                      <TableCell>{getStatusBadge(compliance.status || 'pending')}</TableCell>
                      <TableCell className="text-slate-400">{compliance.createdAt ? new Date(compliance.createdAt).toLocaleDateString() : 'N/A'}</TableCell>
                      <TableCell className="text-slate-400">{compliance.inspectorId || "N/A"}</TableCell>
                    </TableRow>
                  ))}
                  {propertyCompliance.length === 0 && (
                    <TableRow>
                      <TableCell colSpan={5} className="text-center py-8 text-slate-500">{t("admin.compliance.no_property_compliance_records")}</TableCell>
                    </TableRow>
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="global-iq" className="space-y-4">
          <div className="grid md:grid-cols-2 gap-4">
            <Card className="bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-sm font-bold text-white flex items-center gap-2">
                  <Building2 className="w-4 h-4 text-blue-500" />{t("admin.compliance.regional_tax_regulations")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow className="border-white/10">
                      <TableHead className="text-slate-400">{t("admin.compliance.authority")}</TableHead>
                      <TableHead className="text-slate-400">{t("admin.compliance.type")}</TableHead>
                      <TableHead className="text-slate-400">{t("admin.compliance.rate")}</TableHead>
                      <TableHead className="text-slate-400">{t("admin.compliance.status")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {taxRegulations.map((tax: GlobalTaxRegulation) => (
                      <TableRow key={tax.id} className="border-white/10">
                        <TableCell className="font-medium text-white">{tax.taxAuthority || 'N/A'}</TableCell>
                        <TableCell className="text-slate-400">{tax.taxType || 'N/A'}</TableCell>
                        <TableCell className="text-slate-400">%{tax.taxRate || 0}</TableCell>
                        <TableCell>
                          <Badge variant={tax.isAutomated ? "default" : "outline"}>
                            {tax.isAutomated ? t('admin.compliance.auto', 'Oto') : t('admin.compliance.manual', 'Manuel')}
                          </Badge>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>

            <Card className="bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-sm font-bold text-white flex items-center gap-2">
                  <Gavel className="w-4 h-4 text-purple-500" />{t("admin.compliance.legal_compliance_gdprkvkk")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow className="border-white/10">
                      <TableHead className="text-slate-400">{t("admin.compliance.region")}</TableHead>
                      <TableHead className="text-slate-400">{t("admin.compliance.type")}</TableHead>
                      <TableHead className="text-slate-400">{t("admin.compliance.status")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {legalCompliance.map((legal: LegalCompliance) => (
                      <TableRow key={legal.id} className="border-white/10">
                        <TableCell className="text-slate-400">{legal.countryCode || 'N/A'}</TableCell>
                        <TableCell className="text-slate-400">{legal.complianceType || 'N/A'}</TableCell>
                        <TableCell>{getStatusBadge(legal.status || 'pending')}</TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </div>

          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-sm font-bold text-white">{t("admin.compliance.police_guest_reporting_kbsgiykimbil")}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10">
                    <TableHead className="text-slate-400">{t("admin.compliance.report_type")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.reservation")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.submitted_at")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.compliance.status")}</TableHead>
                    <TableHead className="text-right text-slate-400">{t("admin.compliance.action")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {policeReports.map((report: PoliceReport) => (
                    <TableRow key={report.id} className="border-white/10">
                      <TableCell className="font-bold text-blue-400">{report.reportType || 'N/A'}</TableCell>
                      <TableCell className="text-xs font-mono text-slate-400">{report.reservationId || 'N/A'}</TableCell>
                      <TableCell className="text-slate-400">{report.submittedAt ? new Date(report.submittedAt).toLocaleString() : "-"}</TableCell>
                      <TableCell>{getStatusBadge(report.status || 'pending')}</TableCell>
                      <TableCell className="text-right">
                        <Button variant="outline" size="sm">{t("admin.compliance.view_log")}</Button>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
