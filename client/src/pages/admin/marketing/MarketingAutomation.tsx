import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Megaphone, Users, Target, TrendingUp, BarChart3, Eye, Plus, Search, Edit, Mail, Phone, Star } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
export type CampaignStatus = 'DRAFT' | 'PLANNED' | 'ACTIVE' | 'PAUSED' | 'COMPLETED' | 'CANCELLED';
export type AmbassadorStatus = 'PROSPECT' | 'CONTACTED' | 'NEGOTIATING' | 'SIGNED' | 'ACTIVE' | 'INACTIVE' | 'RESTRICTED';
export type AmbassadorCategory = 'CELEBRITY' | 'MACRO' | 'MICRO' | 'NANO' | 'COMMUNITY' | 'CUSTOMER';
export type ContractStatus = 'DRAFT' | 'REVIEW' | 'APPROVED' | 'SIGNING' | 'ACTIVE' | 'EXPIRING' | 'RENEWED' | 'TERMINATED' | 'ARCHIVED';
interface MarketingCampaign {
  id: string;
  orgId: string;
  ambassadorId: string;
  name: string;
  description?: string;
  startDate?: string;
  endDate?: string;
  budget?: number;
  actualSpend?: number;
  currency: string;
  status: CampaignStatus;
  targetReach?: number;
  actualReach?: number;
  impressions?: number;
  clicks?: number;
  conversions?: number;
  conversionValue?: number;
  roi?: number;
  platforms: string[];
}
interface BrandAmbassador {
  id: string;
  orgId: string;
  fullName: string;
  emailCiphertext?: string;
  phoneCiphertext?: string;
  category: AmbassadorCategory;
  platform: string[];
  followerCount?: number;
  engagementRate?: number;
  contractStart?: string;
  contractEnd?: string;
  equityPercent?: number;
  upfrontFee?: number;
  currency: string;
  tier?: string;
  status: AmbassadorStatus;
  agencyName?: string;
  agencyContact?: string;
  ndaSigned: boolean;
  ndaSignedAt?: string;
  notes?: string;
  actualReach?: number;
  totalRoi?: number;
  createdAt: string;
  updatedAt: string;
}
interface AmbassadorContract {
  id: string;
  orgId?: string;
  ambassadorId: string;
  version: number;
  equityPercent?: number;
  upfrontFee?: number;
  currency: string;
  startDate: string;
  endDate?: string;
  signedAt?: string;
  documentUrl?: string;
  status: ContractStatus;
  notes?: string;
  createdAt: string;
  updatedAt: string;
  // UI helper
  ambassadorName?: string;
}
export default function MarketingAutomation() {
  const {
    t
  } = useTranslation();
  const [campaigns, setCampaigns] = useState<MarketingCampaign[]>([]);
  const [ambassadors, setAmbassadors] = useState<BrandAmbassador[]>([]);
  const [contracts, setContracts] = useState<AmbassadorContract[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchMarketingData();
  }, []);
  const fetchMarketingData = async () => {
    try {
      const [campaignsRes, ambassadorsRes, contractsRes] = await Promise.all([apiClient.get('/marketing-campaign') as Promise<{
        data: MarketingCampaign[];
      }>, apiClient.get('/brand-ambassador') as Promise<{
        data: BrandAmbassador[];
      }>, apiClient.get('/ambassador-contract') as Promise<{
        data: AmbassadorContract[];
      }>]);
      setCampaigns(campaignsRes.data || []);
      setAmbassadors(ambassadorsRes.data || []);
      setContracts(contractsRes.data || []);
    } catch (error) {
      toast({
        title: t("admin.marketing.error"),
        description: t("admin.marketing.failed_to_fetch_marketing"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getLocalizedStatus = (status: string) => {
    const map: Record<string, string> = {
      'DRAFT': t('admin.marketing.status.draft', 'Taslak'),
      'PLANNED': t('admin.marketing.status.planned', 'Planlandı'),
      'ACTIVE': t('admin.marketing.status.active', 'Aktif'),
      'PAUSED': t('admin.marketing.status.paused', 'Duraklatıldı'),
      'COMPLETED': t('admin.marketing.status.completed', 'Tamamlandı'),
      'CANCELLED': t('admin.marketing.status.cancelled', 'İptal Edildi'),
      'PROSPECT': t('admin.marketing.status.prospect', 'Aday'),
      'CONTACTED': t('admin.marketing.status.contacted', 'İletişime Geçildi'),
      'NEGOTIATING': t('admin.marketing.status.negotiating', 'Görüşülüyor'),
      'SIGNED': t('admin.marketing.status.signed', 'İmzalandı'),
      'INACTIVE': t('admin.marketing.status.inactive', 'Pasif'),
      'RESTRICTED': t('admin.marketing.status.restricted', 'Kısıtlı'),
      'REVIEW': t('admin.marketing.status.review', 'İncelemede'),
      'APPROVED': t('admin.marketing.status.approved', 'Onaylandı'),
      'SIGNING': t('admin.marketing.status.signing', 'İmza Aşamasında'),
      'EXPIRING': t('admin.marketing.status.expiring', 'Süresi Doluyor'),
      'RENEWED': t('admin.marketing.status.renewed', 'Yenilendi'),
      'TERMINATED': t('admin.marketing.status.terminated', 'Feshedildi'),
      'ARCHIVED': t('admin.marketing.status.archived', 'Arşivlendi')
    };
    return map[status] || status;
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'ACTIVE':
      case 'COMPLETED':
        return 'bg-green-500';
      case 'DRAFT':
      case 'PLANNED':
      case 'PENDING':
        return 'bg-yellow-500';
      case 'PAUSED':
        return 'bg-orange-500';
      case 'CANCELLED':
      case 'EXPIRED':
      case 'TERMINATED':
      case 'INACTIVE':
        return 'bg-red-500';
      default:
        return 'bg-gray-500';
    }
  };
  const getTierColor = (tier: string) => {
    switch (tier) {
      case 'PLATINUM':
        return 'bg-purple-500';
      case 'GOLD':
        return 'bg-yellow-500';
      case 'SILVER':
        return 'bg-gray-400';
      case 'BRONZE':
        return 'bg-orange-600';
      default:
        return 'bg-gray-500';
    }
  };
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  };
  const filteredCampaigns = campaigns.filter(campaign => {
    const matchesSearch = campaign.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || campaign.status === statusFilter;
    return matchesSearch && matchesStatus;
  });
  const activeCampaigns = campaigns.filter(c => c.status === 'ACTIVE').length;
  const totalBudget = campaigns.reduce((sum, c) => sum + (c.budget || 0), 0);
  const totalSpent = campaigns.reduce((sum, c) => sum + (c.actualSpend || 0), 0);
  const activeAmbassadors = ambassadors.filter(a => a.status === 'ACTIVE').length;
  const totalConversions = campaigns.reduce((sum, c) => sum + (c.conversions || 0), 0);
  const totalRevenue = campaigns.reduce((sum, c) => sum + (c.conversionValue || 0), 0);
  if (loading) {
    return <PageShell title={t("admin.marketing.marketing_automation")}>
        <div className="flex items-center justify-center h-64">
          <Megaphone className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.marketing.marketing_automation")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.marketing.active_campaigns")}</CardTitle>
              <Megaphone className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{activeCampaigns}</div>
              <p className="text-xs text-muted-foreground">{t("admin.marketing.of")}{campaigns.length}{t("admin.marketing.total")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.marketing.total_budget")}</CardTitle>
              <Target className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{formatCurrency(totalBudget)}</div>
              <p className="text-xs text-muted-foreground">
                {formatCurrency(totalSpent)}{t("admin.marketing.spent")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.marketing.active_ambassadors")}</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{activeAmbassadors}</div>
              <p className="text-xs text-muted-foreground">{t("admin.marketing.of")}{ambassadors.length}{t("admin.marketing.total")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.marketing.total_conversions")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalConversions.toLocaleString()}</div>
              <p className="text-xs text-muted-foreground">
                {formatCurrency(totalRevenue)}{t("admin.marketing.revenue")}</p>
            </CardContent>
          </Card>
        </div>

        <Tabs defaultValue="campaigns" className="space-y-4">
          <TabsList>
            <TabsTrigger value="campaigns">{t("admin.marketing.campaigns")}</TabsTrigger>
            <TabsTrigger value="ambassadors">{t("admin.marketing.ambassadors")}</TabsTrigger>
            <TabsTrigger value="contracts">{t("admin.marketing.contracts")}</TabsTrigger>
            <TabsTrigger value="social-impact">{t("admin.marketing.social_impact")}</TabsTrigger>
          </TabsList>

          <TabsContent value="campaigns" className="space-y-4">
            <div className="flex justify-between items-center">
              <div className="flex gap-2">
                <div className="relative">
                  <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                  <Input placeholder={t("admin.marketing.search_campaigns")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin.marketing.all_status")}</SelectItem>
                    <SelectItem value="DRAFT">{t("admin.marketing.draft")}</SelectItem>
                    <SelectItem value="ACTIVE">{t("admin.marketing.active")}</SelectItem>
                    <SelectItem value="PAUSED">{t("admin.marketing.paused")}</SelectItem>
                    <SelectItem value="COMPLETED">{t("admin.marketing.completed")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <Button onClick={() => toast({
              title: t("admin.marketing.coming_soon"),
              description: t("admin.marketing.this_feature_is_being")
            })}>
                <Plus className="h-4 w-4 mr-2" />{t("admin.marketing.new_campaign")}</Button>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("admin.marketing.marketing_campaigns")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.marketing.name")}</TableHead>
                      <TableHead>{t("admin.marketing.type")}</TableHead>
                      <TableHead>{t("admin.marketing.objective")}</TableHead>
                      <TableHead>{t("admin.marketing.status")}</TableHead>
                      <TableHead>{t("admin.marketing.budget")}</TableHead>
                      <TableHead>{t("admin.marketing.performance")}</TableHead>
                      <TableHead>{t("admin.marketing.duration")}</TableHead>
                      <TableHead>{t("admin.marketing.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredCampaigns.map(campaign => {
                    return <TableRow key={campaign.id}>
                          <TableCell className="font-medium">{campaign.name}</TableCell>
                          <TableCell>
                            <Badge variant="outline">{campaign.platforms.join(', ') || 'N/A'}</Badge>
                          </TableCell>
                          <TableCell>
                            <Badge variant="secondary">{getLocalizedStatus(campaign.status)}</Badge>
                          </TableCell>
                          <TableCell>
                            <div className="flex items-center gap-2">
                              <div className={`w-2 h-2 rounded-full ${getStatusColor(campaign.status)}`} />
                              <span className="capitalize">{getLocalizedStatus(campaign.status).toLowerCase()}</span>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div>
                              <div className="font-semibold">{formatCurrency(campaign.actualSpend || 0)}</div>
                              <div className="text-xs text-muted-foreground">{t("admin.marketing.of")}{formatCurrency(campaign.budget || 0)}
                              </div>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="space-y-1">
                              <div className="flex justify-between text-xs">
                                <span>{t("admin.marketing.reach")}{campaign.actualReach || 0}</span>
                                <span>{t("admin.marketing.impress")}{campaign.impressions || 0}</span>
                              </div>
                              <div className="flex justify-between text-xs">
                                <span>{t("admin.marketing.click")}{campaign.clicks || 0}</span>
                                <span>{t("admin.marketing.conv")}{campaign.conversions || 0}</span>
                              </div>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="text-sm">
                              <div>{campaign.startDate ? new Date(campaign.startDate).toLocaleDateString() : 'N/A'}</div>
                              {campaign.endDate && <div className="text-muted-foreground">{t("admin.marketing.to")}{new Date(campaign.endDate).toLocaleDateString()}
                                </div>}
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex gap-1">
                              <Button variant="ghost" size="sm">
                                <Eye className="h-4 w-4" />
                              </Button>
                              <Button variant="ghost" size="sm">
                                <BarChart3 className="h-4 w-4" />
                              </Button>
                            </div>
                          </TableCell>
                        </TableRow>;
                  })}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="ambassadors" className="space-y-4">
            <div className="flex justify-end">
              <Button onClick={() => toast({
              title: t("admin.marketing.coming_soon"),
              description: t("admin.marketing.this_feature_is_being")
            })}>
                <Plus className="h-4 w-4 mr-2" />{t("admin.marketing.add_ambassador")}</Button>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("admin.marketing.brand_ambassadors")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.marketing.name")}</TableHead>
                      <TableHead>{t("admin.marketing.contact")}</TableHead>
                      <TableHead>{t("admin.marketing.tier")}</TableHead>
                      <TableHead>{t("admin.marketing.status")}</TableHead>
                      <TableHead>{t("admin.marketing.performance")}</TableHead>
                      <TableHead>{t("admin.marketing.referrals")}</TableHead>
                      <TableHead>{t("admin.marketing.earnings")}</TableHead>
                      <TableHead>{t("admin.marketing.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {ambassadors.map(ambassador => <TableRow key={ambassador.id}>
                        <TableCell className="font-medium">{ambassador.fullName}</TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div className="flex items-center gap-1">
                              <Mail className="h-3 w-3" />
                              {ambassador.emailCiphertext ? t("admin.marketing.encrypted", "[Şifreli]") : "N/A"}
                            </div>
                            <div className="flex items-center gap-1">
                              <Phone className="h-3 w-3" />
                              {ambassador.phoneCiphertext ? t("admin.marketing.encrypted", "[Şifreli]") : "N/A"}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getTierColor(ambassador.tier || "BRONZE")}`} />
                            <Badge variant="outline">{ambassador.tier || "BRONZE"}</Badge>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(ambassador.status)}`} />
                            <span className="capitalize">{getLocalizedStatus(ambassador.status).toLowerCase()}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="space-y-1">
                            <div className="flex items-center gap-1">
                              <Star className="h-3 w-3 text-yellow-500" />
                              <span className="text-sm">{(ambassador.totalRoi || 0).toFixed(1)}{t("admin.marketing.roi")}</span>
                            </div>
                            <div className="text-xs text-muted-foreground">
                              {ambassador.engagementRate || 0}{t("admin.marketing.engagement")}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div>{ambassador.actualReach || 0}</div>
                            <div className="text-xs text-muted-foreground">{t("admin.marketing.actual_reach")}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div>
                            <div className="font-semibold">{formatCurrency(ambassador.upfrontFee || 0)}</div>
                            <div className="text-xs text-muted-foreground">{t("admin.marketing.upfront_fee")}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm">
                              <Eye className="h-4 w-4" />
                            </Button>
                            <Button variant="ghost" size="sm">
                              <Edit className="h-4 w-4" />
                            </Button>
                          </div>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="contracts" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.marketing.ambassador_contracts")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.marketing.ambassador")}</TableHead>
                      <TableHead>{t("admin.marketing.type")}</TableHead>
                      <TableHead>{t("admin.marketing.commission")}</TableHead>
                      <TableHead>{t("admin.marketing.status")}</TableHead>
                      <TableHead>{t("admin.marketing.period")}</TableHead>
                      <TableHead>{t("admin.marketing.total_payouts")}</TableHead>
                      <TableHead>{t("admin.marketing.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {contracts.map(contract => <TableRow key={contract.id}>
                        <TableCell className="font-medium">{contract.ambassadorName}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{getLocalizedStatus(contract.status)}</Badge>
                        </TableCell>
                        <TableCell>
                          <div>
                            {contract.equityPercent && `${contract.equityPercent}% ${t("admin.marketing.equity", "hisse")}`}{contract.upfrontFee && ` + ${formatCurrency(contract.upfrontFee)} ${t("admin.marketing.upfront", "peşin")}`}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(contract.status)}`} />
                            <span className="capitalize">{getLocalizedStatus(contract.status).toLowerCase()}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div>{contract.startDate ? new Date(contract.startDate).toLocaleDateString() : 'N/A'}</div>
                            {contract.endDate && <div className="text-muted-foreground">{t("admin.marketing.to")}{new Date(contract.endDate).toLocaleDateString()}
                              </div>}
                          </div>
                        </TableCell>
                        <TableCell>{contract.upfrontFee ? formatCurrency(contract.upfrontFee) : '-'}</TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm">
                            <Eye className="h-4 w-4" />
                          </Button>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="social-impact" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.marketing.social_impact_tracking")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex flex-col items-center justify-center h-48 text-muted-foreground">
                  <BarChart3 className="h-12 w-12 mb-4 opacity-20" />
                  <p>{t("admin.marketing.social_impact_tracking_is")}</p>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}