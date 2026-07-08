"use client";

import React from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { DollarSign, ShieldCheck, FileText } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { financeOSApi } from "@/lib/api/finance-os";
import { useAuth } from "@/lib/auth";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from "recharts";

export default function FinanceDashboard() {
  const { user } = useAuth();
  
  const { data: statsData, isLoading } = useQuery({
    queryKey: ["finance-os-dashboard", user?.orgId],
    queryFn: () => financeOSApi.getDashboardStats(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalEscrowValue: 0,
    pendingPayouts: 0,
    activeContracts: 0,
    recentTransactions: [],
    chartData: []
  };

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(val);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight text-slate-100">Finance OS Dashboard</h1>
        <p className="text-muted-foreground">Settlement Truth & Escrow Management</p>
      </div>
      
      <div className="grid gap-4 md:grid-cols-3">
        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-400">Total Escrow Value</CardTitle>
            <ShieldCheck className="h-4 w-4 text-emerald-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-100">
              {isLoading ? "..." : formatCurrency(stats.totalEscrowValue)}
            </div>
            <p className="text-xs text-emerald-500 mt-1">Locked in smart contracts</p>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-400">Pending Payouts</CardTitle>
            <DollarSign className="h-4 w-4 text-blue-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-100">
              {isLoading ? "..." : formatCurrency(stats.pendingPayouts)}
            </div>
            <p className="text-xs text-emerald-500 mt-1">Ready for settlement</p>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-400">Active Contracts</CardTitle>
            <FileText className="h-4 w-4 text-purple-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-100">
              {isLoading ? "..." : stats.activeContracts}
            </div>
            <p className="text-xs text-slate-400 mt-1">State machine currently active</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">Revenue Execution Stream</CardTitle>
            <CardDescription className="text-slate-400">Real-time settlement data feeding from the DAG.</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[200px] w-full mt-4">
              {stats.chartData && stats.chartData.length > 0 ? (
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={stats.chartData} margin={{ top: 5, right: 20, bottom: 5, left: 0 }}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
                    <XAxis dataKey="name" stroke="#94a3b8" fontSize={12} tickLine={false} axisLine={false} />
                    <YAxis stroke="#94a3b8" fontSize={12} tickLine={false} axisLine={false} tickFormatter={(value) => `$${value}`} />
                    <Tooltip contentStyle={{ backgroundColor: '#0f172a', borderColor: '#1e293b' }} itemStyle={{ color: '#10b981' }} />
                    <Line type="monotone" dataKey="amount" stroke="#10b981" strokeWidth={2} dot={{ r: 4, fill: "#10b981", strokeWidth: 0 }} activeDot={{ r: 6 }} />
                  </LineChart>
                </ResponsiveContainer>
              ) : (
                <div className="w-full h-full flex items-center justify-center text-slate-500 text-sm">No recent chart data available.</div>
              )}
            </div>
          </CardContent>
        </Card>
        
        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">Recent Transactions</CardTitle>
            <CardDescription className="text-slate-400">Latest ledger entries and escrow releases.</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {stats.recentTransactions && stats.recentTransactions.length > 0 ? stats.recentTransactions.map((tx: any) => (
                <div key={tx.id} className="flex items-center justify-between p-3 bg-slate-800/50 rounded-lg border-l-2 border-emerald-500">
                  <div className="flex flex-col">
                    <p className="text-sm font-medium text-slate-200">Escrow Release</p>
                    <p className="text-xs text-slate-400">Contract #{tx.contractId} settled ({tx.status})</p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-emerald-400">+{formatCurrency(tx.amount)}</p>
                    <p className="text-xs text-slate-500">{new Date(tx.date).toLocaleDateString()}</p>
                  </div>
                </div>
              )) : (
                <div className="text-center text-slate-500 py-4 text-sm">No recent transactions.</div>
              )}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
