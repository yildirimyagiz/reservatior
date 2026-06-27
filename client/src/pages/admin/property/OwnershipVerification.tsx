import { t } from "i18next";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";
import { Shield, Eye, CheckCircle, XCircle, Clock, AlertTriangle, Activity, MapPin, User, Search, Layers, ArrowRight } from "lucide-react";
import { apiClient } from "@/lib/api/client";
import { cn } from "@/lib/utils";
import { motion } from "framer-motion";
export default function OwnershipVerification() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [verifications, setVerifications] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const fetchVerifications = async () => {
    try {
      setLoading(true);
      const res = await apiClient.get<any>("/property-ownership-verification");
      setVerifications(res.data || []);
    } catch (error) {
      toast({
        title: t('admin.users.organizations.syncFailure'),
        description: t("admin.property.global_authentication_matrix_unreachable"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchVerifications();
  }, []);
  const handleStatusUpdate = async (id: string, status: string) => {
    try {
      await apiClient.put(`/property-ownership-verification/${id}/status`, {
        verificationStatus: status,
        rejectionReason: status === 'REJECTED' ? "Compliance requirements not met." : undefined
      });
      toast({
        title: `Node ${status}`,
        description: t("admin.property.global_trust_levels_updated")
      });
      fetchVerifications();
    } catch (error) {
      toast({
        title: t("admin.property.update_failed"),
        description: t("admin.property.identity_sync_failure"),
        variant: "destructive"
      });
    }
  };
  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'VERIFIED':
        return <Badge className="bg-emerald-500/10 text-emerald-400 border-none text-[9px] font-bold px-3 py-1 rounded-full"><CheckCircle className="w-3 h-3 mr-1" />{t("admin.property.verifiednode")}</Badge>;
      case 'REJECTED':
        return <Badge className="bg-red-500/10 text-red-500 border-none text-[9px] font-bold px-3 py-1 rounded-full"><XCircle className="w-3 h-3 mr-1" />{t("admin.property.terminated")}</Badge>;
      case 'PENDING':
        return <Badge className="bg-orange-500/10 text-orange-400 border-none text-[9px] font-bold px-3 py-1 rounded-full animate-pulse"><Clock className="w-3 h-3 mr-1" />{t("admin.property.pendingsync")}</Badge>;
      default:
        return <Badge variant="secondary" className="text-[9px] font-bold px-3 py-1 rounded-full">{status}</Badge>;
    }
  };
  return <PageShell title={t('propertyVerificationTitle')} description={t('propertyVerificationDesc')}>
      <div className="space-y-10 pb-20 selection:bg-primary/30 px-4">
        
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
           {[{
          label: t('totalRequests'),
          value: verifications.length,
          icon: Shield,
          color: "text-blue-500"
        }, {
          label: t('pendingReview'),
          value: verifications.filter(v => v.verificationStatus === 'PENDING').length,
          icon: Clock,
          color: "text-orange-500"
        }, {
          label: t('verifiedProperties'),
          value: verifications.filter(v => v.verificationStatus === 'VERIFIED').length,
          icon: CheckCircle,
          color: "text-emerald-500"
        }].map((stat, i) => <motion.div key={i} initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: i * 0.1
        }}>
               <div className="bg-card/40 backdrop-blur-md border-border dark:border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-2 border-t-2 transition-all hover:bg-card/60 p-8">
                  <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                    <stat.icon className="w-10 h-10" />
                  </div>
                  <p className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] mb-2">{stat.label}</p>
                  <h3 className="text-xl font-bold text-foreground leading-none">{stat.value}</h3>
                  <div className={cn("absolute bottom-0 left-0 w-full h-1 opacity-50", stat.color.replace('text-', 'bg-'))}></div>
               </div>
             </motion.div>)}
        </div>

        {/* Global Data Table */}
        <Card className="bg-card/40 backdrop-blur-xl border-border dark:border-border rounded-4xl overflow-hidden shadow-2xl border-l-2 border-t-2 relative">
           <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-blue-600 via-transparent to-transparent opacity-30"></div>
           <CardHeader className="p-8 border-b border-border flex flex-row items-center justify-between">
              <div>
                <CardTitle className="text-xs font-bold text-foreground tracking-[0.2em] flex items-center gap-2">
                  <Layers className="w-4 h-4 text-primary" /> {t('viewQueue')}
                </CardTitle>
              </div>
              <div className="relative group min-w-[280px]">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
                <input placeholder={t("admin.property.filter_by_node_identity")} className="bg-card border border-border rounded-xl pl-12 h-10 text-[10px] text-foreground w-full focus:ring-primary/20 focus:border-primary/40 transition-all font-bold" />
              </div>
           </CardHeader>
           <CardContent className="p-0">
            {loading ? <div className="py-24 text-center">
                <Activity className="w-12 h-12 text-blue-500 animate-spin mx-auto mb-4 opacity-50" />
                <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t("admin.property.synchronizing_authenticity_matrix")}</p>
              </div> : <Table>
                <TableHeader className="bg-muted/50 border-b border-border">
                  <TableRow className="border-none hover:bg-transparent">
                    <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t('propertyVerificationProperty')}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('owner')}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('method')}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-center">{t('score')}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('propertyVerificationStatus')}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin.property.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {verifications.map(v => <TableRow key={v.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                      <TableCell className="py-8 px-8">
                        <div className="flex items-center gap-4">
                           <div className="w-10 h-10 rounded-xl bg-background border border-border flex items-center justify-center group-hover:scale-110 transition-all shadow-inner">
                              <MapPin className="w-5 h-5 text-orange-500" />
                           </div>
                           <div>
                              <div className="text-sm font-bold text-foreground leading-tight">{v.property?.name}</div>
                              <div className="text-[9px] font-bold text-muted-foreground mt-1 opacity-60 leading-none truncate max-w-[200px]">{v.property?.addressLine1}</div>
                           </div>
                        </div>
                      </TableCell>
                      <TableCell className="px-8">
                        <div className="flex items-center gap-3">
                           <div className="w-8 h-8 rounded-full bg-blue-500/10 flex items-center justify-center">
                              <User className="w-4 h-4 text-blue-400" />
                           </div>
                           <div>
                              <div className="text-[11px] font-bold text-foreground tracking-tight leading-tight">{v.currentOwner?.name || 'MANUAL_ENTRY'}</div>
                              <div className="text-[9px] font-medium text-muted-foreground lowercase opacity-60 leading-none">{v.currentOwner?.email}</div>
                           </div>
                        </div>
                      </TableCell>
                      <TableCell className="px-8">
                        <Badge variant="outline" className="text-[9px] font-bold px-2 py-0.5 rounded-full border-border bg-muted/50 text-muted-foreground">
                          {v.verificationMethod.replace('_', ' ')}
                        </Badge>
                      </TableCell>
                      <TableCell className="px-8 text-center">
                        {v.aiConfidenceScore ? <div className="inline-flex items-center gap-2 px-3 py-1 rounded-xl bg-card border border-border">
                            <span className={cn("text-xs font-bold   leading-none", v.aiConfidenceScore > 0.8 ? 'text-emerald-400' : 'text-amber-400')}>
                              {(v.aiConfidenceScore * 100).toFixed(1)}%
                            </span>
                            {v.aiConfidenceScore < 0.6 && <AlertTriangle className="w-3 h-3 text-red-500" />}
                          </div> : <span className="text-[9px] font-bold text-muted-foreground opacity-30">{t("admin.property.nodata")}</span>}
                      </TableCell>
                      <TableCell className="px-8">{getStatusBadge(v.verificationStatus)}</TableCell>
                      <TableCell className="px-8 text-right">
                        <div className="flex justify-end gap-2">
                          <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-muted/50 text-muted-foreground hover:text-foreground transition-all">
                            <Eye className="w-4 h-4" />
                          </Button>
                          {v.verificationStatus === 'PENDING' && <>
                              <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-emerald-500/10 text-emerald-500 transition-all border border-transparent hover:border-emerald-500/20" onClick={() => handleStatusUpdate(v.id, 'VERIFIED')}>
                                <CheckCircle className="w-4 h-4" />
                              </Button>
                              <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-red-500/10 text-red-500 transition-all border border-transparent hover:border-red-500/20" onClick={() => handleStatusUpdate(v.id, 'REJECTED')}>
                                <XCircle className="w-4 h-4" />
                              </Button>
                            </>}
                        </div>
                      </TableCell>
                    </TableRow>)}
                  {verifications.length === 0 && <TableRow>
                      <TableCell colSpan={6} className="text-center py-24">
                        <p className="text-[10px] font-bold text-muted-foreground opacity-50">{t('noRequests')}</p>
                      </TableCell>
                    </TableRow>}
                </TableBody>
              </Table>}
           </CardContent>
           <div className="p-4 bg-card border-t border-border flex justify-between items-center transition-all">
              <div className="text-[8px] font-bold text-slate-600 tracking-[0.3em] flex items-center gap-2">
                 <Activity className="w-3 h-3 animate-pulse" />{t("admin.property.coreauthenticationmatrixuptime_100")}</div>
              <Button variant="ghost" className="text-[9px] font-bold text-primary hover:text-foreground flex items-center gap-2 group">{t("admin.property.deepauditlogs")}<ArrowRight className="w-3 h-3 group-hover:translate-x-1 transition-transform" />
              </Button>
           </div>
        </Card>
      </div>
    </PageShell>;
}