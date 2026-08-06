"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Download, FileText, Calendar, TrendingUp } from "lucide-react";
export default function Exports() {
  const {
    t
  } = useTranslation();
  return <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("client.src.data_exports")}</h1>
          <p className="text-muted-foreground">{t("client.src.manage_and_download_data")}</p>
        </div>
        <Button>
          <Download className="w-4 h-4 mr-2" />{t("client.src.new_export")}</Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.total_exports")}</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">156</div>
            <p className="text-xs text-muted-foreground">{t("client.src.12_from_last_month")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("common.completed")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">134</div>
            <p className="text-xs text-muted-foreground">{t("client.src.86_completion_rate")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("common.processing")}</CardTitle>
            <Calendar className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">12</div>
            <p className="text-xs text-muted-foreground">{t("client.src.currently_processing")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("common.downloads")}</CardTitle>
            <Download className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">1,234</div>
            <p className="text-xs text-muted-foreground">{t("client.src.total_downloads")}</p>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("client.src.recent_exports")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {[{
            name: "User Data Export",
            type: "CSV",
            status: "completed",
            createdAt: "2024-01-15",
            size: "2.3MB",
            downloads: 45
          }, {
            name: "Property Listings",
            type: "Excel",
            status: "completed",
            createdAt: "2024-01-14",
            size: "5.6MB",
            downloads: 32
          }, {
            name: "Financial Reports Q4",
            type: "PDF",
            status: "processing",
            createdAt: "2024-01-13",
            size: "-",
            downloads: 0
          }, {
            name: "Analytics Summary",
            type: "JSON",
            status: "completed",
            createdAt: "2024-01-12",
            size: "1.2MB",
            downloads: 67
          }].map((item, i) => <div key={i} className="flex items-center justify-between border-b pb-4 last:border-0">
                <div className="flex items-center gap-4">
                  <div className={`w-2 h-2 rounded-full ${item.status === "completed" ? "bg-blue-500" : item.status === "processing" ? "bg-brand/100" : "bg-red-500"}`}></div>
                  <div>
                    <p className="font-medium">{item.name}</p>
                    <p className="text-sm text-muted-foreground">{item.type} • {item.createdAt} • {item.size}</p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <div className="text-right">
                    <p className="font-medium">{item.downloads}{t("common.downloads")}</p>
                    <p className="text-sm text-muted-foreground">{t("common.total")}</p>
                  </div>
                  <Badge variant={item.status === "completed" ? "default" : "secondary"}>
                    {item.status}
                  </Badge>
                  <Button size="sm" variant="outline" disabled={item.status !== "completed"} aria-label={t("common.download")}>
                    <Download className="w-4 h-4" />
                  </Button>
                </div>
              </div>)}
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.export_types")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              type: "CSV",
              count: 45,
              description: t("client.src.commaseparated_values")
            }, {
              type: "Excel",
              count: 34,
              description: t("client.src.microsoft_excel_format")
            }, {
              type: "PDF",
              count: 23,
              description: t("client.src.portable_document_format")
            }, {
              type: "JSON",
              count: 12,
              description: t("client.src.javascript_object_notation")
            }].map((item, i) => <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{item.type}</p>
                    <p className="text-sm text-muted-foreground">{item.description}</p>
                  </div>
                  <div className="text-right">
                    <p className="font-medium">{item.count}</p>
                    <p className="text-sm text-muted-foreground">{t("client.src.exports")}</p>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.scheduled_exports")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              name: "Daily User Report",
              schedule: "Every day at 2:00 AM",
              nextRun: "2024-01-16 02:00",
              status: "scheduled"
            }, {
              name: "Weekly Financial Summary",
              schedule: "Every Monday at 9:00 AM",
              nextRun: "2024-01-22 09:00",
              status: "scheduled"
            }, {
              name: "Monthly Property Data",
              schedule: "1st of month",
              nextRun: "2024-02-01 00:00",
              status: "scheduled"
            }].map((item, i) => <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{item.name}</p>
                    <p className="text-sm text-muted-foreground">{item.schedule}</p>
                  </div>
                  <div className="text-right">
                    <p className="font-medium">{item.nextRun}</p>
                    <Badge variant="outline">
                      {item.status}
                    </Badge>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}