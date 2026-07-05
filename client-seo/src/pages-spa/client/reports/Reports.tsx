"use client";

import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { FileText, Download, TrendingUp, Users, DollarSign, Calendar } from "lucide-react";
export default function Reports() {
  const {
    t
  } = useTranslation();
  return <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("client.src.reports")}</h1>
          <p className="text-muted-foreground">{t("client.src.generate_and_view_business")}</p>
        </div>
        <Button>
          <Download className="w-4 h-4 mr-2" />{t("client.src.export_all")}</Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.total_reports")}</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">247</div>
            <p className="text-xs text-muted-foreground">{t("client.src.12_from_last_month")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.this_month")}</CardTitle>
            <Calendar className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">38</div>
            <p className="text-xs text-muted-foreground">{t("client.src.generated_reports")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.downloads")}</CardTitle>
            <Download className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">1,234</div>
            <p className="text-xs text-muted-foreground">{t("client.src.total_downloads")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.active_users")}</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">89</div>
            <p className="text-xs text-muted-foreground">{t("client.src.report_viewers")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.recent_reports")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              name: "Monthly Financial Report",
              type: "Financial",
              date: "2024-01-15",
              status: "completed",
              downloads: 45
            }, {
              name: "Property Performance Analysis",
              type: "Analytics",
              date: "2024-01-14",
              status: "completed",
              downloads: 32
            }, {
              name: "Tenant Satisfaction Survey",
              type: "Survey",
              date: "2024-01-13",
              status: "processing",
              downloads: 0
            }, {
              name: "Market Trends Q4 2023",
              type: "Market",
              date: "2024-01-12",
              status: "completed",
              downloads: 67
            }].map((report, i) => <div key={i} className="flex items-center justify-between border-b pb-4 last:border-0">
                  <div>
                    <p className="font-medium">{report.name}</p>
                    <p className="text-sm text-muted-foreground">{report.type} • {report.date}</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Badge variant={report.status === "completed" ? "default" : "secondary"}>
                      {report.status}
                    </Badge>
                    <span className="text-sm text-muted-foreground">{report.downloads} ↓</span>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.report_categories")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              category: "Financial",
              count: 89,
              icon: DollarSign,
              color: "text-green-600"
            }, {
              category: "Analytics",
              count: 67,
              icon: TrendingUp,
              color: "text-blue-600"
            }, {
              category: "Property",
              count: 45,
              icon: FileText,
              color: "text-purple-600"
            }, {
              category: "Tenant",
              count: 34,
              icon: Users,
              color: "text-orange-600"
            }, {
              category: "Market",
              count: 12,
              icon: Calendar,
              color: "text-red-600"
            }].map((cat, i) => <div key={i} className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <cat.icon className={`h-5 w-5 ${cat.color}`} />
                    <div>
                      <p className="font-medium">{cat.category}</p>
                      <p className="text-sm text-muted-foreground">{cat.count}{t("client.src.reports")}</p>
                    </div>
                  </div>
                  <Button size="sm" variant="outline">{t("client.src.view_all")}</Button>
                </div>)}
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("client.src.scheduled_reports")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {[{
            name: "Weekly Performance Summary",
            schedule: "Every Monday",
            nextRun: "2024-01-22",
            recipients: 12
          }, {
            name: "Monthly Financial Report",
            schedule: "1st of month",
            nextRun: "2024-02-01",
            recipients: 8
          }, {
            name: "Quarterly Market Analysis",
            schedule: "Quarterly",
            nextRun: "2024-04-01",
            recipients: 15
          }].map((scheduled, i) => <div key={i} className="flex items-center justify-between border-b pb-4 last:border-0">
                <div>
                  <p className="font-medium">{scheduled.name}</p>
                  <p className="text-sm text-muted-foreground">{scheduled.schedule} • {scheduled.recipients}{t("client.src.recipients")}</p>
                </div>
                <div className="text-right">
                  <p className="text-sm font-medium">{t("client.src.next_run")}</p>
                  <p className="text-sm text-muted-foreground">{scheduled.nextRun}</p>
                </div>
              </div>)}
          </div>
        </CardContent>
      </Card>
    </div>;
}