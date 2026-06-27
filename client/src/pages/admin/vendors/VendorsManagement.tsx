import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { Wrench, Plus, Briefcase, Truck, ShieldCheck } from 'lucide-react';
import { Button } from "@/components/ui/button";

const VendorsManagement = () => {
  const { t } = useTranslation();

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-linear-to-r from-amber-400 to-orange-400">
            {t("admin.vendors.title", "Vendor Management")}
          </h1>
          <p className="text-slate-400 mt-2">
            {t("admin.vendors.subtitle", "Manage service providers, contractors, and maintenance teams")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-white/10 hover:bg-white/10">
            {t("common.export", "Export")}
          </Button>
          <Button className="bg-amber-600 hover:bg-amber-700 text-white shadow-lg shadow-amber-500/20">
            <Plus className="w-4 h-4 mr-2" />
            {t("admin.vendors.add", "Add Vendor")}
          </Button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Active Vendors</CardTitle>
            <Briefcase className="w-4 h-4 text-amber-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">482</div>
            <p className="text-xs text-green-400 mt-1">+15 this month</p>
          </CardContent>
        </Card>
        
        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Active Work Orders</CardTitle>
            <Wrench className="w-4 h-4 text-blue-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">1,204</div>
            <p className="text-xs text-slate-400 mt-1">Across all properties</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Compliance Rate</CardTitle>
            <ShieldCheck className="w-4 h-4 text-green-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">96.5%</div>
            <p className="text-xs text-slate-400 mt-1">Insurance & Licenses</p>
          </CardContent>
        </Card>
      </div>

      <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="text-white">{t("admin.vendors.list", "Vendor Network")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex items-center justify-center py-20 text-slate-400">
            {t("common.loading", "Loading vendor network...")}
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default VendorsManagement;
