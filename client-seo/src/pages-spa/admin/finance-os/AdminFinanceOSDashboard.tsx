"use client";

import { useTranslation } from "react-i18next";
import { DollarSign, TrendingUp, CreditCard, Wallet, ArrowUpRight, AlertCircle, CheckCircle, Clock } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
} from "recharts";

const DEMO_REVENUE = [
  { month: "Jan", revenue: 45000, expenses: 32000, profit: 13000 },
  { month: "Feb", revenue: 52000, expenses: 34000, profit: 18000 },
  { month: "Mar", revenue: 48000, expenses: 33000, profit: 15000 },
  { month: "Apr", revenue: 61000, expenses: 38000, profit: 23000 },
  { month: "May", revenue: 55000, expenses: 36000, profit: 19000 },
  { month: "Jun", revenue: 67000, expenses: 40000, profit: 27000 },
];

const PENDING_COMMISSIONS = [
  { id: 1, agent: "John Smith", amount: 12500, status: "pending", dueDate: "2024-01-20" },
  { id: 2, agent: "Sarah Johnson", amount: 9800, status: "processing", dueDate: "2024-01-18" },
  { id: 3, agent: "Mike Davis", amount: 4500, status: "pending", dueDate: "2024-01-22" },
  { id: 4, agent: "Emily Brown", amount: 14200, status: "approved", dueDate: "2024-01-17" },
];

export default function AdminFinanceOSDashboard() {
  const { t } = useTranslation();

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(val);

  const kpis = [
    { title: "Total Revenue", value: formatCurrency(328000), icon: DollarSign, color: "text-emerald-500", trend: "+12.5% vs last quarter" },
    { title: "Total Expenses", value: formatCurrency(213000), icon: CreditCard, color: "text-red-400", trend: "+8.3% vs last quarter" },
    { title: "Net Profit", value: formatCurrency(115000), icon: TrendingUp, color: "text-blue-400", trend: "+18.7% vs last quarter" },
    { title: "Pending Commissions", value: formatCurrency(41000), icon: Wallet, color: "text-purple-400", trend: "4 pending payouts" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Finance OS Management</h1>
          <p className="text-slate-400 mt-1">Financial operations, commissions, and revenue management</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <DollarSign className="h-4 w-4 mr-2" />
          Process Payouts
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1">{kpi.trend}</p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <Tabs defaultValue="overview" className="space-y-4">
        <TabsList className="bg-slate-900/60 border-slate-800">
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="commissions">Commissions</TabsTrigger>
          <TabsTrigger value="revenue">Revenue</TabsTrigger>
          <TabsTrigger value="expenses">Expenses</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100 flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-emerald-400" />
                  Revenue vs Expenses (6 months)
                </CardTitle>
                <CardDescription className="text-slate-400">
                  Monthly financial performance overview
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="h-[260px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={DEMO_REVENUE} margin={{ top: 5, right: 10, left: -20, bottom: 0 }}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                      <XAxis dataKey="month" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                      <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} tickFormatter={(v) => `$${v >= 1000 ? (v/1000).toFixed(0)+"k" : v}`} />
                      <Tooltip
                        contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                        formatter={(v: any) => formatCurrency(Number(v ?? 0))}
                      />
                      <Bar dataKey="revenue" fill="#10b981" radius={[4, 4, 0, 0]} opacity={0.85} />
                      <Bar dataKey="expenses" fill="#ef4444" radius={[4, 4, 0, 0]} opacity={0.6} />
                      <Bar dataKey="profit" fill="#3b82f6" radius={[4, 4, 0, 0]} opacity={0.8} />
                    </BarChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100">Pending Commissions</CardTitle>
                <CardDescription className="text-slate-400">
                  Commission payouts awaiting processing
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {PENDING_COMMISSIONS.map((commission) => (
                    <div key={commission.id} className="flex items-center justify-between p-3 rounded-lg bg-slate-800/50 border border-slate-700">
                      <div className="flex items-center gap-3">
                        <div className={`w-2 h-2 rounded-full ${
                          commission.status === 'approved' ? 'bg-emerald-400' :
                          commission.status === 'processing' ? 'bg-blue-400' :
                          'bg-yellow-400'
                        }`} />
                        <div>
                          <p className="text-sm font-medium text-slate-200">{commission.agent}</p>
                          <p className="text-xs text-slate-500">Due: {commission.dueDate}</p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-sm font-bold text-slate-100">{formatCurrency(commission.amount)}</p>
                        <Badge variant={
                          commission.status === 'approved' ? 'default' :
                          commission.status === 'processing' ? 'secondary' :
                          'outline'
                        } className="text-xs">
                          {commission.status}
                        </Badge>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="commissions">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Commission Management</CardTitle>
              <CardDescription className="text-slate-400">
                Manage agent commissions and payout schedules
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Wallet className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Commission management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="revenue">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Revenue Analytics</CardTitle>
              <CardDescription className="text-slate-400">
                Detailed revenue breakdown and forecasting
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <DollarSign className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Revenue analytics interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="expenses">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Expense Management</CardTitle>
              <CardDescription className="text-slate-400">
                Track and categorize operational expenses
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <CreditCard className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Expense management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
