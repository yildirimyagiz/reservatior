"use client";

import { t } from"i18next";
import { useState, useEffect } from"react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { useTranslation } from"react-i18next";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Home, Calendar, DollarSign, MoreHorizontal, Activity, Plus, TrendingUp, Star, Users, MapPin } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
interface VacationRental {
 id: string;
 orgId?: string;
 propertyId: string;
 platform: string;
 externalId: string;
 status: 'ACTIVE' | 'INACTIVE' | 'SUSPENDED' | 'PENDING';
 nightlyRate: number;
 weeklyRate?: number;
 monthlyRate?: number;
 cleaningFee: number;
 securityDeposit: number;
 minStay: number;
 maxGuests: number;
 availabilityCalendar: any; // JSON calendar data
 bookingSettings: {
 instantBooking: boolean;
 autoApprove: boolean;
 cancellationPolicy: string;
 };
 syncStatus: 'SYNCED' | 'OUT_OF_SYNC' | 'SYNCING' | 'ERROR';
 lastSyncedAt?: Date;
 occupancyRate: number;
 averageRating: number;
 totalBookings: number;
 revenue: number;
 createdAt: Date;
 property?: {
 address: string;
 city: string;
 state: string;
 bedrooms: number;
 bathrooms: number;
 };
}
export default function VacationRentals() {
 const {
 t
 } = useTranslation();
 const [rentals, setRentals] = useState<VacationRental[]>([]);
 const [loading, setLoading] = useState(true);
 const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
 const [platformFilter, setPlatformFilter] = useState<string>('all');
 const [statusFilter, setStatusFilter] = useState<string>('all');
 const {
 toast
 } = useToast();
 const [newRental, setNewRental] = useState({
 propertyId: '',
 platform: 'AIRBNB',
 externalId: '',
 nightlyRate: 0,
 cleaningFee: 0,
 securityDeposit: 0,
 minStay: 1,
 maxGuests: 2,
 instantBooking: true,
 autoApprove: false
 });
 useEffect(() => {
 fetchRentals();
 }, [platformFilter, statusFilter]);
 const fetchRentals = async () => {
 try {
 const params = new URLSearchParams();
 if (platformFilter !== 'all') params.append('platform', platformFilter);
 if (statusFilter !== 'all') params.append('status', statusFilter);
 const response = (await apiClient.get(`/properties/vacation-rentals?${params}`)) as {
 data: VacationRental[];
 };
 setRentals(response.data);
 } catch (error) {
 toast({
 title: t("admin_property_error"),
 description: t("admin_property_failed_to_fetch_vacation"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const createRental = async () => {
 try {
 const response = (await apiClient.post('/properties/vacation-rentals', {
 ...newRental,
 bookingSettings: {
 instantBooking: newRental.instantBooking,
 autoApprove: newRental.autoApprove,
 cancellationPolicy: 'MODERATE'
 }
 })) as {
 data: VacationRental;
 };
 setRentals([...rentals, response.data]);
 setIsCreateDialogOpen(false);
 setNewRental({
 propertyId: '',
 platform: 'AIRBNB',
 externalId: '',
 nightlyRate: 0,
 cleaningFee: 0,
 securityDeposit: 0,
 minStay: 1,
 maxGuests: 2,
 instantBooking: true,
 autoApprove: false
 });
 toast({
 title: t("admin_property_success"),
 description: t("admin_property_vacation_rental_listing_created")
 });
 } catch (error) {
 toast({
 title: t("admin_property_error"),
 description: t("admin_property_failed_to_create_vacation"),
 variant:"destructive"
 });
 }
 };
 const updateRentalStatus = async (rentalId: string, status: string) => {
 try {
 await apiClient.put(`/properties/vacation-rentals/${rentalId}`, {
 status
 });
 setRentals(rentals.map(r => r.id === rentalId ? {
 ...r,
 status: status as any
 } : r));
 toast({
 title: t("admin_property_success"),
 description: t("admin_property_rental_status_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_property_error"),
 description: t("admin_property_failed_to_update_rental"),
 variant:"destructive"
 });
 }
 };
 const syncWithPlatform = async (rentalId: string) => {
 try {
 await apiClient.post(`/properties/vacation-rentals/${rentalId}/sync`);
 setRentals(rentals.map(r => r.id === rentalId ? {
 ...r,
 syncStatus: 'SYNCING'
 } : r));
 toast({
 title: t("admin_property_sync_started"),
 description: t("admin_property_syncing_with_platform")
 });
 } catch (error) {
 toast({
 title: t("admin_property_error"),
 description: t("admin_property_failed_to_start_sync"),
 variant:"destructive"
 });
 }
 };
 const getStatusColor = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 return 'bg-blue-500';
 case 'INACTIVE':
 return 'bg-card/10';
 case 'SUSPENDED':
 return 'bg-red-500';
 case 'PENDING':
 return 'bg-yellow-500';
 default:
 return 'bg-card/10';
 }
 };
 const getSyncStatusColor = (status: string) => {
 switch (status) {
 case 'SYNCED':
 return 'bg-blue-500';
 case 'SYNCING':
 return 'bg-muted0';
 case 'OUT_OF_SYNC':
 return 'bg-yellow-500';
 case 'ERROR':
 return 'bg-red-500';
 default:
 return 'bg-card/10';
 }
 };
 const activeRentals = rentals.filter(r => r.status === 'ACTIVE').length;
 const totalRevenue = rentals.reduce((acc, r) => acc + r.revenue, 0);
 const avgOccupancy = rentals.length > 0 ? rentals.reduce((acc, r) => acc + r.occupancyRate, 0) / rentals.length : 0;
 const avgRating = rentals.length > 0 ? rentals.reduce((acc, r) => acc + r.averageRating, 0) / rentals.length : 0;
 if (loading) {
 return <PageShell title={t("admin_bookings_title") ||"Vacation Rentals"}>
 <div className="flex items-center justify-center h-64">
 <Activity className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 return <PageShell title={t("admin_bookings_title") ||"Vacation Rentals"}>
 <div className="space-y-6">
 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_property_active_listings")}</CardTitle>
 <Home className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{activeRentals}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_live_on_platforms")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_property_total_revenue")}</CardTitle>
 <DollarSign className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{t("currency_symbol", "$")}{totalRevenue.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_this_month")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_property_avg_occupancy")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{avgOccupancy.toFixed(1)}%</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_across_all_listings")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_property_avg_rating")}</CardTitle>
 <Star className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{avgRating.toFixed(1)}/5</div>
 <p className="text-xs text-muted-foreground">{t("admin_property_guest_satisfaction")}</p>
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
 <SelectItem value="AIRBNB">{t("admin_property_airbnb")}</SelectItem>
 <SelectItem value="VRBO">{t("admin_property_vrbo")}</SelectItem>
 <SelectItem value="BOOKING">{t("admin_property_bookingcom")}</SelectItem>
 <SelectItem value="HOMEAWAY">{t("admin_property_homeaway")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-[150px]">
 <SelectValue placeholder={t("admin_property_status")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_property_all_statuses")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_property_active")}</SelectItem>
 <SelectItem value="INACTIVE">{t("admin_property_inactive")}</SelectItem>
 <SelectItem value="SUSPENDED">{t("admin_property_suspended")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_property_pending")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_property_add_rental_listing")}</Button>
 </DialogTrigger>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_property_add_vacation_rental_listing")}</DialogTitle>
 <DialogDescription>{t("admin_property_connect_a_property_to")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="propertyId">{t("admin_property_property_id")}</Label>
 <Input id="propertyId" value={newRental.propertyId} onChange={e => setNewRental({
 ...newRental,
 propertyId: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="platform">{t("admin_property_platform")}</Label>
 <Select value={newRental.platform} onValueChange={value => setNewRental({
 ...newRental,
 platform: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="AIRBNB">{t("admin_property_airbnb")}</SelectItem>
 <SelectItem value="VRBO">{t("admin_property_vrbo")}</SelectItem>
 <SelectItem value="BOOKING">{t("admin_property_bookingcom")}</SelectItem>
 <SelectItem value="HOMEAWAY">{t("admin_property_homeaway")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="externalId">{t("admin_property_external_listing_id")}</Label>
 <Input id="externalId" value={newRental.externalId} onChange={e => setNewRental({
 ...newRental,
 externalId: e.target.value
 })} placeholder={t("admin_property_platforms_listing_id")} />
 </div>
 <div className="grid grid-cols-3 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="nightlyRate">{t("admin_property_nightly_rate")}</Label>
 <Input id="nightlyRate" type="number" value={newRental.nightlyRate} onChange={e => setNewRental({
 ...newRental,
 nightlyRate: parseFloat(e.target.value)
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="cleaningFee">{t("admin_property_cleaning_fee")}</Label>
 <Input id="cleaningFee" type="number" value={newRental.cleaningFee} onChange={e => setNewRental({
 ...newRental,
 cleaningFee: parseFloat(e.target.value)
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="securityDeposit">{t("admin_property_security_deposit")}</Label>
 <Input id="securityDeposit" type="number" value={newRental.securityDeposit} onChange={e => setNewRental({
 ...newRental,
 securityDeposit: parseFloat(e.target.value)
 })} />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="minStay">{t("admin_property_minimum_stay_nights")}</Label>
 <Input id="minStay" type="number" value={newRental.minStay} onChange={e => setNewRental({
 ...newRental,
 minStay: parseInt(e.target.value)
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="maxGuests">{t("admin_property_maximum_guests")}</Label>
 <Input id="maxGuests" type="number" value={newRental.maxGuests} onChange={e => setNewRental({
 ...newRental,
 maxGuests: parseInt(e.target.value)
 })} />
 </div>
 </div>
 <div className="flex items-center gap-4">
 <div className="flex items-center space-x-2">
 <input type="checkbox" id="instantBooking" checked={newRental.instantBooking} onChange={e => setNewRental({
 ...newRental,
 instantBooking: e.target.checked
 })} />
 <Label htmlFor="instantBooking">{t("admin_property_instant_booking")}</Label>
 </div>
 <div className="flex items-center space-x-2">
 <input type="checkbox" id="autoApprove" checked={newRental.autoApprove} onChange={e => setNewRental({
 ...newRental,
 autoApprove: e.target.checked
 })} />
 <Label htmlFor="autoApprove">{t("admin_property_autoapprove_requests")}</Label>
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={createRental}>{t("admin_property_create_listing")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 {/* Rentals Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_property_vacation_rental_listings")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_property_manage_your_vacation_rental")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_property_property")}</TableHead>
 <TableHead>{t("admin_property_platform")}</TableHead>
 <TableHead>{t("admin_property_status")}</TableHead>
 <TableHead>{t("admin_property_sync_status")}</TableHead>
 <TableHead>{t("admin_property_nightly_rate")}</TableHead>
 <TableHead>{t("admin_property_occupancy")}</TableHead>
 <TableHead>{t("admin_property_rating")}</TableHead>
 <TableHead>{t("admin_property_revenue")}</TableHead>
 <TableHead className="text-right">{t("admin_property_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {rentals.map(rental => <TableRow key={rental.id}>
 <TableCell className="font-medium">
 <div>
 <div className="flex items-center gap-2">
 <Home className="h-4 w-4 text-muted-foreground" />
 <div>
 <div>{rental.property?.address || `Property ${rental.propertyId}`}</div>
 <div className="text-xs text-muted-foreground flex items-center gap-1">
 <MapPin className="h-3 w-3" />
 {rental.property?.city}{t(",", ",")}{rental.property?.state}
 </div>
 <div className="text-xs text-muted-foreground">
 {rental.property?.bedrooms}{t("admin_property_bed")}{rental.property?.bathrooms}{t("admin_property_bath")}</div>
 </div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div>
 <Badge variant="outline">{rental.platform}</Badge>
 <div className="text-xs text-muted-foreground mt-1">{t("admin_property_id")}{rental.externalId}
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(rental.status)}`} />
 <span className="capitalize">{rental.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getSyncStatusColor(rental.syncStatus)}`} />
 <span className="capitalize text-xs">
 {rental.syncStatus.replace('_', ' ').toLowerCase()}
 </span>
 </div>
 </TableCell>
 <TableCell className="font-medium">{t("currency_symbol", "$")}{rental.nightlyRate}</TableCell>
 <TableCell>
 <div className="text-center">
 <div className="font-medium">{rental.occupancyRate.toFixed(1)}%</div>
 <div className="text-xs text-muted-foreground">
 {rental.totalBookings}{t("admin_property_bookings")}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <Star className="h-3 w-3 fill-yellow-400 text-yellow-400" />
 <span className="text-sm">{rental.averageRating.toFixed(1)}</span>
 </div>
 </TableCell>
 <TableCell className="font-medium">{t("currency_symbol", "$")}{rental.revenue.toLocaleString()}</TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0" aria-label={t("common.more")}>
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_property_actions")}</DropdownMenuLabel>
 <DropdownMenuItem>
 <Calendar className="h-4 w-4 mr-2" />{t("admin_property_view_calendar")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Users className="h-4 w-4 mr-2" />{t("admin_property_manage_bookings")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => syncWithPlatform(rental.id)}>
 <TrendingUp className="h-4 w-4 mr-2" />{t("admin_property_sync_with_platform")}</DropdownMenuItem>
 {rental.status === 'ACTIVE' && <DropdownMenuItem onClick={() => updateRentalStatus(rental.id, 'INACTIVE')}>{t("admin_property_pause_listing")}</DropdownMenuItem>}
 {rental.status === 'INACTIVE' && <DropdownMenuItem onClick={() => updateRentalStatus(rental.id, 'ACTIVE')}>{t("admin_property_activate_listing")}</DropdownMenuItem>}
 <DropdownMenuSeparator />
 <DropdownMenuItem className="text-red-600">{t("admin_property_remove_listing")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Platform Analytics */}
 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_property_platform_performance")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 {['AIRBNB', 'VRBO', 'BOOKING', 'HOMEAWAY'].map(platform => {
 const platformRentals = rentals.filter(r => r.platform === platform);
 const totalRevenue = platformRentals.reduce((acc, r) => acc + r.revenue, 0);
 const avgOccupancy = platformRentals.length > 0 ? platformRentals.reduce((acc, r) => acc + r.occupancyRate, 0) / platformRentals.length : 0;
 return <div key={platform} className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex justify-between items-center">
 <span className="text-sm">{platform}</span>
 <div className="text-right">
 <div className="text-sm font-medium">{t("currency_symbol", "$")}{totalRevenue.toLocaleString()}</div>
 <div className="text-xs text-muted-foreground">
 {avgOccupancy.toFixed(1)}{t("admin_property_occupancy")}</div>
 </div>
 </div>;
 })}
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_property_booking_settings")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_property_instant_booking")}</span>
 <span className="font-medium">
 {rentals.filter(r => r.bookingSettings.instantBooking).length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_property_autoapprove")}</span>
 <span className="font-medium">
 {rentals.filter(r => r.bookingSettings.autoApprove).length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_property_manual_review")}</span>
 <span className="font-medium">
 {rentals.filter(r => !r.bookingSettings.autoApprove).length}
 </span>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_property_sync_status")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-blue-500" />{t("admin_property_synced")}</span>
 <span className="font-medium">
 {rentals.filter(r => r.syncStatus === 'SYNCED').length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-yellow-500" />{t("admin_property_out_of_sync")}</span>
 <span className="font-medium">
 {rentals.filter(r => r.syncStatus === 'OUT_OF_SYNC').length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-muted0" />{t("admin_property_syncing")}</span>
 <span className="font-medium">
 {rentals.filter(r => r.syncStatus === 'SYNCING').length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-red-500" />{t("admin_property_error")}</span>
 <span className="font-medium">
 {rentals.filter(r => r.syncStatus === 'ERROR').length}
 </span>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </PageShell>;
}