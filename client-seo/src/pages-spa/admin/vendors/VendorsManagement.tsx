"use client";

import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Wrench, Plus, Briefcase, Truck, ShieldCheck } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useMutation } from"@tanstack/react-query";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";

const VendorsManagement = () => {
 const [isAddOpen, setIsAddOpen] = useState(false);
 const { toast } = useToast();
 const { t } = useTranslation();

 const [newVendor, setNewVendor] = useState({
 legalName: '',
 orgId: 'org_1', // Temporary default
 serviceAreas: '',
 defaultCommissionBps: 1000
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/vendor-profiles', {
 ...data,
 defaultCommissionBps: parseInt(data.defaultCommissionBps)
 });
 },
 onSuccess: () => {
 setIsAddOpen(false);
 toast({ title:"Success", description:"Vendor created successfully" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message ||"Failed to create vendor", variant:"destructive" });
 }
 });
 

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-amber-400 to-orange-400">
 {t("admin_vendors_title","Vendor Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_vendors_subtitle","Manage service providers, contractors, and maintenance teams")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-slate-100 dark:hover:bg-white/10">
 {t("common.export","Export")}
 </Button>
 
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button className="bg-amber-600 hover:bg-amber-700 text-foreground shadow-lg shadow-amber-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_vendors_add","Add Vendor")}
 </Button>
 </DialogTrigger>
 
 <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_add_new_vendor", "Add New Vendor")}</DialogTitle>
 <DialogDescription>{t("admin_auto_register_a_new_vendor_in_the_system_mapp", "Register a new vendor in the system mapped to the backend.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="legalName" className="text-right text-xs">{t("admin_auto_legal_name", "Legal Name")}</Label>
 <Input id="legalName" className="col-span-3 h-10" value={newVendor.legalName} onChange={e => setNewVendor({...newVendor, legalName: e.target.value})} placeholder={t("admin_auto_acme_services_llc", "Acme Services LLC")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="orgId" className="text-right text-xs">{t("admin_auto_org_id", "Org ID")}</Label>
 <Input id="orgId" className="col-span-3 h-10" value={newVendor.orgId} onChange={e => setNewVendor({...newVendor, orgId: e.target.value})} placeholder={t("admin_auto_org_1", "org_1")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="serviceAreas" className="text-right text-xs">{t("admin_auto_service_areas", "Service Areas")}</Label>
 <Input id="serviceAreas" className="col-span-3 h-10" value={newVendor.serviceAreas} onChange={e => setNewVendor({...newVendor, serviceAreas: e.target.value})} placeholder={t("admin_auto_plumbing_electrical", "Plumbing, Electrical")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="defaultCommissionBps" className="text-right text-xs">{t("admin_auto_commission_bps", "Commission (BPS)")}</Label>
 <Input id="defaultCommissionBps" type="number" className="col-span-3 h-10" value={newVendor.defaultCommissionBps} onChange={e => setNewVendor({...newVendor, defaultCommissionBps: parseInt(e.target.value) || 0})} placeholder="1000 (10%)" />
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => createMutation.mutate(newVendor)} disabled={createMutation.isPending || !newVendor.legalName}>
 {createMutation.isPending ?"Saving..." :"Add Vendor"}
 </Button>
 </DialogFooter>
 </DialogContent>
 
 </Dialog>
 
 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">{t("admin_auto_active_vendors", "Active Vendors")}</CardTitle>
 <Briefcase className="w-4 h-4 text-amber-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">482</div>
 <p className="text-xs text-green-400 mt-1">{t("admin_auto_15_this_month", "+15 this month")}</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">{t("admin_auto_active_work_orders", "Active Work Orders")}</CardTitle>
 <Wrench className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">1,204</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_property_across_all_properties", "Across all properties")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">{t("agent.compliance.compliance_rate", "Compliance Rate")}</CardTitle>
 <ShieldCheck className="w-4 h-4 text-green-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">96.5%</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_auto_insurance_licenses", "Insurance & Licenses")}</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_vendors_list","Vendor Network")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading","Loading vendor network...")}
 </div>
 </CardContent>
 </Card>
 </div>
 );
};

export default VendorsManagement;
