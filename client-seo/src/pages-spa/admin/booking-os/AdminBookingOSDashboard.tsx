"use client";

import { useTranslation } from "react-i18next";
import { Calendar, LogIn, LogOut, DollarSign, Key, ShieldAlert, CheckCircle, Users, TrendingUp, AlertTriangle } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend,
} from "recharts";

const DEMO_PRICING = [
  { date: "2024-01-01", baseRate: 150, optimizedRate: 180 },
  { date: "2024-01-02", baseRate: 150, optimizedRate: 175 },
  { date: "2024-01-03", baseRate: 155, optimizedRate: 190 },
  { date: "2024-01-04", baseRate: 155, optimizedRate: 185 },
  { date: "2024-01-05", baseRate: 160, optimizedRate: 200 },
  { date: "2024-01-06", baseRate: 160, optimizedRate: 195 },
  { date: "2024-01-07", baseRate: 165, optimizedRate: 210 },
];

const RECENT_BOOKINGS = [
  { id: 1, property: "Marina Residences #4B", guest: "John Doe", status: "checked-in", checkIn: "2024-01-15", checkOut: "2024-01-20" },
  { id: 2, property: "Harbour View Penthouse", guest: "Jane Smith", status: "pending", checkIn: "2024-01-16", checkOut: "2024-01-21" },
  { id: 3, property: "Westside Studio Unit 12", guest: "Bob Johnson", status: "checked-out", checkIn: "2024-01-10", checkOut: "2024-01-15" },
  { id: 4, property: "Riverside Loft Block A", guest: "Alice Brown", status: "checked-in", checkIn: "2024-01-14", checkOut: "2024-01-19" },
];

export default function AdminBookingOSDashboard() {
  const { t } = useTranslation();

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(val);

  const kpis = [
    { title: t("booking_os.active_bookings", "Aktif Rezervasyonlar"), value: 156, icon: Calendar, color: "text-success", trend: "+12 this week" },
    { title: t("booking_os.pending_check_ins", "Bekleyen Check-in'ler"), value: 23, icon: LogIn, color: "text-info", trend: "Today: 8" },
    { title: t("booking_os.pending_check_outs", "Bekleyen Check-out'lar"), value: 18, icon: LogOut, color: "text-brand", trend: "Today: 5" },
    { title: t("booking_os.todays_revenue", "Today's Revenue"), value: formatCurrency(12450), icon: DollarSign, color: "text-warning", trend: "+8.3% vs yesterday" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-foreground">{t("booking_os.title", "Rezervasyon OS")}</h1>
          <p className="text-muted-foreground mt-1">{t("booking_os.subtitle", "Rezervasyonlar ve Canlı Operasyonlar")}</p>
        </div>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          <Calendar className="h-4 w-4 mr-2" />
          {t("booking_os.new_booking", "New Booking")}
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-card border-border">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-foreground">{kpi.value}</div>
                <p className="text-xs text-muted-foreground mt-1">{kpi.trend}</p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <Tabs defaultValue="overview" className="space-y-4">
        <TabsList className="bg-card border-border">
          <TabsTrigger value="overview">{t("booking_os.tabs.overview", "Genel Bakış")}</TabsTrigger>
          <TabsTrigger value="bookings">{t("booking_os.tabs.bookings", "Rezervasyonlar")}</TabsTrigger>
          <TabsTrigger value="pricing">{t("booking_os.tabs.pricing", "Pricing")}</TabsTrigger>
          <TabsTrigger value="iot">{t("booking_os.tabs.iot", "IoT Cihazlar")}</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-success" />
                  {t("booking_os.pricing_engine", "Fiyatlandırma Motoru")}
                </CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("booking_os.pricing_engine_desc", "Zaman içinde AI optimize edilmiş dinamik fiyatlandırma trendleri.")}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="h-[260px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <LineChart data={DEMO_PRICING} margin={{ top: 5, right: 10, left: -20, bottom: 0 }}>
                      <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#334155" />
                      <XAxis 
                        dataKey="date" 
                        stroke="#64748b" 
                        fontSize={12} 
                        tickLine={false}
                        axisLine={false}
                        tickFormatter={(val) => new Date(val).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
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
                      />
                      <Legend iconType="circle" wrapperStyle={{ fontSize: '12px', paddingTop: '10px' }} />
                      <Line 
                        type="monotone" 
                        dataKey="baseRate" 
                        name={t("booking_os.base_rate", "Temel Oran")} 
                        stroke="#64748b" 
                        strokeWidth={2} 
                        dot={false} 
                        activeDot={{ r: 4 }} 
                      />
                      <Line 
                        type="monotone" 
                        dataKey="optimizedRate" 
                        name={t("booking_os.optimized_rate", "Optimize Edilmiş Oran")} 
                        stroke="#3b82f6" 
                        strokeWidth={2} 
                        dot={false} 
                        activeDot={{ r: 4 }} 
                      />
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground">{t("booking_os.recent_bookings", "Recent Bookings")}</CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("booking_os.latest_reservation_activity", "Latest reservation activity")}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {RECENT_BOOKINGS.map((booking) => (
                    <div key={booking.id} className="flex items-center justify-between p-3 rounded-lg bg-muted/50 border border-border">
                      <div className="flex items-center gap-3">
                        <div className={`w-2 h-2 rounded-full ${
                          booking.status === 'checked-in' ? 'bg-blue-400' :
                          booking.status === 'pending' ? 'bg-yellow-400' :
                          'bg-muted'
                        }`} />
                        <div>
                          <p className="text-sm font-medium text-foreground">{booking.property}</p>
                          <p className="text-xs text-muted-foreground">{booking.guest}</p>
                        </div>
                      </div>
                      <Badge variant={
                        booking.status === 'checked-in' ? 'default' :
                        booking.status === 'pending' ? 'secondary' :
                        'outline'
                      } className="text-xs">
                        {booking.status}
                      </Badge>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="bookings">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("booking_os.booking_management", "Rezervasyon Yönetimi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("booking_os.booking_management_desc", "Tüm rezervasyonları ve giriş/çıkış işlemlerini yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <Calendar className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("booking_os.booking_management_interface", "Rezervasyon yönetim arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="pricing">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("booking_os.pricing_configuration", "Pricing Configuration")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("booking_os.pricing_configuration_desc", "Configure dynamic pricing rules and AI optimization")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <DollarSign className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("booking_os.pricing_configuration_interface", "Pricing configuration interface")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="iot">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("booking_os.iot_device_management", "IoT Cihaz Yönetimi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("booking_os.iot_device_management_desc", "Akıllı kilitleri ve mülk IoT cihazlarını yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <Key className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("booking_os.iot_device_management_interface", "IoT cihaz yönetim arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
