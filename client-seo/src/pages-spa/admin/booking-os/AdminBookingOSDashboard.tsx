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
    { title: "Active Bookings", value: 156, icon: Calendar, color: "text-emerald-500", trend: "+12 this week" },
    { title: "Pending Check-ins", value: 23, icon: LogIn, color: "text-blue-400", trend: "Today: 8" },
    { title: "Pending Check-outs", value: 18, icon: LogOut, color: "text-purple-400", trend: "Today: 5" },
    { title: "Today's Revenue", value: formatCurrency(12450), icon: DollarSign, color: "text-orange-400", trend: "+8.3% vs yesterday" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Booking OS Management</h1>
          <p className="text-slate-400 mt-1">Reservation operations and smart lock management</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <Calendar className="h-4 w-4 mr-2" />
          New Booking
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
          <TabsTrigger value="bookings">Bookings</TabsTrigger>
          <TabsTrigger value="pricing">Pricing</TabsTrigger>
          <TabsTrigger value="iot">IoT Devices</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100 flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-emerald-400" />
                  Pricing Engine Performance
                </CardTitle>
                <CardDescription className="text-slate-400">
                  Base vs optimized rates over time
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
                        name="Base Rate" 
                        stroke="#64748b" 
                        strokeWidth={2} 
                        dot={false} 
                        activeDot={{ r: 4 }} 
                      />
                      <Line 
                        type="monotone" 
                        dataKey="optimizedRate" 
                        name="Optimized Rate" 
                        stroke="#10b981" 
                        strokeWidth={2} 
                        dot={false} 
                        activeDot={{ r: 4 }} 
                      />
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100">Recent Bookings</CardTitle>
                <CardDescription className="text-slate-400">
                  Latest reservation activity
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {RECENT_BOOKINGS.map((booking) => (
                    <div key={booking.id} className="flex items-center justify-between p-3 rounded-lg bg-slate-800/50 border border-slate-700">
                      <div className="flex items-center gap-3">
                        <div className={`w-2 h-2 rounded-full ${
                          booking.status === 'checked-in' ? 'bg-emerald-400' :
                          booking.status === 'pending' ? 'bg-yellow-400' :
                          'bg-slate-400'
                        }`} />
                        <div>
                          <p className="text-sm font-medium text-slate-200">{booking.property}</p>
                          <p className="text-xs text-slate-500">{booking.guest}</p>
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
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Booking Management</CardTitle>
              <CardDescription className="text-slate-400">
                Manage all reservations and check-in/check-out operations
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Calendar className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Booking management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="pricing">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Pricing Configuration</CardTitle>
              <CardDescription className="text-slate-400">
                Configure dynamic pricing rules and AI optimization
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <DollarSign className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Pricing configuration interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="iot">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">IoT Device Management</CardTitle>
              <CardDescription className="text-slate-400">
                Manage smart locks and property IoT devices
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Key className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>IoT device management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
