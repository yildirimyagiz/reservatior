"use client";
import { apiClient } from '@/lib/api/client';

import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { financialsApi, type Mortgage } from"@/lib/api/financials";
import { propertiesApi, type Property } from"@/lib/api/properties";
import { Building2, Landmark, Calendar, Percent, Plus, RefreshCw, Loader2, Info } from"lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useMutation, useQueryClient } from"@tanstack/react-query";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { useToast } from"@/hooks/use-toast";

export default function Mortgages() {
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
 

 const { t } = useTranslation();
 const [isAddOpen, setIsAddOpen] = useState(false);

 const [newMortgage, setNewMortgage] = useState({
 propertyId: '',
 lender: '',
 principal: '',
 interestRate: '',
 startDate: '',
 status: 'ACTIVE'
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return financialsApi.createMortgage({
 ...data,
 principal: parseFloat(data.principal),
 interestRate: parseFloat(data.interestRate),
 startDate: new Date(data.startDate).toISOString()
 });
 },
 onSuccess: () => {
 setIsAddOpen(false);
 fetchData();
 toast({ title:"Success", description:"Mortgage created successfully" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message ||"Failed to create mortgage", variant:"destructive" });
 }
 });
 
 const [mortgages, setMortgages] = useState<Mortgage[]>([]);
 const [properties, setProperties] = useState<Property[]>([]);
 const [loading, setLoading] = useState(true);
 const fetchData = async () => {
 try {
 setLoading(true);
 const [mortRes, propRes] = await Promise.all([financialsApi.getMortgages(), propertiesApi.getAll()]);
 setMortgages(mortRes || [{
 id:"m1",
 propertyId:"prop1",
 lender:"Chase Bank",
 principal: 450000,
 interestRate: 4.5,
 startDate:"2023-01-01",
 status:"ACTIVE"
 }, {
 id:"m2",
 propertyId:"prop2",
 lender:"Wells Fargo",
 principal: 1200000,
 interestRate: 3.8,
 startDate:"2022-06-15",
 status:"ACTIVE"
 }]);
 setProperties(propRes || []);
 } catch (error) {
 console.error("API error, using mock data");
 setMortgages([{
 id:"m1",
 propertyId:"prop1",
 lender:"Chase Bank",
 principal: 450000,
 interestRate: 4.5,
 startDate:"2023-01-01",
 status:"ACTIVE"
 }, {
 id:"m2",
 propertyId:"prop2",
 lender:"Wells Fargo",
 principal: 1200000,
 interestRate: 3.8,
 startDate:"2022-06-15",
 status:"ACTIVE"
 }]);
 } finally {
 setLoading(false);
 }
 };
 useEffect(() => {
 fetchData();
 }, []);
 const getPropertyName = (id: string) => properties.find(p => p.id === id)?.name ||"Unknown Property";
 return <PageShell title={t("admin_financial_property_mortgages")} description={t("admin_financial_track_and_manage_property")} actions={<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex gap-2">
 <Button variant="outline" size="sm" onClick={fetchData} disabled={loading}>
 <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("admin_financial_refresh")}</Button>
 
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button size="sm" className="bg-primary hover:bg-primary/90 text-primary-foreground">
 <Plus className="w-4 h-4 mr-2" />{t("admin_financial_add_mortgage")}</Button>
 </DialogTrigger>
 
 <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_add_new_mortgage", "Add New Mortgage")}</DialogTitle>
 <DialogDescription>{t("admin_auto_register_a_new_mortgage_for_a_property_m", "Register a new mortgage for a property mapping to the backend.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="propertyId" className="text-right text-xs">{t("admin_auto_property", "Property")}</Label>
 <Select value={newMortgage.propertyId} onValueChange={(v) => setNewMortgage({...newMortgage, propertyId: v})}>
 <SelectTrigger className="col-span-3 h-10">
 <SelectValue placeholder={t("admin_contract_select_property", "Select Property")} />
 </SelectTrigger>
 <SelectContent>
 {properties.map(p => (
 <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="lender" className="text-right text-xs">{t("admin_auto_lender_bank", "Lender Bank")}</Label>
 <Input id="lender" className="col-span-3 h-10" value={newMortgage.lender} onChange={e => setNewMortgage({...newMortgage, lender: e.target.value})} placeholder={t("admin_auto_e_g_chase_bank", "e.g. Chase Bank")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="principal" className="text-right text-xs">{t("admin_auto_principal", "Principal ($)")}</Label>
 <Input id="principal" type="number" className="col-span-3 h-10" value={newMortgage.principal} onChange={e => setNewMortgage({...newMortgage, principal: e.target.value})} placeholder="450000" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="interestRate" className="text-right text-xs">{t("admin_auto_interest_rate", "Interest Rate (%)")}</Label>
 <Input id="interestRate" type="number" step="0.1" className="col-span-3 h-10" value={newMortgage.interestRate} onChange={e => setNewMortgage({...newMortgage, interestRate: e.target.value})} placeholder="4.5" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="startDate" className="text-right text-xs">{t("admin_auto_start_date", "Start Date")}</Label>
 <Input id="startDate" type="date" className="col-span-3 h-10" value={newMortgage.startDate} onChange={e => setNewMortgage({...newMortgage, startDate: e.target.value})} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="status" className="text-right text-xs">{t("admin_auto_status", "Status")}</Label>
 <Select value={newMortgage.status} onValueChange={(v) => setNewMortgage({...newMortgage, status: v})}>
 <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder={t("client.src.select_status", "Select Status")} /></SelectTrigger>
 <SelectContent>
 <SelectItem value="ACTIVE">{t("admin_ai_active", "Active")}</SelectItem>
 <SelectItem value="PAID_OFF">{t("admin_auto_paid_off", "Paid Off")}</SelectItem>
 <SelectItem value="REFINANCED">{t("admin_auto_refinanced", "Refinanced")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => createMutation.mutate(newMortgage)} disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Add Mortgage"}
 </Button>
 </DialogFooter>
 </DialogContent>
 
 </Dialog>
 
 </div>}>
 <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
 <Card className="shadow-sm border-muted">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_financial_total_principal_outstanding")}</CardTitle>
 <Landmark className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{t("currency_symbol", "$")}{mortgages.reduce((a, b) => a + b.principal, 0).toLocaleString()}</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_financial_across")}{mortgages.length}{t("admin_financial_properties")}</p>
 </CardContent>
 </Card>
 <Card className="shadow-sm border-muted">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_financial_interest_rates_range")}</CardTitle>
 <Percent className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">3.8% - 4.5%</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_financial_current_market_average_62")}</p>
 </CardContent>
 </Card>
 </div>

 <div className="bg-card border border-border rounded-xl shadow-sm overflow-hidden">
 <Table>
 <TableHeader className="bg-muted/30">
 <TableRow>
 <TableHead className="font-bold text-xs">{t("admin_financial_property")}</TableHead>
 <TableHead className="font-bold text-xs">{t("admin_financial_lender")}</TableHead>
 <TableHead className="font-bold text-xs">{t("admin_financial_principal")}</TableHead>
 <TableHead className="font-bold text-xs">{t("admin_financial_interest_rate")}</TableHead>
 <TableHead className="font-bold text-xs">{t("admin_financial_start_date")}</TableHead>
 <TableHead className="font-bold text-xs">{t("admin_financial_status")}</TableHead>
 <TableHead className="w-10" />
 </TableRow>
 </TableHeader>
 <TableBody>
 {loading ? <TableRow>
 <TableCell colSpan={7} className="h-64 text-center">
 <div className="flex flex-col items-center justify-center gap-2">
 <Loader2 className="w-8 h-8 animate-spin text-primary" />
 <span>{t("admin_financial_loading_mortgage_data")}</span>
 </div>
 </TableCell>
 </TableRow> : mortgages.length === 0 ? <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("admin_financial_no_mortgages_found","No mortgages found")}</TableCell></TableRow> : mortgages.map(mort => <TableRow key={mort.id} className="hover:bg-muted/40 transition-colors">
 <TableCell>
 <div className="flex items-center gap-2">
 <Building2 className="w-4 h-4 text-primary" />
 <span className="font-medium text-sm">{getPropertyName(mort.propertyId)}</span>
 </div>
 </TableCell>
 <TableCell className="text-sm">{mort.lender}</TableCell>
 <TableCell className="font-semibold text-sm">{t("currency_symbol", "$")}{mort.principal.toLocaleString()}</TableCell>
 <TableCell className="text-sm">{mort.interestRate}%</TableCell>
 <TableCell className="text-xs text-muted-foreground">
 <div className="flex items-center gap-1">
 <Calendar className="w-3 h-3" />
 {new Date(mort.startDate).toLocaleDateString()}
 </div>
 </TableCell>
 <TableCell>
 <Badge className="bg-green-100 text-green-700 hover:bg-green-200 border-0 text-[10px] font-bold">
 {mort.status}
 </Badge>
 </TableCell>
 <TableCell>
 <Button variant="ghost" size="icon" className="h-8 w-8">
 <Info className="w-4 h-4 text-muted-foreground" />
 </Button>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </div>
 </PageShell>;
}