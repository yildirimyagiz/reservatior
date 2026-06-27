import { t } from "i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectGroup, SelectItem, SelectLabel, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Home, Building, TrendingUp, DollarSign, MoreHorizontal, Activity, Eye, MapPin, Calendar, Users } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
interface PropertyInventory {
  id: string;
  orgId?: string;
  listingId?: string;
  address: string;
  city: string;
  state: string;
  zipCode: string;
  propertyType: string;
  status: 'AVAILABLE' | 'PENDING' | 'UNDER_CONTRACT' | 'SOLD' | 'OFF_MARKET' | 'WITHDRAWN';
  price: number;
  bedrooms?: number;
  bathrooms?: number;
  squareFeet?: number;
  lotSize?: number;
  yearBuilt?: number;
  listingAgent?: {
    id: string;
    name: string;
  };
  daysOnMarket: number;
  views: number;
  favorites: number;
  offers: number;
  createdAt: Date;
  updatedAt: Date;
}
export default function PropertyInventory() {
  const {
    t
  } = useTranslation();
  const [properties, setProperties] = useState<PropertyInventory[]>([]);
  const [loading, setLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [typeFilter, setTypeFilter] = useState<string>('all');
  const [sortBy, setSortBy] = useState<string>('createdAt');
  const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc');
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchProperties();
  }, [statusFilter, typeFilter, sortBy, sortOrder]);
  const fetchProperties = async () => {
    try {
      const params = new URLSearchParams();
      if (statusFilter !== 'all') params.append('status', statusFilter);
      if (typeFilter !== 'all') params.append('propertyType', typeFilter);
      params.append('sortBy', sortBy);
      params.append('sortOrder', sortOrder);
      const response = (await apiClient.get(`/property-inventory?${params}`)) as {
        data: PropertyInventory[];
      };
      setProperties(response.data);
    } catch (error) {
      toast({
        title: t("admin.property.error"),
        description: t("admin.property.failed_to_fetch_property"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const updatePropertyStatus = async (propertyId: string, status: string) => {
    try {
      await apiClient.put(`/property-inventory/${propertyId}`, {
        status
      });
      setProperties(properties.map(p => p.id === propertyId ? {
        ...p,
        status: status as any
      } : p));
      toast({
        title: t("admin.property.success"),
        description: t("admin.property.property_status_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.property.error"),
        description: t("admin.property.failed_to_update_property"),
        variant: "destructive"
      });
    }
  };
  const getLocalizedType = (type: string) => {
    const key = `client.property.types.${type}`;
    const translated = t(key);
    // If i18next returns the key itself, it means no translation was found; return raw type
    return translated !== key ? translated : type;
  };
  
  const getStatusLabel = (status: string) => {
    switch (status) {
      case 'AVAILABLE':
        return t("available");
      case 'PENDING':
        return t("admin.inventory.status.pending");
      case 'UNDER_CONTRACT':
        return t("admin.inventory.status.underContract");
      case 'SOLD':
        return t("admin.inventory.status.sold");
      case 'OFF_MARKET':
        return t("admin.inventory.status.offMarket");
      case 'WITHDRAWN':
        return t("admin.inventory.status.withdrawn");
      default:
        return status;
    }
  };
  const availableProperties = properties.filter(p => p.status === 'AVAILABLE').length;
  const totalValue = properties.reduce((acc, p) => acc + p.price, 0);
  const avgPrice = properties.length > 0 ? totalValue / properties.length : 0;
  const totalViews = properties.reduce((acc, p) => acc + p.views, 0);
  const avgDaysOnMarket = properties.length > 0 ? properties.reduce((acc, p) => acc + p.daysOnMarket, 0) / properties.length : 0;
  if (loading) {
    return <PageShell title={t("admin.inventory.title")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.inventory.title")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("available")}</CardTitle>
              <Home className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{availableProperties}</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.ready_for_showing")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.inventory.portfolioValue")}</CardTitle>
              <DollarSign className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">${totalValue.toLocaleString()}</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.across_all_properties")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.inventory.avgPrice")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">${avgPrice.toLocaleString()}</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.market_average")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.inventory.avgDOM")}</CardTitle>
              <Calendar className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{Math.round(avgDaysOnMarket)}</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.time_to_sell")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters */}
        <Card>
          <CardContent className="pt-6">
            <div className="flex gap-4 items-center">
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium">{t("admin.property.status")}</span>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[150px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin.inventory.status.all")}</SelectItem>
                    <SelectItem value="AVAILABLE">{t("available")}</SelectItem>
                    <SelectItem value="PENDING">{t("admin.inventory.status.pending")}</SelectItem>
                    <SelectItem value="UNDER_CONTRACT">{t("admin.inventory.status.underContract")}</SelectItem>
                    <SelectItem value="SOLD">{t("admin.inventory.status.sold")}</SelectItem>
                    <SelectItem value="OFF_MARKET">{t("admin.inventory.status.offMarket")}</SelectItem>
                    <SelectItem value="WITHDRAWN">{t("admin.inventory.status.withdrawn")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium">{t("admin.property.type")}</span>
                <Select value={typeFilter} onValueChange={setTypeFilter}>
                  <SelectTrigger className="w-[180px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="max-h-[400px]">
                    <SelectItem value="all">{t("admin.inventory.types.all")}</SelectItem>
                    <SelectGroup>
                      <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1">{t("client.property.portfolio.filters.type.residential")} - HOUSES</SelectLabel>
                      <SelectItem value="DETACHED_HOUSE">{t("client.property.types.DETACHED_HOUSE")}</SelectItem>
                      <SelectItem value="SEMI_DETACHED_HOUSE">{t("client.property.types.SEMI_DETACHED_HOUSE")}</SelectItem>
                      <SelectItem value="TERRACED_HOUSE">{t("client.property.types.TERRACED_HOUSE")}</SelectItem>
                      <SelectItem value="TOWNHOUSE">{t("client.property.types.TOWNHOUSE")}</SelectItem>
                      <SelectItem value="SINGLE_FAMILY">{t("client.property.types.SINGLE_FAMILY")}</SelectItem>
                      <SelectItem value="MULTI_FAMILY">{t("client.property.types.MULTI_FAMILY")}</SelectItem>
                      <SelectItem value="BUNGALOW">{t("client.property.types.BUNGALOW")}</SelectItem>
                      <SelectItem value="COTTAGE">{t("client.property.types.COTTAGE")}</SelectItem>
                      <SelectItem value="VILLA">{t("client.property.types.VILLA")}</SelectItem>
                      <SelectItem value="CABIN_TINY_HOUSE">{t("client.property.types.CABIN_TINY_HOUSE")}</SelectItem>
                      <SelectItem value="ADU_GUEST_HOUSE">{t("client.property.types.ADU_GUEST_HOUSE")}</SelectItem>
                      <SelectItem value="COMPOUND">{t("client.property.types.COMPOUND")}</SelectItem>
                    </SelectGroup>
                    <SelectGroup>
                      <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1 mt-2">{t("client.property.portfolio.filters.type.residential")} - APARTMENTS</SelectLabel>
                      <SelectItem value="APARTMENT">{t("client.property.types.APARTMENT")}</SelectItem>
                      <SelectItem value="CONDO_APARTMENT">{t("client.property.types.CONDO_APARTMENT")}</SelectItem>
                      <SelectItem value="FLAT_MAISONETTE">{t("client.property.types.FLAT_MAISONETTE")}</SelectItem>
                      <SelectItem value="STUDIO">{t("client.property.types.STUDIO")}</SelectItem>
                      <SelectItem value="PENTHOUSE">{t("client.property.types.PENTHOUSE")}</SelectItem>
                    </SelectGroup>
                    <SelectGroup>
                      <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1 mt-2">{t("client.property.portfolio.filters.type.commercial")}</SelectLabel>
                      <SelectItem value="OFFICE">{t("client.property.types.OFFICE")}</SelectItem>
                      <SelectItem value="RETAIL">{t("client.property.types.RETAIL")}</SelectItem>
                      <SelectItem value="COMMERCIAL_SPACE">{t("client.property.types.COMMERCIAL_SPACE")}</SelectItem>
                      <SelectItem value="COMMERCIAL">{t("client.property.types.COMMERCIAL")}</SelectItem>
                    </SelectGroup>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium">{t("admin.property.sort_by")}</span>
                <Select value={sortBy} onValueChange={setSortBy}>
                  <SelectTrigger className="w-[150px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="createdAt">{t("admin.property.date_added")}</SelectItem>
                    <SelectItem value="price">{t("admin.property.price")}</SelectItem>
                    <SelectItem value="daysOnMarket">{t("admin.property.days_on_market")}</SelectItem>
                    <SelectItem value="views">{t("admin.property.views")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium">{t("admin.property.order")}</span>
                <Select value={sortOrder} onValueChange={value => setSortOrder(value as 'asc' | 'desc')}>
                  <SelectTrigger className="w-[120px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="desc">{t("admin.property.descending")}</SelectItem>
                    <SelectItem value="asc">{t("admin.property.ascending")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Properties Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.property.property_inventory")}</CardTitle>
            <p className="text-sm text-muted-foreground">{t("admin.property.manage_your_property_listings")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.property.property")}</TableHead>
                  <TableHead>{t("admin.property.type")}</TableHead>
                  <TableHead>{t("admin.property.status")}</TableHead>
                  <TableHead>{t("admin.property.price")}</TableHead>
                  <TableHead>{t("admin.property.size")}</TableHead>
                  <TableHead>{t("admin.property.agent")}</TableHead>
                  <TableHead>{t("admin.property.days_on_market")}</TableHead>
                  <TableHead>{t("admin.property.views")}</TableHead>
                  <TableHead>{t("admin.property.offers")}</TableHead>
                  <TableHead className="text-right">{t("admin.property.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {properties.map(property => <TableRow key={property.id}>
                    <TableCell className="font-medium">
                      <div>
                        <div className="flex items-center gap-2">
                          <Building className="h-4 w-4 text-muted-foreground" />
                          <div>
                            <div>{property.address}</div>
                            <div className="text-xs text-muted-foreground flex items-center gap-1">
                              <MapPin className="h-3 w-3" />
                              {property.city}, {property.state} {property.zipCode}
                            </div>
                          </div>
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline">{getLocalizedType(property.propertyType)}</Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <div className={`w-2 h-2 rounded-full ${property.status === 'AVAILABLE' ? 'bg-green-500' : property.status === 'PENDING' ? 'bg-yellow-500' : property.status === 'UNDER_CONTRACT' ? 'bg-blue-500' : property.status === 'SOLD' ? 'bg-purple-500' : property.status === 'WITHDRAWN' ? 'bg-red-500' : 'bg-gray-500'}`} />
                        <span className="capitalize">{getStatusLabel(property.status)}</span>
                      </div>
                    </TableCell>
                    <TableCell className="font-medium">${property.price.toLocaleString()}</TableCell>
                    <TableCell>
                      <div className="text-sm">
                        <div>{property.bedrooms}{t("admin.property.bed")}{property.bathrooms}{t("admin.property.bath")}</div>
                        <div className="text-muted-foreground">
                          {property.squareFeet?.toLocaleString()}{t("admin.property.sq_ft")}</div>
                      </div>
                    </TableCell>
                    <TableCell>
                      {property.listingAgent?.name || 'Unassigned'}
                    </TableCell>
                    <TableCell>
                      <div className="text-center">
                        <div className="font-medium">{property.daysOnMarket}</div>
                        <div className="text-xs text-muted-foreground">{t("admin.property.days")}</div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <Eye className="h-3 w-3" />
                        <span>{property.views}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-1">
                        <TrendingUp className="h-3 w-3" />
                        <span>{property.offers}</span>
                      </div>
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin.property.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem>
                            <Eye className="h-4 w-4 mr-2" />{t("admin.property.view_details")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <Users className="h-4 w-4 mr-2" />{t("admin.property.manage_offers")}</DropdownMenuItem>
                          {property.status === 'AVAILABLE' && <>
                              <DropdownMenuItem onClick={() => updatePropertyStatus(property.id, 'PENDING')}>{t("admin.property.mark_as_pending")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => updatePropertyStatus(property.id, 'OFF_MARKET')}>{t("admin.property.take_off_market")}</DropdownMenuItem>
                            </>}
                          <DropdownMenuSeparator />
                          <DropdownMenuItem className="text-red-600">{t("admin.property.withdraw_listing")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Inventory Analytics */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.property.status_distribution")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <div className="flex justify-between items-center">
                  <span className="text-sm flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-green-500" />{t("admin.property.available")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.status === 'AVAILABLE').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-yellow-500" />{t("admin.property.pending")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.status === 'PENDING').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-blue-500" />{t("admin.property.under_contract")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.status === 'UNDER_CONTRACT').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-purple-500" />{t("admin.property.sold")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.status === 'SOLD').length}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.property.property_types")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.houses")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.propertyType === 'HOUSE').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.condos")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.propertyType === 'CONDO').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.townhouses")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.propertyType === 'TOWNHOUSE').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.apartments")}</span>
                  <span className="font-medium">
                    {properties.filter(p => p.propertyType === 'APARTMENT').length}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.property.performance_metrics")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="text-center">
                  <div className="text-2xl font-bold text-blue-600">
                    {Math.round(avgDaysOnMarket)}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.property.avg_days_on_market")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-green-600">
                    {totalViews}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.property.total_views")}</p>
                </div>
                <div className="text-center">
                  <div className="text-2xl font-bold text-purple-600">
                    {properties.reduce((acc, p) => acc + p.offers, 0)}
                  </div>
                  <p className="text-sm text-muted-foreground">{t("admin.property.total_offers")}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>;
}