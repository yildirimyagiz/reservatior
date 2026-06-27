import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
import { BadgeCheck, Plus, UserCircle, Star, Target } from 'lucide-react';
import { Button } from "@/components/ui/button";

const AgentsManagement = () => {
  const { t } = useTranslation();

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-linear-to-r from-purple-400 to-pink-400">
            {t("admin.agents.title", "Agent Management")}
          </h1>
          <p className="text-slate-400 mt-2">
            {t("admin.agents.subtitle", "Monitor agent performance, licenses, and operational status")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-white/10 hover:bg-white/10">
            {t("common.export", "Export")}
          </Button>
          <Button className="bg-purple-600 hover:bg-purple-700 text-white shadow-lg shadow-purple-500/20">
            <Plus className="w-4 h-4 mr-2" />
            {t("admin.agents.add", "Invite Agent")}
          </Button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Total Agents</CardTitle>
            <UserCircle className="w-4 h-4 text-purple-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">1,240</div>
            <p className="text-xs text-green-400 mt-1">+45 active</p>
          </CardContent>
        </Card>
        
        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">Top Performers</CardTitle>
            <Star className="w-4 h-4 text-amber-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">12%</div>
            <p className="text-xs text-slate-400 mt-1">Exceeding targets</p>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">License Verification</CardTitle>
            <BadgeCheck className="w-4 h-4 text-green-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-white">99.2%</div>
            <p className="text-xs text-slate-400 mt-1">Fully verified</p>
          </CardContent>
        </Card>
      </div>

      <Card className="bg-white/5 border-white/10 backdrop-blur-sm">
        <CardHeader>
          <CardTitle className="text-white">{t("admin.agents.list", "Agent Roster")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex items-center justify-center py-20 text-slate-400">
            {t("common.loading", "Loading agent records...")}
          </div>
        </CardContent>
      </Card>
    </div>
  );
};

export default AgentsManagement;
