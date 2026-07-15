import React from 'react';
import { motion } from 'framer-motion';
import { DollarSign, TrendingUp, PiggyBank, Briefcase, Zap, AlertCircle } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, AreaChart, Area } from 'recharts';

// Mock Data
const AMORTIZATION_DATA = [
  { month: 'Jan', revenue: 4500, deduction: 900, remaining: 9100 },
  { month: 'Feb', revenue: 4800, deduction: 960, remaining: 8140 },
  { month: 'Mar', revenue: 5200, deduction: 1040, remaining: 7100 },
  { month: 'Apr', revenue: 5000, deduction: 1000, remaining: 6100 },
  { month: 'May', revenue: 6100, deduction: 1220, remaining: 4880 },
  { month: 'Jun', revenue: 6500, deduction: 1300, remaining: 3580 },
  { month: 'Jul', revenue: 7000, deduction: 1400, remaining: 2180 },
  { month: 'Aug', revenue: 7200, deduction: 1440, remaining: 740 },
  { month: 'Sep', revenue: 6800, deduction: 740, remaining: 0 },
  { month: 'Oct', revenue: 5500, deduction: 0, remaining: 0 },
];

const PORTFOLIO_PROPERTIES = [
  { id: '1', name: 'Seattle Penthouse', cost: 15000, paid: 15000, status: 'Fully Amortized', returnRate: '14.2%' },
  { id: '2', name: 'Lakeview Suite', cost: 8500, paid: 6200, status: 'In Progress', returnRate: '12.8%' },
  { id: '3', name: 'Downtown Loft', cost: 12000, paid: 3500, status: 'In Progress', returnRate: '15.1%' },
  { id: '4', name: 'Capitol Hill Studio', cost: 6500, paid: 6500, status: 'Fully Amortized', returnRate: '11.5%' },
];

