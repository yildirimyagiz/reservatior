import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { Shield, Eye, ShieldCheck, ShieldAlert, Clock, AlertTriangle, Monitor, Globe, Activity, Zap } from "lucide-react";
import { apiClient } from "@/lib/api/client";
import { cn } from "@/lib/utils";
export default function SecurityScreening() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const { data: screenings = [], isLoading } = useQuery({
    queryKey: ['security-screenings'],
    queryFn: async () => {
      const res = await apiClient.get<any>("/booking-security-screening");
      return Array.isArray(res) ? res : (res as any).data || [];
    }
  });
  const getRiskStyle = (level: string) => {
    switch (level) {
      case 'HIGH': return "bg-rose-500/10 text-rose-400 border-rose-500/20";
      case 'MEDIUM': return "bg-orange-500/10 text-orange-400 border-orange-500/20";
      case 'LOW': return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
      default: return "bg-slate-500/10 text-slate-400 border-slate-500/20";
    }
  };
  return <div className="min-h-screen bg-background">
      <div className="p-6 space-y-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-white/10">
          <h1 className="text-xl font-bold text-white">{t("admin.security.fraud_assessment_hub")}</h1>
          <p className="text-sm text-slate-400">{t("admin.security.realtime_behavioral_analysis_and")}</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
           {[{ label: t("admin.security.total_screened"), val: screenings.length, icon: Shield, color: "text-blue-400" },
             { label: t("admin.security.critical_flags"), val: screenings.filter(s => s.riskLevel === 'HIGH').length, icon: ShieldAlert, color: "text-rose-500" },
             { label: t("admin.security.manual_reviews"), val: screenings.filter(s => s.manualReviewRequired).length, icon: Clock, color: "text-orange-400" },
             { label: t("admin.security.safe_entities"), val: screenings.filter(s => s.riskLevel === 'LOW').length, icon: ShieldCheck, color: "text-emerald-400" }
           ].map((stat, i) => <Card key={i} className="bg-white/5 border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group">
                 <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                    <stat.icon className="w-12 h-12" />
                 </div>
                 <CardContent className="p-8">
                   <p className="text-[10px] font-bold text-slate-400 mb-1">{stat.label}</p>
                   <h3 className="text-xl font-bold text-white leading-none">{stat.val}</h3>
                 </CardContent>
              </Card>)}
        </div>

        <Card className="bg-white/5 border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
           <CardHeader className="p-8 border-b border-white/10 flex flex-row items-center justify-between">
              <CardTitle className="text-xs font-bold text-white flex items-center gap-2">
                 <Zap className="w-4 h-4 text-orange-500" />{t("admin.security.assessment_queue")}</CardTitle>
              <div className="flex gap-2">
                 <Button variant="outline" className="h-10 rounded-xl border-white/10 bg-white/5 hover:bg-white/10 text-slate-400 hover:text-white font-bold text-[9px] gap-2">
                    <Monitor className="w-3.5 h-3.5" />{t("admin.security.behavioral_analysis")}</Button>
                 <Button variant="outline" className="h-10 rounded-xl border-white/10 bg-white/5 hover:bg-white/10 text-slate-400 hover:text-white font-bold text-[9px] gap-2">
                    <Globe className="w-3.5 h-3.5" />{t("admin.security.ip_intel")}</Button>
              </div>
           </CardHeader>
           <CardContent className="p-0">
             {isLoading ? <div className="py-24 text-center">
                   <Activity className="w-8 h-8 text-orange-500 animate-spin mx-auto mb-4 opacity-50" />
                   <p className="text-xs font-bold text-slate-400 animate-pulse">{t("admin.security.syncing_trust_matrix")}</p>
                </div> : <Table>
                 <TableHeader className="bg-white/5 border-b border-white/10">
                   <TableRow className="hover:bg-transparent border-none">
                     <TableHead className="text-[10px] font-bold text-slate-400 py-6 px-8">{t("admin.security.entity_signature")}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.security.asset_context")}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.security.risk_profile")}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.security.neural_score")}</TableHead>
                     <TableHead className="text-[10px] font-bold text-slate-400 px-8 text-right">{t("admin.security.actions")}</TableHead>
                   </TableRow>
                 </TableHeader>
                 <TableBody>
                   {screenings.map(s => <TableRow key={s.id} className="border-b border-white/10 hover:bg-white/5 transition-all group">
                       <TableCell className="py-8 px-8">
                         <div className="font-bold text-blue-400 text-[9px] mb-2">{s.booking?.id?.slice(0, 8) || 'PRE-BOOKING'}</div>
                         <div className="text-sm font-bold text-white leading-none">{s.contact?.fullName}</div>
                         <div className="text-[10px] font-bold text-slate-400 mt-1">{s.contact?.email}</div>
                       </TableCell>
                       <TableCell className="px-8">
                         <div className="text-xs font-bold text-slate-400">{s.property?.name}</div>
                         <div className="text-[10px] font-bold text-slate-600 mt-1">{s.property?.city}</div>
                       </TableCell>
                       <TableCell className="px-8">
                          <Badge className={cn("text-[9px] font-bold px-2", getRiskStyle(s.riskLevel))}>{s.riskLevel}</Badge>
                       </TableCell>
                       <TableCell className="px-8">
                          <div className="flex items-center gap-4">
                             <div className="w-24 h-1.5 bg-white/5 rounded-full overflow-hidden">
                                <div className={cn("h-full rounded-full transition-all duration-1000", s.riskScore > 0.7 ? 'bg-rose-500' : s.riskScore > 0.4 ? 'bg-orange-500' : 'bg-emerald-500')} style={{ width: `${s.riskScore * 100}%` }} />
                             </div>
                             <span className="text-xs font-bold text-white">{(s.riskScore * 100).toFixed(0)}</span>
                          </div>
                       </TableCell>
                       <TableCell className="px-8 text-right">
                         <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-400 hover:text-white">
                           <Eye className="w-5 h-5" />
                         </Button>
                       </TableCell>
                     </TableRow>)}
                 </TableBody>
               </Table>}
           </CardContent>
        </Card>
      </div>
    </div>;
}
