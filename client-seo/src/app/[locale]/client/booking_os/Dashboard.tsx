"use client";

import React from "react";

import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Calendar, LogIn, LogOut, DollarSign, Key, ShieldAlert, CheckCircle2 } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { bookingOSApi } from "@/lib/api/booking-os";
import { useAuth } from "@/lib/auth";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from "recharts";
import { format } from "date-fns";
import { TenantInstallmentPlans } from "./TenantInstallmentPlans";
import { useTranslation } from "react-i18next";
import { useLocalization } from "@/contexts/LocalizationContext";

export default function BookingDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  
  const { data: statsData, isLoading: isLoadingStats } = useQuery({
    queryKey: ["booking-os-dashboard", user?.orgId],
    queryFn: () => bookingOSApi.getDashboardStats(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const { data: feedData, isLoading: isLoadingFeed } = useQuery({
    queryKey: ["booking-os-feed", user?.orgId],
    queryFn: () => bookingOSApi.getLiveFeed(user?.orgId || ""),
    enabled: !!user?.orgId,
    refetchInterval: 30000, // refresh every 30s
  });

  const { data: pricingData, isLoading: isLoadingPricing } = useQuery({
    queryKey: ["booking-os-pricing", user?.orgId],
    queryFn: () => bookingOSApi.getPricingData(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalActiveBookings: 0,
    pendingCheckIns: 0,
    pendingCheckOuts: 0,
    todayRevenue: 0,
  };

  const feedItems = feedData?.data || [];
  const pricingItems = pricingData?.data || [];

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const formatPricingDate = (tickItem: string) => {
    return format(new Date(tickItem), 'MMM dd');
  };

  const { t } = useTranslation();

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight text-slate-100 dark:text-slate-100">{t("booking_os.title", { defaultValue: "Booking OS Dashboard" })}</h1>
        <p className="text-slate-500 dark:text-muted-foreground">{t("booking_os.subtitle", { defaultValue: "Reservations & Live Operations" })}</p>
      </div>
      
      <div className="grid gap-4 md:grid-cols-4">
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("booking_os.active_bookings", { defaultValue: "Active Bookings" })}</CardTitle>
            <Calendar className="h-4 w-4 text-emerald-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoadingStats ? "..." : stats.totalActiveBookings}
            </div>
            <p className="text-xs text-emerald-500 mt-1">{t("booking_os.confirmed_checked_in", { defaultValue: "Confirmed & Checked-In" })}</p>
          </CardContent>
        </Card>

        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("booking_os.pending_check_ins", { defaultValue: "Pending Check-Ins" })}</CardTitle>
            <LogIn className="h-4 w-4 text-blue-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoadingStats ? "..." : stats.pendingCheckIns}
            </div>
            <p className="text-xs text-slate-500 mt-1">{t("booking_os.arriving_today", { defaultValue: "Arriving today" })}</p>
          </CardContent>
        </Card>

        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("booking_os.pending_check_outs", { defaultValue: "Pending Check-Outs" })}</CardTitle>
            <LogOut className="h-4 w-4 text-purple-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoadingStats ? "..." : stats.pendingCheckOuts}
            </div>
            <p className="text-xs text-slate-500 mt-1">{t("booking_os.departing_today", { defaultValue: "Departing today" })}</p>
          </CardContent>
        </Card>
        
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("booking_os.todays_revenue", { defaultValue: "Today's Revenue" })}</CardTitle>
            <DollarSign className="h-4 w-4 text-emerald-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoadingStats ? "..." : formatCurrency(stats.todayRevenue)}
            </div>
            <p className="text-xs text-slate-500 mt-1">{t("booking_os.from_financial_records", { defaultValue: "From Financial Records" })}</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800 flex flex-col">
          <CardHeader>
            <CardTitle className="text-slate-900 dark:text-slate-100">{t("booking_os.live_ops_feed", { defaultValue: "Live Operations Feed" })}</CardTitle>
            <CardDescription className="text-slate-500 dark:text-slate-400">{t("booking_os.live_ops_feed_desc", { defaultValue: "Real-time status updates from smart locks and property IoT." })}</CardDescription>
          </CardHeader>
          <CardContent className="flex-1 overflow-auto max-h-[400px]">
             {isLoadingFeed ? (
               <div className="text-center text-slate-500 py-8 text-sm">{t("booking_os.loading_feed", { defaultValue: "Loading feed..." })}</div>
             ) : feedItems.length === 0 ? (
               <div className="text-center text-slate-500 py-8 text-sm">{t("booking_os.no_live_ops", { defaultValue: "No live operations today." })}</div>
             ) : (
               <div className="space-y-4">
                 {feedItems.map((item: any) => (
                   <div key={item.id} className="flex items-start space-x-4 border-b border-slate-100 dark:border-slate-800 pb-4 last:border-0 last:pb-0">
                     <div className={`p-2 rounded-full ${item.status === 'FAILED' ? 'bg-red-100 dark:bg-red-900/30 text-red-500' : 'bg-emerald-100 dark:bg-emerald-900/30 text-emerald-500'}`}>
                       {item.status === 'FAILED' ? <ShieldAlert className="w-4 h-4" /> : item.action === 'UNLOCK' ? <Key className="w-4 h-4" /> : <CheckCircle2 className="w-4 h-4" />}
                     </div>
                     <div className="flex-1 space-y-1">
                       <p className="text-sm font-medium leading-none text-slate-900 dark:text-slate-100">
                         {item.smartLock?.property?.title || t("booking_os.property", { defaultValue: "Property" })} - {item.action} {item.method}
                       </p>
                       <p className="text-sm text-slate-500 dark:text-slate-400">
                         {item.notes || (item.status === 'SUCCESS' ? t("booking_os.access_granted", { defaultValue: 'Access granted successfully.' }) : t("booking_os.access_failed", { defaultValue: 'Access attempt failed.' }))}
                       </p>
                     </div>
                     <div className="text-xs text-slate-400 whitespace-nowrap">
                       {format(new Date(item.accessedAt), 'HH:mm')}
                     </div>
                   </div>
                 ))}
               </div>
             )}
          </CardContent>
        </Card>
        
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800 flex flex-col">
          <CardHeader>
            <CardTitle className="text-slate-900 dark:text-slate-100">{t("booking_os.pricing_engine", { defaultValue: "Pricing Engine" })}</CardTitle>
            <CardDescription className="text-slate-500 dark:text-slate-400">{t("booking_os.pricing_engine_desc", { defaultValue: "AI optimized dynamic pricing trends over time." })}</CardDescription>
          </CardHeader>
          <CardContent className="flex-1 min-h-[300px]">
            {isLoadingPricing ? (
              <div className="text-center text-slate-500 py-8 text-sm">{t("booking_os.loading_pricing", { defaultValue: "Loading pricing data..." })}</div>
            ) : pricingItems.length === 0 ? (
              <div className="text-center text-slate-500 py-8 text-sm">{t("booking_os.no_pricing", { defaultValue: "No pricing data available." })}</div>
            ) : (
              <ResponsiveContainer width="100%" height={300}>
                <LineChart data={pricingItems} margin={{ top: 5, right: 10, left: -20, bottom: 0 }}>
                  <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#334155" />
                  <XAxis 
                    dataKey="targetDate" 
                    tickFormatter={formatPricingDate} 
                    stroke="#64748b" 
                    fontSize={12} 
                    tickLine={false}
                    axisLine={false}
                    minTickGap={20}
                  />
                  <YAxis 
                    stroke="#64748b" 
                    fontSize={12} 
                    tickLine={false}
                    axisLine={false}
                    tickFormatter={(val) => `$${val}`}
                  />
                  <Tooltip 
                    contentStyle={{ backgroundColor: '#0f172a', border: '1px solid #1e293b', borderRadius: '8px' }}
                    labelFormatter={(label) => format(new Date(label), 'MMM dd, yyyy')}
                  />
                  <Legend iconType="circle" wrapperStyle={{ fontSize: '12px', paddingTop: '10px' }} />
                  <Line 
                    type="monotone" 
                    dataKey="baseRate" 
                    name={t("booking_os.base_rate", { defaultValue: "Base Rate" })} 
                    stroke="#64748b" 
                    strokeWidth={2} 
                    dot={false} 
                    activeDot={{ r: 4 }} 
                  />
                  <Line 
                    type="monotone" 
                    dataKey="optimizedRate" 
                    name={t("booking_os.optimized_rate", { defaultValue: "Optimized Rate" })} 
                    stroke="#10b981" 
                    strokeWidth={2} 
                    dot={false} 
                    activeDot={{ r: 4 }} 
                  />
                </LineChart>
              </ResponsiveContainer>
            )}
          </CardContent>
        </Card>
      </div>

      <TenantInstallmentPlans />
    </div>
  );
}
