import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Globe, ExternalLink, TrendingUp, Users, Star, DollarSign, Clock, Filter, Search, Download, RefreshCw, Eye, Edit, Activity, BarChart3, Target, Zap, Hotel, Home, Navigation, Plane, Calendar, Loader2 } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { channelManagementApi, Channel, PropertyListing, ChannelAnalytics } from "@/lib/api/channel-management";

export default function ChannelManagement() {
  const {
    t
  } = useTranslation();
  const { data: channels, isLoading: channelsLoading } = useQuery({
    queryKey: ['channel-management', 'channels'],
    queryFn: async () => {
      const response = await channelManagementApi.getChannels();
      return (response as any).data || response || [];
    }
  });

  const { data: listings, isLoading: listingsLoading } = useQuery({
    queryKey: ['channel-management', 'listings'],
    queryFn: async () => {
      const response = await channelManagementApi.getListings();
      return (response as any).data || response || [];
    }
  });

  const { data: analytics = null, isLoading: analyticsLoading } = useQuery({
    queryKey: ['channel-management', 'analytics'],
    queryFn: async () => {
      const response = await channelManagementApi.getAnalytics();
      return (response as any).data || response || null;
    }
  });

  const [filteredChannels, setFilteredChannels] = useState<Channel[]>([]);
  const [filteredListings, setFilteredListings] = useState<PropertyListing[]>([]);
  const [filter, setFilter] = useState<{
    status?: string;
    type?: string;
    search?: string;
  }>({});
  const [selectedChannel, setSelectedChannel] = useState<Channel | null>(null);
  const [selectedListing, setSelectedListing] = useState<PropertyListing | null>(null);
  const [isLive, setIsLive] = useState(true);

  const queryClient = useQueryClient();

  useEffect(() => {
    let filtered = [...(channels || [])];
    if (filter.status) {
      filtered = filtered.filter(c => c.status === filter.status);
    }
    if (filter.type) {
      filtered = filtered.filter(c => c.type === filter.type);
    }
    if (filter.search) {
      filtered = filtered.filter(c => c.name.toLowerCase().includes(filter.search!.toLowerCase()) || c.type.toLowerCase().includes(filter.search!.toLowerCase()));
    }
    setFilteredChannels(filtered);

    let filteredList = [...(listings || [])];
    if (filter.search) {
      filteredList = filteredList.filter(l => l.propertyName.toLowerCase().includes(filter.search!.toLowerCase()) || l.channelName.toLowerCase().includes(filter.search!.toLowerCase()) || l.channelListingId.toLowerCase().includes(filter.search!.toLowerCase()));
    }
    setFilteredListings(filteredList);
  }, [channels, listings, filter]);


  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active':
        return 'bg-green-100 text-green-800';
      case 'inactive':
        return 'bg-gray-100 text-gray-800';
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'suspended':
        return 'bg-red-100 text-red-800';
      case 'syncing':
        return 'bg-blue-100 text-blue-800';
      case 'failed':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getChannelIcon = (type: string) => {
    switch (type) {
      case 'google_hotels':
        return <Globe className="w-5 h-5 text-blue-500" />;
      case 'booking_com':
        return <Hotel className="w-5 h-5 text-blue-600" />;
      case 'airbnb':
        return <Home className="w-5 h-5 text-pink-500" />;
      case 'expedia':
        return <Plane className="w-5 h-5 text-yellow-500" />;
      case 'tripadvisor':
        return <Star className="w-5 h-5 text-green-500" />;
      case 'vrbo':
        return <Globe className="w-5 h-5 text-purple-500" />;
      case 'agoda':
        return <Navigation className="w-5 h-5 text-blue-400" />;
      case 'hotels_dot_com':
        return <Hotel className="w-5 h-5 text-red-500" />;
      default:
        return <Globe className="w-5 h-5" />;
    }
  };
  const formatCurrency = (amount: number, currency: string) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency
    }).format(amount);
  };
  const exportChannels = () => {
    const csv = ['Channel Name,Type,Status,Listings,Bookings,Revenue,Rating,Last Sync', ...filteredChannels.map(c => `${c.name},${c.type},${c.status},${c.listings?.total || 'N/A'},${c.performance ? c.performance.bookings : 'N/A'},${c.performance ? formatCurrency(c.performance.revenue, 'USD') : 'N/A'},${c.performance ? c.performance.averageRating : 'N/A'},${c.integration ? new Date(c.integration.lastSync).toLocaleString() : 'N/A'}`)].join('\n');
    const blob = new Blob([csv], {
      type: 'text/csv'
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `channels-${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  };
  return <div className="min-h-screen bg-background">
      <div className="container mx-auto p-6">
        <div className="mb-6">
          <h1 className="text-3xl font-bold">{t("client.src.channel_management")}</h1>
          <p className="text-muted-foreground">{t("client.src.manage_and_sync_listings")}</p>
        </div>

        {/* Analytics Dashboard */}
        {analytics && <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4 mb-6">
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.total_channels")}</p>
                    <p className="text-2xl font-bold">{analytics.total}</p>
                    <p className="text-xs text-muted-foreground">{analytics.active}{t("client.src.active")}</p>
                  </div>
                  <Globe className="w-8 h-8 text-blue-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.total_listings")}</p>
                    <p className="text-2xl font-bold">{analytics.totalListings}</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.across_all_channels")}</p>
                  </div>
                  <Home className="w-8 h-8 text-green-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.total_bookings")}</p>
                    <p className="text-2xl font-bold">{analytics.totalBookings}</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.this_month")}</p>
                  </div>
                  <Calendar className="w-8 h-8 text-purple-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.total_revenue")}</p>
                    <p className="text-2xl font-bold">{formatCurrency(analytics.totalRevenue, 'USD')}</p>
                    <div className="flex items-center gap-1">
                      <TrendingUp className="w-3 h-3 text-green-500" />
                      <p className="text-xs text-muted-foreground">+12.5%</p>
                    </div>
                  </div>
                  <DollarSign className="w-8 h-8 text-orange-500" />
                </div>
              </CardContent>
            </Card>
          </div>}

        {/* Status Overview */}
        <div className="grid gap-4 md:grid-cols-4 mb-6">
          {[{
          status: 'active',
          count: analytics?.active || 0,
          label: t("client.src.active"),
          color: 'bg-green-100 text-green-800'
        }, {
          status: 'inactive',
          count: analytics?.inactive || 0,
          label: t("client.src.inactive"),
          color: 'bg-gray-100 text-gray-800'
        }, {
          status: 'pending',
          count: analytics?.pending || 0,
          label: t("client.src.pending"),
          color: 'bg-yellow-100 text-yellow-800'
        }, {
          status: 'suspended',
          count: analytics?.suspended || 0,
          label: t("client.src.suspended"),
          color: 'bg-red-100 text-red-800'
        }].map(({
          status,
          count,
          label,
          color
        }) => <Card key={status} className="cursor-pointer" onClick={() => setFilter({
          ...filter,
          status
        })}>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-2xl font-bold">{count}</p>
                    <p className="text-sm text-muted-foreground">{label}</p>
                  </div>
                  <Badge className={color}>{status}</Badge>
                </div>
              </CardContent>
            </Card>)}
        </div>

        {/* Controls */}
        <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between mb-6">
          <div className="flex flex-wrap gap-2">
            <Button variant={isLive ? "default" : "outline"} size="sm" onClick={() => setIsLive(!isLive)}>
              {isLive ? <Activity className="w-4 h-4 mr-2" /> : <Clock className="w-4 h-4 mr-2" />}
              {isLive ? "Live" : "Paused"}
            </Button>
            
            <Button variant="outline" size="sm" onClick={() => {
              queryClient.invalidateQueries({ queryKey: ['channel-management'] });
            }}>
              <RefreshCw className="w-4 h-4 mr-2" />{t("client.src.refresh")}</Button>

            <Button variant="outline" size="sm" onClick={exportChannels}>
              <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
          </div>

          <div className="flex items-center gap-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <input type="text" placeholder={t("client.src.search_channels")} className="pl-8 pr-3 py-2 border rounded-md text-sm" value={filter.search || ''} onChange={e => setFilter({
              ...filter,
              search: e.target.value || undefined
            })} />
            </div>
            
            <Button variant="outline" size="sm">
              <Filter className="w-4 h-4 mr-2" />{t("client.src.filter")}</Button>
          </div>
        </div>

        <Tabs defaultValue="channels" className="w-full">
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="channels">{t("client.src.channels")}</TabsTrigger>
            <TabsTrigger value="listings">{t("client.src.listings")}</TabsTrigger>
            <TabsTrigger value="analytics">{t("client.src.analytics")}</TabsTrigger>
          </TabsList>

          <TabsContent value="channels" className="space-y-6">
            {/* Channel Filters */}
            <div className="flex flex-wrap gap-2 mb-6">
              <select className="px-3 py-1 border rounded-md text-sm" value={filter.status || ''} onChange={e => setFilter({
              ...filter,
              status: e.target.value || undefined
            })}>
                <option value="">{t("client.src.all_statuses")}</option>
                <option value="active">{t("client.src.active")}</option>
                <option value="inactive">{t("client.src.inactive")}</option>
                <option value="pending">{t("client.src.pending")}</option>
                <option value="suspended">{t("client.src.suspended")}</option>
              </select>

              <select className="px-3 py-1 border rounded-md text-sm" value={filter.type || ''} onChange={e => setFilter({
              ...filter,
              type: e.target.value || undefined
            })}>
                <option value="">{t("client.src.all_channels")}</option>
                <option value="google_hotels">{t("client.src.google_hotels")}</option>
                <option value="booking_com">{t("client.src.bookingcom")}</option>
                <option value="airbnb">{t("client.src.airbnb")}</option>
                <option value="expedia">{t("client.src.expedia")}</option>
                <option value="tripadvisor">{t("client.src.tripadvisor")}</option>
                <option value="vrbo">{t("client.src.vrbo")}</option>
                <option value="agoda">{t("client.src.agoda")}</option>
                <option value="hotels_dot_com">{t("client.src.hotelscom")}</option>
              </select>
            </div>

            {/* Channels List */}
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.channels")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {filteredChannels.map(channel => <div key={channel.id} className="border rounded-lg p-4 hover:bg-muted/50 transition-colors cursor-pointer" onClick={() => setSelectedChannel(channel)}>
                      <div className="flex items-start justify-between mb-3">
                        <div className="flex items-center gap-3">
                          <div className="w-12 h-12 bg-muted rounded-lg flex items-center justify-center">
                            {getChannelIcon(channel.type)}
                          </div>
                          <div>
                            <div className="flex items-center gap-2 mb-1">
                              <h4 className="font-medium">{channel.name}</h4>
                              <Badge className={getStatusColor(channel.status)}>
                                {channel.status}
                              </Badge>
                            </div>
                            <p className="text-sm text-muted-foreground">{channel.type.replace('_', ' ').toUpperCase()}</p>
                          </div>
                        </div>
                        <div className="text-right">
                          <p className="text-lg font-bold">{channel.performance ? formatCurrency(channel.performance.revenue, 'USD') : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{channel.performance ? channel.performance.bookings : 'N/A'}{t("client.src.bookings")}</p>
                        </div>
                      </div>

                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                        <div>
                          <p className="text-muted-foreground">{t("client.src.listings")}</p>
                          <p className="font-medium">{channel.listings ? channel.listings.total : 'N/A'} ({channel.listings ? channel.listings.active : 'N/A'}{t("client.src.active")}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.views")}</p>
                          <p className="font-medium">{channel.performance ? channel.performance.views.toLocaleString() : 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.clicks")}</p>
                          <p className="font-medium">{channel.performance ? channel.performance.clicks.toLocaleString() : 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.conversion")}</p>
                          <p className="font-medium">{channel.performance ? channel.performance.conversionRate.toFixed(2) + '%' : 'N/A'}</p>
                        </div>
                      </div>

                      <div className="flex items-center gap-4 mt-3 text-sm">
                        <div className="flex items-center gap-1">
                          <Star className="w-3 h-3 text-yellow-500" />
                          <span>{channel.performance ? channel.performance.averageRating.toFixed(1) : 'N/A'}</span>
                          <span className="text-muted-foreground">({channel.performance ? channel.performance.totalReviews : 'N/A'})</span>
                        </div>
                        <div className="flex items-center gap-1">
                          <Clock className="w-3 h-3 text-blue-500" />
                          <span>{t("client.src.last_sync")}{channel.integration ? new Date(channel.integration.lastSync).toLocaleTimeString() : 'N/A'}</span>
                        </div>
                        <div className="flex items-center gap-1">
                          <Badge className={getStatusColor(channel.integration ? channel.integration.syncStatus : 'unknown')}>
                            {channel.integration ? channel.integration.syncStatus : 'N/A'}
                          </Badge>
                        </div>
                      </div>
                    </div>)}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="listings" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.property_listings")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {filteredListings.map(listing => <div key={listing.id} className="border rounded-lg p-4 hover:bg-muted/50 transition-colors cursor-pointer" onClick={() => setSelectedListing(listing)}>
                      <div className="flex items-start justify-between mb-3">
                        <div className="flex items-center gap-3">
                          <div className="w-12 h-12 bg-muted rounded-lg flex items-center justify-center">
                            <Home className="w-6 h-6" />
                          </div>
                          <div>
                            <div className="flex items-center gap-2 mb-1">
                              <h4 className="font-medium">{listing.propertyName}</h4>
                              <Badge className={getStatusColor(listing.status)}>
                                {listing.status}
                              </Badge>
                            </div>
                            <p className="text-sm text-muted-foreground">{listing.channelName}</p>
                          </div>
                        </div>
                        <div className="text-right">
                          <p className="text-lg font-bold">{listing.pricing ? formatCurrency(listing.pricing.basePrice, listing.pricing.currency) : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{listing.channelListingId}</p>
                        </div>
                      </div>

                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                        <div>
                          <p className="text-muted-foreground">{t("client.src.views")}</p>
                          <p className="font-medium">{listing.performance ? listing.performance.views.toLocaleString() : 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.bookings")}</p>
                          <p className="font-medium">{listing.performance ? listing.performance.bookings : 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.revenue")}</p>
                          <p className="font-medium">{listing.performance && listing.pricing ? formatCurrency(listing.performance.revenue, listing.pricing.currency) : 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.conversion")}</p>
                          <p className="font-medium">{listing.performance ? listing.performance.conversionRate.toFixed(2) + '%' : 'N/A'}</p>
                        </div>
                      </div>

                      <div className="flex items-center gap-4 mt-3 text-sm">
                        <div className="flex items-center gap-1">
                          <Calendar className="w-3 h-3 text-blue-500" />
                          <span>{listing.availability ? listing.availability.availableDays : 'N/A'}/{listing.availability ? listing.availability.totalDays : 'N/A'}{t("client.src.days_available")}</span>
                        </div>
                        <div className="flex items-center gap-1">
                          <ExternalLink className="w-3 h-3 text-green-500" />
                          <a href={listing.channelUrl} target="_blank" rel="noopener noreferrer" className="text-blue-500 hover:underline">{t("client.src.view_listing")}</a>
                        </div>
                        <div className="flex items-center gap-1">
                          <Badge className={getStatusColor(listing.syncStatus)}>
                            {listing.syncStatus}
                          </Badge>
                        </div>
                      </div>
                    </div>)}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="analytics" className="space-y-6">
            <div className="grid gap-6 md:grid-cols-2">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <BarChart3 className="w-5 h-5" />{t("client.src.performance_trends")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="h-64 bg-muted rounded-md flex items-center justify-center">
                    <p className="text-sm text-muted-foreground">{t("client.src.booking_and_revenue_trends")}</p>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Target className="w-5 h-5" />{t("client.src.top_performers")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {analytics?.topPerformers.map((performer: any, index: number) => <div key={performer.channelId} className="flex items-center justify-between p-2 border rounded">
                        <div className="flex items-center gap-2">
                          <span className="font-medium text-sm">#{index + 1}</span>
                          <span className="font-medium">{performer.channelName}</span>
                        </div>
                        <div className="text-right">
                          <p className="text-sm font-medium">{performer.revenue !== undefined ? formatCurrency(performer.revenue, 'USD') : 'N/A'}</p>
                          <p className="text-xs text-muted-foreground">{performer.bookings !== undefined ? performer.bookings : 'N/A'}{t("client.src.bookings")}</p>
                        </div>
                      </div>)}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Users className="w-5 h-5" />{t("client.src.channel_distribution")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {filteredChannels.map(channel => <div key={channel.id} className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          {getChannelIcon(channel.type)}
                          <span className="text-sm">{channel.name}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <div className="w-32 bg-muted rounded-full h-2">
                            <div className="bg-primary h-2 rounded-full" style={{
                          width: `${channel.listings && channel.listings.total ? channel.listings.total / Math.max(...(channels || []).map((c: any) => c.listings?.total || 0)) * 100 : 0}%`
                        }} />
                          </div>
                          <span className="text-sm font-medium w-8">{channel.listings ? channel.listings.total : 'N/A'}</span>
                        </div>
                      </div>)}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <DollarSign className="w-5 h-5" />{t("client.src.revenue_analysis")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div className="flex justify-between">
                      <span className="text-sm font-medium text-muted-foreground">{t("client.src.total_revenue")}</span>
                      <span className="font-medium">{formatCurrency(analytics?.totalRevenue || 0, 'USD')}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-sm font-medium text-muted-foreground">{t("client.src.average_rating")}</span>
                      <span className="font-medium">{analytics?.averageRating.toFixed(1) || 0}/5</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-sm font-medium text-muted-foreground">{t("client.src.total_reviews")}</span>
                      <span className="font-medium">{analytics?.totalReviews || 0}</span>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>

        {/* Channel Detail Modal */}
        {selectedChannel && <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <Card className="w-full max-w-4xl max-h-[90vh] overflow-auto">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle>{t("client.src.channel_detail")}{selectedChannel.name}</CardTitle>
                  <Button variant="ghost" size="sm" onClick={() => setSelectedChannel(null)}>
                    ×
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Channel Info */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.channel_information")}</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-2">
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.status")}</span>
                            <Badge className={getStatusColor(selectedChannel.status)}>
                              {selectedChannel.status}
                            </Badge>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.api_key")}</span>
                            <span className="font-medium text-xs">{selectedChannel.apiKey ? selectedChannel.apiKey.substring(0, 10) + '...' : 'N/A'}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.webhook_url")}</span>
                            <span className="font-medium text-xs">{selectedChannel.webhookUrl || 'N/A'}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-2">
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.commission")}</span>
                            <span className="font-medium">{selectedChannel.commission ? `${selectedChannel.commission.percentage}% + $${selectedChannel.commission.fixed}` : 'N/A'}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.auto_sync")}</span>
                            <span className="font-medium">{selectedChannel.settings ? (selectedChannel.settings.autoSync ? 'Yes' : 'No') : 'N/A'}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.sync_frequency")}</span>
                            <span className="font-medium">{selectedChannel.settings ? `${selectedChannel.settings.syncFrequency}${t("client.src.minutes")}` : 'N/A'}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  </div>
                </div>

                {/* Performance */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.performance")}</h3>
                  <Card>
                    <CardContent className="p-4">
                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedChannel.performance ? selectedChannel.performance.views.toLocaleString() : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.views")}</p>
                        </div>
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedChannel.performance ? selectedChannel.performance.clicks.toLocaleString() : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.clicks")}</p>
                        </div>
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedChannel.performance ? selectedChannel.performance.bookings : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.bookings")}</p>
                        </div>
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedChannel.performance ? formatCurrency(selectedChannel.performance.revenue, 'USD') : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.revenue")}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </div>

                {/* Actions */}
                <div className="flex gap-2 pt-4 border-t">
                  <Button onClick={() => console.log('Test connection')}>
                    <Zap className="w-4 h-4 mr-2" />{t("client.src.test_connection")}</Button>
                  <Button variant="outline" onClick={() => console.log('Sync now')}>
                    <RefreshCw className="w-4 h-4 mr-2" />{t("client.src.sync_now")}</Button>
                  <Button variant="outline" onClick={() => console.log('View listings')}>
                    <Eye className="w-4 h-4 mr-2" />{t("client.src.view_listings")}</Button>
                  <Button variant="outline" onClick={() => console.log('Export channel data')}>
                    <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
                </div>
              </CardContent>
            </Card>
          </div>}

        {/* Listing Detail Modal */}
        {selectedListing && <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <Card className="w-full max-w-4xl max-h-[90vh] overflow-auto">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle>{t("client.src.listing_detail")}{selectedListing.propertyName}</CardTitle>
                  <Button variant="ghost" size="sm" onClick={() => setSelectedListing(null)}>
                    ×
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Listing Info */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.listing_information")}</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-2">
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.channel")}</span>
                            <span className="font-medium">{selectedListing.channelName}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.listing_id")}</span>
                            <span className="font-medium">{selectedListing.channelListingId}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.status")}</span>
                            <Badge className={getStatusColor(selectedListing.status)}>
                              {selectedListing.status}
                            </Badge>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-2">
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.base_price")}</span>
                            <span className="font-medium">{selectedListing.pricing ? formatCurrency(selectedListing.pricing.basePrice, selectedListing.pricing.currency) : 'N/A'}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.weekend")}</span>
                            <span className="font-medium">{selectedListing.pricing ? formatCurrency(selectedListing.pricing.weekendPrice || 0, selectedListing.pricing.currency) : 'N/A'}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.cleaning_fee")}</span>
                            <span className="font-medium">{selectedListing.pricing ? formatCurrency(selectedListing.pricing.cleaningFee || 0, selectedListing.pricing.currency) : 'N/A'}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  </div>
                </div>

                {/* Performance */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.performance")}</h3>
                  <Card>
                    <CardContent className="p-4">
                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedListing.performance ? selectedListing.performance.views.toLocaleString() : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.views")}</p>
                        </div>
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedListing.performance ? selectedListing.performance.clicks.toLocaleString() : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.clicks")}</p>
                        </div>
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedListing.performance ? selectedListing.performance.bookings : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.bookings")}</p>
                        </div>
                        <div className="text-center">
                          <p className="text-2xl font-bold">{selectedListing.performance && selectedListing.pricing ? formatCurrency(selectedListing.performance.revenue, selectedListing.pricing.currency) : 'N/A'}</p>
                          <p className="text-sm text-muted-foreground">{t("client.src.revenue")}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </div>

                {/* Actions */}
                <div className="flex gap-2 pt-4 border-t">
                  <Button onClick={() => console.log('View on channel')}>
                    <ExternalLink className="w-4 h-4 mr-2" />{t("client.src.view_on_channel")}</Button>
                  <Button variant="outline" onClick={() => console.log('Edit listing')}>
                    <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</Button>
                  <Button variant="outline" onClick={() => console.log('Sync listing')}>
                    <RefreshCw className="w-4 h-4 mr-2" />{t("client.src.sync")}</Button>
                  <Button variant="outline" onClick={() => console.log('Pause listing')}>
                    <Clock className="w-4 h-4 mr-2" />{t("client.src.pause")}</Button>
                </div>
              </CardContent>
            </Card>
          </div>}
      </div>
    </div>;
}