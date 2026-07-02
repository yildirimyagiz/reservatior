"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Users, FileText, Calendar, DollarSign, TrendingUp } from "lucide-react";
import Link from "next/link";

export function TenantsContent() {
  const tenantModules = [
    {
      title: "All Tenants",
      description: "View and manage all tenants",
      icon: Users,
      href: "/client/tenants/all",
      color: "text-blue-500"
    },
    {
      title: "Tenant Applications",
      description: "Manage rental applications",
      icon: FileText,
      href: "/client/tenants/applications",
      color: "text-purple-500"
    },
    {
      title: "Rent Schedule",
      description: "View rent payment schedules",
      icon: Calendar,
      href: "/client/tenants/rent-schedule",
      color: "text-emerald-500"
    },
    {
      title: "Rent Arrears",
      description: "Track overdue rent payments",
      icon: DollarSign,
      href: "/client/tenants/rent-arrears",
      color: "text-red-500"
    },
    {
      title: "Rent Increases",
      description: "Manage rent increase notifications",
      icon: TrendingUp,
      href: "/client/tenants/rent-increases",
      color: "text-orange-500"
    }
  ];

  return (
    <div className="container mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold">Tenants</h1>
        <p className="text-muted-foreground">Manage tenants and rental applications</p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {tenantModules.map((module) => (
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