export default function CapExAmortization() {
  const { t } = useTranslation();

  return (
    <div className="p-6 md:p-8 space-y-8 animate-in fade-in duration-500">
      
      {/* Header */}
      <div>
        <h1 className="text-3xl font-black text-slate-900 dark:text-white tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_auto_zero_capex_amortization", "Zero-CapEx Amortization")}</h1>
        <p className="text-slate-500 dark:text-slate-400 mt-1">{t("admin_auto_track_furniture_investments_automatic_re", "Track furniture investments, automatic rent deductions, and break-even points.")}</p>
      </div>

      {/* Top Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card className="border-none shadow-sm dark:bg-slate-900/50 bg-gradient-to-br from-blue-600 to-blue-800 text-white">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-white/20 rounded-lg"><Briefcase className="w-5 h-5 text-white" /></div>
              <span className="px-2 py-1 bg-white/20 rounded text-xs font-bold">{t("admin_investors_portfolio", "Portfolio")}</span>
            </div>
            <p className="text-blue-100 text-sm font-medium mb-1">{t("admin_auto_total_capex_deployed", "Total CapEx Deployed")}</p>
            <h3 className="text-3xl font-black">$42,000</h3>
          </CardContent>
        </Card>

        <Card className="border-none shadow-sm dark:bg-slate-900/50">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-emerald-100 dark:bg-emerald-900/30 rounded-lg"><PiggyBank className="w-5 h-5 text-emerald-600 dark:text-emerald-400" /></div>
            </div>
            <p className="text-slate-500 dark:text-slate-400 text-sm font-medium mb-1">{t("admin_auto_capital_recovered", "Capital Recovered")}</p>
            <h3 className="text-3xl font-black">$31,200</h3>
            <p className="text-xs text-emerald-500 font-bold mt-2">{t("admin_auto_74_2_amortized", "74.2% Amortized")}</p>
          </CardContent>
        </Card>

        <Card className="border-none shadow-sm dark:bg-slate-900/50">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-amber-100 dark:bg-amber-900/30 rounded-lg"><TrendingUp className="w-5 h-5 text-amber-600 dark:text-amber-400" /></div>
            </div>
            <p className="text-slate-500 dark:text-slate-400 text-sm font-medium mb-1">{t("admin_auto_avg_break_even_time", "Avg Break-Even Time")}</p>
            <h3 className="text-3xl font-black">{t("admin_auto_8_4_mo", "8.4 mo")}</h3>
            <p className="text-xs text-amber-500 font-bold mt-2">{t("admin_auto_industry_avg_24_mo", "Industry avg: 24 mo")}</p>
          </CardContent>
        </Card>

        <Card className="border-none shadow-sm dark:bg-slate-900/50">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-purple-100 dark:bg-purple-900/30 rounded-lg"><Zap className="w-5 h-5 text-purple-600 dark:text-purple-400" /></div>
            </div>
            <p className="text-slate-500 dark:text-slate-400 text-sm font-medium mb-1">{t("admin_auto_owner_roi", "Owner ROI")}</p>
            <h3 className="text-3xl font-black">13.4%</h3>
            <p className="text-xs text-purple-500 font-bold mt-2">{t("admin_auto_post_amortization", "Post-Amortization")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        {/* Main Chart */}
        <Card className="lg:col-span-2 border-none shadow-sm dark:bg-slate-900/50">
          <CardHeader>
            <CardTitle>{t("admin_auto_capex_payback_trajectory_lakeview_suite", "CapEx Payback Trajectory (Lakeview Suite)")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="h-[300px] w-full">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={AMORTIZATION_DATA} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                  <defs>
                    <linearGradient id="colorRemaining" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#ef4444" stopOpacity={0.3}/>
                      <stop offset="95%" stopColor="#ef4444" stopOpacity={0}/>
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#334155" opacity={0.2} />
                  <XAxis dataKey="month" axisLine={false} tickLine={false} tick={{ fontSize: 12 }} />
                  <YAxis axisLine={false} tickLine={false} tickFormatter={(val) => `$${val/1000}k`} tick={{ fontSize: 12 }} />
                  <Tooltip 
                    contentStyle={{ backgroundColor: 'rgba(15, 23, 42, 0.9)', borderRadius: '8px', border: 'none', color: '#fff' }}
                    itemStyle={{ color: '#fff' }}
                  />
                  <Area type="monotone" dataKey="remaining" stroke="#ef4444" strokeWidth={3} fillOpacity={1} fill="url(#colorRemaining)" name="Remaining CapEx Debt" />
                </AreaChart>
              </ResponsiveContainer>
            </div>
            <div className="mt-4 flex items-center justify-between p-4 bg-blue-50 dark:bg-blue-900/10 rounded-xl border border-blue-100 dark:border-blue-900/30">
              <div className="flex items-center gap-3">
                <AlertCircle className="w-5 h-5 text-blue-600 dark:text-blue-400" />
                <div>
                  <p className="text-sm font-bold text-blue-900 dark:text-blue-300">{t("admin_auto_break_even_reached_in_september", "Break-Even Reached in September")}</p>
                  <p className="text-xs text-blue-800/80 dark:text-blue-200/70">{t("admin_auto_from_october_onwards_100_of_the_rent_dis", "From October onwards, 100% of the rent distribution goes to the owner.")}</p>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Portfolio Status */}
        <Card className="border-none shadow-sm dark:bg-slate-900/50">
          <CardHeader>
            <CardTitle>{t("admin_dashboard_action_properties", "Properties")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {PORTFOLIO_PROPERTIES.map((prop, i) => (
              <div key={i} className="p-4 rounded-xl border border-slate-100 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
                <div className="flex justify-between items-start mb-3">
                  <div>
                    <h4 className="font-bold text-sm">{prop.name}</h4>
                    <p className="text-xs text-slate-500 mt-0.5">{prop.status}</p>
                  </div>
                  <span className="text-xs font-bold text-emerald-500 bg-emerald-50 dark:bg-emerald-900/20 px-2 py-1 rounded">
                    {prop.returnRate} {t("admin_financial_roi", "ROI")}</span>
                </div>
                <div className="space-y-1.5">
                  <div className="flex justify-between text-xs">
                    <span className="text-slate-500">{t("admin_auto_recovered", "Recovered: $")}{prop.paid.toLocaleString()}</span>
                    <span className="text-slate-900 dark:text-white font-bold">{t("admin_auto_total", "Total: $")}{prop.cost.toLocaleString()}</span>
                  </div>
                  <div className="w-full h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                    <div 
                      className={`h-full rounded-full ${prop.paid === prop.cost ? 'bg-emerald-500' : 'bg-blue-500'}`} 
                      style={{ width: `${(prop.paid / prop.cost) * 100}%` }}
                    />
                  </div>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>

      </div>

    </div>
  );
}
