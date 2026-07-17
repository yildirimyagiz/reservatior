"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Users, Tag, DollarSign } from "lucide-react";
import Link from "next/link";
import { useTranslation } from "react-i18next";

export function CRMContent() {
    const { t } = useTranslation();
  const crmModules = [
    {
      title: "Leads",
      description: "Manage leads and prospects",
      icon: Users,
      href: "/client/crm/leads",
      color: "text-blue-500"
    },
    {
      title: "Deals Pipeline",
      description: "Track and close opportunities",
      icon: DollarSign,
      href: "/client/deals",
      color: "text-emerald-500"
    },
    {
      title: "Tags",
      description: "Manage tags and categories",
      icon: Tag,
      href: "/client/crm/tags",
      color: "text-purple-500"
    }
  ];

  return (
    <div className="container mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold">{t("crm.crmcontent.auto_ext_1")}</h1>
        <p className="text-muted-foreground">{t("crm.crmcontent.auto_ext_2")}</p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {crmModules.map((module) => (
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
