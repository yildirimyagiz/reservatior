"use client";

import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { useTranslation } from"react-i18next";
import { Button } from"@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectGroup, SelectItem, SelectLabel, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Home, Building, TrendingUp, DollarSign, MoreHorizontal, Activity, Eye, MapPin, Calendar, Users } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";

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
 const { t } = useTranslation();
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 const [statusFilter, setStatusFilter] = useState<string>('all');
 const [typeFilter, setTypeFilter] = useState<string>('all');
 const [sortBy, setSortBy] = useState<string>('createdAt');
 const [sortOrder, setSortOrder] = useState<'asc' | 'desc'>('desc');
 const { data: properties = [], isLoading } = useQuery({
 queryKey: ['property-inventory', statusFilter, typeFilter, sortBy, sortOrder],
 queryFn: async () => {
 const params = new URLSearchParams();
 if (statusFilter !== 'all') params.append('status', statusFilter);
 if (typeFilter !== 'all') params.append('propertyType', typeFilter);
 params.append('sortBy', sortBy);
 params.append('sortOrder', sortOrder);
 const response = await apiClient.get(`/property-inventory?${params}`) as { data: PropertyInventory[] };
 return response.data;
 }
 });
 const updateStatusMutation = useMutation({
 mutationFn: async ({ propertyId, status }: { propertyId: string; status: string }) => {
 await apiClient.put(`/property-inventory/${propertyId}`, { status });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['property-inventory'] });
 toast({ title: t("admin_property_success"), description: t("admin_property_property_status_updated_successfully") });
 },
 onError: () => {
 toast({ title: t("admin_property_error"), description: t("admin_property_failed_to_update_property"), variant:"destructive" });
 }
 });
 const getLocalizedType = (type: string) => {
 const key = `client.property.types.${type}`;
 const translated = t(key);
 return translated !== key ? translated : type;
 };
 const getStatusLabel = (status: string) => {
 switch (status) {
 case 'AVAILABLE': return t("available");
 case 'PENDING': return t("admin_inventory_status_pending");
 case 'UNDER_CONTRACT': return t("admin_inventory_status_underContract");
 case 'SOLD': return t("admin_inventory_status_sold");
 case 'OFF_MARKET': return t("admin_inventory_status_offMarket");
 case 'WITHDRAWN': return t("admin_inventory_status_withdrawn");
 default: return status;
 }
 };
 const availableProperties = properties.filter(p => p.status === 'AVAILABLE').length;
 const totalValue = properties.reduce((acc, p) => acc + p.price, 0);
 const avgPrice = properties.length > 0 ? totalValue / properties.length : 0;
 const totalViews = properties.reduce((acc, p) => acc + p.views, 0);
 const avgDaysOnMarket = properties.length > 0 ? properties.reduce((acc, p) => acc + p.daysOnMarket, 0) / properties.length : 0;
 if (isLoading) {
 return <div className="min-h-screen bg-background p-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_inventory_title")}</h1>
 </div>
 <div className="flex items-center justify-center h-64 mt-6">
 <Activity className="h-8 w-8 animate-spin text-foreground" />
 </div>
 </div>;
 }
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground">{t("admin_inventory_title")}</h1>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("available")}</CardTitle>
 <Home className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{availableProperties}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_ready_for_showing")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_inventory_portfolioValue")}</CardTitle>
 <DollarSign className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{t("currency_symbol", "$")}{totalValue.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_across_all_properties")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_inventory_avgPrice")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{t("currency_symbol", "$")}{avgPrice.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_market_average")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_inventory_avgDOM")}</CardTitle>
 <Calendar className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{Math.round(avgDaysOnMarket)}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_time_to_sell")}</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border">
 <CardContent className="pt-6">
 <div className="flex gap-4 items-center">
 <div className="flex items-center gap-2">
 <span className="text-sm font-medium text-muted-foreground">{t("admin_property_status")}</span>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-[150px] bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="all">{t("admin_inventory_status_all")}</SelectItem>
 <SelectItem value="AVAILABLE">{t("available")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_inventory_status_pending")}</SelectItem>
 <SelectItem value="UNDER_CONTRACT">{t("admin_inventory_status_underContract")}</SelectItem>
 <SelectItem value="SOLD">{t("admin_inventory_status_sold")}</SelectItem>
 <SelectItem value="OFF_MARKET">{t("admin_inventory_status_offMarket")}</SelectItem>
 <SelectItem value="WITHDRAWN">{t("admin_inventory_status_withdrawn")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="flex items-center gap-2">
 <span className="text-sm font-medium text-muted-foreground">{t("admin_property_type")}</span>
 <Select value={typeFilter} onValueChange={setTypeFilter}>
 <SelectTrigger className="w-[180px] bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="max-h-[400px] bg-card border-border text-foreground">
 <SelectItem value="all">{t("admin_inventory_types_all")}</SelectItem>
 <SelectGroup>
 <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1">{t("client.property.portfolio.filters.type.residential")} {t("admin_auto_houses", "- HOUSES")}</SelectLabel>
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
 <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1 mt-2">{t("client.property.portfolio.filters.type.residential")} {t("admin_auto_apartments", "- APARTMENTS")}</SelectLabel>
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
 <span className="text-sm font-medium text-muted-foreground">{t("admin_property_sort_by")}</span>
 <Select value={sortBy} onValueChange={setSortBy}>
 <SelectTrigger className="w-[150px] bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="createdAt">{t("admin_property_date_added")}</SelectItem>
 <SelectItem value="price">{t("admin_property_price")}</SelectItem>
 <SelectItem value="daysOnMarket">{t("admin_property_days_on_market")}</SelectItem>
 <SelectItem value="views">{t("admin_property_views")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="flex items-center gap-2">
 <span className="text-sm font-medium text-muted-foreground">{t("admin_property_order")}</span>
 <Select value={sortOrder} onValueChange={value => setSortOrder(value as 'asc' | 'desc')}>
 <SelectTrigger className="w-[120px] bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="desc">{t("admin_property_descending")}</SelectItem>
 <SelectItem value="asc">{t("admin_property_ascending")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_property_property_inventory")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_property_manage_your_property_listings")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border">
 <TableHead className="text-muted-foreground">{t("admin_property_property")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_price")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_size")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_agent")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_days_on_market")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_views")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_property_offers")}</TableHead>
 <TableHead className="text-right text-muted-foreground">{t("admin_property_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {properties.map(property => <TableRow key={property.id} className="border-border">
 <TableCell className="font-medium text-foreground">
 <div className="flex items-center gap-2">
 <Building className="h-4 w-4 text-muted-foreground" />
 <div>
 <div className="text-foreground">{property.address}</div>
 <div className="text-xs text-muted-foreground flex items-center gap-1">
 <MapPin className="h-3 w-3" />
 {property.city}{t(",", ",")}{property.state} {property.zipCode}
 </div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="text-muted-foreground border-border">{getLocalizedType(property.propertyType)}</Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2 text-foreground">
 <div className={`w-2 h-2 rounded-full ${property.status === 'AVAILABLE' ? 'bg-green-500' : property.status === 'PENDING' ? 'bg-yellow-500' : property.status === 'UNDER_CONTRACT' ? 'bg-muted0' : property.status === 'SOLD' ? 'bg-muted0' : property.status === 'WITHDRAWN' ? 'bg-red-500' : 'bg-white/10'}`} />
 <span className="capitalize">{getStatusLabel(property.status)}</span>
 </div>
 </TableCell>
 <TableCell className="font-medium text-foreground">{t("currency_symbol", "$")}{property.price.toLocaleString()}</TableCell>
 <TableCell className="text-muted-foreground">
 <div className="text-sm">
 <div className="text-foreground">{property.bedrooms}{t("admin_property_bed")}{property.bathrooms}{t("admin_property_bath")}</div>
 <div className="text-muted-foreground">{property.squareFeet?.toLocaleString()}{t("admin_property_sq_ft")}</div>
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">
                  {property.listingAgent?.name || t("admin_property_unassigned", "Unassigned")}
 </TableCell>
 <TableCell>
 <div className="text-center">
 <div className="font-medium text-foreground">{property.daysOnMarket}</div>
 <div className="text-xs text-muted-foreground">{t("admin_property_days")}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1 text-foreground">
 <Eye className="h-3 w-3 text-muted-foreground" />
 <span>{property.views}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1 text-foreground">
 <TrendingUp className="h-3 w-3 text-muted-foreground" />
 <span>{property.offers}</span>
 </div>
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0 text-muted-foreground">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border text-foreground">
 <DropdownMenuLabel className="text-muted-foreground">{t("admin_property_actions")}</DropdownMenuLabel>
 <DropdownMenuItem className="hover:bg-card">
 <Eye className="h-4 w-4 mr-2" />{t("admin_property_view_details")}
 </DropdownMenuItem>
 <DropdownMenuItem className="hover:bg-card">
 <Users className="h-4 w-4 mr-2" />{t("admin_property_manage_offers")}
 </DropdownMenuItem>
 {property.status === 'AVAILABLE' && <>
 <DropdownMenuItem className="hover:bg-card" onClick={() => updateStatusMutation.mutate({ propertyId: property.id, status: 'PENDING' })}>{t("admin_property_mark_as_pending")}</DropdownMenuItem>
 <DropdownMenuItem className="hover:bg-card" onClick={() => updateStatusMutation.mutate({ propertyId: property.id, status: 'OFF_MARKET' })}>{t("admin_property_take_off_market")}</DropdownMenuItem>
 </>}
 <DropdownMenuSeparator className="border-border" />
 <DropdownMenuItem className="text-red-600 hover:bg-card">{t("admin_property_withdraw_listing")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_property_status_distribution")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-green-500" />{t("admin_property_available")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.status === 'AVAILABLE').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-yellow-500" />{t("admin_property_pending")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.status === 'PENDING').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-muted0" />{t("admin_property_under_contract")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.status === 'UNDER_CONTRACT').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-muted0" />{t("admin_property_sold")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.status === 'SOLD').length}</span>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_property_property_types")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_houses")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.propertyType === 'HOUSE').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_condos")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.propertyType === 'CONDO').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_townhouses")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.propertyType === 'TOWNHOUSE').length}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm text-foreground">{t("admin_property_apartments")}</span>
 <span className="font-medium text-foreground">{properties.filter(p => p.propertyType === 'APARTMENT').length}</span>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_property_performance_metrics")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <div className="text-center">
 <div className="text-2xl font-bold text-muted-foreground">{Math.round(avgDaysOnMarket)}</div>
 <p className="text-sm text-muted-foreground">{t("admin_property_avg_days_on_market")}</p>
 </div>
 <div className="text-center">
 <div className="text-2xl font-bold text-green-400">{totalViews}</div>
 <p className="text-sm text-muted-foreground">{t("admin_property_total_views")}</p>
 </div>
 <div className="text-center">
 <div className="text-2xl font-bold text-muted-foreground">{properties.reduce((acc, p) => acc + p.offers, 0)}</div>
 <p className="text-sm text-muted-foreground">{t("admin_property_total_offers")}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </div>;
}
