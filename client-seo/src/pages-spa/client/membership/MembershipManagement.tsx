import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Crown, Star, CheckCircle, XCircle, AlertCircle, TrendingUp, DollarSign, MoreHorizontal, Edit, Rocket, Shield, Building, RefreshCw } from "lucide-react";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { apiClient } from "@/lib/api";
import { LocalComplianceWidget } from "@/components/legal/LocalComplianceWidget";
import { SmartLockWidget } from "@/components/iot/SmartLockWidget";
import { Scale, Globe, FileText, Smartphone } from "lucide-react";
interface MembershipRecord {
  id: string;
  orgId: string;
  planId: string;
  status: string;
  currentPeriodEnd?: string | null;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string | null;
  org: {
    id: string;
    name: string;
    type: string;
  };
  plan: {
    id: string;
    key: string;
    name: string;
    limits: any;
    priceMonthlyCents?: number | null;
  };
}
const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-100 text-green-700",
  TRIALING: "bg-blue-100 text-blue-700",
  EXPIRED: "bg-red-100 text-red-700",
  CANCELLED: "bg-gray-100 text-gray-700",
  SUSPENDED: "bg-orange-100 text-orange-700"
};
export default function MembershipManagement() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [memberships, setMemberships] = useState<MembershipRecord[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedMembership, setSelectedMembership] = useState<MembershipRecord | null>(null);
  const [upgradeOpen, setUpgradeOpen] = useState(false);
  const [cancelOpen, setCancelOpen] = useState(false);
  const [selectedPlan, setSelectedPlan] = useState<string>("");
  useEffect(() => {
    fetchMemberships();
  }, []);
  const fetchMemberships = async () => {
    try {
      setLoading(true);
      const res = (await apiClient.get('/admin/subscriptions')) as {
        data: MembershipRecord[];
      };
      setMemberships(res.data || []);
    } catch (error) {
      console.error("Error fetching memberships:", error);
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_load_membership"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const stats = {
    total: memberships.length,
    active: memberships.filter(m => m.status === "ACTIVE").length,
    trialing: memberships.filter(m => m.status === "TRIALING").length,
    expired: memberships.filter(m => m.status === "EXPIRED").length,
    mrr: memberships.filter(m => m.status === "ACTIVE").reduce((sum, m) => sum + (m.plan.priceMonthlyCents || 0) / 100, 0)
  };
  const handleUpgrade = (membership: MembershipRecord, newPlan: string) => {
    setSelectedMembership(membership);
    setSelectedPlan(newPlan);
    setUpgradeOpen(true);
  };
  const handleCancel = (membership: MembershipRecord) => {
    setSelectedMembership(membership);
    setCancelOpen(true);
  };
  const confirmUpgrade = async () => {
    if (!selectedMembership || !selectedPlan) return;
    toast({
      title: t("client.src.action_required"),
      description: t("client.src.upgrade_logic_is_being")
    });
    setUpgradeOpen(false);
    setSelectedMembership(null);
  };
  const confirmCancel = async () => {
    if (!selectedMembership) return;
    try {
      await apiClient.patch(`/admin/subscriptions/${selectedMembership.id}`, {
        status: "CANCELLED"
      });
      toast({
        title: t("client.src.membership_cancelled"),
        description: t("client.src.membership_has_been_cancelled")
      });
      fetchMemberships();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_cancel_membership"),
        variant: "destructive"
      });
    } finally {
      setCancelOpen(false);
      setSelectedMembership(null);
    }
  };
  const getPlanIcon = (planKey: string) => {
    const key = planKey.toUpperCase();
    if (key.includes("ENTERPRISE")) return Crown;
    if (key.includes("PROFESSIONAL") || key.includes("ROCKET")) return Rocket;
    if (key.includes("BASIC") || key.includes("STAR")) return Star;
    return Shield;
  };
  const getPlanColor = (planKey: string) => {
    const key = planKey.toUpperCase();
    if (key.includes("ENTERPRISE")) return "bg-yellow-100 text-yellow-700";
    if (key.includes("PROFESSIONAL")) return "bg-purple-100 text-purple-700";
    if (key.includes("BASIC")) return "bg-blue-100 text-blue-700";
    return "bg-gray-100 text-gray-700";
  };
  const formatDate = (dateString?: string | null) => {
    if (!dateString) return "N/A";
    return new Date(dateString).toLocaleDateString();
  };
  return <PageShell title={t("client.src.membership_management")} description={t("client.src.manage_organization_subscriptions_and")}>
      <div className="space-y-6">
        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4">
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm font-medium text-gray-600">{t("client.src.total_subscriptions")}</p>
              <div className="flex items-center justify-center gap-2 mt-2">
                <Building className="w-5 h-5 text-blue-600" />
                <p className="text-2xl font-bold">{stats.total}</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm font-medium text-gray-600">{t("client.src.active")}</p>
              <div className="flex items-center justify-center gap-2 mt-2">
                <CheckCircle className="w-5 h-5 text-green-600" />
                <p className="text-2xl font-bold text-green-600">{stats.active}</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm font-medium text-gray-600">{t("client.src.trialing")}</p>
              <div className="flex items-center justify-center gap-2 mt-2">
                <AlertCircle className="w-5 h-5 text-blue-600" />
                <p className="text-2xl font-bold text-blue-600">{stats.trialing}</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm font-medium text-gray-600">{t("client.src.expired")}</p>
              <div className="flex items-center justify-center gap-2 mt-2">
                <XCircle className="w-5 h-5 text-red-600" />
                <p className="text-2xl font-bold text-red-600">{stats.expired}</p>
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4 text-center">
              <p className="text-sm font-medium text-gray-600">{t("client.src.monthly_revenue_mrr")}</p>
              <div className="flex items-center justify-center gap-2 mt-2">
                <DollarSign className="w-5 h-5 text-green-600" />
                <p className="text-2xl font-bold">${stats.mrr.toLocaleString()}</p>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Strategy & Compliance Hybrid View */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
           <div className="lg:col-span-2">
              <Card className="h-full border-none shadow-2xl bg-gradient-to-br from-indigo-50 to-white overflow-hidden ring-1 ring-indigo-100">
                 <CardHeader className="pb-4">
                    <div className="flex items-center gap-3">
                       <div className="p-3 bg-indigo-100 rounded-2xl">
                          <Scale className="w-6 h-6 text-indigo-700" />
                       </div>
                       <div>
                          <CardTitle className="text-2xl font-black text-slate-800 tracking-tight">{t("client.src.financial_shield_strategy")}</CardTitle>
                          <CardDescription className="text-xs font-bold text-slate-500 tracking-widest">{t("client.src.disrupting_the_20_ota")}</CardDescription>
                       </div>
                    </div>
                 </CardHeader>
                 <CardContent className="space-y-6">
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                       <div className="p-5 rounded-2xl bg-white shadow-sm border border-slate-100 group hover:border-emerald-200 transition-all">
                          <div className="flex items-center gap-3 mb-3">
                             <div className="p-2 bg-emerald-50 text-emerald-600 rounded-lg group-hover:bg-emerald-600 group-hover:text-white transition-colors">
                                <DollarSign className="w-4 h-4" />
                             </div>
                             <h4 className="font-black text-sm text-slate-900">{t("client.src.10_optimized_commission")}</h4>
                          </div>
                          <p className="text-[11px] text-slate-500 font-medium leading-relaxed">{t("client.src.our_core_revenue_model")}</p>
                       </div>
                       
                       <div className="p-5 rounded-2xl bg-white shadow-sm border border-slate-100 group hover:border-blue-200 transition-all">
                          <div className="flex items-center gap-3 mb-3">
                             <div className="p-2 bg-blue-50 text-blue-600 rounded-lg group-hover:bg-blue-600 group-hover:text-white transition-colors">
                                <Building className="w-4 h-4" />
                             </div>
                             <h4 className="font-black text-sm text-slate-900">{t("client.src.local_tax_entity")}</h4>
                          </div>
                          <p className="text-[11px] text-slate-500 font-medium leading-relaxed">{t("client.src.we_act_as_your")}</p>
                       </div>
                    </div>

                    <div className="p-6 rounded-2xl bg-slate-900 text-white relative overflow-hidden group">
                       <div className="absolute top-0 right-0 p-8 opacity-10">
                          <Globe className="w-32 h-32" />
                       </div>
                       <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-6">
                          <div className="space-y-4">
                             <h4 className="text-xl font-black tracking-tight flex items-center gap-2">
                                <FileText className="w-5 h-5 text-indigo-400" />{t("client.src.global_hub")}<span className="text-indigo-400">{t("client.src.expansion_strategy")}</span>
                             </h4>
                             <div className="grid grid-cols-2 md:grid-cols-3 gap-3">
                                {[{
                        name: 'USA',
                        desc: '1099-K & TOT'
                      }, {
                        name: 'Europe',
                        desc: 'DAC7 & VAT'
                      }, {
                        name: 'Brazil',
                        desc: 'ISS & CNPJ'
                      }, {
                        name: 'India',
                        desc: 'GST & 15CA'
                      }, {
                        name: 'Russia',
                        desc: 'Local OFD'
                      }, {
                        name: 'Turkey',
                        desc: '7464 / KDV'
                      }].map(m => <div key={m.name} className="p-2 bg-white/5 border border-white/10 rounded-lg backdrop-blur-sm">
                                     <p className="text-[10px] font-black text-indigo-400">{m.name}</p>
                                     <p className="text-[9px] text-slate-400 font-bold">{m.desc}</p>
                                  </div>)}
                             </div>
                             <p className="text-[10px] text-slate-500 font-medium max-w-md">{t("client.src.unlike_global_conglomerates_our")}</p>
                          </div>
                          <Button variant="secondary" className="font-black text-xs h-12 px-6 rounded-xl hover:scale-105 transition-all shadow-2xl bg-indigo-600 border-none text-white hover:bg-indigo-500 w-full md:w-auto">{t("client.src.view_global_legal_packs")}</Button>
                       </div>
                    </div>
                 </CardContent>
              </Card>
           </div>
           
           <div className="lg:col-span-1 space-y-6">
              <LocalComplianceWidget />
              <SmartLockWidget />
           </div>
        </div>

        {/* Platform Infrastructure Shop */}
        <div className="space-y-6 mb-8 mt-12 px-2">
          <div className="flex items-center justify-between">
            <h2 className="text-xl font-black text-slate-900 flex items-center gap-2">
              <Smartphone className="w-5 h-5 text-indigo-600" />{t("client.src.platform_infrastructure_shop")}</h2>
            <Badge variant="outline" className="bg-indigo-50 text-indigo-700 font-bold border-indigo-200 text-[10px]">{t("client.src.microsaas_addons")}</Badge>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <Card className="hover:shadow-lg transition-all border-none shadow-xl bg-white ring-1 ring-indigo-50 group cursor-pointer">
              <CardHeader className="pb-4 text-center">
                <div className="w-12 h-12 bg-indigo-50 rounded-2xl flex items-center justify-center mb-2 mx-auto group-hover:bg-indigo-600 transition-all group-hover:scale-110">
                  <Shield className="w-6 h-6 text-indigo-600 group-hover:text-white" />
                </div>
                <CardTitle className="text-sm font-black text-slate-900">{t("client.src.police_reporting_plus")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-slate-400 tracking-tighter">{t("client.src.auto_kbscsi_link")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-between bg-slate-50 p-2 rounded-xl">
                  <span className="text-lg font-black text-slate-900 leading-none">$0.50<span className="text-[10px] text-slate-500 font-bold"> /RPT</span></span>
                  <Button size="sm" variant="outline" className="h-8 text-[10px] font-black tracking-widest bg-white hover:bg-indigo-600 hover:text-white transition-all">{t("client.src.enable")}</Button>
                </div>
              </CardContent>
            </Card>

            <Card className="hover:shadow-lg transition-all border-none shadow-xl bg-white ring-1 ring-emerald-50 group cursor-pointer">
              <CardHeader className="pb-4 text-center">
                <div className="w-12 h-12 bg-emerald-50 rounded-2xl flex items-center justify-center mb-2 mx-auto group-hover:bg-emerald-600 transition-all group-hover:scale-110">
                  <Smartphone className="w-6 h-6 text-emerald-600 group-hover:text-white" />
                </div>
                <CardTitle className="text-sm font-black text-slate-900">{t("client.src.smartlock_sdk")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-slate-400 tracking-tighter">{t("client.src.zillowstyle_selftour")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-between bg-slate-50 p-2 rounded-xl">
                  <span className="text-lg font-black text-slate-900 leading-none">$19<span className="text-[10px] text-slate-500 font-bold"> /MO</span></span>
                  <Button size="sm" variant="outline" className="h-8 text-[10px] font-black tracking-widest bg-white hover:bg-emerald-600 hover:text-white transition-all">{t("client.src.activate")}</Button>
                </div>
              </CardContent>
            </Card>

            <Card className="hover:shadow-lg transition-all border-none shadow-xl bg-white ring-1 ring-yellow-50 group cursor-pointer">
              <CardHeader className="pb-4 text-center">
                <div className="w-12 h-12 bg-yellow-50 rounded-2xl flex items-center justify-center mb-2 mx-auto group-hover:bg-yellow-600 transition-all group-hover:scale-110">
                  <FileText className="w-6 h-6 text-yellow-600 group-hover:text-white" />
                </div>
                <CardTitle className="text-sm font-black text-slate-900">{t("client.src.ai_valuation_pro")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-slate-400 tracking-tighter">{t("client.src.certified_property_audit")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-between bg-slate-50 p-2 rounded-xl">
                  <span className="text-lg font-black text-slate-900 leading-none">$49<span className="text-[10px] text-slate-500 font-bold"> /RPT</span></span>
                  <Button size="sm" variant="outline" className="h-8 text-[10px] font-black tracking-widest bg-white hover:bg-yellow-600 hover:text-white transition-all">{t("client.src.order")}</Button>
                </div>
              </CardContent>
            </Card>

            <Card className="hover:shadow-lg transition-all border-none shadow-xl bg-white ring-1 ring-purple-50 group cursor-pointer">
              <CardHeader className="pb-4 text-center">
                <div className="w-12 h-12 bg-purple-50 rounded-2xl flex items-center justify-center mb-2 mx-auto group-hover:bg-purple-600 transition-all group-hover:scale-110">
                  <Globe className="w-6 h-6 text-purple-600 group-hover:text-white" />
                </div>
                <CardTitle className="text-sm font-black text-slate-900">{t("client.src.channel_shield")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-slate-400 tracking-tighter">{t("client.src.sync_15_rate_to")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="flex items-center justify-between bg-slate-50 p-2 rounded-xl">
                  <span className="text-lg font-black text-slate-900 leading-none">$25<span className="text-[10px] text-slate-500 font-bold"> /MO</span></span>
                  <Button size="sm" variant="outline" className="h-8 text-[10px] font-black tracking-widest bg-white hover:bg-purple-600 hover:text-white transition-all">{t("client.src.sync")}</Button>
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
        {/* Members Table */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between">
            <div>
              <CardTitle>{t("client.src.subscriptions")}{memberships.length})</CardTitle>
              <CardDescription>{t("client.src.directly_pulling_from_core")}</CardDescription>
            </div>
            <Button variant="outline" size="sm" onClick={fetchMemberships} disabled={loading}>
              <RefreshCw className={`w-4 h-4 mr-2 ${loading ? "animate-spin" : ""}`} />{t("client.src.refresh")}</Button>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("client.src.organization")}</TableHead>
                  <TableHead>{t("client.src.plan")}</TableHead>
                  <TableHead>{t("client.src.status")}</TableHead>
                  <TableHead>{t("client.src.limits")}</TableHead>
                  <TableHead>{t("client.src.period_end")}</TableHead>
                  <TableHead>{t("client.src.created_at")}</TableHead>
                  <TableHead className="w-[80px]">{t("client.src.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? <TableRow>
                    <TableCell colSpan={7} className="text-center py-10">
                      <div className="flex items-center justify-center gap-2">
                        <RefreshCw className="w-5 h-5 animate-spin" />
                        <span>{t("client.src.fetching_live_data")}</span>
                      </div>
                    </TableCell>
                  </TableRow> : memberships.length === 0 ? <TableRow>
                    <TableCell colSpan={7} className="text-center py-10 text-muted-foreground">{t("client.src.no_active_subscriptions_found")}</TableCell>
                  </TableRow> : memberships.map(membership => {
                const PlanIcon = getPlanIcon(membership.plan.key);
                const planColor = getPlanColor(membership.plan.key);
                return <TableRow key={membership.id}>
                        <TableCell>
                          <div className="flex items-center gap-3">
                            <Avatar className="h-9 w-9">
                              <AvatarFallback className="bg-primary/10 text-primary font-bold">
                                {membership.org.name.slice(0, 2).toUpperCase()}
                              </AvatarFallback>
                            </Avatar>
                            <div>
                              <div className="font-medium">{membership.org.name}</div>
                              <div className="text-xs text-muted-foreground">{membership.org.type}</div>
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`p-1.5 rounded-lg ${planColor}`}>
                              <PlanIcon className="w-3.5 h-3.5" />
                            </div>
                            <div>
                              <div className="font-medium">{membership.plan.name}</div>
                              <div className="text-xs text-muted-foreground">
                                {membership.plan.priceMonthlyCents ? `$${(membership.plan.priceMonthlyCents / 100).toFixed(2)}/mo` : "Free"}
                              </div>
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge className={STATUS_COLORS[membership.status] || "bg-gray-100 text-gray-700"}>
                            {membership.status}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className="text-xs space-y-1">
                            <div className="flex items-center gap-2">
                              <span className="text-muted-foreground">{t("client.src.users")}</span>
                              <span className="font-medium">{membership.plan.limits?.maxUsers || "∞"}</span>
                            </div>
                            <div className="flex items-center gap-2">
                              <span className="text-muted-foreground">{t("client.src.props")}</span>
                              <span className="font-medium">{membership.plan.limits?.maxProperties || "∞"}</span>
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm font-medium">
                            {formatDate(membership.currentPeriodEnd)}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm text-muted-foreground">
                            {formatDate(membership.createdAt)}
                          </div>
                        </TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm">
                                <MoreHorizontal className="w-4 h-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="end">
                              <DropdownMenuItem>
                                <Edit className="w-4 h-4 mr-2" />{t("client.src.edit_plan")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => handleUpgrade(membership, "ENTERPRISE")}>
                                <TrendingUp className="w-4 h-4 mr-2" />{t("client.src.upgrade")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => handleCancel(membership)} className="text-red-600">
                                <XCircle className="w-4 h-4 mr-2" />{t("client.src.cancel")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>;
              })}
              </TableBody>
            </Table>
          </CardContent>
        </Card>
      </div>

      {/* Upgrade Dialog */}
      <Dialog open={upgradeOpen} onOpenChange={setUpgradeOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("client.src.upgrade_membership")}</DialogTitle>
            <DialogDescription>{t("client.src.modify_subscription_tier_for")}{selectedMembership?.org.name}
            </DialogDescription>
          </DialogHeader>
          <div className="py-4">
            <div className="p-4 border rounded-lg bg-blue-50 border-blue-200">
              <div className="flex items-center gap-2 text-blue-700 font-medium">
                <TrendingUp className="w-5 h-5" />
                <span>{t("client.src.move_to")}{selectedPlan}{t("client.src.plan")}</span>
              </div>
              <p className="text-sm text-blue-600 mt-2">{t("client.src.this_will_update_the")}</p>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setUpgradeOpen(false)}>{t("client.src.cancel")}</Button>
            <Button onClick={confirmUpgrade}>{t("client.src.establish_upgrade")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Cancel Dialog */}
      <Dialog open={cancelOpen} onOpenChange={setCancelOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("client.src.cancel_subscription")}</DialogTitle>
            <DialogDescription>{t("client.src.are_you_sure_you")}{selectedMembership?.org.name}{t("client.src.s_membership")}</DialogDescription>
          </DialogHeader>
          <div className="py-4">
            <div className="p-4 border rounded-lg bg-red-50 border-red-200">
              <div className="flex items-center gap-2 text-red-700">
                <AlertCircle className="w-5 h-5" />
                <span className="font-medium">{t("client.src.service_interruption")}</span>
              </div>
              <ul className="mt-2 space-y-1 text-sm text-red-600">
                <li>{t("client.src.api_access_will_be")}</li>
                <li>{t("client.src.team_member_invitations_will")}</li>
                <li>{t("client.src.advanced_analytics_will_be")}</li>
              </ul>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setCancelOpen(false)}>{t("client.src.keep_active")}</Button>
            <Button variant="destructive" onClick={confirmCancel}>{t("client.src.confirm_cancellation")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}