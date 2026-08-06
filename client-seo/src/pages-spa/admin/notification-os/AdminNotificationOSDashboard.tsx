"use client";

import { useTranslation } from "react-i18next";
import { Bell, Mail, MessageSquare, Smartphone, CheckCircle, Clock, AlertCircle, Users, Settings, TrendingUp } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";

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
    { title: t("notification_os.total_sent", "Toplam Gönderilen"), value: 4044, icon: Bell, color: "text-success", trend: "+18% this week" },
    { title: t("notification_os.delivery_rate", "Teslimat Oranı"), value: "96.2%", icon: CheckCircle, color: "text-info", trend: "+2.1% vs last week" },
    { title: t("notification_os.active_rules", "Aktif Kurallar"), value: 24, icon: Settings, color: "text-brand", trend: "+3 new this month" },
    { title: t("notification_os.failed", "Başarısız"), value: 82, icon: AlertCircle, color: "text-red-400", trend: "-12% improvement" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-foreground">{t("notification_os.title", "Bildirim OS")}</h1>
          <p className="text-muted-foreground mt-1">{t("notification_os.subtitle", "notification os.subtitle")}</p>
        </div>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          <Bell className="h-4 w-4 mr-2" />
          {t("notification_os.send_notification", "Bildirim Gönder")}
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

      <Tabs defaultValue="channels" className="space-y-4">
        <TabsList className="bg-card border-border">
          <TabsTrigger value="channels">{t("notification_os.tabs.channels", "Kanallar")}</TabsTrigger>
          <TabsTrigger value="rules">{t("notification_os.tabs.rules", "Kurallar")}</TabsTrigger>
          <TabsTrigger value="templates">{t("notification_os.tabs.templates", "Şablonlar")}</TabsTrigger>
          <TabsTrigger value="history">{t("notification_os.tabs.history", "Geçmiş")}</TabsTrigger>
        </TabsList>

        <TabsContent value="channels" className="space-y-4">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("notification_os.channels", "Bildirim Kanalları")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("notification_os.channels_desc", "Kanala göre teslimat durumu")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {CHANNELS.map((channel) => (
                  <div key={channel.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <channel.icon className={`h-5 w-5 ${channel.status === 'active' ? 'text-success' : 'text-muted-foreground'}`} />
                      <div>
                        <p className="text-sm font-medium text-foreground">{channel.name}</p>
                        <p className="text-xs text-muted-foreground">{t("notification_os.sent", "Gönderildi:")} {channel.sent} • {t("notification_os.delivered", "Teslim edildi:")} {channel.delivered} • {t("notification_os.failed", "Başarısız")} {channel.failed}</p>
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
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("notification_os.rules", "Bildirim Kuralları")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("notification_os.rules_desc", "Otomatik bildirim tetikleyicileri")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {RULES.map((rule) => (
                  <div key={rule.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Settings className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{rule.name}</p>
                        <p className="text-xs text-muted-foreground">{rule.eventType} • {rule.triggers} {t("notification_os.triggers", "tetikleyici")}</p>
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
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("notification_os.templates", "Bildirim Şablonları")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("notification_os.templates_desc", "Yeniden kullanılabilir bildirim şablonları")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <Mail className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("notification_os.template_management_interface", "Şablon yönetim arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="history">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("notification_os.history", "Bildirim Geçmişi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("notification_os.history_desc", "Son bildirim teslimatları")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {RECENT_NOTIFICATIONS.map((notif) => (
                  <div key={notif.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <Bell className="h-5 w-5 text-muted-foreground" />
                      <div>
                        <p className="text-sm font-medium text-foreground">{notif.subject}</p>
                        <p className="text-xs text-muted-foreground">{notif.recipient} • {notif.sentAt}</p>
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
