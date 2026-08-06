"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { MessageSquare, History, Search, Filter, FileText, Mail, Smartphone, Globe, Bell, Clock, ArrowRight } from "lucide-react";
export default function CommunicationLogs() {
  const {
    t
  } = useTranslation();
  const logs = [{
    type: "Email",
    recipient: "john.doe@example.com",
    subject: "Rental Agreement Signed",
    date: "10:24 AM",
    status: "Delivered"
  }, {
    type: "SMS",
    recipient: "+1 (555) 0123",
    subject: "Rent Reminder",
    date: "Yesterday, 09:12 AM",
    status: "Sent"
  }, {
    type: "Push",
    recipient: "Sarah Miller (iOS)",
    subject: "New Booking Request",
    date: "Yesterday, 04:30 PM",
    status: "Failed"
  }, {
    type: "Email",
    recipient: "michael.real@propos.com",
    subject: "Commission Payout Ready",
    date: "Mar 22, 11:45 AM",
    status: "Opened"
  }, {
    type: "SMS",
    recipient: "+44 7700 900077",
    subject: "Maintenance Update",
    date: "Mar 21, 02:20 PM",
    status: "Delivered"
  }];
  return <div className="p-6 space-y-6 bg-muted min-h-screen text-foreground font-sans">
      <div className="flex justify-between items-center bg-card p-8 rounded-3xl shadow-sm border border-border">
        <div className="flex items-center gap-6">
          <div className="p-4 bg-blue-600 rounded-2xl shadow-xl shadow-blue-600/10">
            <History className="w-10 h-10 text-white" />
          </div>
          <div>
            <h1 className="text-4xl font-extrabold tracking-tight text-muted-foreground">{t("client.src.communication_logs")}</h1>
            <p className="text-muted-foreground text-lg">{t("client.src.central_hub_for_tracking")}</p>
          </div>
        </div>
        <div className="flex gap-4">
          <Button variant="outline" className="h-12 px-6 gap-2 rounded-xl border-slate-300 hover:bg-muted font-bold">
             <Filter className="w-4 h-4" />{t("client.src.filter_logs")}</Button>
          <Button className="h-12 px-6 gap-2 rounded-xl bg-blue-600 hover:bg-brand shadow-lg shadow-blue-600/20 font-bold">
            <MessageSquare className="w-4 h-4" />{t("client.src.send_manual_log")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        <Card className="rounded-3xl border-border shadow-xl shadow-slate-200/50">
          <CardHeader>
            <CardTitle className="text-sm font-bold text-muted-foreground flex items-center gap-2">
              <Mail className="w-4 h-4 text-brand" />{t("client.src.channel_usage")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {[{
            label: t("client.src.emails"),
            value: "8,240",
            pct: 65
          }, {
            label: t("client.src.sms"),
            value: "3,120",
            pct: 25
          }, {
            label: t("client.src.push_notifications"),
            value: "1,250",
            pct: 10
          }].map((item, i) => <div key={i} className="space-y-2">
                <div className="flex justify-between font-bold">
                  <span>{item.label}</span>
                  <span className="text-brand">{item.value}</span>
                </div>
                <div className="h-2 w-full bg-muted rounded-full">
                  <div className="h-full bg-blue-600 rounded-full" style={{
                width: `${item.pct}%`
              }} />
                </div>
              </div>)}
          </CardContent>
        </Card>

        <Card className="lg:col-span-3 rounded-3xl border-border shadow-xl shadow-slate-200/50 overflow-hidden">
          <div className="bg-muted p-6 border-b border-border">
             <div className="flex items-center gap-4 bg-card border border-border rounded-2xl px-4 h-12">
               <Search className="w-5 h-5 text-muted-foreground" />
                <input type="text" aria-label="Search by recipient or subject" placeholder={t("client.src.search_by_recipient_subject")} className="flex-1 bg-transparent border-none text-sm font-medium focus:ring-0 placeholder:text-muted-foreground" />
               <Badge className="bg-muted text-muted-foreground hover:bg-muted border-none font-bold text-[9px]">{t("client.src.k")}</Badge>
             </div>
          </div>
          <CardContent className="p-0">
            <div className="overflow-x-auto">
              <table className="w-full text-left">
                <thead>
                  <tr className="bg-muted/50 text-muted-foreground border-b border-border">
                    <th className="px-6 py-4 font-bold text-[10px] tracking-wider">{t("client.src.channel")}</th>
                    <th className="px-6 py-4 font-bold text-[10px] tracking-wider">{t("client.src.recipient")}</th>
                    <th className="px-6 py-4 font-bold text-[10px] tracking-wider">{t("client.src.subject")}</th>
                    <th className="px-6 py-4 font-bold text-[10px] tracking-wider">{t("client.src.timestamp")}</th>
                    <th className="px-6 py-4 font-bold text-[10px] tracking-wider">{t("common.status")}</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-100 bg-card">
                  {logs.map((log, i) => <tr key={i} className="hover:bg-muted/50 transition-colors group">
                      <td className="px-6 py-4">
                        <div className="flex items-center gap-2">
                          <div className={cn("w-8 h-8 rounded-lg flex items-center justify-center bg-muted", log.type === "Email" ? "text-brand" : log.type === "SMS" ? "text-success" : "text-amber-500")}>
                            {log.type === "Email" ? <Mail className="w-4 h-4" /> : log.type === "SMS" ? <Smartphone className="w-4 h-4" /> : <Bell className="w-4 h-4" />}
                          </div>
                          <span className="text-sm font-bold text-foreground">{log.type}</span>
                        </div>
                      </td>
                      <td className="px-6 py-4 font-mono text-xs font-bold text-muted-foreground">{log.recipient}</td>
                      <td className="px-6 py-4 font-bold text-sm text-foreground">{log.subject}</td>
                      <td className="px-6 py-4">
                         <div className="flex items-center gap-1.5 text-muted-foreground">
                           <Clock className="w-3.5 h-3.5" /> <span className="text-xs font-bold">{log.date}</span>
                         </div>
                      </td>
                      <td className="px-6 py-4">
                         <Badge className={cn("bg-muted border-none text-[10px] font-black  text-center px-2 py-0.5", log.status === "Delivered" ? "text-success bg-blue-50" : log.status === "Failed" ? "text-rose-500 bg-rose-50" : "text-brand bg-brand/10")}>
                            {log.status}
                         </Badge>
                      </td>
                    </tr>)}
                </tbody>
              </table>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}
function cn(...classes: any[]) {
  return classes.filter(Boolean).join(' ');
}