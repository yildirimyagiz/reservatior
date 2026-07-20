"use client";

import { useTranslation } from "react-i18next";
import { Bell, Mail, MessageSquare, Smartphone, CheckCircle, Clock, AlertCircle, Users, Settings, TrendingUp } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { motion } from "framer-motion";

const CHANNELS = [
  { id: 1, name: "Email", icon: Mail, status: "active", sent: 1247, delivered: 1189, failed: 58 },
  { id: 2, name: "SMS", icon: Smartphone, status: "active", sent: 456, delivered: 432, failed: 24 },
  { id: 3, name: "In-App", icon: Bell, status: "active", sent: 2341, delivered: 2341, failed: 0 },
  { id: 4, name: "WhatsApp", icon: MessageSquare, status: "inactive", sent: 0, delivered: 0, failed: 0 },
];

const RULES = [
  { id: 1, name: "Booking Confirmation", eventType: "booking.created", status: "active", triggers: 45 },
  { id: 2, name: "Payment Reminder", eventType: "payment.due", status: "active", triggers: 128 },
  { id: 3, name: "Review Request", eventType: "booking.completed", status: "paused", triggers: 67 },
];

const RECENT_NOTIFICATIONS = [
  { id: 1, type: "email", recipient: "john@example.com", subject: "Booking Confirmed", status: "delivered", sentAt: "2024-01-15 10:30" },
  { id: 2, type: "sms", recipient: "+1234567890", subject: "Payment Reminder", status: "delivered", sentAt: "2024-01-15 09:15" },
  { id: 3, type: "in_app", recipient: "user_123", subject: "New Message", status: "pending", sentAt: "2024-01-15 08:45" },
];

export default function AdminNotificationOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: "Total Sent", value: 4044, icon: Bell, color: "text-emerald-500", trend: "+18% this week" },
    { title: "Delivery Rate", value: "96.2%", icon: CheckCircle, color: "text-blue-400", trend: "+2.1% vs last week" },
    { title: "Active Rules", value: 24, icon: Settings, color: "text-purple-400", trend: "+3 new this month" },
    { title: "Failed", value: 82, icon: AlertCircle, color: "text-red-400", trend: "-12% improvement" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Notification OS Management</h1>
          <p className="text-slate-400 mt-1">Multi-channel notification delivery and automation</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <Bell className="h-4 w-4 mr-2" />
          Send Notification
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <motion.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
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
          </motion.div>
        ))}
      </div>

      <Tabs defaultValue="channels" className="space-y-4">
        <TabsList className="bg-slate-900/60 border-slate-800">
          <TabsTrigger value="channels">Channels</TabsTrigger>
          <TabsTrigger value="rules">Rules</TabsTrigger>
          <TabsTrigger value="templates">Templates</TabsTrigger>
          <TabsTrigger value="history">History</TabsTrigger>
        </TabsList>

        <TabsContent value="channels" className="space-y-4">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Notification Channels</CardTitle>
              <CardDescription className="text-slate-400">
                Delivery status by channel
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {CHANNELS.map((channel) => (
                  <div key={channel.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <channel.icon className={`h-5 w-5 ${channel.status === 'active' ? 'text-emerald-400' : 'text-slate-500'}`} />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{channel.name}</p>
                        <p className="text-xs text-slate-500">Sent: {channel.sent} • Delivered: {channel.delivered} • Failed: {channel.failed}</p>
                      </div>
                    </div>
                    <Badge variant={channel.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {channel.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="rules">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Notification Rules</CardTitle>
              <CardDescription className="text-slate-400">
                Automated notification triggers
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {RULES.map((rule) => (
                  <div key={rule.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Settings className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{rule.name}</p>
                        <p className="text-xs text-slate-500">{rule.eventType} • {rule.triggers} triggers</p>
                      </div>
                    </div>
                    <Badge variant={rule.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {rule.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="templates">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Notification Templates</CardTitle>
              <CardDescription className="text-slate-400">
                Reusable notification templates
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Mail className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Template management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="history">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Notification History</CardTitle>
              <CardDescription className="text-slate-400">
                Recent notification deliveries
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {RECENT_NOTIFICATIONS.map((notif) => (
                  <div key={notif.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Bell className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{notif.subject}</p>
                        <p className="text-xs text-slate-500">{notif.recipient} • {notif.sentAt}</p>
                      </div>
                    </div>
                    <Badge variant={notif.status === 'delivered' ? 'default' : 'secondary'} className="text-xs">
                      {notif.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
