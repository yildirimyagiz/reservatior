"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Progress } from "@/components/ui/progress";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Building2, Users, Settings, TrendingUp, Search, Plus, MoreVertical, Shield, CreditCard, Activity, ArrowUpRight, MapPin, Mail, Filter, Download } from "lucide-react";
import { m } from "framer-motion";
const kpis = [{
  label: t("client.src.total_organizations"),
  value: "124",
  change: "+12",
  trend: "up",
  icon: Building2,
  color: "text-blue-400",
  bg: "bg-blue-500/10"
}, {
  label: t("client.src.active_users"),
  value: "4,821",
  change: "+148",
  trend: "up",
  icon: Users,
  color: "text-emerald-400",
  bg: "bg-emerald-500/10"
}, {
  label: t("client.src.total_properties"),
  value: "1,205",
  change: "+45",
  trend: "up",
  icon: TrendingUp,
  color: "text-purple-400",
  bg: "bg-purple-500/10"
}, {
  label: t("client.src.monthly_mrr"),
  value: "$142.5K",
  change: "+$8.2K",
  trend: "up",
  icon: Activity,
  color: "text-amber-400",
  bg: "bg-amber-500/10"
}];
const organizations = [{
  id: "ORG-001",
  name: "Sunset Properties LLC",
  type: "Real Estate Agency",
  status: "active",
  users: 45,
  maxUsers: 50,
  properties: 89,
  joinedDate: "2023-11-12",
  plan: "Enterprise",
  location: "Miami, FL",
  mrr: "$4,500"
}, {
  id: "ORG-002",
  name: "Ocean View Management",
  type: "Property Management",
  status: "active",
  users: 23,
  maxUsers: 25,
  properties: 156,
  joinedDate: "2024-01-05",
  plan: "Pro",
  location: "San Diego, CA",
  mrr: "$2,200"
}, {
  id: "ORG-003",
  name: "Urban Investments Inc",
  type: "Investment Firm",
  status: "pending",
  users: 12,
  maxUsers: 15,
  properties: 34,
  joinedDate: "2024-03-20",
  plan: "Starter",
  location: "New York, NY",
  mrr: "$850"
}, {
  id: "ORG-004",
  name: "Luxe Living Realtors",
  type: "Boutique Agency",
  status: "suspended",
  users: 8,
  maxUsers: 15,
  properties: 42,
  joinedDate: "2023-08-14",
  plan: "Starter",
  location: "Austin, TX",
  mrr: "$0"
}, {
  id: "ORG-005",
  name: "Global Asset Group",
  type: "Enterprise",
  status: "active",
  users: 142,
  maxUsers: 200,
  properties: 450,
  joinedDate: "2022-05-10",
  plan: "Enterprise Plus",
  location: "Chicago, IL",
  mrr: "$12,400"
}, {
  id: "ORG-006",
  name: "Pioneer Realty",
  type: "Real Estate Agency",
  status: "active",
  users: 18,
  maxUsers: 25,
  properties: 67,
  joinedDate: "2024-02-18",
  plan: "Pro",
  location: "Denver, CO",
  mrr: "$1,850"
}, {
  id: "ORG-007",
  name: "Horizon Developments",
  type: "Developer",
  status: "active",
  users: 34,
  maxUsers: 50,
  properties: 112,
  joinedDate: "2023-09-02",
  plan: "Enterprise",
  location: "Seattle, WA",
  mrr: "$3,800"
}];
export default function Organizations() {
  const {
    t
  } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  return <div className="p-4 md:p-8 space-y-8 max-w-(--breakpoint-2xl) mx-auto">
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight flex items-center gap-3">
            <div className="p-2 rounded-xl bg-primary/10">
              <Building2 className="w-7 h-7 text-primary" />
            </div>{t("client.src.organizations")}</h1>
          <p className="text-muted-foreground mt-1">{t("client.src.manage_tenants_agencies_and")}</p>
        </div>
        <div className="flex items-center gap-3">
          <Button variant="outline" className="border-white/10 hidden sm:flex">
            <Download className="w-4 h-4 mr-2" />{t("client.src.export")}</Button>
          <Button className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
            <Plus className="w-4 h-4 mr-2" />{t("client.src.new_organization")}</Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map(kpi => <m.div key={kpi.label} initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        delay: 0.08
      }}>
            <Card className="border-white/5 bg-secondary/20 backdrop-blur-xl hover:bg-secondary/30 transition-all rounded-2xl group">
              <CardContent className="p-6">
                <div className="flex justify-between items-start mb-4">
                  <div className={`p-3 rounded-xl ${kpi.bg} ${kpi.color} group-hover:scale-110 transition-transform`}>
                    <kpi.icon className="h-6 w-6" />
                  </div>
                  <Badge variant="secondary" className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 rounded-full">
                    <ArrowUpRight className="h-3 w-3 mr-1" />
                    {kpi.change}
                  </Badge>
                </div>
                <p className="text-sm text-muted-foreground font-medium">{kpi.label}</p>
                <h3 className="text-2xl font-bold mt-1">{kpi.value}</h3>
              </CardContent>
            </Card>
          </m.div>)}
      </div>

      {/* Main Content */}
      <Card className="border-white/5 bg-secondary/10 rounded-2xl overflow-hidden">
        <CardHeader className="border-b border-white/5 pb-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
            <CardTitle className="text-xl">{t("client.src.organization_directory")}</CardTitle>
            <div className="flex items-center gap-2">
              <div className="relative w-full sm:w-64">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                <Input placeholder={t("client.src.search_organizations")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-9 bg-background/50 border-white/10 w-full" />
              </div>
              <Button variant="outline" size="icon" className="border-white/10 shrink-0">
                <Filter className="w-4 h-4" />
              </Button>
            </div>
          </div>
        </CardHeader>
        <CardContent className="p-0">
          <div className="overflow-x-auto">
            <Table>
              <TableHeader className="bg-secondary/20 hover:bg-secondary/20">
                <TableRow className="border-white/5">
                  <TableHead className="w-[300px]">{t("client.src.organization")}</TableHead>
                  <TableHead>{t("client.src.status_plan")}</TableHead>
                  <TableHead>{t("client.src.users_subs")}</TableHead>
                  <TableHead>{t("client.src.properties")}</TableHead>
                  <TableHead className="text-right">{t("client.src.monthly_mrr")}</TableHead>
                  <TableHead className="w-[50px]"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {organizations.map(org => {
                const usagePercent = Math.round(org.users / org.maxUsers * 100);
                return <TableRow key={org.id} className="border-white/5 hover:bg-secondary/20 transition-colors">
                      <TableCell>
                        <div className="flex flex-col">
                          <span className="font-semibold text-base">{org.name}</span>
                          <span className="text-xs text-muted-foreground flex items-center gap-1 mt-0.5">
                            <MapPin className="w-3 h-3" /> {org.location} • {org.type}
                          </span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex flex-col gap-1.5 items-start">
                          <Badge variant="outline" className={`text-[10px]  tracking-wider ${org.status === 'active' ? 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20' : org.status === 'pending' ? 'bg-amber-500/10 text-amber-400 border-amber-500/20' : 'bg-red-500/10 text-red-400 border-red-500/20'}`}>
                            {org.status}
                          </Badge>
                          <span className="text-xs font-medium px-2 py-0.5 rounded-md bg-secondary/50 border border-white/5">
                            {org.plan}
                          </span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="space-y-1.5 w-32">
                          <div className="flex items-center justify-between text-xs">
                            <span className="font-medium text-foreground">{org.users}</span>
                            <span className="text-muted-foreground capitalize">/ {org.maxUsers}{t("client.src.max")}</span>
                          </div>
                          <Progress value={usagePercent} className={`h-1.5 bg-secondary [&>div]:${usagePercent > 90 ? 'bg-red-500' : usagePercent > 75 ? 'bg-amber-500' : 'bg-primary'}`} />
                        </div>
                      </TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <Building2 className="w-4 h-4 text-muted-foreground" />
                          <span className="font-medium">{org.properties}</span>
                        </div>
                      </TableCell>
                      <TableCell className="text-right">
                        <span className="font-bold text-emerald-400">{org.mrr}</span>
                      </TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="icon" className="h-8 w-8 hover:bg-white/10">
                              <MoreVertical className="w-4 h-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="w-48">
                            <DropdownMenuLabel>{t("client.src.actions")}</DropdownMenuLabel>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem className="cursor-pointer">
                              <Settings className="w-4 h-4 mr-2" />{t("client.src.view_details")}</DropdownMenuItem>
                            <DropdownMenuItem className="cursor-pointer">
                              <Users className="w-4 h-4 mr-2" />{t("client.src.manage_users")}</DropdownMenuItem>
                            <DropdownMenuItem className="cursor-pointer">
                              <CreditCard className="w-4 h-4 mr-2" />{t("client.src.billing_information")}</DropdownMenuItem>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem className="cursor-pointer text-amber-500 focus:text-amber-500">
                              <Shield className="w-4 h-4 mr-2" />{t("client.src.suspend_account")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
              })}
              </TableBody>
            </Table>
          </div>
        </CardContent>
      </Card>
      
      {/* Metrics Section */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
        <Card className="border-white/5 bg-secondary/10 rounded-2xl p-6">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-semibold">{t("client.src.top_plans")}</h3>
            <Badge variant="outline" className="border-white/10 border bg-background/50">{t("client.src.current")}</Badge>
          </div>
          <div className="space-y-4">
            {[{
            name: "Pro",
            count: 68,
            percent: 55,
            color: "bg-blue-500"
          }, {
            name: "Enterprise",
            count: 32,
            percent: 26,
            color: "bg-purple-500"
          }, {
            name: "Starter",
            count: 20,
            percent: 16,
            color: "bg-emerald-500"
          }, {
            name: "Enterprise Plus",
            count: 4,
            percent: 3,
            color: "bg-amber-500"
          }].map(plan => <div key={plan.name} className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span className="font-medium text-muted-foreground">{plan.name}</span>
                  <div className="space-x-2">
                    <span className="font-bold">{plan.count}</span>
                    <span className="text-muted-foreground text-xs">({plan.percent}%)</span>
                  </div>
                </div>
                <div className="h-2 w-full bg-secondary rounded-full overflow-hidden">
                  <div className={`h-full ${plan.color} rounded-full`} style={{
                width: `${plan.percent}%`
              }} />
                </div>
              </div>)}
          </div>
        </Card>
        
        <Card className="border-white/5 bg-secondary/10 rounded-2xl p-6 flex flex-col items-center justify-center text-center">
          <div className="w-16 h-16 rounded-2xl bg-primary/20 flex items-center justify-center mb-4">
            <Mail className="w-8 h-8 text-primary" />
          </div>
          <h3 className="text-xl font-bold mb-2">{t("client.src.need_to_contact_everyone")}</h3>
          <p className="text-muted-foreground text-sm max-w-sm mb-6">{t("client.src.send_a_global_broadcast")}</p>
          <Button className="w-full sm:w-auto">{t("client.src.compose_global_broadcast")}</Button>
        </Card>
      </div>
    </div>;
}