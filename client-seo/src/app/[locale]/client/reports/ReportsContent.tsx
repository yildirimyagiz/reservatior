"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { BarChart3, FileText, Clock, Settings } from "lucide-react";
import Link from "next/link";
import { useTranslation } from "react-i18next";

export function ReportsContent() {
    const { t } = useTranslation();
  const reportModules = [
    {
      title: "Analytics Dashboard",
      description: "View analytics and reports for your property business",
      icon: BarChart3,
      href: "/client/reports/analytics",
      color: "text-blue-500"
    },
    {
      title: "Custom Reports",
      description: "Create and manage custom reports",
      icon: FileText,
      href: "/client/reports/custom",
      color: "text-purple-500"
    },
    {
      title: "Scheduled Reports",
      description: "Manage scheduled and automated reports",
      icon: Clock,
      href: "/client/reports/scheduled",
      color: "text-emerald-500"
    },
    {
      title: "Report Settings",
      description: "Configure report settings and preferences",
      icon: Settings,
      href: "/client/reports/settings",
      color: "text-orange-500"
    }
  ];

  return (
    <div className="container mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold">{t("reports.reportscontent.auto_ext_1")}</h1>
        <p className="text-muted-foreground">{t("reports.reportscontent.auto_ext_2")}</p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {reportModules.map((module) => (
          <Link key={module.href} href={module.href}>
            <Card className="hover:shadow-lg transition-shadow cursor-pointer h-full">
              <CardHeader>
                <div className={`w-12 h-12 rounded-lg bg-muted flex items-center justify-center mb-4 ${module.color}`}>
                  <module.icon className="w-6 h-6" />
                </div>
                <CardTitle className="text-lg">{module.title}</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">{module.description}</p>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>
    </div>
  );
}
