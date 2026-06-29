import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { BarChart3, TrendingUp, TrendingDown, Eye, DollarSign, Calendar, MoreHorizontal, Activity, Home, Users } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";

interface PropertyAnalytics {
  id: string; orgId?: string; propertyId: string;
  period: 'DAILY' | 'WEEKLY' | 'MONTHLY' | 'YEARLY';
  views: number; uniqueViews: number; inquiries: number; favorites: number; shares: number;
  timeOnPage: number; bounceRate: number; conversionRate: number; revenue: number; leadsGenerated: number;
  topTrafficSources: { source: string; views: number; percentage: number }[];
  deviceBreakdown: { desktop: number; mobile: number; tablet: number };
  geographicData: { country: string; views: number; percentage: number }[];
  generatedAt: Date;
  property?: { address: string; city: string; state: string; price: number; status: string };
}
interface MarketAnalytics {
  totalProperties: number; avgPrice: number; avgDaysOnMarket: number;
  totalViews: number; totalInquiries: number;
  marketTrends: { period: string; priceChange: number; inventoryChange: number }[];
  topPerformingProperties: PropertyAnalytics[];
  marketInsights: string[];
}
export default function PropertyAnalytics() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [periodFilter, setPeriodFilter] = useState<string>('MONTHLY');
  const [sortBy, setSortBy] = useState<string>('views');
  const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc');
  const { data: analytics = [], isLoading: analyticsLoading } = useQuery({
    queryKey: ['property-analytics', periodFilter, sortBy, sortOrder],
    queryFn: async () => {
      const params = new URLSearchParams({ period: periodFilter, sortBy, sortOrder });
      const response = await apiClient.get(`/properties/analytics?${params}`) as Promise<{ data: PropertyAnalytics[] }>;
      return (await response).data || [];
    }
  });
  const { data: marketData } = useQuery({
    queryKey: ['property-market-analytics'],
    queryFn: async () => {
      const response = await apiClient.get('/properties/market-analytics') as Promise<{ data: MarketAnalytics }>;
      return (await response).data || null;
    }
  });
  const formatNumber = (num: number) => {
    if (num >= 1000000) return (num / 1000000).toFixed(1) + 'M';
    if (num >= 1000) return (num / 1000).toFixed(1) + 'K';
    return num.toString();
  };
  const formatCurrency = (num: number) => new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', minimumFractionDigits: 0, maximumFractionDigits: 0 }).format(num);
  const getTrendIcon = (change: number) => {
    if (change > 0) return <TrendingUp className="h-4 w-4 text-green-500" />;
    if (change < 0) return <TrendingDown className="h-4 w-4 text-red-500" />;
    return <Activity className="h-4 w-4 text-gray-500" />;
  };
  if (analyticsLoading) {
    return <div className="min-h-screen bg-background p-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-white/10">
          <h1 className="text-xl font-bold text-white">{t("admin.property.property_analytics")}</h1>
        </div>
        <div className="flex items-center justify-center h-64 mt-6">
          <Activity className="h-8 w-8 animate-spin text-white" />
        </div>
      </div>;
  }
  return <div className="min-h-screen bg-background">
      <div className="p-6 space-y-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-white/10">
          <h1 className="text-xl font-bold text-white">{t("admin.property.property_analytics")}</h1>
        </div>

        {marketData && <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.total_properties")}</CardTitle>
                <Home className="h-4 w-4 text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">{marketData.totalProperties}</div>
                <p className="text-xs text-slate-400">{t("admin.property.active_listings")}</p>
              </CardContent>
            </Card>
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.average_price")}</CardTitle>
                <DollarSign className="h-4 w-4 text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">{formatCurrency(marketData.avgPrice)}</div>
                <p className="text-xs text-slate-400">{t("admin.property.market_average")}</p>
              </CardContent>
            </Card>
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.avg_days_on_market")}</CardTitle>
                <Calendar className="h-4 w-4 text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">{Math.round(marketData.avgDaysOnMarket)}</div>
                <p className="text-xs text-slate-400">{t("admin.property.time_to_sell")}</p>
              </CardContent>
            </Card>
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.total_views")}</CardTitle>
                <Eye className="h-4 w-4 text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">{formatNumber(marketData.totalViews)}</div>
                <p className="text-xs text-slate-400">{t("admin.property.across_all_properties")}</p>
              </CardContent>
            </Card>
          </div>}

        <Card className="bg-white/5 border-white/10">
          <CardContent className="pt-6">
            <div className="flex gap-4 items-center">
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-400">{t("admin.property.period")}</span>
                <Select value={periodFilter} onValueChange={setPeriodFilter}>
                  <SelectTrigger className="w-[150px] bg-white/5 border-white/10 text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-white/10 text-white">
                    <SelectItem value="DAILY">{t("admin.property.daily")}</SelectItem>
                    <SelectItem value="WEEKLY">{t("admin.property.weekly")}</SelectItem>
                    <SelectItem value="MONTHLY">{t("admin.property.monthly")}</SelectItem>
                    <SelectItem value="YEARLY">{t("admin.property.yearly")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-400">{t("admin.property.sort_by")}</span>
                <Select value={sortBy} onValueChange={setSortBy}>
                  <SelectTrigger className="w-[150px] bg-white/5 border-white/10 text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-white/10 text-white">
                    <SelectItem value="views">{t("admin.property.views")}</SelectItem>
                    <SelectItem value="inquiries">{t("admin.property.inquiries")}</SelectItem>
                    <SelectItem value="conversionRate">{t("admin.property.conversion_rate")}</SelectItem>
                    <SelectItem value="revenue">{t("admin.property.revenue")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-400">{t("admin.property.order")}</span>
                <Select value={sortOrder} onValueChange={value => setSortOrder(value as 'asc' | 'desc')}>
                  <SelectTrigger className="w-[120px] bg-white/5 border-white/10 text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-white/10 text-white">
                    <SelectItem value="desc">{t("admin.property.descending")}</SelectItem>
                    <SelectItem value="asc">{t("admin.property.ascending")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">{t("admin.property.property_performance")}</CardTitle>
            <p className="text-sm text-slate-400">{t("admin.property.detailed_analytics_for_each")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow className="border-white/10">
                  <TableHead className="text-slate-400">{t("admin.property.property")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.views")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.unique_views")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.inquiries")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.conversion_rate")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.bounce_rate")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.avg_time")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.revenue")}</TableHead>
                  <TableHead className="text-right text-slate-400">{t("admin.property.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {analytics.map(item => <TableRow key={item.id} className="border-white/10">
                    <TableCell className="font-medium text-white">
                      <div className="flex items-center gap-2">
                        <Home className="h-4 w-4 text-slate-400" />
                        <div>
                          <div className="text-white">{item.property?.address || `Property ${item.propertyId}`}</div>
                          <div className="text-xs text-slate-400">
                            {item.property?.city}, {item.property?.state} • {formatCurrency(item.property?.price || 0)}
                          </div>
                        </div>
                      </div>
                    </TableCell>
                    <TableCell className="text-slate-400">
                      <div className="font-medium text-white">{formatNumber(item.views)}</div>
                      <div className="text-xs text-slate-400">{item.favorites}{t("admin.property.favorites")}</div>
                    </TableCell>
                    <TableCell className="text-slate-400">
                      <div className="font-medium text-white">{formatNumber(item.uniqueViews)}</div>
                      <div className="text-xs text-slate-400">{(item.uniqueViews / item.views * 100).toFixed(1)}{t("admin.property.unique")}</div>
                    </TableCell>
                    <TableCell className="text-slate-400">
                      <div className="font-medium text-white">{item.inquiries}</div>
                      <div className="text-xs text-slate-400">{item.leadsGenerated}{t("admin.property.leads")}</div>
                    </TableCell>
                    <TableCell className="text-slate-400">
                      <div className="font-medium text-green-400">{item.conversionRate.toFixed(2)}%</div>
                      <div className="text-xs text-slate-400">{item.shares}{t("admin.property.shares")}</div>
                    </TableCell>
                    <TableCell className="text-slate-400">
                      <div className="font-medium text-white">{item.bounceRate.toFixed(1)}%</div>
                    </TableCell>
                    <TableCell className="text-slate-400">
                      <div className="font-medium text-white">{Math.round(item.timeOnPage / 60)}m {item.timeOnPage % 60}s</div>
                    </TableCell>
                    <TableCell className="font-medium text-green-400">{formatCurrency(item.revenue)}</TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0 text-slate-400">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="bg-[#14151a] border-white/10 text-white">
                          <DropdownMenuLabel className="text-slate-400">{t("admin.property.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem className="hover:bg-white/5"><BarChart3 className="h-4 w-4 mr-2" />{t("admin.property.view_detailed_analytics")}</DropdownMenuItem>
                          <DropdownMenuItem className="hover:bg-white/5"><TrendingUp className="h-4 w-4 mr-2" />{t("admin.property.performance_report")}</DropdownMenuItem>
                          <DropdownMenuItem className="hover:bg-white/5"><Users className="h-4 w-4 mr-2" />{t("admin.property.lead_analysis")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {marketData && <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.property.market_trends")}</CardTitle>
              <p className="text-sm text-slate-400">{t("admin.property.recent_market_performance_indicators")}</p>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {marketData.marketTrends.slice(0, 3).map((trend, index) => <div key={index} className="space-y-2">
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-medium text-white">{trend.period}</span>
                      {getTrendIcon(trend.priceChange)}
                    </div>
                    <div className="text-2xl font-bold text-white">{trend.priceChange > 0 ? '+' : ''}{trend.priceChange.toFixed(1)}%</div>
                    <p className="text-xs text-slate-400">{t("admin.property.price_change")}</p>
                    <div className="text-xs text-slate-400">{t("admin.property.inventory")}{trend.inventoryChange > 0 ? '+' : ''}{trend.inventoryChange}%</div>
                  </div>)}
              </div>
            </CardContent>
          </Card>}

        {marketData && marketData.topPerformingProperties.length > 0 && <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.property.top_performing_properties")}</CardTitle>
              <p className="text-sm text-slate-400">{t("admin.property.properties_with_highest_engagement")}</p>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {marketData.topPerformingProperties.slice(0, 5).map((property, index) => <div key={property.id} className="flex items-center justify-between p-4 border border-white/10 rounded-lg">
                    <div className="flex items-center gap-4">
                      <div className="flex items-center justify-center w-8 h-8 bg-blue-100 text-blue-600 rounded-full font-bold">{index + 1}</div>
                      <div>
                        <div className="font-medium text-white">{property.property?.address}</div>
                        <div className="text-sm text-slate-400">{property.property?.city}, {property.property?.state}</div>
                      </div>
                    </div>
                    <div className="text-right">
                      <div className="font-medium text-white">{formatNumber(property.views)}{t("admin.property.views")}</div>
                      <div className="text-sm text-slate-400">{property.conversionRate.toFixed(2)}{t("admin.property.conversion")}</div>
                    </div>
                  </div>)}
              </div>
            </CardContent>
          </Card>}

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.property.top_traffic_sources")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {analytics.length > 0 && analytics[0].topTrafficSources.slice(0, 5).map((source, index) => <div key={index} className="flex justify-between items-center">
                    <span className="text-sm text-white">{source.source}</span>
                    <div className="text-right">
                      <div className="font-medium text-white">{formatNumber(source.views)}</div>
                      <div className="text-xs text-slate-400">{source.percentage.toFixed(1)}%</div>
                    </div>
                  </div>)}
              </div>
            </CardContent>
          </Card>
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.property.device_breakdown")}</CardTitle>
            </CardHeader>
            <CardContent>
              {analytics.length > 0 && <div className="space-y-4">
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-white flex items-center gap-2"><div className="w-3 h-3 bg-blue-500 rounded" />{t("admin.property.desktop")}</span>
                    <span className="font-medium text-white">{analytics[0].deviceBreakdown.desktop.toFixed(1)}%</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-white flex items-center gap-2"><div className="w-3 h-3 bg-green-500 rounded" />{t("admin.property.mobile")}</span>
                    <span className="font-medium text-white">{analytics[0].deviceBreakdown.mobile.toFixed(1)}%</span>
                  </div>
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-white flex items-center gap-2"><div className="w-3 h-3 bg-orange-500 rounded" />{t("admin.property.tablet")}</span>
                    <span className="font-medium text-white">{analytics[0].deviceBreakdown.tablet.toFixed(1)}%</span>
                  </div>
                </div>}
            </CardContent>
          </Card>
        </div>

        <Card className="bg-white/5 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">{t("admin.property.geographic_distribution")}</CardTitle>
            <p className="text-sm text-slate-400">{t("admin.property.where_your_property_views")}</p>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {analytics.length > 0 && analytics[0].geographicData.slice(0, 6).map((geo, index) => <div key={index} className="p-4 border border-white/10 rounded-lg">
                  <div className="flex justify-between items-start">
                    <div>
                      <div className="font-medium text-white">{geo.country}</div>
                      <div className="text-sm text-slate-400">{geo.percentage.toFixed(1)}{t("admin.property.of_views")}</div>
                    </div>
                    <div className="text-right text-white font-bold text-lg">{formatNumber(geo.views)}</div>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>

        {marketData && marketData.marketInsights.length > 0 && <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.property.market_insights")}</CardTitle>
              <p className="text-sm text-slate-400">{t("admin.property.aipowered_market_analysis_and")}</p>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {marketData.marketInsights.map((insight, index) => <div key={index} className="flex items-start gap-3 p-3 bg-blue-50 rounded-lg">
                    <BarChart3 className="h-5 w-5 text-blue-600 mt-0.5" />
                    <p className="text-sm">{insight}</p>
                  </div>)}
              </div>
            </CardContent>
          </Card>}
      </div>
    </div>;
}
