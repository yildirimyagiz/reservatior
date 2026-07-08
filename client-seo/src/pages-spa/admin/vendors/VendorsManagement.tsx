"use client";

import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Wrench, Plus, Briefcase, Truck, ShieldCheck } from 'lucide-react';
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useMutation } from "@tanstack/react-query";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";

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
                toast({ title: "Success", description: "Vendor created successfully" });
              },
              onError: (err: any) => {
                toast({ title: "Error", description: err.message || "Failed to create vendor", variant: "destructive" });
              }
            });
          

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-amber-400 to-orange-400">
            {t("admin.vendors.title", "Vendor Management")}
          </h1>
          <p className="text-slate-500 dark:text-slate-400 mt-2">
            {t("admin.vendors.subtitle", "Manage service providers, contractors, and maintenance teams")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-slate-200 dark:border-white/10 hover:bg-white/10">
            {t("common.export", "Export")}
          </Button>
          
                            <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
                              <DialogTrigger asChild>
                                <Button className="bg-amber-600 hover:bg-amber-700 text-slate-900 dark:text-white shadow-lg shadow-amber-500/20">
                              <Plus className="w-4 h-4 mr-2" />
                              {t("admin.vendors.add", "Add Vendor")}
                            </Button>
                              </DialogTrigger>
                              
                      <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
                        <DialogHeader>
                          <DialogTitle>Add New Vendor</DialogTitle>
                          <DialogDescription>
                            Register a new vendor in the system mapped to the backend.
                          </DialogDescription>
                        </DialogHeader>
                        <div className="grid gap-4 py-4">
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="legalName" className="text-right text-xs">Legal Name</Label>
                            <Input id="legalName" className="col-span-3 h-10" value={newVendor.legalName} onChange={e => setNewVendor({...newVendor, legalName: e.target.value})} placeholder="Acme Services LLC" />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="orgId" className="text-right text-xs">Org ID</Label>
                            <Input id="orgId" className="col-span-3 h-10" value={newVendor.orgId} onChange={e => setNewVendor({...newVendor, orgId: e.target.value})} placeholder="org_1" />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="serviceAreas" className="text-right text-xs">Service Areas</Label>
                            <Input id="serviceAreas" className="col-span-3 h-10" value={newVendor.serviceAreas} onChange={e => setNewVendor({...newVendor, serviceAreas: e.target.value})} placeholder="Plumbing, Electrical" />
                          </div>
                          <div className="grid grid-cols-4 items-center gap-4">
                            <Label htmlFor="defaultCommissionBps" className="text-right text-xs">Commission (BPS)</Label>
                            <Input id="defaultCommissionBps" type="number" className="col-span-3 h-10" value={newVendor.defaultCommissionBps} onChange={e => setNewVendor({...newVendor, defaultCommissionBps: parseInt(e.target.value) || 0})} placeholder="1000 (10%)" />
                          </div>
                        </div>
                        <DialogFooter>
                          <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                          <Button onClick={() => createMutation.mutate(newVendor)} disabled={createMutation.isPending || !newVendor.legalName}>
                            {createMutation.isPending ? "Saving..." : "Add Vendor"}
                          </Button>
                        </DialogFooter>
                      </DialogContent>
                            
                            </Dialog>
                          
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Active Vendors</CardTitle>
            <Briefcase className="w-4 h-4 text-amber-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">482</div>
            <p className="text-xs text-green-400 mt-1">+15 this month</p>
          </CardContent>
        </Card>
        
        <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Active Work Orders</CardTitle>
            <Wrench className="w-4 h-4 text-slate-500 dark:text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">1,204</div>
            <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">Across all properties</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Compliance Rate</CardTitle>
            <ShieldCheck className="w-4 h-4 text-green-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">96.5%</div>
            <p className="text-xs text-slate-500 dark:text-slate-400 mt-1">Insurance & Licenses</p>
          </CardContent>
        </Card>
      </div>

      <Card className="bg-white/5 border-slate-200 dark:border-white/10 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="text-slate-900 dark:text-white">{t("admin.vendors.list", "Vendor Network")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex items-center justify-center py-20 text-slate-500 dark:text-slate-400">
            {t("common.loading", "Loading vendor network...")}
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default VendorsManagement;
