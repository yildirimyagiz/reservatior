"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { aiApi, type AIMarketAnalysis } from "@/lib/api/ai";
import { BarChart3, TrendingUp, TrendingDown, Minus, Plus, Edit, Trash2, MoreHorizontal } from "lucide-react";
export default function AIMarketAnalysisPage() {
  const {
    t
  } = useTranslation();
  const [analyses, setAnalyses] = useState<AIMarketAnalysis[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedAnalysis, setSelectedAnalysis] = useState<AIMarketAnalysis | null>(null);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const {
    toast
  } = useToast();
  const [form, setForm] = useState({
    region: '',
    propertyType: '',
    marketTrend: 'STABLE' as AIMarketAnalysis['marketTrend'],
    averagePrice: 0,
    priceChange: 0,
    demandScore: 0,
    supplyScore: 0
  });
  useEffect(() => {
    fetchAnalyses();
  }, []);
  const fetchAnalyses = async () => {
    try {
      const response = await aiApi.getMarketAnalyses();
      setAnalyses(response);
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_fetch_market"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const createAnalysis = async () => {
    try {
      const response = await aiApi.createMarketAnalysis({
        region: form.region,
        propertyType: form.propertyType,
        marketTrend: form.marketTrend,
        averagePrice: form.averagePrice,
        priceChange: form.priceChange,
        demandScore: form.demandScore,
        supplyScore: form.supplyScore
      });
      setAnalyses([...analyses, response]);
      setIsCreateDialogOpen(false);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.market_analysis_created_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_create_market"),
        variant: "destructive"
      });
    }
  };
  const updateAnalysis = async () => {
    if (!selectedAnalysis) return;
    try {
      const response = await aiApi.updateMarketAnalysis(selectedAnalysis.id, {
        region: form.region,
        propertyType: form.propertyType,
        marketTrend: form.marketTrend,
        averagePrice: form.averagePrice,
        priceChange: form.priceChange,
        demandScore: form.demandScore,
        supplyScore: form.supplyScore
      });
      setAnalyses(analyses.map(analysis => analysis.id === selectedAnalysis.id ? response : analysis));
      setIsEditDialogOpen(false);
      setSelectedAnalysis(null);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.market_analysis_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_update_market"),
        variant: "destructive"
      });
    }
  };
  const deleteAnalysis = async (id: string) => {
    try {
      await aiApi.deleteMarketAnalysis(id);
      setAnalyses(analyses.filter(analysis => analysis.id !== id));
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.market_analysis_deleted_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_delete_market"),
        variant: "destructive"
      });
    }
  };
  const resetForm = () => {
    setForm({
      region: '',
      propertyType: '',
      marketTrend: 'STABLE',
      averagePrice: 0,
      priceChange: 0,
      demandScore: 0,
      supplyScore: 0
    });
  };
  const openEdit = (analysis: AIMarketAnalysis) => {
    setSelectedAnalysis(analysis);
    setForm({
      region: analysis.region,
      propertyType: analysis.propertyType,
      marketTrend: analysis.marketTrend,
      averagePrice: analysis.averagePrice,
      priceChange: analysis.priceChange,
      demandScore: analysis.demandScore,
      supplyScore: analysis.supplyScore
    });
    setIsEditDialogOpen(true);
  };
  const getTrendIcon = (trend: AIMarketAnalysis['marketTrend']) => {
    switch (trend) {
      case 'RISING':
        return <TrendingUp className="h-4 w-4 text-green-500" />;
      case 'DECLINING':
        return <TrendingDown className="h-4 w-4 text-red-500" />;
      case 'STABLE':
        return <Minus className="h-4 w-4 text-slate-400" />;
    }
  };
  const getTrendColor = (trend: AIMarketAnalysis['marketTrend']) => {
    switch (trend) {
      case 'RISING':
        return 'bg-green-100 text-green-800';
      case 'DECLINING':
        return 'bg-red-100 text-red-800';
      case 'STABLE':
        return 'bg-white/5 text-slate-300';
    }
  };
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(amount);
  };
  if (loading) {
    return <PageShell title={t("admin.ai.ai_market_analysis_management")}>
        <div className="flex items-center justify-center h-64">
          <BarChart3 className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.ai.ai_market_analysis_management")}>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold">{t("admin.ai.ai_market_analysis")}</h1>
            <p className="text-muted-foreground">{t("admin.ai.manage_aipowered_market_analysis")}</p>
          </div>
          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("admin.ai.add_analysis")}</Button>
            </DialogTrigger>
            <DialogContent className="max-w-2xl">
              <DialogHeader>
                <DialogTitle>{t("admin.ai.add_new_market_analysis")}</DialogTitle>
                <DialogDescription>{t("admin.ai.create_a_new_ai")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="region" className="text-right">{t("admin.ai.region")}</Label>
                  <Input id="region" value={form.region} onChange={e => setForm({
                  ...form,
                  region: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.eg_new_york_california")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="propertyType" className="text-right">{t("admin.ai.property_type")}</Label>
                  <Input id="propertyType" value={form.propertyType} onChange={e => setForm({
                  ...form,
                  propertyType: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.eg_apartment_house_condo")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="marketTrend" className="text-right">{t("admin.ai.market_trend")}</Label>
                  <Select value={form.marketTrend} onValueChange={value => setForm({
                  ...form,
                  marketTrend: value as AIMarketAnalysis['marketTrend']
                })}>
                    <SelectTrigger className="col-span-3">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="RISING">{t("admin.ai.rising")}</SelectItem>
                      <SelectItem value="STABLE">{t("admin.ai.stable")}</SelectItem>
                      <SelectItem value="DECLINING">{t("admin.ai.declining")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="averagePrice" className="text-right">{t("admin.ai.average_price")}</Label>
                  <Input id="averagePrice" type="number" value={form.averagePrice} onChange={e => setForm({
                  ...form,
                  averagePrice: parseInt(e.target.value)
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="priceChange" className="text-right">{t("admin.ai.price_change")}</Label>
                  <Input id="priceChange" type="number" step="0.1" value={form.priceChange} onChange={e => setForm({
                  ...form,
                  priceChange: parseFloat(e.target.value)
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="demandScore" className="text-right">{t("admin.ai.demand_score")}</Label>
                  <Input id="demandScore" type="number" min="0" max="100" value={form.demandScore} onChange={e => setForm({
                  ...form,
                  demandScore: parseInt(e.target.value)
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="supplyScore" className="text-right">{t("admin.ai.supply_score")}</Label>
                  <Input id="supplyScore" type="number" min="0" max="100" value={form.supplyScore} onChange={e => setForm({
                  ...form,
                  supplyScore: parseInt(e.target.value)
                })} className="col-span-3" />
                </div>
              </div>
              <DialogFooter>
                <Button onClick={createAnalysis}>{t("admin.ai.create_analysis")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.ai.market_analyses")}</CardTitle>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.ai.region")}</TableHead>
                  <TableHead>{t("admin.ai.property_type")}</TableHead>
                  <TableHead>{t("admin.ai.market_trend")}</TableHead>
                  <TableHead>{t("admin.ai.average_price")}</TableHead>
                  <TableHead>{t("admin.ai.price_change")}</TableHead>
                  <TableHead>{t("admin.ai.demandsupply")}</TableHead>
                  <TableHead>{t("admin.ai.analysis_date")}</TableHead>
                  <TableHead className="text-right">{t("admin.ai.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {analyses.map(analysis => <TableRow key={analysis.id}>
                    <TableCell className="font-medium">
                      <div className="flex items-center gap-2">
                        <BarChart3 className="h-4 w-4" />
                        {analysis.region}
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline">{analysis.propertyType}</Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        {getTrendIcon(analysis.marketTrend)}
                        <Badge className={getTrendColor(analysis.marketTrend)}>
                          {analysis.marketTrend}
                        </Badge>
                      </div>
                    </TableCell>
                    <TableCell className="font-semibold">
                      {formatCurrency(analysis.averagePrice)}
                    </TableCell>
                    <TableCell>
                      <div className={`flex items-center gap-1 ${analysis.priceChange >= 0 ? 'text-green-600' : 'text-red-600'}`}>
                        {analysis.priceChange >= 0 ? <TrendingUp className="h-3 w-3" /> : <TrendingDown className="h-3 w-3" />}
                        {analysis.priceChange >= 0 ? '+' : ''}{analysis.priceChange.toFixed(1)}%
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="text-sm">
                        <div>{t("admin.ai.d")}{analysis.demandScore}/100</div>
                        <div>{t("admin.ai.s")}{analysis.supplyScore}/100</div>
                      </div>
                    </TableCell>
                    <TableCell>
                      {new Date(analysis.analysisDate).toLocaleDateString()}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin.ai.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem onClick={() => openEdit(analysis)}>
                            <Edit className="h-4 w-4 mr-2" />{t("admin.ai.edit")}</DropdownMenuItem>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem onClick={() => deleteAnalysis(analysis.id)} className="text-red-600">
                            <Trash2 className="h-4 w-4 mr-2" />{t("admin.ai.delete")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
          <DialogContent className="max-w-2xl">
            <DialogHeader>
              <DialogTitle>{t("admin.ai.edit_market_analysis")}</DialogTitle>
              <DialogDescription>{t("admin.ai.update_the_market_analysis")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-region" className="text-right">{t("admin.ai.region")}</Label>
                <Input id="edit-region" value={form.region} onChange={e => setForm({
                ...form,
                region: e.target.value
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-propertyType" className="text-right">{t("admin.ai.property_type")}</Label>
                <Input id="edit-propertyType" value={form.propertyType} onChange={e => setForm({
                ...form,
                propertyType: e.target.value
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-marketTrend" className="text-right">{t("admin.ai.market_trend")}</Label>
                <Select value={form.marketTrend} onValueChange={value => setForm({
                ...form,
                marketTrend: value as AIMarketAnalysis['marketTrend']
              })}>
                  <SelectTrigger className="col-span-3">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="RISING">{t("admin.ai.rising")}</SelectItem>
                    <SelectItem value="STABLE">{t("admin.ai.stable")}</SelectItem>
                    <SelectItem value="DECLINING">{t("admin.ai.declining")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-averagePrice" className="text-right">{t("admin.ai.average_price")}</Label>
                <Input id="edit-averagePrice" type="number" value={form.averagePrice} onChange={e => setForm({
                ...form,
                averagePrice: parseInt(e.target.value)
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-priceChange" className="text-right">{t("admin.ai.price_change")}</Label>
                <Input id="edit-priceChange" type="number" step="0.1" value={form.priceChange} onChange={e => setForm({
                ...form,
                priceChange: parseFloat(e.target.value)
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-demandScore" className="text-right">{t("admin.ai.demand_score")}</Label>
                <Input id="edit-demandScore" type="number" min="0" max="100" value={form.demandScore} onChange={e => setForm({
                ...form,
                demandScore: parseInt(e.target.value)
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-supplyScore" className="text-right">{t("admin.ai.supply_score")}</Label>
                <Input id="edit-supplyScore" type="number" min="0" max="100" value={form.supplyScore} onChange={e => setForm({
                ...form,
                supplyScore: parseInt(e.target.value)
              })} className="col-span-3" />
              </div>
            </div>
            <DialogFooter>
              <Button onClick={updateAnalysis}>{t("admin.ai.update_analysis")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}