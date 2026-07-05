"use client";

import React from 'react';
import { apiClient } from "@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Megaphone, Users, Target, TrendingUp, BarChart3, Eye, Plus, Search, Mail, Phone, Star } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { MoreHorizontal, Edit, Trash2 } from "lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";

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
  ambassadorName?: string;
}

export default function MarketingAutomation() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const { t } = useTranslation();
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [formData, setFormData] = React.useState({ name: "", type: "", status: "" });
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");

  const { data: { campaigns = [], ambassadors = [], contracts = [] } = {}, isLoading } = useQuery({
    queryKey: ['marketing-data'],
    queryFn: async () => {
      const [campaignsRes, ambassadorsRes, contractsRes] = await Promise.all([
        apiClient.get('/marketing-campaign') as Promise<{ data: MarketingCampaign[] }>,
        apiClient.get('/brand-ambassador') as Promise<{ data: BrandAmbassador[] }>,
        apiClient.get('/ambassador-contract') as Promise<{ data: AmbassadorContract[] }>,
      ]);
      return {
        campaigns: campaignsRes.data || [],
        ambassadors: ambassadorsRes.data || [],
        contracts: contractsRes.data || [],
      };
    },
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await apiClient.post('/marketing-campaigns', data);
      return res;
    },
    onSuccess: () => {
      setIsAddOpen(false);
      queryClient.invalidateQueries({ queryKey: ['marketing-data'] });
      toast({ title: "Success", description: "Campaign created successfully" });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    }
  });

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(`/marketing-campaigns/${data.id}`, data),
    onSuccess: () => {
      toast({ title: "Updated", description: "Record updated successfully" });
      queryClient.invalidateQueries({ queryKey: ['marketing-data'] });
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/marketing-campaigns/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries({ queryKey: ['marketing-data'] });
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const getLocalizedStatus = (status: string) => {
    const map: Record<string, string> = {
      'DRAFT': t('admin.marketing.status.draft', 'Taslak'),
      'PLANNED': t('admin.marketing.status.planned', 'Planlandi'),
      'ACTIVE': t('admin.marketing.status.active', 'Aktif'),
      'PAUSED': t('admin.marketing.status.paused', 'Duraklatildi'),
      'COMPLETED': t('admin.marketing.status.completed', 'Tamamlandi'),
      'CANCELLED': t('admin.marketing.status.cancelled', 'Iptal Edildi'),
      'PROSPECT': t('admin.marketing.status.prospect', 'Aday'),
      'CONTACTED': t('admin.marketing.status.contacted', 'Iletisime Gecildi'),
      'NEGOTIATING': t('admin.marketing.status.negotiating', 'Gorusuluyor'),
      'SIGNED': t('admin.marketing.status.signed', 'Imzalandi'),
      'INACTIVE': t('admin.marketing.status.inactive', 'Pasif'),
      'RESTRICTED': t('admin.marketing.status.restricted', 'Kisitli'),
      'REVIEW': t('admin.marketing.status.review', 'Incelemede'),
      'APPROVED': t('admin.marketing.status.approved', 'Onaylandi'),
      'SIGNING': t('admin.marketing.status.signing', 'Imza Asamasinda'),
      'EXPIRING': t('admin.marketing.status.expiring', 'Suresi Doluyor'),
      'RENEWED': t('admin.marketing.status.renewed', 'Yenilendi'),
      'TERMINATED': t('admin.marketing.status.terminated', 'Feshedildi'),
      'ARCHIVED': t('admin.marketing.status.archived', 'Arsivlendi')
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
        return 'bg-white/10';
    }
  };

  const getTierColor = (tier: string) => {
    switch (tier) {
      case 'PLATINUM':
        return 'bg-slate-500';
      case 'GOLD':
        return 'bg-yellow-500';
      case 'SILVER':
        return 'bg-white/10';
      case 'BRONZE':
        return 'bg-orange-600';
      default:
        return 'bg-white/10';
    }
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount);
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

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-center h-64">
          <Megaphone className="h-8 w-8 animate-spin text-slate-400" />
        </div>
      </div>
    );
  }

  return (
    <div className="p-6 space-y-6">
      <div className="bg-white/5 p-6 rounded-2xl border border-white/10">
        <h1 className="text-3xl font-bold tracking-tight text-white">{t("admin.marketing.marketing_automation")}</h1>
      </div>

      {/* Overview Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <Card className="bg-white/5 border-white/10">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-white">{t("admin.marketing.active_campaigns")}</CardTitle>
            <Megaphone className="h-4 w-4 text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">{activeCampaigns}</div>
            <p className="text-xs text-slate-400">{t("admin.marketing.of")}{campaigns.length}{t("admin.marketing.total")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-white">{t("admin.marketing.total_budget")}</CardTitle>
            <Target className="h-4 w-4 text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">{formatCurrency(totalBudget)}</div>
            <p className="text-xs text-slate-400">{formatCurrency(totalSpent)}{t("admin.marketing.spent")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-white">{t("admin.marketing.active_ambassadors")}</CardTitle>
            <Users className="h-4 w-4 text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">{activeAmbassadors}</div>
            <p className="text-xs text-slate-400">{t("admin.marketing.of")}{ambassadors.length}{t("admin.marketing.total")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium text-white">{t("admin.marketing.total_conversions")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">{totalConversions.toLocaleString()}</div>
            <p className="text-xs text-slate-400">{formatCurrency(totalRevenue)}{t("admin.marketing.revenue")}</p>
          </CardContent>
        </Card>
      </div>

      <Tabs defaultValue="campaigns" className="space-y-4">
        <TabsList className="bg-white/5 border border-white/10">
          <TabsTrigger value="campaigns" className="text-white data-[state=active]:bg-slate-600">{t("admin.marketing.campaigns")}</TabsTrigger>
          <TabsTrigger value="ambassadors" className="text-white data-[state=active]:bg-slate-600">{t("admin.marketing.ambassadors")}</TabsTrigger>
          <TabsTrigger value="contracts" className="text-white data-[state=active]:bg-slate-600">{t("admin.marketing.contracts")}</TabsTrigger>
          <TabsTrigger value="social-impact" className="text-white data-[state=active]:bg-slate-600">{t("admin.marketing.social_impact")}</TabsTrigger>
        </TabsList>

        <TabsContent value="campaigns" className="space-y-4">
          <div className="flex justify-between items-center">
            <div className="flex gap-2">
              <div className="relative">
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-slate-400" />
                <Input placeholder={t("admin.marketing.search_campaigns")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64 bg-white/5 border-white/10 text-white" />
              </div>
              <Select value={statusFilter} onValueChange={setStatusFilter}>
                <SelectTrigger className="w-32 bg-white/5 border-white/10 text-white">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent className="bg-white/5 border-white/10 text-white">
                  <SelectItem value="ALL">{t("admin.marketing.all_status")}</SelectItem>
                  <SelectItem value="DRAFT">{t("admin.marketing.draft")}</SelectItem>
                  <SelectItem value="ACTIVE">{t("admin.marketing.active")}</SelectItem>
                  <SelectItem value="PAUSED">{t("admin.marketing.paused")}</SelectItem>
                  <SelectItem value="COMPLETED">{t("admin.marketing.completed")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
              <DialogTrigger asChild>
                <Button className="bg-slate-600 hover:bg-slate-500 text-white">
                  <Plus className="h-4 w-4 mr-2" />{t("admin.marketing.new_campaign")}
                </Button>
              </DialogTrigger>
              <DialogContent className="sm:max-w-[425px] bg-white/5 border-white/10 text-white">
                <DialogHeader>
                  <DialogTitle>Create New Campaign</DialogTitle>
                  <DialogDescription className="text-slate-400">Enter the details for the new campaign.</DialogDescription>
                </DialogHeader>
                <div className="grid gap-4 py-4">
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="name" className="text-right text-xs text-slate-400">Campaign Name</Label>
                    <Input id="name" className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} placeholder="Enter campaign name" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="type" className="text-right text-xs text-slate-400">Type</Label>
                    <Input id="type" className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={formData.type} onChange={e => setFormData({ ...formData, type: e.target.value })} placeholder="Enter type" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="status" className="text-right text-xs text-slate-400">Status</Label>
                    <Input id="status" className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={formData.status} onChange={e => setFormData({ ...formData, status: e.target.value })} placeholder="Enter status" />
                  </div>
                </div>
                <DialogFooter>
                  <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                  <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending}>
                    {createMutation.isPending ? "Saving..." : "Save Changes"}
                  </Button>
                </DialogFooter>
              </DialogContent>
            </Dialog>
          </div>

          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.marketing.marketing_campaigns")}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10 hover:bg-transparent">
                    <TableHead className="text-slate-400">{t("admin.marketing.name")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.type")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.objective")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.status")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.budget")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.performance")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.duration")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredCampaigns.map(campaign => (
                    <TableRow key={campaign.id} className="border-white/10 hover:bg-white/5">
                      <TableCell className="font-medium text-white">{campaign.name}</TableCell>
                      <TableCell>
                        <Badge variant="outline" className="border-white/10 text-slate-400">{campaign.platforms.join(', ') || 'N/A'}</Badge>
                      </TableCell>
                      <TableCell>
                        <Badge variant="secondary" className="bg-white/5 text-slate-400">{getLocalizedStatus(campaign.status)}</Badge>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <div className={`w-2 h-2 rounded-full ${getStatusColor(campaign.status)}`} />
                          <span className="capitalize text-white">{getLocalizedStatus(campaign.status).toLowerCase()}</span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div>
                          <div className="font-semibold text-white">{formatCurrency(campaign.actualSpend || 0)}</div>
                          <div className="text-xs text-slate-400">{t("admin.marketing.of")}{formatCurrency(campaign.budget || 0)}</div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="space-y-1">
                          <div className="flex justify-between text-xs text-slate-400">
                            <span>{t("admin.marketing.reach")}{campaign.actualReach || 0}</span>
                            <span>{t("admin.marketing.impress")}{campaign.impressions || 0}</span>
                          </div>
                          <div className="flex justify-between text-xs text-slate-400">
                            <span>{t("admin.marketing.click")}{campaign.clicks || 0}</span>
                            <span>{t("admin.marketing.conv")}{campaign.conversions || 0}</span>
                          </div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="text-sm text-white">
                          <div>{campaign.startDate ? new Date(campaign.startDate).toLocaleDateString() : 'N/A'}</div>
                          {campaign.endDate && <div className="text-slate-400">{t("admin.marketing.to")}{new Date(campaign.endDate).toLocaleDateString()}</div>}
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex gap-1">
                          <Button variant="ghost" size="sm" className="text-slate-400 hover:text-white"><Eye className="h-4 w-4" /></Button>
                          <Button variant="ghost" size="sm" className="text-slate-400 hover:text-white"><BarChart3 className="h-4 w-4" /></Button>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" className="h-8 w-8 p-0 text-slate-400 hover:text-white"><span className="sr-only">Open menu</span><MoreHorizontal className="h-4 w-4" /></Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="end" className="bg-white/5 border-white/10 text-white">
                              <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => {
                                setFormData(campaign as any);
                                setIsAddOpen(true);
                              }}><Edit className="mr-2 h-4 w-4" /> Edit</DropdownMenuItem>
                              <DropdownMenuItem className="cursor-pointer text-red-400 hover:bg-red-400/10" onClick={() => deleteMutation.mutate(campaign.id)}><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </div>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="ambassadors" className="space-y-4">
          <div className="flex justify-end">
            <Button className="bg-slate-600 hover:bg-slate-500 text-white">
              <Plus className="h-4 w-4 mr-2" />{t("admin.marketing.add_ambassador")}
            </Button>
          </div>
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.marketing.brand_ambassadors")}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10 hover:bg-transparent">
                    <TableHead className="text-slate-400">{t("admin.marketing.name")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.contact")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.tier")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.status")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.performance")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.referrals")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.earnings")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {ambassadors.map(ambassador => (
                    <TableRow key={ambassador.id} className="border-white/10 hover:bg-white/5">
                      <TableCell className="font-medium text-white">{ambassador.fullName}</TableCell>
                      <TableCell>
                        <div className="text-sm text-white">
                          <div className="flex items-center gap-1"><Mail className="h-3 w-3 text-slate-400" />{ambassador.emailCiphertext ? t("admin.marketing.encrypted", "[Sifreli]") : "N/A"}</div>
                          <div className="flex items-center gap-1"><Phone className="h-3 w-3 text-slate-400" />{ambassador.phoneCiphertext ? t("admin.marketing.encrypted", "[Sifreli]") : "N/A"}</div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <div className={`w-2 h-2 rounded-full ${getTierColor(ambassador.tier || "BRONZE")}`} />
                          <Badge variant="outline" className="border-white/10 text-slate-400">{ambassador.tier || "BRONZE"}</Badge>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <div className={`w-2 h-2 rounded-full ${getStatusColor(ambassador.status)}`} />
                          <span className="capitalize text-white">{getLocalizedStatus(ambassador.status).toLowerCase()}</span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="space-y-1">
                          <div className="flex items-center gap-1">
                            <Star className="h-3 w-3 text-yellow-500" />
                            <span className="text-sm text-white">{(ambassador.totalRoi || 0).toFixed(1)}{t("admin.marketing.roi")}</span>
                          </div>
                          <div className="text-xs text-slate-400">{ambassador.engagementRate || 0}{t("admin.marketing.engagement")}</div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="text-sm text-white">
                          <div>{ambassador.actualReach || 0}</div>
                          <div className="text-xs text-slate-400">{t("admin.marketing.actual_reach")}</div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div>
                          <div className="font-semibold text-white">{formatCurrency(ambassador.upfrontFee || 0)}</div>
                          <div className="text-xs text-slate-400">{t("admin.marketing.upfront_fee")}</div>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex gap-1">
                          <Button variant="ghost" size="sm" className="text-slate-400 hover:text-white"><Eye className="h-4 w-4" /></Button>
                          <Button variant="ghost" size="sm" className="text-slate-400 hover:text-white"><Edit className="h-4 w-4" /></Button>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" className="h-8 w-8 p-0 text-slate-400 hover:text-white"><span className="sr-only">Open menu</span><MoreHorizontal className="h-4 w-4" /></Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="end" className="bg-white/5 border-white/10 text-white">
                              <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => {
                                // Add edit handler if needed
                              }}><Edit className="mr-2 h-4 w-4" /> Edit</DropdownMenuItem>
                              <DropdownMenuItem className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </div>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="contracts" className="space-y-4">
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.marketing.ambassador_contracts")}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow className="border-white/10 hover:bg-transparent">
                    <TableHead className="text-slate-400">{t("admin.marketing.ambassador")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.type")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.commission")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.status")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.period")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.total_payouts")}</TableHead>
                    <TableHead className="text-slate-400">{t("admin.marketing.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {contracts.map(contract => (
                    <TableRow key={contract.id} className="border-white/10 hover:bg-white/5">
                      <TableCell className="font-medium text-white">{contract.ambassadorName}</TableCell>
                      <TableCell>
                        <Badge variant="outline" className="border-white/10 text-slate-400">{getLocalizedStatus(contract.status)}</Badge>
                      </TableCell>
                      <TableCell>
                        <div className="text-white">
                          {contract.equityPercent && `${contract.equityPercent}% ${t("admin.marketing.equity", "hisse")}`}{contract.upfrontFee && ` + ${formatCurrency(contract.upfrontFee)} ${t("admin.marketing.upfront", "pesin")}`}
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <div className={`w-2 h-2 rounded-full ${getStatusColor(contract.status)}`} />
                          <span className="capitalize text-white">{getLocalizedStatus(contract.status).toLowerCase()}</span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="text-sm text-white">
                          <div>{contract.startDate ? new Date(contract.startDate).toLocaleDateString() : 'N/A'}</div>
                          {contract.endDate && <div className="text-slate-400">{t("admin.marketing.to")}{new Date(contract.endDate).toLocaleDateString()}</div>}
                        </div>
                      </TableCell>
                      <TableCell className="text-white">{contract.upfrontFee ? formatCurrency(contract.upfrontFee) : '-'}</TableCell>
                      <TableCell>
                        <Button variant="ghost" size="sm" className="text-slate-400 hover:text-white"><Eye className="h-4 w-4" /></Button>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" className="h-8 w-8 p-0 text-slate-400 hover:text-white"><span className="sr-only">Open menu</span><MoreHorizontal className="h-4 w-4" /></Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-white/5 border-white/10 text-white">
                            <DropdownMenuItem className="cursor-pointer hover:bg-white/10"><Edit className="mr-2 h-4 w-4" /> Edit</DropdownMenuItem>
                            <DropdownMenuItem className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="social-impact" className="space-y-4">
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.marketing.social_impact_tracking")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="flex flex-col items-center justify-center h-48 text-slate-400">
                <BarChart3 className="h-12 w-12 mb-4 opacity-20" />
                <p>{t("admin.marketing.social_impact_tracking_is")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
