"use client";

import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Shield, Eye, CheckCircle, XCircle, Clock, AlertTriangle, Activity, MapPin, User, Search, Layers, ArrowRight } from "lucide-react";
import { apiClient } from "@/lib/api/client";
import { cn } from "@/lib/utils";
export default function OwnershipVerification() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const { data: verifications = [], isLoading } = useQuery({
    queryKey: ['ownership-verifications'],
    queryFn: async () => {
      const res = await apiClient.get<any>("/ownership-verification-document");
      return res.data || [];
    }
  });
  const statusMutation = useMutation({
    mutationFn: async ({ id, status }: { id: string; status: string }) => {
      await apiClient.put(`/ownership-verification-document/${id}/status`, {
        verificationStatus: status,
        rejectionReason: status === 'REJECTED' ? "Compliance requirements not met." : undefined
      });
    },
    onSuccess: (_data, variables) => {
      toast({ title: `Node ${variables.status}`, description: t("admin_property_global_trust_levels_updated") });
      queryClient.invalidateQueries({ queryKey: ['ownership-verifications'] });
    },
    onError: () => {
      toast({ title: t("admin_property_update_failed"), description: t("admin_property_identity_sync_failure"), variant: "destructive" });
    }
  });
  const getStatusBadge = (status: string) => {
    switch (status) {
      case 'VERIFIED': return <Badge className="bg-emerald-500/10 text-emerald-400 border-none text-[9px] font-bold px-3 py-1 rounded-full"><CheckCircle className="w-3 h-3 mr-1" />{t("admin_property_verifiednode")}</Badge>;
      case 'REJECTED': return <Badge className="bg-red-500/10 text-red-500 border-none text-[9px] font-bold px-3 py-1 rounded-full"><XCircle className="w-3 h-3 mr-1" />{t("admin_property_terminated")}</Badge>;
      case 'PENDING': return <Badge className="bg-orange-500/10 text-orange-400 border-none text-[9px] font-bold px-3 py-1 rounded-full animate-pulse"><Clock className="w-3 h-3 mr-1" />{t("admin_property_pendingsync")}</Badge>;
      default: return <Badge variant="secondary" className="text-[9px] font-bold px-3 py-1 rounded-full">{status}</Badge>;
    }
  };
  return <div className="min-h-screen bg-background">
      <div className="p-6 space-y-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
          <h1 className="text-xl font-bold text-slate-900 dark:text-white">{t("propertyVerificationTitle")}</h1>
          <p className="text-sm text-slate-500 dark:text-slate-400">{t("propertyVerificationDesc")}</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
           {[{ label: t('totalRequests'), value: verifications.length, icon: Shield, color: "text-slate-500" },
             { label: t('pendingReview'), value: verifications.filter((v: any) => v.verificationStatus === 'PENDING').length, icon: Clock, color: "text-orange-500" },
             { label: t('verifiedProperties'), value: verifications.filter((v: any) => v.verificationStatus === 'VERIFIED').length, icon: CheckCircle, color: "text-emerald-500" }
           ].map((stat, i) => <Card key={i} className="bg-white/5 border-slate-200 dark:border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group border-l-2 border-t-2 transition-all hover:bg-white/10 p-8">
                 <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                   <stat.icon className="w-10 h-10" />
                 </div>
                 <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 tracking-[0.2em] mb-2">{stat.label}</p>
                 <h3 className="text-xl font-bold text-slate-900 dark:text-white leading-none">{stat.value}</h3>
                 <div className={cn("absolute bottom-0 left-0 w-full h-1 opacity-50", stat.color.replace('text-', 'bg-'))}></div>
              </Card>)}
        </div>

        <Card className="bg-white/5 backdrop-blur-xl border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l-2 border-t-2 relative">
           <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-600 via-transparent to-transparent opacity-30"></div>
           <CardHeader className="p-8 border-b border-slate-200 dark:border-white/10 flex flex-row items-center justify-between">
              <div>
                <CardTitle className="text-xs font-bold text-slate-900 dark:text-white tracking-[0.2em] flex items-center gap-2">
                  <Layers className="w-4 h-4 text-primary" /> {t('viewQueue')}</CardTitle>
              </div>
              <div className="relative group min-w-[280px]">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-500 dark:text-slate-400 group-focus-within:text-primary transition-colors" />
                <input placeholder={t("admin_property_filter_by_node_identity")} className="bg-white/5 border border-slate-200 dark:border-white/10 rounded-xl pl-12 h-10 text-[10px] text-slate-900 dark:text-white w-full focus:ring-primary/20 focus:border-primary/40 transition-all font-bold" />
              </div>
           </CardHeader>
           <CardContent className="p-0">
             {isLoading ? <div className="py-24 text-center">
                 <Activity className="w-12 h-12 text-slate-500 animate-spin mx-auto mb-4 opacity-50" />
                 <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 animate-pulse">{t("admin_property_synchronizing_authenticity_matrix")}</p>
               </div> : <Table>
                 <TableHeader className="bg-white/5 border-b border-slate-200 dark:border-white/10">
                   <TableRow className="border-none hover:bg-transparent">
                     <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 py-6 px-8">{t('propertyVerificationProperty')}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t('owner')}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t('method')}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8 text-center">{t('score')}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t('propertyVerificationStatus')}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8 text-right">{t("admin_property_actions")}</TableHead>
                   </TableRow>
                 </TableHeader>
                 <TableBody>
                   {verifications.map((v: any) => <TableRow key={v.id} className="border-b border-slate-200 dark:border-white/10 hover:bg-white/5 transition-all group">
                       <TableCell className="py-8 px-8">
                         <div className="flex items-center gap-4">
                            <div className="w-10 h-10 rounded-xl bg-white/5 border border-slate-200 dark:border-white/10 flex items-center justify-center group-hover:scale-110 transition-all shadow-inner">
                               <MapPin className="w-5 h-5 text-orange-500" />
                            </div>
                            <div>
                               <div className="text-sm font-bold text-slate-900 dark:text-white leading-tight">{v.property?.name}</div>
                               <div className="text-[9px] font-bold text-slate-500 dark:text-slate-400 mt-1 opacity-60 leading-none truncate max-w-[200px]">{v.property?.addressLine1}</div>
                            </div>
                         </div>
                       </TableCell>
                       <TableCell className="px-8">
                         <div className="flex items-center gap-3">
                            <div className="w-8 h-8 rounded-full bg-slate-500/10 flex items-center justify-center">
                               <User className="w-4 h-4 text-slate-500 dark:text-slate-400" />
                            </div>
                            <div>
                               <div className="text-[11px] font-bold text-slate-900 dark:text-white tracking-tight leading-tight">{v.currentOwner?.name || 'MANUAL_ENTRY'}</div>
                               <div className="text-[9px] font-medium text-slate-500 dark:text-slate-400 lowercase opacity-60 leading-none">{v.currentOwner?.email}</div>
                            </div>
                         </div>
                       </TableCell>
                       <TableCell className="px-8">
                         <Badge variant="outline" className="text-[9px] font-bold px-2 py-0.5 rounded-full border-slate-200 dark:border-white/10 bg-white/5 text-slate-500 dark:text-slate-400">
                           {v.verificationMethod?.replace('_', ' ')}
                         </Badge>
                       </TableCell>
                       <TableCell className="px-8 text-center">
                         {v.aiConfidenceScore ? <div className="inline-flex items-center gap-2 px-3 py-1 rounded-xl bg-white/5 border border-slate-200 dark:border-white/10">
                             <span className={cn("text-xs font-bold leading-none", v.aiConfidenceScore > 0.8 ? 'text-emerald-400' : 'text-amber-400')}>
                               {(v.aiConfidenceScore * 100).toFixed(1)}%
                             </span>
                             {v.aiConfidenceScore < 0.6 && <AlertTriangle className="w-3 h-3 text-red-500" />}
                           </div> : <span className="text-[9px] font-bold text-slate-500 dark:text-slate-400 opacity-30">{t("admin_property_nodata")}</span>}
                       </TableCell>
                       <TableCell className="px-8">{getStatusBadge(v.verificationStatus)}</TableCell>
                       <TableCell className="px-8 text-right">
                         <div className="flex justify-end gap-2">
                           <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-white/5 text-slate-500 dark:text-slate-400 hover:text-white transition-all">
                             <Eye className="w-4 h-4" />
                           </Button>
                           {v.verificationStatus === 'PENDING' && <>
                               <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-emerald-500/10 text-emerald-500 transition-all border border-transparent hover:border-emerald-500/20" onClick={() => statusMutation.mutate({ id: v.id, status: 'VERIFIED' })}>
                                 <CheckCircle className="w-4 h-4" />
                               </Button>
                               <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-red-500/10 text-red-500 transition-all border border-transparent hover:border-red-500/20" onClick={() => statusMutation.mutate({ id: v.id, status: 'REJECTED' })}>
                                 <XCircle className="w-4 h-4" />
                               </Button>
                             </>}
                         </div>
                       </TableCell>
                     </TableRow>)}
                   {verifications.length === 0 && <TableRow>
                       <TableCell colSpan={6} className="text-center py-24">
                         <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 opacity-50">{t('noRequests')}</p>
                       </TableCell>
                     </TableRow>}
                 </TableBody>
               </Table>}
           </CardContent>
           <div className="p-4 bg-white/5 border-t border-slate-200 dark:border-white/10 flex justify-between items-center transition-all">
              <div className="text-[8px] font-bold text-slate-600 tracking-[0.3em] flex items-center gap-2">
                 <Activity className="w-3 h-3 animate-pulse" />{t("admin_property_coreauthenticationmatrixuptime_100")}</div>
              <Button variant="ghost" className="text-[9px] font-bold text-primary hover:text-foreground flex items-center gap-2 group">{t("admin_property_deepauditlogs")}<ArrowRight className="w-3 h-3 group-hover:translate-x-1 transition-transform" />
              </Button>
           </div>
        </Card>
      </div>
    </div>;
}
