"use client";
import React from 'react';
import { useMutation, useQueryClient } from '@tanstack/react-query';

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { TrendingUp, DollarSign, Eye, MoreHorizontal, Activity, Plus, Target } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
interface PropertyPromotion {
  id: string;
  orgId?: string;
  propertyId: string;
  promotionType: 'FEATURED' | 'PREMIUM' | 'BOOSTED' | 'SPONSORED';
  platform: 'INTERNAL' | 'ZILLOW' | 'REALTOR' | 'FACEBOOK' | 'GOOGLE' | 'OTHER';
  status: 'ACTIVE' | 'PAUSED' | 'EXPIRED' | 'DRAFT';
  budget: number;
  spent: number;
  impressions: number;
  clicks: number;
  conversions: number;
  ctr: number;
  cpc: number;
  startDate: Date;
  endDate?: Date;
  targeting: {
    location?: string;
    demographics?: any;
    interests?: string[];
  };
  createdAt: Date;
  property?: {
    address: string;
    city: string;
    price: number;
  };
}
export default function PropertyPromotions() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [editingId, setEditingId] = React.useState<string | null>(null);

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(`/admin/propertypromotions/${data.id}`, data),
    onSuccess: () => { toast({ title: "Updated", description: "Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/admin/propertypromotions/${id}`),
    onSuccess: () => { toast({ title: "Deleted", description: "Record deleted successfully" }); queryClient.invalidateQueries(); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  
  const {
    t
  } = useTranslation();
  const [promotions, setPromotions] = useState<PropertyPromotion[]>([]);
  const [loading, setLoading] = useState(true);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [platformFilter, setPlatformFilter] = useState<string>('all');
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [newPromotion, setNewPromotion] = useState({
    propertyId: '',
    promotionType: 'FEATURED',
    platform: 'INTERNAL',
    budget: 0,
    startDate: '',
    endDate: ''
  });
  useEffect(() => {
    fetchPromotions();
  }, [platformFilter, statusFilter]);
  const fetchPromotions = async () => {
    try {
      const params = new URLSearchParams();
      if (platformFilter !== 'all') params.append('platform', platformFilter);
      if (statusFilter !== 'all') params.append('status', statusFilter);
      const response = (await apiClient.get(`/properties/promotions?${params}`)) as {
        data: PropertyPromotion[];
      };
      setPromotions(response.data);
    } catch (error) {
      toast({
        title: t("admin_property_error"),
        description: t("admin_property_failed_to_fetch_property"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const createPromotion = async () => {
    try {
      const response = (await apiClient.post('/properties/promotions', {
        ...newPromotion,
        startDate: new Date(newPromotion.startDate),
        endDate: newPromotion.endDate ? new Date(newPromotion.endDate) : null
      })) as {
        data: PropertyPromotion;
      };
      setPromotions([...promotions, response.data]);
      setIsCreateDialogOpen(false);
      setNewPromotion({
        propertyId: '',
        promotionType: 'FEATURED',
        platform: 'INTERNAL',
        budget: 0,
        startDate: '',
        endDate: ''
      });
      toast({
        title: t("admin_property_success"),
        description: t("admin_property_property_promotion_created_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin_property_error"),
        description: t("admin_property_failed_to_create_property"),
        variant: "destructive"
      });
    }
  };
  const updatePromotionStatus = async (promotionId: string, status: string) => {
    try {
      await apiClient.put(`/properties/promotions/${promotionId}`, {
        status
      });
      setPromotions(promotions.map(p => p.id === promotionId ? {
        ...p,
        status: status as any
      } : p));
      toast({
        title: t("admin_property_success"),
        description: t("admin_property_promotion_status_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin_property_error"),
        description: t("admin_property_failed_to_update_promotion"),
        variant: "destructive"
      });
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'ACTIVE':
        return 'bg-green-500';
      case 'PAUSED':
        return 'bg-yellow-500';
      case 'EXPIRED':
        return 'bg-red-500';
      case 'DRAFT':
        return 'bg-white/10';
      default:
        return 'bg-white/10';
    }
  };
  const getPlatformIcon = (_platform: string) => {
    // Simplified icon mapping
    return <Target className="h-4 w-4" />;
  };
  const activePromotions = promotions.filter(p => p.status === 'ACTIVE').length;
  const totalSpent = promotions.reduce((acc, p) => acc + p.spent, 0);
  const totalImpressions = promotions.reduce((acc, p) => acc + p.impressions, 0);
  const avgCTR = promotions.length > 0 ? promotions.reduce((acc, p) => acc + p.ctr, 0) / promotions.length : 0;
  if (loading) {
    return <PageShell title={t("admin_property_property_promotions")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin_property_property_promotions")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_property_active_promotions")}</CardTitle>
              <Target className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{activePromotions}</div>
              <p className="text-xs text-muted-foreground">{t("admin_property_currently_running_campaigns")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_property_total_spent")}</CardTitle>
              <DollarSign className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">${totalSpent.toLocaleString()}</div>
              <p className="text-xs text-muted-foreground">{t("admin_property_across_all_campaigns")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_property_total_impressions")}</CardTitle>
              <Eye className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalImpressions.toLocaleString()}</div>
              <p className="text-xs text-muted-foreground">{t("admin_property_campaign_reach")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_property_avg_ctr")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{avgCTR.toFixed(2)}%</div>
              <p className="text-xs text-muted-foreground">{t("admin_property_clickthrough_rate")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Create Button */}
        <div className="flex justify-between items-center">
          <div className="flex gap-4">
            <Select value={platformFilter} onValueChange={setPlatformFilter}>
              <SelectTrigger className="w-[150px]">
                <SelectValue placeholder={t("admin_property_platform")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin_property_all_platforms")}</SelectItem>
                <SelectItem value="INTERNAL">{t("admin_property_internal")}</SelectItem>
                <SelectItem value="ZILLOW">{t("admin_property_zillow")}</SelectItem>
                <SelectItem value="REALTOR">{t("admin_property_realtorcom")}</SelectItem>
                <SelectItem value="FACEBOOK">{t("admin_property_facebook")}</SelectItem>
                <SelectItem value="GOOGLE">{t("admin_property_google")}</SelectItem>
              </SelectContent>
            </Select>
            <Select value={statusFilter} onValueChange={setStatusFilter}>
              <SelectTrigger className="w-[150px]">
                <SelectValue placeholder={t("admin_property_status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin_property_all_statuses")}</SelectItem>
                <SelectItem value="ACTIVE">{t("admin_property_active")}</SelectItem>
                <SelectItem value="PAUSED">{t("admin_property_paused")}</SelectItem>
                <SelectItem value="EXPIRED">{t("admin_property_expired")}</SelectItem>
                <SelectItem value="DRAFT">{t("admin_property_draft")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("admin_property_create_promotion")}</Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>{t("admin_property_create_property_promotion")}</DialogTitle>
                <DialogDescription>{t("admin_property_set_up_a_new")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="propertyId" className="text-right">{t("admin_property_property_id")}</Label>
                  <Input id="propertyId" value={newPromotion.propertyId} onChange={e => setNewPromotion({
                  ...newPromotion,
                  propertyId: e.target.value
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="promotionType" className="text-right">{t("admin_property_type")}</Label>
                  <Select value={newPromotion.promotionType} onValueChange={value => setNewPromotion({
                  ...newPromotion,
                  promotionType: value
                })}>
                    <SelectTrigger className="col-span-3">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="FEATURED">{t("admin_property_featured")}</SelectItem>
                      <SelectItem value="PREMIUM">{t("admin_property_premium")}</SelectItem>
                      <SelectItem value="BOOSTED">{t("admin_property_boosted")}</SelectItem>
                      <SelectItem value="SPONSORED">{t("admin_property_sponsored")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="platform" className="text-right">{t("admin_property_platform")}</Label>
                  <Select value={newPromotion.platform} onValueChange={value => setNewPromotion({
                  ...newPromotion,
                  platform: value
                })}>
                    <SelectTrigger className="col-span-3">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="INTERNAL">{t("admin_property_internal")}</SelectItem>
                      <SelectItem value="ZILLOW">{t("admin_property_zillow")}</SelectItem>
                      <SelectItem value="REALTOR">{t("admin_property_realtorcom")}</SelectItem>
                      <SelectItem value="FACEBOOK">{t("admin_property_facebook")}</SelectItem>
                      <SelectItem value="GOOGLE">{t("admin_property_google")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="budget" className="text-right">{t("admin_property_budget")}</Label>
                  <Input id="budget" type="number" value={newPromotion.budget} onChange={e => setNewPromotion({
                  ...newPromotion,
                  budget: parseFloat(e.target.value)
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="startDate" className="text-right">{t("admin_property_start_date")}</Label>
                  <Input id="startDate" type="date" value={newPromotion.startDate} onChange={e => setNewPromotion({
                  ...newPromotion,
                  startDate: e.target.value
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="endDate" className="text-right">{t("admin_property_end_date")}</Label>
                  <Input id="endDate" type="date" value={newPromotion.endDate} onChange={e => setNewPromotion({
                  ...newPromotion,
                  endDate: e.target.value
                })} className="col-span-3" />
                </div>
              </div>
              <DialogFooter>
                <Button onClick={createPromotion}>{t("admin_property_create_promotion")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        {/* Promotions Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin_property_property_promotions")}</CardTitle>
            <p className="text-sm text-muted-foreground">{t("admin_property_manage_property_promotion_campaigns")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin_property_property")}</TableHead>
                  <TableHead>{t("admin_property_type")}</TableHead>
                  <TableHead>{t("admin_property_platform")}</TableHead>
                  <TableHead>{t("admin_property_status")}</TableHead>
                  <TableHead>{t("admin_property_budget")}</TableHead>
                  <TableHead>{t("admin_property_spent")}</TableHead>
                  <TableHead>{t("admin_property_impressions")}</TableHead>
                  <TableHead>{t("admin_property_ctr")}</TableHead>
                  <TableHead>{t("admin_property_start_date")}</TableHead>
                  <TableHead className="text-right">{t("admin_property_actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {promotions.map(promotion => <TableRow key={promotion.id}>
                    <TableCell className="font-medium">
                      <div>
                        <div>{promotion.property?.address || `Property ${promotion.propertyId}`}</div>
                        <div className="text-xs text-muted-foreground">
                          ${promotion.property?.price?.toLocaleString()}
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline">{promotion.promotionType}</Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        {getPlatformIcon(promotion.platform)}
                        <span>{promotion.platform}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <div className={`w-2 h-2 rounded-full ${getStatusColor(promotion.status)}`} />
                        <span className="capitalize">{promotion.status.toLowerCase()}</span>
                      </div>
                    </TableCell>
                    <TableCell>${promotion.budget.toLocaleString()}</TableCell>
                    <TableCell>${promotion.spent.toLocaleString()}</TableCell>
                    <TableCell>{promotion.impressions.toLocaleString()}</TableCell>
                    <TableCell>{promotion.ctr.toFixed(2)}%</TableCell>
                    <TableCell>
                      {new Date(promotion.startDate).toLocaleDateString()}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin_property_actions")}</DropdownMenuLabel>
                          <DropdownMenuItem>
                            <Eye className="h-4 w-4 mr-2" />{t("admin_property_view_details")}</DropdownMenuItem>
                          {promotion.status === 'ACTIVE' && <DropdownMenuItem onClick={() => updatePromotionStatus(promotion.id, 'PAUSED')}>{t("admin_property_pause_campaign")}</DropdownMenuItem>}
                          {promotion.status === 'PAUSED' && <DropdownMenuItem onClick={() => updatePromotionStatus(promotion.id, 'ACTIVE')}>{t("admin_property_resume_campaign")}</DropdownMenuItem>}
                          <DropdownMenuSeparator />
                          <DropdownMenuItem className="text-red-600">{t("admin_property_stop_campaign")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Performance Analytics */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin_property_platform_performance")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {['INTERNAL', 'ZILLOW', 'REALTOR', 'FACEBOOK', 'GOOGLE'].map(platform => {
                const platformPromotions = promotions.filter(p => p.platform === platform);
                const totalSpent = platformPromotions.reduce((acc, p) => acc + p.spent, 0);
                const totalClicks = platformPromotions.reduce((acc, p) => acc + p.clicks, 0);
                const avgCTR = platformPromotions.length > 0 ? platformPromotions.reduce((acc, p) => acc + p.ctr, 0) / platformPromotions.length : 0;
                return <div key={platform} className="flex justify-between items-center">
                      <span className="text-sm">{platform}</span>
                      <div className="text-right">
                        <div className="text-sm font-medium">${totalSpent}</div>
                        <div className="text-xs text-muted-foreground">
                          {totalClicks}{t("admin_property_clicks")}{avgCTR.toFixed(1)}{t("admin_property_ctr")}</div>
                      </div>
                    </div>;
              })}
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin_property_promotion_types")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {['FEATURED', 'PREMIUM', 'BOOSTED', 'SPONSORED'].map(type => {
                const typePromotions = promotions.filter(p => p.promotionType === type);
                const totalSpent = typePromotions.reduce((acc, p) => acc + p.spent, 0);
                const totalConversions = typePromotions.reduce((acc, p) => acc + p.conversions, 0);
                return <div key={type} className="flex justify-between items-center">
                      <span className="text-sm">{type}</span>
                      <div className="text-right">
                        <div className="text-sm font-medium">${totalSpent}</div>
                        <div className="text-xs text-muted-foreground">
                          {totalConversions}{t("admin_property_conversions")}</div>
                      </div>
                    </div>;
              })}
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin_property_campaign_health")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-green-600">
                    {promotions.filter(p => p.ctr > 2).length}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin_property_highperforming_campaigns")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-yellow-600">
                    {promotions.filter(p => p.ctr >= 1 && p.ctr <= 2).length}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin_property_moderate_performance")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-red-600">
                    {promotions.filter(p => p.ctr < 1).length}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin_property_needs_optimization")}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>;
}