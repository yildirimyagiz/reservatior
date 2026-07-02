import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ShieldCheck, ShieldAlert, FileText, Calendar, Search, Plus, Clock, UserCheck, UserX, Loader2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import { PageShell } from "../layout/PageShell";
import { complianceApi, RightToRentCheck } from "@/lib/api/compliance";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useToast } from "@/hooks/use-toast";
interface RightToRentRecord {
  id: string;
  contactName: string;
  leaseId?: string;
  property?: string;
  checkType: 'Passport' | 'BRP' | 'ShareCode' | 'DocumentExam';
  reference: string;
  status: 'pending' | 'verified' | 'rejected' | 'expired' | 'conditional';
  checkedAt?: string;
  expiresAt?: string;
  riskScore?: number;
}
export default function RightToRent() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [searchQuery, setSearchQuery] = useState("");

  const { data: checksData = [], isLoading, refetch } = useQuery({
    queryKey: ['right-to-rent-checks'],
    queryFn: async () => {
      const response = await complianceApi.getRightToRentChecks();
      return (response as any).data || response || [];
    }
  });

  const createMutation = useMutation({
    mutationFn: (data: any) => complianceApi.createRightToRentCheck(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['right-to-rent-checks'] });
      toast({ title: t("client.src.check_created") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => complianceApi.updateRightToRentCheck(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['right-to-rent-checks'] });
      toast({ title: t("client.src.check_updated") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });

  const filteredChecks = checksData.filter((check: RightToRentCheck) => {
    const reference = check.reference || '';
    const checkType = check.checkType || '';
    return reference.toLowerCase().includes(searchQuery.toLowerCase()) ||
           checkType.toLowerCase().includes(searchQuery.toLowerCase());
  });

  const stats = {
    verified: checksData.filter((c: RightToRentCheck) => c.status === 'verified').length,
    warnings: checksData.filter((c: RightToRentCheck) => c.status === 'conditional' || c.status === 'pending').length,
    critical: checksData.filter((c: RightToRentCheck) => c.status === 'expired' || c.status === 'rejected').length,
    total: checksData.length
  };

  const complianceRate = stats.total > 0 ? Math.round((stats.verified / stats.total) * 100) : 0;

  const handleStartNewCheck = () => {
    console.log('Starting new right-to-rent check');
    // TODO: Implement new check dialog/form
  };

  const handleViewReport = (check: RightToRentCheck) => {
    console.log('Viewing report for:', check.reference);
    // TODO: Implement report view dialog
  };

  const handleRecheckStatus = (check: RightToRentCheck) => {
    updateMutation.mutate({
      id: check.id,
      data: { status: 'pending' }
    });
  };


  const getStatusBadge = (status: RightToRentRecord['status']) => {
    switch (status) {
      case 'verified':
        return <Badge className="bg-emerald-100 text-emerald-800 border-emerald-200 font-bold"><UserCheck className="w-3 h-3 mr-1" />{t("client.src.fully_verified")}</Badge>;
      case 'pending':
        return <Badge variant="outline" className="text-blue-600 border-blue-200 bg-blue-50 font-bold"><Clock className="w-3 h-3 mr-1" />{t("client.src.pending_check")}</Badge>;
      case 'rejected':
        return <Badge variant="destructive" className="font-bold"><UserX className="w-3 h-3 mr-1" />{t("client.src.rejected")}</Badge>;
      case 'expired':
        return <Badge variant="destructive" className="bg-red-50 text-red-600 border-red-200 font-bold underline"><ShieldAlert className="w-3 h-3 mr-1" />{t("client.src.expired")}</Badge>;
      case 'conditional':
        return <Badge className="bg-amber-100 text-amber-800 border-amber-200 font-bold"><Calendar className="w-3 h-3 mr-1" />{t("client.src.limited_leave")}</Badge>;
    }
  };
  if (isLoading) {
    return <PageShell title={t("client.src.right_to_rent_checks")} description={t("client.src.verification_of_identity_and")}>
      <div className="flex items-center justify-center h-[60vh]">
        <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
      </div>
    </PageShell>;
  }

  return <PageShell title={t("client.src.right_to_rent_checks")} description={t("client.src.verification_of_identity_and")}>
      <div className="space-y-6">
        {/* Compliance Meter */}
        <Card className="bg-gradient-to-r from-emerald-600 to-indigo-500 text-white shadow-xl border-none">
          <CardContent className="p-8">
            <div className="flex flex-col md:flex-row justify-between items-center gap-8">
              <div className="max-w-md">
                <h2 className="text-3xl font-bold mb-2">{complianceRate}% {t("client.src.compliant")}</h2>
                <p className="text-emerald-50 mb-4 opacity-90">{t("client.src.you_have")} {stats.total} {t("client.src.active_checks")}</p>
                <div className="flex gap-4">
                  <div className="bg-white/20 px-4 py-2 rounded-lg backdrop-blur-sm">
                    <p className="text-2xl font-bold">{stats.verified}</p>
                    <p className="text-xs tracking-wider opacity-80">{t("client.src.verified")}</p>
                  </div>
                  <div className="bg-amber-400/30 px-4 py-2 rounded-lg backdrop-blur-sm">
                    <p className="text-2xl font-bold text-amber-200">{stats.warnings}</p>
                    <p className="text-xs tracking-wider opacity-80">{t("client.src.warnings")}</p>
                  </div>
                  <div className="bg-red-400/30 px-4 py-2 rounded-lg backdrop-blur-sm">
                    <p className="text-2xl font-bold text-red-200">{stats.critical}</p>
                    <p className="text-xs tracking-wider opacity-80">{t("client.src.critical")}</p>
                  </div>
                </div>
              </div>

              <div className="w-48 h-48 relative flex items-center justify-center">
                <div className="absolute inset-0 rounded-full border-12 border-emerald-400/30"></div>
                <div className="absolute inset-0 rounded-full border-12 border-white border-t-transparent border-r-transparent transform -rotate-45"></div>
                <ShieldCheck className="w-16 h-16 text-white drop-shadow-lg" />
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Filters and Search */}
        <div className="flex flex-col md:flex-row gap-4 justify-between items-center">
          <div className="relative w-full md:w-96">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
            <Input placeholder={t("client.src.search_by_tenant_name")} className="pl-10" value={searchQuery} onChange={e => setSearchQuery(e.target.value)} />
          </div>
          <div className="flex gap-2 w-full md:w-auto">
             <Button className="bg-emerald-600 hover:bg-emerald-700 shadow-lg shadow-emerald-100" onClick={handleStartNewCheck}><Plus className="w-4 h-4 mr-2" />{t("client.src.start_new_check")}</Button>
          </div>
        </div>

        {/* Checks Table/Grid */}
        <div className="grid gap-4">
          {filteredChecks.length === 0 ? (
            <Card>
              <CardContent className="p-8 text-center text-muted-foreground">
                <ShieldCheck className="w-12 h-12 mx-auto mb-4 opacity-50" />
                <p>{t("client.src.no_checks_found")}</p>
              </CardContent>
            </Card>
          ) : (
            filteredChecks.map((check: RightToRentCheck) => <Card key={check.id} className="group hover:border-emerald-500 transition-all">
              <CardContent className="p-0">
                <div className="flex flex-col md:flex-row items-stretch">
                  <div className="p-6 flex-1">
                    <div className="flex justify-between items-start mb-4">
                      <div className="flex items-center gap-3">
                        <div className={`w-12 h-12 rounded-full flex items-center justify-center ${check.status === 'verified' ? 'bg-emerald-50 text-emerald-600' : 'bg-red-50 text-red-600'}`}>
                          <UserCheck className="w-6 h-6" />
                        </div>
                        <div>
                          <h3 className="text-lg font-bold group-hover:text-emerald-700 transition-colors tracking-tight">{check.contactId || 'N/A'}</h3>
                          <p className="text-sm text-muted-foreground font-medium">{check.leaseId || 'No active lease attached'}</p>
                        </div>
                      </div>
                      {getStatusBadge(check.status as any)}
                    </div>

                    <div className="grid grid-cols-2 lg:grid-cols-4 gap-6 text-sm">
                      <div>
                        <p className="text-xs tracking-wider text-muted-foreground mb-1 font-bold">{t("client.src.document_type")}</p>
                        <p className="font-semibold text-foreground flex items-center">
                          <FileText className="w-3.5 h-3.5 mr-1.5 text-emerald-600" />
                          {check.checkType}
                        </p>
                      </div>
                      <div>
                        <p className="text-xs tracking-wider text-muted-foreground mb-1 font-bold">{t("client.src.reference_number")}</p>
                        <p className="font-mono text-xs bg-muted px-2 py-1 rounded-md inline-block">
                          {check.reference}
                        </p>
                      </div>
                      <div>
                        <p className="text-xs tracking-wider text-muted-foreground mb-1 font-bold">{t("client.src.checked_on")}</p>
                        <p className="font-semibold text-foreground flex items-center">
                          <Calendar className="w-3.5 h-3.5 mr-1.5 text-blue-500" />
                          {check.checkedAt ? new Date(check.checkedAt as string).toLocaleDateString() : 'Scheduled'}
                        </p>
                      </div>
                      <div>
                        <p className="text-xs tracking-wider text-muted-foreground mb-1 font-bold">{t("client.src.expiry_date")}</p>
                        <p className={`font-semibold flex items-center ${check.status === 'expired' ? 'text-red-600 font-bold' : 'text-foreground font-medium'}`}>
                          <Clock className="w-3.5 h-3.5 mr-1.5 opacity-60" />
                          {check.expiresAt ? new Date(check.expiresAt).toLocaleDateString() : 'Indefinite Leave'}
                        </p>
                      </div>
                    </div>
                  </div>

                  <div className="bg-muted/30 p-4 flex md:flex-col justify-center gap-2 border-t md:border-t-0 md:border-l w-full md:w-56">
                    <Button variant="default" size="sm" className="w-full bg-emerald-600 hover:bg-emerald-700 shadow-sm shadow-emerald-100" onClick={() => handleViewReport(check)}>{t("client.src.view_report")}</Button>
                    <Button variant="outline" size="sm" className="w-full" onClick={() => handleRecheckStatus(check)} disabled={updateMutation.isPending}>{t("client.src.recheck_status")}</Button>
                  </div>
                </div>
              </CardContent>
            </Card>)
          )}
        </div>

        {/* Legal Disclaimer */}
        <div className="bg-amber-50 border-l-4 border-amber-400 p-4 rounded-r-lg">
          <div className="flex items-start">
            <ShieldAlert className="w-5 h-5 text-amber-500 mr-3 shrink-0 mt-0.5" />
            <div>
              <p className="text-sm text-amber-800 font-bold">{t("client.src.compliance_reminder")}</p>
              <p className="text-xs text-amber-700 mt-1">{t("client.src.failing_to_carry_out")}</p>
            </div>
          </div>
        </div>
      </div>
    </PageShell>;
}