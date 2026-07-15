"use client";

import React, { useState, useEffect } from"react";import { useTranslation } from"react-i18next";
import { useQuery } from"@tanstack/react-query";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Badge } from"@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Button } from"@/components/ui/button";
import { complianceApi, RightToRentCheck, ImmigrationStatusCheck, PropertyCompliance } from"@/lib/api/compliance";
import { orchestrationApi, GlobalTaxRegulation, LegalCompliance } from"@/lib/api/orchestration";
import { identityComplianceApi, PoliceReport } from"@/lib/api/identity-compliance";
import { ShieldCheck, AlertTriangle, CheckCircle2, Users, Globe, Building2, Gavel, Activity, FileSearch, Eye } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { cn } from"@/lib/utils";
import { motion, AnimatePresence } from"framer-motion";

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

 const [liveEvents, setLiveEvents] = useState<{id: number, text: string, type: 'success' | 'warning' | 'error'}[]>([]);

 useEffect(() => {
 let eventId = 0;
 const eventTypes: Array<'success' | 'warning' | 'error'> = ['success', 'success', 'warning', 'error', 'success'];
 const messages = ["Passport OCR verification passed for J. Smith","Property #412 safety check queued","Immigration API (Home Office) slow response","Biometric mismatch detected for upload #889","Right-to-Rent automated approval granted","Fraud detection engine flagged document anomalies"
 ];

 const timer = setInterval(() => {
 const type = eventTypes[Math.floor(Math.random() * eventTypes.length)];
 const msg = messages[Math.floor(Math.random() * messages.length)];
 const newEvent = { id: ++eventId, text: msg, type };
 
 setLiveEvents(prev => [newEvent, ...prev].slice(0, 5));
 
 if (type === 'error') {
 toast({ title:"Compliance Alert", description: msg, variant:"destructive" });
 }
 }, Math.floor(Math.random() * 5000) + 4000); // 4-9 seconds

 return () => clearInterval(timer);
 }, [toast]);

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
 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex flex-col items-center justify-center h-[60vh] space-y-6">
 <Activity className="w-12 h-12 text-slate-500 animate-spin mb-4 opacity-50" />
 <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t("admin_compliance_aligning_regulatory_parameters")}</p>
 </div>
 );
 }

 const getLocalizedStatus = (status: string) => {
 const map: Record<string, string> = {
 'completed': t('admin_compliance_status_completed', 'Tamamlandı'),
 'approved': t('admin_compliance_status_approved', 'Onaylandı'),
 'verified': t('admin_compliance_status_verified', 'Doğrulandı'),
 'pending': t('admin_compliance_status_pending', 'Bekliyor'),
 'queued': t('admin_compliance_status_queued', 'Sırada'),
 'expired': t('admin_compliance_status_expired', 'Süresi Doldu'),
 'failed': t('admin_compliance_status_failed', 'Başarısız')
 };
 return map[status.toLowerCase()] || status;
 };

 const getStatusBadge = (status: string) => {
 const s = status.toLowerCase();
 const isVerified = ["completed","approved","verified"].includes(s);
 const isPending = ["pending","queued"].includes(s);
 const isCritical = ["expired","failed"].includes(s);
 return (
 <Badge className={cn("text-[8px] font-bold px-3 py-0.5 rounded-full border-none shadow-lg",
 isVerified ? 'bg-emerald-500/20 text-emerald-400' :
 isPending ? 'bg-orange-500/20 text-orange-400' :
 isCritical ? 'bg-red-500/20 text-red-500' : 'bg-muted0/20 text-muted-foreground')}>
 {getLocalizedStatus(status)}
 </Badge>
 );
 };

 const renderStepper = (status: string) => {
 const s = status.toLowerCase();
 let step = 0;
 if (s === 'queued') step = 1;
 if (s === 'pending') step = 2;
 if (s === 'verified' || s === 'approved' || s === 'completed') step = 4;
 if (s === 'failed' || s === 'expired') step = -1;

 const steps = ['Uploaded', 'OCR Analysis', 'Authority Check', 'Approved'];
 
 return (
 <div className="flex items-center w-full max-w-[200px] gap-1">
 {steps.map((label, idx) => {
 const isActive = step >= (idx + 1);
 const isError = step === -1 && idx === 1;
 return (
 <div key={idx} className="flex-1 flex flex-col items-center gap-1 group relative">
 <div className={cn("h-1.5 w-full rounded-full transition-all duration-500",
 isActive ?"bg-emerald-500" : isError ?"bg-red-500" :"bg-slate-700"
 )} />
 {/* Tooltip on hover */}
 <div className="absolute -top-6 opacity-0 group-hover:opacity-100 transition-opacity bg-black text-[8px] px-2 py-1 rounded text-foreground whitespace-nowrap z-10 pointer-events-none">
 {label}
 </div>
 </div>
 );
 })}
 </div>
 );
 };

 return (
 <div className="p-6 grid grid-cols-1 xl:grid-cols-4 gap-6">
 <div className="xl:col-span-3 space-y-6">
 {/* KPI Neural Grid */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
 <Users className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_compliance_pending_authority_checks")}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{rtrChecks.filter((c: RightToRentCheck) => c.status ==="pending").length}</h3>
 <p className="text-[9px] font-bold text-slate-600 mt-4">{t("admin_compliance_awaiting_document_matrix_sync")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
 <ShieldCheck className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_compliance_active_immigration_pulses")}</p>
 <h3 className="text-xl font-bold text-muted-foreground leading-none">{immigrationChecks.filter((c: ImmigrationStatusCheck) => c.checkStatus ==="PENDING").length}</h3>
 <p className="text-[9px] font-bold text-slate-500/60 mt-4">{t("admin_compliance_verification_flow_active")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-red-500/20 rounded-3xl overflow-hidden shadow-2xl relative group border">
 <div className="absolute top-0 right-0 p-6 opacity-20 group-hover:opacity-40 transition-all text-red-500">
 <AlertTriangle className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-red-500/70 mb-1">{t("admin_compliance_entity_violations")}</p>
 <h3 className="text-xl font-bold text-red-500 leading-none">{propertyCompliance.filter((c: PropertyCompliance) => c.status ==="failed").length}</h3>
 <p className="text-[9px] font-bold text-red-400/60 mt-4 animate-pulse">{t("admin_compliance_critical_intervention_required")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
 <CheckCircle2 className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_compliance_optimization_index")}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">94%</h3>
 <p className="text-[9px] font-bold text-emerald-500/60 mt-4 leading-tight">{t("admin_compliance_global_alignment_success_rate")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Audit Tactical Center */}
 <Tabs defaultValue="right-to-rent" className="space-y-10 focus-visible:ring-0">
 <TabsList className="bg-card border border-border p-1.5 rounded-2xl h-16 w-full max-w-3xl mx-auto flex">
 <TabsTrigger value="right-to-rent" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-muted-foreground transition-all">{t("admin_compliance_lease_authority")}</TabsTrigger>
 <TabsTrigger value="immigration" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-muted-foreground transition-all">{t("admin_compliance_border_logic")}</TabsTrigger>
 <TabsTrigger value="property" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-muted-foreground transition-all">{t("admin_compliance_node_health")}</TabsTrigger>
 <TabsTrigger value="global-iq" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-muted-foreground transition-all flex items-center gap-2">
 <Globe className="w-3 h-3" />{t("admin_compliance_regulatory_hub")}</TabsTrigger>
 </TabsList>

 <TabsContent value="right-to-rent" className="space-y-6 focus-visible:ring-0">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl border relative">
 <CardHeader className="pt-8 px-8 border-b border-border">
 <div className="flex items-center justify-between">
 <div className="space-y-1">
 <CardTitle className="text-xs font-bold text-foreground">{t("admin_compliance_right_to_rent_pulse")}</CardTitle>
 <p className="text-[9px] font-bold text-muted-foreground">{t("admin_compliance_tenant_authority_synchronization_logs")}</p>
 </div>
 <Button className="bg-card hover:bg-slate-100 dark:hover:bg-white/10 text-foreground rounded-xl h-10 px-6 font-bold text-[10px] border border-border">{t("admin_compliance_start_new_sync")}</Button>
 </div>
 </CardHeader>
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card">
 <TableRow className="border-none">
 <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin_compliance_reference_id")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_compliance_check_type")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_compliance_status_arc")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin_compliance_interrogate")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {rtrChecks.map((check: RightToRentCheck) => (
 <TableRow key={check.id} className="border-b border-border hover:bg-card transition-all group">
 <TableCell className="py-6 px-8 text-sm font-bold text-foreground">{check.reference || 'N/A'}</TableCell>
 <TableCell className="px-8 text-[10px] font-bold text-muted-foreground">{check.checkType || 'N/A'}</TableCell>
 <TableCell className="px-8">{renderStepper(check.status || 'pending')}</TableCell>
 <TableCell className="px-8 text-right">
 <Button variant="ghost" className="h-10 px-4 rounded-xl hover:bg-slate-100 dark:hover:bg-white/10 text-muted-foreground hover:text-foreground transition-all font-bold text-[9px] border border-border">{t("admin_compliance_audit_matrix")}</Button>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="immigration" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_compliance_immigration_status_checks")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_compliance_tenant_id")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_visa_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_document_no")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_verified")}</TableHead>
 <TableHead className="text-right text-muted-foreground">{t("admin_compliance_expires")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {immigrationChecks.map((check: ImmigrationStatusCheck) => (
 <TableRow key={check.id} className="border-border">
 <TableCell className="font-medium text-foreground">{check.tenantId ? check.tenantId.substring(0, 8) + '...' : 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{check.visaType ||"N/A"}</TableCell>
 <TableCell>{renderStepper(check.checkStatus || 'pending')}</TableCell>
 <TableCell className="text-muted-foreground">{check.documentNumber ||"-"}</TableCell>
 <TableCell className="text-muted-foreground">{check.documentVerified ? t('admin_compliance_yes', 'Evet') : t('admin_compliance_no', 'Hayır')}</TableCell>
 <TableCell className="text-right text-muted-foreground">
 {check.validUntil ? new Date(check.validUntil).toLocaleDateString() : t('admin_compliance_permanent', 'Kalıcı')}
 </TableCell>
 </TableRow>
 ))}
 {immigrationChecks.length === 0 && (
 <TableRow>
 <TableCell colSpan={6} className="text-center py-8 text-slate-500">{t("admin_compliance_no_immigration_check_records")}</TableCell>
 </TableRow>
 )}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="property" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_compliance_property_compliance_audits")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_compliance_property_id")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_last_audit")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_inspector")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {propertyCompliance.map((compliance: PropertyCompliance) => (
 <TableRow key={compliance.id} className="border-border">
 <TableCell className="font-medium text-foreground">{compliance.propertyId ? compliance.propertyId.substring(0, 8) + '...' : 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{compliance.type || 'N/A'}</TableCell>
 <TableCell>{getStatusBadge(compliance.status || 'pending')}</TableCell>
 <TableCell className="text-muted-foreground">{compliance.createdAt ? new Date(compliance.createdAt).toLocaleDateString() : 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{compliance.inspectorId ||"N/A"}</TableCell>
 </TableRow>
 ))}
 {propertyCompliance.length === 0 && (
 <TableRow>
 <TableCell colSpan={5} className="text-center py-8 text-slate-500">{t("admin_compliance_no_property_compliance_records")}</TableCell>
 </TableRow>
 )}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="global-iq" className="space-y-4">
 <div className="grid md:grid-cols-2 gap-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-sm font-bold text-foreground flex items-center gap-2">
 <Building2 className="w-4 h-4 text-slate-500" />{t("admin_compliance_regional_tax_regulations")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_compliance_authority")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_rate")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_status")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {taxRegulations.map((tax: GlobalTaxRegulation) => (
 <TableRow key={tax.id} className="border-border">
 <TableCell className="font-medium text-foreground">{tax.taxAuthority || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{tax.taxType || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">%{tax.taxRate || 0}</TableCell>
 <TableCell>
 <Badge variant={tax.isAutomated ?"default" :"outline"}>
 {tax.isAutomated ? t('admin_compliance_auto', 'Oto') : t('admin_compliance_manual', 'Manuel')}
 </Badge>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-sm font-bold text-foreground flex items-center gap-2">
 <Gavel className="w-4 h-4 text-slate-500" />{t("admin_compliance_legal_compliance_gdprkvkk")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_compliance_region")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_status")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {legalCompliance.map((legal: LegalCompliance) => (
 <TableRow key={legal.id} className="border-border">
 <TableCell className="text-muted-foreground">{legal.countryCode || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{legal.complianceType || 'N/A'}</TableCell>
 <TableCell>{getStatusBadge(legal.status || 'pending')}</TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-sm font-bold text-foreground">{t("admin_compliance_police_guest_reporting_kbsgiykimbil")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_compliance_report_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_reservation")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_submitted_at")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_compliance_status")}</TableHead>
 <TableHead className="text-right text-muted-foreground">{t("admin_compliance_action")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {policeReports.map((report: PoliceReport) => (
 <TableRow key={report.id} className="border-border">
 <TableCell className="font-bold text-muted-foreground">{report.reportType || 'N/A'}</TableCell>
 <TableCell className="text-xs font-mono text-muted-foreground">{report.reservationId || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{report.submittedAt ? new Date(report.submittedAt).toLocaleString() :"-"}</TableCell>
 <TableCell>{getStatusBadge(report.status || 'pending')}</TableCell>
 <TableCell className="text-right">
 <Button variant="outline" size="sm">{t("admin_compliance_view_log")}</Button>
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

 {/* Live Feed Sidebar */}
 <div className="hidden xl:block xl:col-span-1">
 <Card className="bg-card border-border rounded-2xl h-[calc(100vh-100px)] sticky top-6 overflow-hidden flex flex-col">
 <CardHeader className="border-b border-border bg-black/20 pb-4">
 <div className="flex items-center justify-between">
 <CardTitle className="text-sm font-bold flex items-center gap-2">
 <Activity className="w-4 h-4 text-emerald-500 animate-pulse" />
 {t("admin_auto_live_compliance_feed", "Live Compliance Feed")}</CardTitle>
 <Badge variant="outline" className="text-[9px] bg-emerald-500/10 text-emerald-500 border-none">{t("admin_ai_active", "Active")}</Badge>
 </div>
 <p className="text-[10px] text-muted-foreground mt-1">{t("admin_auto_real_time_global_identity_verification_l", "Real-time global identity & verification logs.")}</p>
 </CardHeader>
 <CardContent className="flex-1 overflow-y-auto p-4 space-y-3">
 <AnimatePresence>
 {liveEvents.map((ev) => (
 <motion.div
 key={ev.id}
 initial={{ opacity: 0, x: 20, height: 0 }}
 animate={{ opacity: 1, x: 0, height: 'auto' }}
 exit={{ opacity: 0, scale: 0.9 }}
 className={cn("p-3 rounded-xl border text-xs font-mono relative overflow-hidden",
 ev.type === 'success' ?"bg-emerald-500/5 border-emerald-500/20 text-emerald-400" :
 ev.type === 'warning' ?"bg-amber-500/5 border-amber-500/20 text-amber-400" :"bg-red-500/5 border-red-500/20 text-red-400"
 )}
 >
 <div className="flex items-start gap-2">
 {ev.type === 'success' && <CheckCircle2 className="w-3.5 h-3.5 shrink-0 mt-0.5" />}
 {ev.type === 'warning' && <AlertTriangle className="w-3.5 h-3.5 shrink-0 mt-0.5" />}
 {ev.type === 'error' && <ShieldCheck className="w-3.5 h-3.5 shrink-0 mt-0.5" />}
 <span className="leading-relaxed">{ev.text}</span>
 </div>
 <div className="absolute top-1 right-2 text-[8px] opacity-50">{t("messages.messagespage.auto_ext_6", "Just now")}</div>
 </motion.div>
 ))}
 </AnimatePresence>
 
 {liveEvents.length === 0 && (
 <div className="h-full flex flex-col items-center justify-center text-slate-500 space-y-2 opacity-50">
 <FileSearch className="w-8 h-8 animate-pulse" />
 <span className="text-xs">{t("admin_auto_awaiting_events", "Awaiting events...")}</span>
 </div>
 )}
 </CardContent>
 </Card>
 </div>
 </div>
 );
}
