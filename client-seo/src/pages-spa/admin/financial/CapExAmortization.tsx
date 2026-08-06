import React from 'react';
import { m } from 'framer-motion';
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
        <h1 className="text-3xl font-black text-muted-foreground dark:text-white tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_auto_zero_capex_amortization", "Sıfır Sermaye Harcaması Amortismanı")}</h1>
        <p className="text-muted-foreground dark:text-muted-foreground mt-1">{t("admin_auto_track_furniture_investments_automatic_re", "Mobilya yatırımlarını, otomatik kira kesintilerini ve başabaş noktalarını takip edin.")}</p>
      </div>

      {/* Top Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card className="border-none shadow-sm dark:bg-card/50 bg-gradient-to-br from-blue-600 to-blue-800 text-white">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-card/20 rounded-lg"><Briefcase className="w-5 h-5 text-white" /></div>
              <span className="px-2 py-1 bg-card/20 rounded text-xs font-bold">{t("admin_investors_portfolio", "Portföy")}</span>
            </div>
            <p className="text-blue-100 text-sm font-medium mb-1">{t("admin_auto_total_capex_deployed", "Dağıtılan Toplam Sermaye Harcaması")}</p>
            <h3 className="text-3xl font-black">$42,000</h3>
          </CardContent>
        </Card>

        <Card className="border-none shadow-sm dark:bg-card/50">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-blue-100 dark:bg-blue-900/30 rounded-lg"><PiggyBank className="w-5 h-5 text-blue-600 dark:text-blue-400" /></div>
            </div>
            <p className="text-muted-foreground dark:text-muted-foreground text-sm font-medium mb-1">{t("admin_auto_capital_recovered", "Geri Kazanılan Sermaye")}</p>
            <h3 className="text-3xl font-black">$31,200</h3>
            <p className="text-xs text-success font-bold mt-2">{t("admin_auto_74_2_amortized", "%74,2 Amortisman")}</p>
          </CardContent>
        </Card>

        <Card className="border-none shadow-sm dark:bg-card/50">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-amber-100 dark:bg-amber-900/30 rounded-lg"><TrendingUp className="w-5 h-5 text-amber-600 dark:text-warning" /></div>
            </div>
            <p className="text-muted-foreground dark:text-muted-foreground text-sm font-medium mb-1">{t("admin_auto_avg_break_even_time", "Ortalama Başabaş Süresi")}</p>
            <h3 className="text-3xl font-black">{t("admin_auto_8_4_mo", "8,4 ay")}</h3>
            <p className="text-xs text-amber-500 font-bold mt-2">{t("admin_auto_industry_avg_24_mo", "Sektör ortalaması: 24 ay")}</p>
          </CardContent>
        </Card>

        <Card className="border-none shadow-sm dark:bg-card/50">
          <CardContent className="p-6">
            <div className="flex justify-between items-start mb-4">
              <div className="p-2 bg-brand/15 dark:bg-brand/30 rounded-lg"><Zap className="w-5 h-5 text-brand dark:text-brand" /></div>
            </div>
            <p className="text-muted-foreground dark:text-muted-foreground text-sm font-medium mb-1">{t("admin_auto_owner_roi", "Sahip YG'si")}</p>
            <h3 className="text-3xl font-black">13.4%</h3>
            <p className="text-xs text-brand font-bold mt-2">{t("admin_auto_post_amortization", "Amortisman Sonrası")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        {/* Main Chart */}
        <Card className="lg:col-span-2 border-none shadow-sm dark:bg-card/50">
          <CardHeader>
            <CardTitle>{t("admin_auto_capex_payback_trajectory_lakeview_suite", "Sermaye Harcaması Geri Ödeme Yörüngesi (Lakeview Suite)")}</CardTitle>
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
                <AlertCircle className="w-5 h-5 text-blue-600 dark:text-info" />
                <div>
                  <p className="text-sm font-bold text-blue-900 dark:text-blue-300">{t("admin_auto_break_even_reached_in_september", "Eylül'de Başabaş Noktasına Ulaşıldı")}</p>
                  <p className="text-xs text-blue-800/80 dark:text-blue-200/70">{t("admin_auto_from_october_onwards_100_of_the_rent_dis", "Ekim ayından itibaren kira dağıtımının %100'ü ev sahibine gidiyor.")}</p>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Portfolio Status */}
        <Card className="border-none shadow-sm dark:bg-card/50">
          <CardHeader>
            <CardTitle>{t("admin_dashboard_action_properties", "Mülkler")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {PORTFOLIO_PROPERTIES.map((prop, i) => (
              <div key={i} className="p-4 rounded-xl border border-slate-100 dark:border-border hover:bg-muted dark:hover:bg-muted/50 transition-colors">
                <div className="flex justify-between items-start mb-3">
                  <div>
                    <h4 className="font-bold text-sm">{prop.name}</h4>
                    <p className="text-xs text-muted-foreground mt-0.5">{prop.status}</p>
                  </div>
                  <span className="text-xs font-bold text-success bg-blue-50 dark:bg-blue-900/20 px-2 py-1 rounded">
                    {prop.returnRate} {t("admin_financial_roi", "Yatırım Getirisi (Roi)")}</span>
                </div>
                <div className="space-y-1.5">
                  <div className="flex justify-between text-xs">
                    <span className="text-muted-foreground">{t("admin_auto_recovered", "Kurtarılan: $")}{prop.paid.toLocaleString()}</span>
                    <span className="text-muted-foreground dark:text-white font-bold">{t("admin_auto_total", "Toplam: $")}{prop.cost.toLocaleString()}</span>
                  </div>
                  <div className="w-full h-1.5 bg-muted dark:bg-muted rounded-full overflow-hidden">
                    <div 
                      className={`h-full rounded-full ${prop.paid === prop.cost ? 'bg-blue-500' : 'bg-blue-500'}`} 
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
