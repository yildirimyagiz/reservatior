"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, CheckCircle, XCircle, Clock, Loader2, RefreshCw, Brain, Users, TrendingUp, Send } from "lucide-react";
import { tenantApplicationsApi, type TenantApplication } from "@/lib/api/tenant-applications";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { useMutation, useQueryClient } from "@tanstack/react-query";
const STATUS_CONFIG = {
  PENDING: {
    label: t("client.src.pending"),
    icon: Clock,
    cls: "bg-yellow-100 text-yellow-700"
  },
  UNDER_REVIEW: {
    label: t("client.src.reviewing"),
    icon: Edit,
    cls: "bg-blue-100 text-blue-700"
  },
  APPROVED: {
    label: t("client.src.approved"),
    icon: CheckCircle,
    cls: "bg-green-100 text-green-700"
  },
  REJECTED: {
    label: t("client.src.rejected"),
    icon: XCircle,
    cls: "bg-red-100 text-red-700"
  }
};
export default function TenantApplications() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [applications, setApplications] = useState<TenantApplication[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [loading, setLoading] = useState(true);
  const [viewOpen, setViewOpen] = useState(false);
  const [selectedApp, setSelectedApp] = useState<TenantApplication | null>(null);

  // Lead score calculation mutation
  const calculateScoreMutation = useMutation({
    mutationFn: (id: string) => tenantApplicationsApi.calculateLeadScore(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['tenant-applications'] });
      toast({ title: t("client.src.lead_score_calculated") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });

  // Landlord matching mutation
  const matchLandlordsMutation = useMutation({
    mutationFn: (id: string) => tenantApplicationsApi.matchWithLandlords(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['tenant-applications'] });
      toast({ title: t("client.src.landlords_matched") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });
  const fetchData = async () => {
    try {
      setLoading(true);
      const [appRes, propRes] = await Promise.all([tenantApplicationsApi.getAll(), propertiesApi.getAll()]);
      setApplications(appRes.data || []);
      setProperties(propRes || []);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_load_applications"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);
  const filtered = applications.filter(app => {
    const applicantName = `${app.applicant?.firstName || ''} ${app.applicant?.lastName || ''}`.toLowerCase();
    const matchesSearch = applicantName.includes(search.toLowerCase()) || (app.applicant?.email || '').toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || app.status === filterStatus;
    return matchesSearch && matchesStatus;
  });
  const handleUpdateStatus = async (id: string, status: string) => {
    try {
      await tenantApplicationsApi.update(id, {
        status
      } as any);
      toast({
        title: t("client.src.status_updated"),
        description: `Application is now ${status}`
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_update_status"),
        variant: "destructive"
      });
    }
  };
  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure?")) return;
    try {
      await tenantApplicationsApi.delete(id);
      toast({
        title: t("client.src.application_deleted")
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_delete_application"),
        variant: "destructive"
      });
    }
  };

  const handleCalculateScore = (id: string) => {
    calculateScoreMutation.mutate(id);
  };

  const handleMatchLandlords = (id: string) => {
    matchLandlordsMutation.mutate(id);
  };
  return <PageShell title={t("client.src.tenant_applications")} description={t("client.src.manage_and_review_prospective")} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search by applicant name or email..." actions={<Button variant="outline" size="icon" onClick={fetchData} disabled={loading}>
          <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
        </Button>} stats={[{
    label: t("client.src.total_applications"),
    value: applications.length
  }, {
    label: t("client.src.pending"),
    value: applications.filter(a => a.status === 'PENDING').length
  }, {
    label: t("client.src.under_review"),
    value: applications.filter(a => a.status === 'UNDER_REVIEW').length
  }, {
    label: t("client.src.approved"),
    value: applications.filter(a => a.status === 'APPROVED').length
  }]}>
      <div className="space-y-6">
        <div className="flex items-center space-x-2">
          {Object.entries(STATUS_CONFIG).map(([key, config]) => {
          const Icon = config.icon;
          return <Button key={key} variant={filterStatus === key ? "default" : "outline"} size="sm" onClick={() => setFilterStatus(prev => prev === key ? "all" : key)} className="h-8">
                <Icon className="w-3.5 h-3.5 mr-2" />
                {config.label}
              </Button>;
        })}
        </div>

        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.applicant")}</TableHead>
                <TableHead>{t("client.src.propertylisting")}</TableHead>
                <TableHead>{t("client.src.scoreincome")}</TableHead>
                <TableHead>{t("client.src.lead_score")}</TableHead>
                <TableHead>{t("client.src.engagement")}</TableHead>
                <TableHead>{t("client.src.status")}</TableHead>
                <TableHead>{t("client.src.date_submitted")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={8} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={8} className="text-center py-12 text-muted-foreground">{t("client.src.no_applications_found")}</TableCell></TableRow> : filtered.map(app => {
              const prop = properties.find(p => p.id === app.propertyId);
              return <TableRow key={app.id} className="hover:bg-muted/40 transition-colors cursor-pointer" onClick={() => {
                setSelectedApp(app);
                setViewOpen(true);
              }}>
                      <TableCell>
                        <div className="font-semibold text-sm">{app.applicant?.firstName} {app.applicant?.lastName}</div>
                        <div className="text-xs text-muted-foreground">{app.applicant?.email}</div>
                      </TableCell>
                      <TableCell>
                        <div className="text-sm font-medium">{app.listing?.title || prop?.name || "Direct Application"}</div>
                        <div className="text-[10px] text-muted-foreground font-mono">{app.propertyId}</div>
                      </TableCell>
                      <TableCell>
                        <div className="text-sm">{t("client.src.credit")}<span className="font-bold">{app.creditScore || "N/A"}</span></div>
                        <div className="text-xs text-muted-foreground">{t("client.src.income_verified")}{app.incomeVerified ? "Yes" : "No"}</div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <Brain className="w-4 h-4 text-blue-500" />
                          <span className="font-bold text-sm">{app.leadScore || "—"}</span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <Badge className={app.engagementLevel === 'HIGH' ? 'bg-green-100 text-green-700' : app.engagementLevel === 'MEDIUM' ? 'bg-yellow-100 text-yellow-700' : 'bg-gray-100 text-gray-700'}>
                          {app.engagementLevel || "LOW"}
                        </Badge>
                      </TableCell>
                      <TableCell>
                        <Badge className={`${STATUS_CONFIG[app.status]?.cls} border-0 text-[10px]`}>
                          {STATUS_CONFIG[app.status]?.label}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-sm text-muted-foreground">
                        {new Date(app.submittedAt).toLocaleDateString()}
                      </TableCell>
                      <TableCell onClick={e => e.stopPropagation()}>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem onClick={() => handleCalculateScore(app.id)}><Brain className="w-4 h-4 mr-2" />{t("client.src.calculate_lead_score")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleMatchLandlords(app.id)}><Users className="w-4 h-4 mr-2" />{t("client.src.match_landlords")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleUpdateStatus(app.id, "UNDER_REVIEW")}>{t("client.src.mark_under_review")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleUpdateStatus(app.id, "APPROVED")} className="text-green-600">{t("client.src.approve")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleUpdateStatus(app.id, "REJECTED")} className="text-red-600">{t("client.src.reject")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDelete(app.id)} className="text-destructive font-bold"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
            </TableBody>
          </Table>
        </div>

        <Dialog open={viewOpen} onOpenChange={setViewOpen}>
          <DialogContent className="sm:max-w-[700px] max-h-[85vh] overflow-y-auto">
            <DialogHeader>
              <DialogTitle>{t("client.src.application_details")}</DialogTitle>
            </DialogHeader>
            {selectedApp && <div className="space-y-6 py-4">
                <div className="grid grid-cols-2 gap-8">
                  <div className="space-y-4">
                    <h3 className="font-bold border-b pb-2 flex items-center gap-2"><Clock className="w-4 h-4" />{t("client.src.applicant_info")}</h3>
                    <div className="grid grid-cols-2 gap-x-4 gap-y-2 text-sm">
                      <span className="text-muted-foreground">{t("client.src.full_name")}</span>
                      <span className="font-medium">{selectedApp.applicant?.firstName} {selectedApp.applicant?.lastName}</span>
                      <span className="text-muted-foreground">{t("client.src.email")}</span>
                      <span className="font-medium">{selectedApp.applicant?.email}</span>
                      <span className="text-muted-foreground">{t("client.src.monthly_income")}</span>
                      <span className="font-medium text-green-700">${selectedApp.income?.toLocaleString() || "N/A"}</span>
                      <span className="text-muted-foreground">{t("client.src.employment")}</span>
                      <span className="font-medium">{selectedApp.employmentStatus || "N/A"}</span>
                    </div>
                  </div>
                  <div className="space-y-4">
                    <h3 className="font-bold border-b pb-2 flex items-center gap-2"><CheckCircle className="w-4 h-4" />{t("client.src.checks_scores")}</h3>
                    <div className="grid grid-cols-2 gap-x-4 gap-y-2 text-sm">
                      <span className="text-muted-foreground">{t("client.src.credit_score")}</span>
                      <span className={`font-bold ${(selectedApp.creditScore || 0) > 700 ? 'text-green-600' : 'text-yellow-600'}`}>
                        {selectedApp.creditScore || "Pending"}
                      </span>
                      <span className="text-muted-foreground">{t("client.src.income_verified")}</span>
                      <Badge variant={selectedApp.incomeVerified ? "default" : "outline"}>{selectedApp.incomeVerified ? "YES" : "NO"}</Badge>
                      <span className="text-muted-foreground">{t("client.src.background_check")}</span>
                      <Badge variant={selectedApp.backgroundCheck ? "default" : "outline"}>{selectedApp.backgroundCheck ? "PASSED" : "PENDING"}</Badge>
                    </div>
                  </div>
                </div>
                
                <div className="space-y-3">
                  <h3 className="font-bold border-b pb-2 flex items-center gap-2"><Users className="w-4 h-4" /> Accommodation Details</h3>
                  <div className="grid grid-cols-2 gap-x-4 gap-y-2 text-sm bg-muted/50 p-4 rounded-lg">
                    <span className="text-muted-foreground">Guest Count</span>
                    <span className="font-medium">{selectedApp.guestCount || selectedApp.applicationData?.guestCount || "Not specified"}</span>
                    <span className="text-muted-foreground">Smoking Allowed</span>
                    <span className="font-medium">{selectedApp.smoking || selectedApp.applicationData?.smoking ? "Yes" : "No"}</span>
                    <span className="text-muted-foreground">BBQ Preference</span>
                    <span className="font-medium">{selectedApp.bbq || selectedApp.applicationData?.bbq ? "Yes" : "No"}</span>
                    <span className="text-muted-foreground">Guest Details</span>
                    <span className="font-medium">{selectedApp.guestDetails || selectedApp.applicationData?.guestDetails || "None"}</span>
                  </div>
                </div>

                <div className="space-y-3">
                  <h3 className="font-bold border-b pb-2">{t("client.src.proposed_movein_notes")}</h3>
                  <div className="bg-muted p-4 rounded-lg space-y-2">
                    <div className="text-sm"><span className="text-muted-foreground mr-2">{t("client.src.property")}</span> {selectedApp.propertyName || "Unknown"}</div>
                    <div className="text-sm text-muted-foreground italic">"{selectedApp.applicationData?.notes || 'No notes provided'}"</div>
                  </div>
                </div>

                <DialogFooter className="flex justify-between sm:justify-between items-center bg-muted/30 -mx-6 -mb-6 p-6 mt-4">
                   <div className="flex gap-2">
                     <Button variant="outline" onClick={() => handleUpdateStatus(selectedApp.id, "REJECTED")} className="text-red-600 border-red-200 hover:bg-red-50">{t("client.src.reject")}</Button>
                     <Button variant="outline" onClick={() => handleUpdateStatus(selectedApp.id, "UNDER_REVIEW")}>{t("client.src.under_review")}</Button>
                   </div>
                   <Button onClick={() => handleUpdateStatus(selectedApp.id, "APPROVED")} className="bg-green-600 hover:bg-green-700">{t("client.src.approve_generate_lease")}</Button>
                </DialogFooter>
              </div>}
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}